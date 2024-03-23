variable "basic_auth_username" {
  description = "The basic auth username you use to access the instance"
  type        = string
  default     = "nitter"
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t4g.micro"
}

variable "deactivate_instance_cron" {
  description = "Deactivate the instance at a specified time every day. Might save some money, see https://crontab.guru/"
  type        = string
  default     = ""
}

variable "activate_instance_cron" {
  description = "Activate the instance at a specified time every day, see https://crontab.guru/"
  type        = string
  default     = ""
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

