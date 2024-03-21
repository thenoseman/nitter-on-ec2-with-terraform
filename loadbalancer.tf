resource "aws_lb_target_group" "nitter" {
  name        = "nitter"
  port        = 8080
  target_type = "instance"
  protocol    = "TCP"
  vpc_id      = data.aws_vpc.default.id

  health_check {
    healthy_threshold   = 2
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    unhealthy_threshold = 5
    matcher             = "200,401"
  }
}

resource "aws_lb" "nitter" {
  name               = "nitter"
  internal           = false
  load_balancer_type = "network"
  ip_address_type    = "ipv4"
  security_groups    = [aws_default_security_group.default.id]
  subnets            = data.aws_subnets.default.ids

  enable_deletion_protection = true
}

resource "aws_lb_listener" "nitter" {
  load_balancer_arn = aws_lb.nitter.arn
  port              = 8080
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nitter.arn
  }
}
