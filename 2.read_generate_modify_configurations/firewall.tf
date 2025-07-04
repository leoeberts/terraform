locals {
  port = {
    web = "80",
    app = "8080",
    ssh = "443",
  }
  everywhere_cidr_v4 = "0.0.0.0/0"
  everywhere_cidr_v6 = "::/0"
  public_ip_cidr_v4  = "${aws_eip.lb.public_ip}/32"
}

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
  cidr_ipv4         = local.public_ip_cidr_v4
  from_port         = local.port["app"] #can get data from maps like this too
  ip_protocol       = "tcp"
  to_port           = local.port.app
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4" {
  security_group_id = aws_security_group.terraform_firewall.id
  cidr_ipv4         = local.public_ip_cidr_v4
  from_port         = local.port.ssh
  ip_protocol       = "tcp"
  to_port           = local.port.ssh
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4_other" {
  security_group_id = aws_security_group.terraform_firewall.id
  cidr_ipv4         = var.ipv4_cidr
  from_port         = local.port.app
  ip_protocol       = "tcp"
  to_port           = local.port.app
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4_other" {
  security_group_id = aws_security_group.terraform_firewall.id
  cidr_ipv4         = var.ipv4_cidr
  from_port         = local.port.ssh
  ip_protocol       = "tcp"
  to_port           = local.port.ssh
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.terraform_firewall.id
  cidr_ipv4         = local.everywhere_cidr_v4
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
  cidr_ipv4         = local.everywhere_cidr_v4
  from_port         = local.port.web
  ip_protocol       = "tcp"
  to_port           = local.port.web
}

resource "aws_vpc_security_group_ingress_rule" "allow_all__http_ipv6" {
  security_group_id = aws_security_group.web_firewall.id
  cidr_ipv6         = local.everywhere_cidr_v6
  from_port         = local.port.web
  ip_protocol       = "tcp"
  to_port           = local.port.web
}

resource "aws_vpc_security_group_egress_rule" "allow_all_web_traffic_ipv4" {
  security_group_id = aws_security_group.web_firewall.id
  cidr_ipv4         = local.everywhere_cidr_v4
  ip_protocol       = "-1"
}
