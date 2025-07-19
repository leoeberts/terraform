vpc = {
  cidr_block                       = "10.2.0.0/16"
  assign_generated_ipv6_cidr_block = true
  enable_dns_support               = true
  enable_dns_hostnames             = false
  instance_tenancy                 = "default"
  name                             = "my-study-vpc"
}

igw_name         = "my-igw"
default_acl_id   = "acl-0da0fefeca761bac6"
default_acl_name = "default"

subnets = [
  { name = "Private-1a", cidr_block = "10.2.48.0/20", az = "eu-central-1a", ipv6_cidr_block = "2a05:d014:1b19:3703::/64", map_public_ip_on_launch = false, assign_ipv6_address_on_creation = false },
  { name = "Private-1b", cidr_block = "10.2.64.0/20", az = "eu-central-1b", ipv6_cidr_block = "2a05:d014:1b19:3704::/64", map_public_ip_on_launch = false, assign_ipv6_address_on_creation = false },
  { name = "Private-1c", cidr_block = "10.2.80.0/20", az = "eu-central-1c", ipv6_cidr_block = "2a05:d014:1b19:3705::/64", map_public_ip_on_launch = false, assign_ipv6_address_on_creation = false },
  { name = "Public-1a", cidr_block = "10.2.0.0/20", az = "eu-central-1a", ipv6_cidr_block = "2a05:d014:1b19:3700::/64", map_public_ip_on_launch = true, assign_ipv6_address_on_creation = true },
  { name = "Public-1b", cidr_block = "10.2.16.0/20", az = "eu-central-1b", ipv6_cidr_block = "2a05:d014:1b19:3701::/64", map_public_ip_on_launch = true, assign_ipv6_address_on_creation = true },
  { name = "Public-1c", cidr_block = "10.2.32.0/20", az = "eu-central-1c", ipv6_cidr_block = "2a05:d014:1b19:3702::/64", map_public_ip_on_launch = true, assign_ipv6_address_on_creation = true }
]

route_tables = [
  { name = "Public-RT" },
  { name = "Private-RT" }
]

routes = [
  { key = "public-ipv4", route_table_name = "Public-RT", destination_cidr_block = "0.0.0.0/0" },
  { key = "public-ipv6", route_table_name = "Public-RT", destination_ipv6_cidr_block = "::/0" }
]

associations = [
  { key = "private-1a", subnet_name = "Private-1a", route_table_name = "Private-RT" },
  { key = "private-1b", subnet_name = "Private-1b", route_table_name = "Private-RT" },
  { key = "private-1c", subnet_name = "Private-1c", route_table_name = "Private-RT" }
]

network_acl_rules = [
  { key = "ingress-ipv4", rule_number = 100, egress = false, protocol = "-1", action = "allow", cidr_block = "0.0.0.0/0", from_port = 0, to_port = 0 },
  { key = "ingress-ipv6", rule_number = 101, egress = false, protocol = "-1", action = "allow", ipv6_cidr_block = "::/0", from_port = 0, to_port = 0 },
  { key = "egress-ipv4", rule_number = 100, egress = true, protocol = "-1", action = "allow", cidr_block = "0.0.0.0/0", from_port = 0, to_port = 0 },
  { key = "egress-ipv6", rule_number = 101, egress = true, protocol = "-1", action = "allow", ipv6_cidr_block = "::/0", from_port = 0, to_port = 0 }
]
