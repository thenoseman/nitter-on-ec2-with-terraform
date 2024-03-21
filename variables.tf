variable "basic_auth_username" {
  type    = string
  default = "nitter"
}

variable "instance_type" {
  type    = string
  default = "t4g.micro"
}

variable "nitter_title" {
  type    = string
  default = "nitter"
}

variable "nitter_theme" {
  type    = string
  default = "Twitter Dark"

  validation {
    condition     = can(regex("^(Black|Dracla|Mastodon|Nitter|Pleroma|Twitter|Twitter Dark)$", var.nitter_theme))
    error_message = "Select one from Black, Dracula, Mastodon, Nitter, Pleroma, Twitter or Twitter Dark"
  }
}

