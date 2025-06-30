variable "sg_ports" {
  type        = list(number)
  description = "List of ingress ports"
  default     = [8081, 9091, 9300, 9500, 9700]
}

resource "aws_security_group" "dynamic_ports_sg" {
  name        = "terraform_firewall_dynamic"
  description = "Terraform test"
  vpc_id      = "vpc-06c09fea3a4914da8"

  tags = merge(
    { Name = "terraform - dynamic_ports_sg" },
    var.tags
  )

  dynamic "ingress" { # old style just for tests (today we use aws_vpc_security_group_ingress_rule) 
    for_each = var.sg_ports

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
