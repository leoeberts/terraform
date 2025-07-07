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

data "aws_key_pair" "study_key" {
  filter {
    name   = "key-pair-id"
    values = ["key-0ce3c988a890c59fc"]
  }
}

output "study_key" {
  value = {
    id   = data.aws_key_pair.study_key.id
    name = data.aws_key_pair.study_key.key_name
  }
}
