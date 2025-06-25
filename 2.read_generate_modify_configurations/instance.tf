resource "aws_instance" "web" {
  ami                    = var.ami[var.region]
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.terraform_firewall.id]
}

resource "aws_instance" "cluster" {
  ami                    = var.ami[var.region]
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.terraform_firewall.id]
  count                  = 3

  tags = {
    Name   = "cluster_#${count.index}"
    Reason = var.cluster_reason[count.index]
  }
}
