locals {
  protocol = {
    all = "-1",
    tcp = "tcp"
  }
  port = {
    ssh = "22",
    web = "80",
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

resource "aws_security_group_rule" "allow_web_ipv4" {
  security_group_id = aws_security_group.web_firewall.id
  type              = "ingress"
  protocol          = local.protocol.tcp
  from_port         = local.port.web
  to_port           = local.port.web
  cidr_blocks       = [local.everywhere_cidr_v4]
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.latest_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_firewall.id]
  key_name               = data.aws_key_pair.study_key.key_name
  tags = {
    Name = "terraform-test-web-2"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > public_ip.txt"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo ^<offline^> > public_ip.txt"
  }

  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("Study.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum -y install nginx",
      "sudo systemctl start nginx",
    ]
  }
}

resource "aws_instance" "provisioner_fail_test_continue" {
  ami                    = data.aws_ami.latest_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_firewall.id]
  key_name               = data.aws_key_pair.study_key.key_name
  tags = {
    Name = "terraform-fail_test_continue"
  }

  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("Study.pem")
  }

  provisioner "remote-exec" {
    on_failure = continue
    inline = [
      " yum install yarn"
    ]
  }
}

resource "aws_instance" "provisioner_fail_test_tainted" {
  ami                    = data.aws_ami.latest_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_firewall.id]
  key_name               = data.aws_key_pair.study_key.key_name
  tags = {
    Name = "terraform-fail_test_tainted"
  }

  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("Study.pem")
  }

  provisioner "remote-exec" {
    on_failure = fail #default
    inline = [
      " yum install yarn"
    ]
  }
}
