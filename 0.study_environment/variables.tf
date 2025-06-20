# Global
variable "region" {
  description = "AWS Region"
  type        = string
  default     = "eu-central-1"
}

variable "profile" {
  description = "The AWS CLI profile to use for authentication"
  type        = string
}

# Network Module Variables
variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "vpc_enable_dns_support" {
  type        = bool
  description = "Enable DNS support in the VPC"
}

variable "vpc_enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in the VPC"
}

variable "vpc_assign_generated_ipv6_cidr_block" {
  type        = bool
  description = "Assign an IPv6 CIDR block to the VPC"
}

variable "vpc_instance_tenancy" {
  type        = string
  description = "The instance tenancy option for instances launched into the VPC"
}

variable "vpc_name" {
  type        = string
  description = "The name tag to assign to the VPC"
}

variable "igw_name" {
  type        = string
  description = "The name tag to assign to the Internet Gateway"
}

variable "public_route_table_name" {
  type        = string
  description = "Name tag for the public route table"
}

variable "private_route_table_name" {
  type        = string
  description = "Name tag for the private route table"
}

# Subnet Variables
variable "subnet_private_1a_cidr" {
  type        = string
  description = "CIDR block for private subnet 1a"
}

variable "subnet_private_1a_az" {
  type        = string
  description = "Availability zone for private subnet 1a"
}

variable "subnet_private_1a_ipv6" {
  type        = string
  description = "IPv6 block for private subnet 1a"
}

variable "subnet_private_1a_name" {
  type        = string
  description = "Name tag for private subnet 1a"
}

variable "subnet_private_1b_cidr" {
  type        = string
  description = "CIDR block for private subnet 1b"
}

variable "subnet_private_1b_az" {
  type        = string
  description = "Availability zone for private subnet 1b"
}

variable "subnet_private_1b_ipv6" {
  type        = string
  description = "IPv6 block for private subnet 1b"
}

variable "subnet_private_1b_name" {
  type        = string
  description = "Name tag for private subnet 1b"
}

variable "subnet_private_1c_cidr" {
  type        = string
  description = "CIDR block for private subnet 1c"
}

variable "subnet_private_1c_az" {
  type        = string
  description = "Availability zone for private subnet 1c"
}

variable "subnet_private_1c_ipv6" {
  type        = string
  description = "IPv6 block for private subnet 1c"
}

variable "subnet_private_1c_name" {
  type        = string
  description = "Name tag for private subnet 1c"
}

variable "subnet_public_1a_cidr" {
  type        = string
  description = "CIDR block for public subnet 1a"
}

variable "subnet_public_1a_az" {
  type        = string
  description = "Availability zone for public subnet 1a"
}

variable "subnet_public_1a_ipv6" {
  type        = string
  description = "IPv6 block for public subnet 1a"
}

variable "subnet_public_1a_name" {
  type        = string
  description = "Name tag for public subnet 1a"
}

variable "subnet_public_1b_cidr" {
  type        = string
  description = "CIDR block for public subnet 1b"
}

variable "subnet_public_1b_az" {
  type        = string
  description = "Availability zone for public subnet 1b"
}

variable "subnet_public_1b_ipv6" {
  type        = string
  description = "IPv6 block for public subnet 1b"
}

variable "subnet_public_1b_name" {
  type        = string
  description = "Name tag for public subnet 1b"
}

variable "subnet_public_1c_cidr" {
  type        = string
  description = "CIDR block for public subnet 1c"
}

variable "subnet_public_1c_az" {
  type        = string
  description = "Availability zone for public subnet 1c"
}

variable "subnet_public_1c_ipv6" {
  type        = string
  description = "IPv6 block for public subnet 1c"
}

variable "subnet_public_1c_name" {
  type        = string
  description = "Name tag for public subnet 1c"
}

variable "default_acl_id" {
  type        = string
  description = "ID of the default network ACL"
}

variable "default_acl_name" {
  type        = string
  description = "Name tag for the default network ACL"
}

# Security Module Variables
variable "sg_default_name" {
  type        = string
  description = "Name of the default security group"
}

variable "sg_web_name" {
  type        = string
  description = "Name of the web access security group"
}

variable "sg_internal_name" {
  type        = string
  description = "Name of the internal access security group"
}

# Peering Module Variables
variable "peerings" {
  description = "List of static peering definitions"
  type = list(object({
    name        = string
    peer_vpc_id = string
    peer_cidr   = string
    peer_region = optional(string)
  }))
}
