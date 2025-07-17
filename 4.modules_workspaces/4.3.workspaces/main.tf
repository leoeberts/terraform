locals {
  name = {
    study    = "terraform-study"
    personal = "terraform-personal"
  }
}


resource "aws_instance" "web" {
  ami           = data.aws_ami.latest_linux.id
  instance_type = "t2.micro"

  tags = {
    Name = local.name[terraform.workspace]
  }
}
