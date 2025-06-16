provider "aws" {
  region  = "eu-central-1"
  profile = "terraform-study" 
}

terraform {
    required_providers {
        github = {
            source = "integrations/github"
            version = "~> 6.0"
        }
    }
}

provider "github" {
    #token = var.github_token
    owner = var.github_owner
}
