terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = ">= 5.0"
        }
        github = {
            source = "integrations/github"
            version = "~> 6.0"
        }
    }
}

provider "aws" {
  region  = "eu-central-1"
  profile = "terraform-study" 
}

provider "github" {
    #token = var.github_token
    owner = var.github_owner
}
