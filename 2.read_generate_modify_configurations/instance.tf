resource "aws_instance" "web_snake_cat" {
  ami                    = data.aws_ami.latest_linux.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_firewall.id]
  user_data              = file("./ec2_files/snake_cat.txt")

  tags = {
    Name = "web_snake_cat"
  }
}

resource "aws_instance" "web_welcome_earthling" {
  ami                    = data.aws_ami.latest_linux.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_firewall.id]
  user_data              = file("./ec2_files/welcome_earthling.txt")

  tags = {
    Name = "web_welcome_earthling"
  }
}

resource "aws_instance" "cluster" {
  ami                    = var.ami[var.region]
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.terraform_firewall.id]
  count                  = 3

  tags = {
    Name      = "cluster_#${count.index}"
    Reason    = var.cluster_reason[count.index]
    Condition = count.index < 1 ? "First" : "Not first"
  }
}

output "cluster_ids" {
  value = aws_instance.cluster[*].id
}
