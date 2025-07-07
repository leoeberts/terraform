locals {
  my_instances_map = {
    web_snake_cat = {
      name                   = "web_snake_cat"
      ami                    = data.aws_ami.latest_linux.id
      instance_type          = "t2.micro"
      vpc_security_group_ids = [aws_security_group.web_firewall.id]
      user_data              = file("./ec2_files/snake_cat.txt")
      tags = {
        Name = "web_snake_cat"
        Type = "web"
      }
    }
    web_welcome_earthling = {
      name                   = "web_welcome_earthling"
      ami                    = data.aws_ami.latest_linux.id
      instance_type          = "t2.micro"
      vpc_security_group_ids = [aws_security_group.web_firewall.id]
      user_data              = file("./ec2_files/welcome_earthling.txt")
      tags = {
        Name = "web_welcome_earthling"
      }
    }
  }
}

resource "aws_instance" "my_instances" {
  for_each               = local.my_instances_map
  ami                    = each.value.ami
  instance_type          = each.value.instance_type
  vpc_security_group_ids = each.value.vpc_security_group_ids
  user_data              = each.value.user_data
  tags                   = each.value.tags
}
