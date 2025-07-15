terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  profile = "terraform-study"
  region  = "eu-central-1"
}

provider "aws" {
  profile = "terraform-study"
  alias   = "ireland"
  region  = "eu-west-1"
}
