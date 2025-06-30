data "aws_vpc" "selected" { #Get infor from resurces managed outside of TF
  id = "vpc-07026206cc7697c1b"
}

output "vpc_tagscd" {
  value = {
    tags = data.aws_vpc.selected.tags
  }
}

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

output "linux_ami" {
  value = {
    id   = data.aws_ami.latest_linux.id
    name = data.aws_ami.latest_linux.name
  }
}
