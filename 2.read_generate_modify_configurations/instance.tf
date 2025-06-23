resource "aws_instance" "web" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.terraform_firewall.id]
}
