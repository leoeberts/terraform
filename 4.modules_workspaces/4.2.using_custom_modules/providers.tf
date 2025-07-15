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
  region  = var.regions.default.region
}

provider "aws" {
  profile = "terraform-study"
  alias   = "ireland"
  region  = var.regions.ireland.region
}
