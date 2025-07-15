terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
      configuration_aliases = [
        aws.frankfurt,
        aws.ireland
      ]
    }
  }
}

data "aws_ami" "ami_frankfurt" {
  provider    = aws.frankfurt
  most_recent = var.most_recent
  owners      = var.owners

  dynamic "filter" {
    for_each = var.filter
    content {
      name   = filter.value.name
      values = filter.value.values
    }
  }
}

data "aws_ami" "ami_ireland" {
  provider    = aws.ireland
  most_recent = var.most_recent
  owners      = var.owners

  dynamic "filter" {
    for_each = var.filter
    content {
      name   = filter.value.name
      values = filter.value.values
    }
  }
}
