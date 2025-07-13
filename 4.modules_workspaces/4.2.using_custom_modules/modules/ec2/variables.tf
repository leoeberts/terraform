
data "aws_ami" "latest_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al*-ami-20*-kernel-6*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  effective_ami = var.ami == "none" ? data.aws_ami.latest_linux.id : var.ami
}

variable "ami" {
  type     = string
  nullable = false
  default  = "none"
}

variable "instance_type" {
  type     = string
  nullable = false
  default  = "t2.micro"
}
