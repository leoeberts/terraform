terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

resource "aws_instance" "web" {
  ami           = local.effective_ami
  instance_type = var.instance_type

  lifecycle {
    create_before_destroy = true
  }
}
