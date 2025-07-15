output "ami" {
  value = {
    frankfurt = {
      id   = data.aws_ami.ami_frankfurt.id
      name = data.aws_ami.ami_frankfurt.name
    }
    ireland = {
      id   = data.aws_ami.ami_ireland.id
      name = data.aws_ami.ami_ireland.name
    }
  }
}
