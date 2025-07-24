terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

provider "aws" {
  alias   = "frankfurt"
  region  = "eu-central-1"
  profile = "terraform-study"
}

provider "aws" {
  alias   = "ireland"
  region  = "eu-west-1"
  profile = "terraform-study"
}
