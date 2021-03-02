
terraform {
  required_version = "~> 0.14"
  required_providers {
    aws        = "~> 3.30"
    rds-aurora = "~> 2.0"
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "twdps"
    workspaces {
      prefix = "lab-platform-rds-"
    }
  }
}

provider "aws" {
  region = var.aws_region
  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id}:role/${var.assume_role}"
    session_name = "lab-platform-rds"
  }
}
