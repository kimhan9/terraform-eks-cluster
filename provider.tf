terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.53.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      env = var.env
    }
  }

}