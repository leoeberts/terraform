# Global
region  = "eu-central-1"
profile = "terraform-study"

# Network Module Variables
vpc_cidr_block                       = "10.2.0.0/16"
vpc_enable_dns_support               = true
vpc_enable_dns_hostnames             = false
vpc_assign_generated_ipv6_cidr_block = true
vpc_instance_tenancy                 = "default"
vpc_name                             = "my-study-vpc"

igw_name = "my-igw"

public_route_table_name  = "Public-RT"
private_route_table_name = "Private-RT"

subnet_private_1a_cidr = "10.2.48.0/20"
subnet_private_1a_az   = "eu-central-1a"
subnet_private_1a_ipv6 = "2a05:d014:1b19:3703::/64"
subnet_private_1a_name = "Private-1a"

subnet_private_1b_cidr = "10.2.64.0/20"
subnet_private_1b_az   = "eu-central-1b"
subnet_private_1b_ipv6 = "2a05:d014:1b19:3704::/64"
subnet_private_1b_name = "Private-1b"

subnet_private_1c_cidr = "10.2.80.0/20"
subnet_private_1c_az   = "eu-central-1c"
subnet_private_1c_ipv6 = "2a05:d014:1b19:3705::/64"
subnet_private_1c_name = "Private-1c"

subnet_public_1a_cidr = "10.2.0.0/20"
subnet_public_1a_az   = "eu-central-1a"
subnet_public_1a_ipv6 = "2a05:d014:1b19:3700::/64"
subnet_public_1a_name = "Public-1a"

subnet_public_1b_cidr = "10.2.16.0/20"
subnet_public_1b_az   = "eu-central-1b"
subnet_public_1b_ipv6 = "2a05:d014:1b19:3701::/64"
subnet_public_1b_name = "Public-1b"

subnet_public_1c_cidr = "10.2.32.0/20"
subnet_public_1c_az   = "eu-central-1c"
subnet_public_1c_ipv6 = "2a05:d014:1b19:3702::/64"
subnet_public_1c_name = "Public-1c"

default_acl_id   = "acl-0da0fefeca761bac6"
default_acl_name = "default"

# Security Module Variables
security_groups = [
  { name = "default", description = "default VPC security group" },
  { name = "Web-Access", description = "Allows SSH" },
  { name = "Internal-Access", description = "Allow SSH from Web-Access" }
]

# Security Group Rule Variables (separated by SG)
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

# Peering Module Variables
peerings = [
  {
    name        = "peer-with-personal"
    peer_vpc_id = "vpc-09ae5bda14d06e230"
    peer_cidr   = "10.0.0.0/16"
  },
  {
    name        = "peer-with-main"
    peer_vpc_id = "vpc-0c28f6cd530e40b62"
    peer_cidr   = "10.1.0.0/16"
  }
]

peering_sg_rules = [
  {
    security_group_name = "Web-Access"
    type                = "ingress"
    from_port           = -1
    to_port             = -1
    protocol            = "icmp"
    cidr_blocks         = ["10.0.0.0/16"]
    description         = "peering-with-main"
  },
  {
    security_group_name = "Web-Access"
    type                = "ingress"
    from_port           = -1
    to_port             = -1
    protocol            = "icmp"
    cidr_blocks         = ["10.1.0.0/16"]
    description         = "peering-with-personal"
  }
]
