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
sg_default_name = "default"

sg_web_name = "Web-Access"

sg_internal_name = "Internal-Access"

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
