## 34. Security Group Pratical
resource "aws_security_group" "terraform_firewall" {
  name        = "terraform_firewall"
  description = "Terraform test"
  vpc_id      = "vpc-06c09fea3a4914da8"

  tags = {
    Name = "terraform"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.terraform_firewall.id
  cidr_ipv4         = "172.31.0.0/16"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4" {
  security_group_id = aws_security_group.terraform_firewall.id
  cidr_ipv4         = "172.31.0.0/16"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.terraform_firewall.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
