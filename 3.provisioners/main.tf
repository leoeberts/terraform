locals {
  protocol = {
    all = "-1",
    tcp = "tcp"
  }
  port = {
    ssh = "22",
  }
  everywhere_cidr_v4 = "0.0.0.0/0"
  vpc_id             = "vpc-06c09fea3a4914da8"
}

resource "aws_security_group" "web_firewall" {
  name   = "terraform__test_ssh_firewall"
  vpc_id = local.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "allow_all_ipv4" {
  security_group_id = aws_security_group.web_firewall.id
  cidr_ipv4         = local.everywhere_cidr_v4
  ip_protocol       = local.protocol.all
}

resource "aws_security_group_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.web_firewall.id
  type              = "ingress"
  protocol          = local.protocol.tcp
  from_port         = local.port.ssh
  to_port           = local.port.ssh
  cidr_blocks       = [local.everywhere_cidr_v4]
}


resource "aws_instance" "web" {
  ami                    = data.aws_ami.latest_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_firewall.id]
  tags = {
    Name = "terraform-test-web"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.web.public_ip} > public_ip.txt"
  }
}
