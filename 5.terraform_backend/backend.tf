terraform {
  backend "s3" {
    use_lockfile = true
    region       = "eu-central-1"
    bucket       = "terraform-state-bucket-852456"
    key          = "tests/terraform-5.0.tfstate"
  }
}
