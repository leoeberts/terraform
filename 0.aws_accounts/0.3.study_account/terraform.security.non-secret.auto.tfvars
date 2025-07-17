security_groups = [
  { name = "default", description = "default VPC security group" },
  { name = "Web-Access", description = "Allows SSH" },
  { name = "Internal-Access", description = "Allow SSH from Web-Access" }
]

default_sg_rules = [
  {
    security_group_name = "default"
    type                = "ingress"
    from_port           = 0
    to_port             = 0
    protocol            = "-1"
    self                = true
  },
  {
    security_group_name = "default"
    type                = "egress"
    from_port           = 0
    to_port             = 0
    protocol            = "-1"
    cidr_blocks         = ["0.0.0.0/0"]
    ipv6_cidr_blocks    = ["::/0"]
  }
]

web_access_rules = [
  {
    security_group_name = "Web-Access"
    type                = "ingress"
    from_port           = 80
    to_port             = 80
    protocol            = "tcp"
    cidr_blocks         = ["0.0.0.0/0"]
    ipv6_cidr_blocks    = ["::/0"]
  },
  {
    security_group_name = "Web-Access"
    type                = "ingress"
    from_port           = 443
    to_port             = 443
    protocol            = "tcp"
    cidr_blocks         = ["0.0.0.0/0"]
    ipv6_cidr_blocks    = ["::/0"]
  },
  {
    security_group_name = "Web-Access"
    type                = "ingress"
    from_port           = 22
    to_port             = 22
    protocol            = "tcp"
    cidr_blocks         = ["0.0.0.0/0"]
    ipv6_cidr_blocks    = ["::/0"]
  },
  {
    security_group_name = "Web-Access"
    type                = "egress"
    from_port           = 0
    to_port             = 0
    protocol            = "-1"
    cidr_blocks         = ["0.0.0.0/0"]
    ipv6_cidr_blocks    = ["::/0"]
  }
]

internal_access_rules = [
  {
    security_group_name = "Internal-Access"
    type                = "ingress"
    from_port           = 22
    to_port             = 22
    protocol            = "tcp"
    security_groups     = ["Web-Access"]
  },
  {
    security_group_name = "Internal-Access"
    type                = "egress"
    from_port           = 0
    to_port             = 0
    protocol            = "-1"
    cidr_blocks         = ["0.0.0.0/0"]
    ipv6_cidr_blocks    = ["::/0"]
  }
]
