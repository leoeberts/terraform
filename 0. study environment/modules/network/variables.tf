variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "vpc_enable_dns_support" {
  type        = bool
  description = "Whether to enable DNS support"
}

variable "vpc_enable_dns_hostnames" {
  type        = bool
  description = "Whether to enable DNS hostnames"
}

variable "vpc_assign_generated_ipv6_cidr_block" {
  type        = bool
  description = "Whether to assign IPv6 CIDR block"
}

variable "vpc_instance_tenancy" {
  type        = string
  description = "Instance tenancy for the VPC"
}

variable "vpc_name" {
  type        = string
  description = "Name tag for the VPC"
}

variable "igw_name" {
  type        = string
  description = "Name tag for the Internet Gateway"
}

variable "route_peer_1_cidr" {
  type        = string
  description = "CIDR block for peer 1"
}

variable "route_peer_2_cidr" {
  type        = string
  description = "CIDR block for peer 2"
}

variable "route_peer_1_id" {
  type        = string
  description = "Peering connection ID for peer 1"
}

variable "route_peer_2_id" {
  type        = string
  description = "Peering connection ID for peer 2"
}

variable "public_route_table_name" {
  type        = string
  description = "Name for public route table"
}

variable "private_route_table_name" {
  type        = string
  description = "Name for private route table"
}

variable "subnet_private_1a_cidr" {
  type = string
}

variable "subnet_private_1a_az" {
  type = string
}

variable "subnet_private_1a_ipv6" {
  type = string
}

variable "subnet_private_1a_name" {
  type = string
}

variable "subnet_private_1b_cidr" {
  type = string
}

variable "subnet_private_1b_az" {
  type = string
}

variable "subnet_private_1b_ipv6" {
  type = string
}

variable "subnet_private_1b_name" {
  type = string
}

variable "subnet_private_1c_cidr" {
  type = string
}

variable "subnet_private_1c_az" {
  type = string
}

variable "subnet_private_1c_ipv6" {
  type = string
}

variable "subnet_private_1c_name" {
  type = string
}

variable "subnet_public_1a_cidr" {
  type = string
}

variable "subnet_public_1a_az" {
  type = string
}

variable "subnet_public_1a_ipv6" {
  type = string
}

variable "subnet_public_1a_name" {
  type = string
}

variable "subnet_public_1b_cidr" {
  type = string
}

variable "subnet_public_1b_az" {
  type = string
}

variable "subnet_public_1b_ipv6" {
  type = string
}

variable "subnet_public_1b_name" {
  type = string
}

variable "subnet_public_1c_cidr" {
  type = string
}

variable "subnet_public_1c_az" {
  type = string
}

variable "subnet_public_1c_ipv6" {
  type = string
}

variable "subnet_public_1c_name" {
  type = string
}

variable "default_acl_id" {
  type = string
}

variable "default_acl_name" {
  type = string
}
