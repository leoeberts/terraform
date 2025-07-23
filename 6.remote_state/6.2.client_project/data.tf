data "terraform_remote_state" "source_project_eip" {
  backend = "s3"
  config = {
    bucket = "terraform-state-bucket-852456"
    key    = "tests/terraform-6.1.tfstate"
    region = "eu-central-1"
  }
}
