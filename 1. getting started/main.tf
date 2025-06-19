module "aws" {
  source = "./modules/aws"
}

module "github" {
  source           = "./modules/github"
  repo_name        = var.repo_name
  repo_description = var.repo_description
}