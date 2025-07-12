terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.66"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
  profile = "terraform-study"
}
