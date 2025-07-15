output "ami" {
  value = {
    id   = data.aws_ami.ami_filtered.id
    name = data.aws_ami.ami_filtered.name
  }
}
