## 34. Security Group Pratical
resource "aws_security_group" "terraform_firewall" {
  name        = "terraform_firewall"
  description = "Terraform test"
  vpc_id      = "vpc-06c09fea3a4914da8"

  tags = merge(
    { Name = "terraform" },
    var.tags
  )
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.terraform_firewall.id
  cidr_ipv4         = "${aws_eip.lb.public_ip}/32"
  from_port         = var.port["app"]
  ip_protocol       = "tcp"
  to_port           = var.port["app"]
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4" {
  security_group_id = aws_security_group.terraform_firewall.id
  cidr_ipv4         = "${aws_eip.lb.public_ip}/32"
  from_port         = var.port["ssh"]
  ip_protocol       = "tcp"
  to_port           = var.port["ssh"]
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4_other" {
  security_group_id = aws_security_group.terraform_firewall.id
  cidr_ipv4         = var.ipv4_cidr
  from_port         = var.port["app"]
  ip_protocol       = "tcp"
  to_port           = var.port["app"]
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4_other" {
  security_group_id = aws_security_group.terraform_firewall.id
  cidr_ipv4         = var.ipv4_cidr
  from_port         = var.port["ssh"]
  ip_protocol       = "tcp"
  to_port           = var.port["ssh"]
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.terraform_firewall.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_security_group" "web_firewall" {
  name        = "web_enabled"
  description = "Terraform test"
  vpc_id      = "vpc-06c09fea3a4914da8"

  tags = merge(
    { Name = "web_enabled" },
    var.tags
  )
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_http_ipv4" {
  security_group_id = aws_security_group.web_firewall.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = var.port["web"]
  ip_protocol       = "tcp"
  to_port           = var.port["web"]
}

resource "aws_vpc_security_group_ingress_rule" "allow_all__http_ipv6" {
  security_group_id = aws_security_group.web_firewall.id
  cidr_ipv6         = "::/0"
  from_port         = var.port["web"]
  ip_protocol       = "tcp"
  to_port           = var.port["web"]
}

resource "aws_vpc_security_group_egress_rule" "allow_all_web_traffic_ipv4" {
  security_group_id = aws_security_group.web_firewall.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

