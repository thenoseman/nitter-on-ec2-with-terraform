terraform {
  backend "local" {
    path = ".terraform/nitter-terraform.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 1.3"
    }
  }
  required_version = ">= 1.7.5"
}

provider "aws" {
  default_tags {
    tags = {
      Project = "nitter-on-docker"
    }
  }
}
