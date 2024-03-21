output "lib-redirect-twitter-url" {
  value = <<-EOV
  USAGE WITH LIB-REDIRECT CHROME EXTENSION:
  -----------------------------------------
  Install https://libredirect.github.io/download.html
  Open the options of the extension and select "Twitter" on the left side.
  Click on the input field under "Add own instance" and enter:

  http://${var.basic_auth_username}:${random_pet.password.id}@${aws_lb.nitter.dns_name}:8080
EOV 
}

output "basic-auth-username" {
  value = var.basic_auth_username
}

output "basic-auth-password" {
  value = random_pet.password.id
}

