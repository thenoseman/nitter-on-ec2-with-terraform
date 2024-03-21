resource "random_pet" "password" {
  length = 3
}

resource "aws_launch_template" "nitter" {
  name          = "nitter"
  image_id      = data.aws_ami.al2023-arm64.id
  instance_type = var.instance_type

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "nitter"
    }
  }

  # Userdata installs everything:
  user_data = base64encode(templatefile("${path.module}/userdata.sh.tftpl", {
    BASIC_AUTH_PASSWORD    = random_pet.password.id
    BASIC_AUTH_USERNAME    = var.basic_auth_username
    NITTER_GUEST_AUTH_JSON = file("${path.module}/guide-nitter-self-hosting/nitter-guest_accounts.json")
    NITTER_TITLE           = var.nitter_title
    NITTER_THEME           = var.nitter_theme
  }))
}

resource "aws_autoscaling_group" "nitter" {
  name              = "nitter"
  max_size          = 1
  min_size          = 1
  desired_capacity  = 1
  force_delete      = true
  health_check_type = "EC2"

  vpc_zone_identifier = data.aws_subnets.default.ids

  target_group_arns = [aws_lb_target_group.nitter.arn]

  launch_template {
    id      = aws_launch_template.nitter.id
    version = "$Latest"
  }

  instance_refresh {
    strategy = "Rolling"
    triggers = ["tag"]
  }

  tag {
    key                 = "user_data"
    value               = md5(aws_launch_template.nitter.user_data)
    propagate_at_launch = true
  }
}
