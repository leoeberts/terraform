resource "aws_instance" "web" {
  ami                    = "ami-092ff8e60e2d51e19"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.terraform_firewall.id]
}
