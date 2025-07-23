resource "aws_security_group" "allow_tls" {
  name = "allow_tls"
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = "${data.terraform_remote_state.source_project_eip.outputs.public_ip}/32"
  security_group_id = aws_security_group.allow_tls.id
}
