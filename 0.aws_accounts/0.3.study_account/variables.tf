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
variable "vpc" {
  description = "VPC configuration"
  type = object({
    cidr_block                       = string
    assign_generated_ipv6_cidr_block = bool
    enable_dns_support               = bool
    enable_dns_hostnames             = bool
    instance_tenancy                 = string
    name                             = string
  })
}

variable "igw_name" {
  type        = string
  description = "Name tag for the Internet Gateway"
}

variable "default_acl_id" {
  type        = string
  description = "ID of the default network ACL"
}

variable "default_acl_name" {
  type        = string
  description = "Name tag for the default network ACL"
}

variable "subnets" {
  description = "List of subnets"
  type = list(object({
    name                            = string
    cidr_block                      = string
    az                              = string
    ipv6_cidr_block                 = string
    map_public_ip_on_launch         = bool
    assign_ipv6_address_on_creation = bool
  }))
}

variable "route_tables" {
  description = "List of route tables"
  type = list(object({
    name = string
  }))
}

variable "routes" {
  description = "List of routes"
  type = list(object({
    key                         = string
    route_table_name            = string
    destination_cidr_block      = optional(string)
    destination_ipv6_cidr_block = optional(string)
    gateway_id                  = optional(string)
    nat_gateway_id              = optional(string)
    transit_gateway_id          = optional(string)
    vpc_peering_connection_id   = optional(string)
    network_interface_id        = optional(string)
    egress_only_gateway_id      = optional(string)
  }))
}

variable "associations" {
  description = "List of route table associations"
  type = list(object({
    key              = string
    subnet_name      = string
    route_table_name = string
  }))
}

variable "network_acl_rules" {
  description = "List of network ACL rules"
  type = list(object({
    key             = string
    rule_number     = number
    egress          = bool
    protocol        = string
    action          = string
    cidr_block      = optional(string)
    ipv6_cidr_block = optional(string)
    from_port       = number
    to_port         = number
  }))
}

# Security Module Variables
variable "security_groups" {
  description = "List of security groups"
  type = list(object({
    name        = string
    description = string
  }))
}

# Security Group Rule Variables (separated by SG)
variable "web_access_rules" {
  description = "Rules for the Web-Access security group"
  type = list(object({
    security_group_name = string
    type                = string
    from_port           = number
    to_port             = number
    protocol            = string
    cidr_blocks         = optional(list(string))
    ipv6_cidr_blocks    = optional(list(string))
    security_groups     = optional(list(string))
    description         = optional(string)
    self                = optional(bool)
  }))
}

variable "internal_access_rules" {
  description = "Rules for the Internal-Access security group"
  type = list(object({
    security_group_name = string
    type                = string
    from_port           = number
    to_port             = number
    protocol            = string
    cidr_blocks         = optional(list(string))
    ipv6_cidr_blocks    = optional(list(string))
    security_groups     = optional(list(string))
    description         = optional(string)
    self                = optional(bool)
  }))
}

variable "default_sg_rules" {
  description = "Rules for the default security group"
  type = list(object({
    security_group_name = string
    type                = string
    from_port           = number
    to_port             = number
    protocol            = string
    cidr_blocks         = optional(list(string))
    ipv6_cidr_blocks    = optional(list(string))
    security_groups     = optional(list(string))
    description         = optional(string)
    self                = optional(bool)
  }))
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

variable "peering_sg_rules" {
  description = "List of security group rules related to VPC peering"
  type = list(object({
    security_group_name = string
    type                = string
    from_port           = number
    to_port             = number
    protocol            = string
    cidr_blocks         = optional(list(string))
    ipv6_cidr_blocks    = optional(list(string))
    security_groups     = optional(list(string))
    description         = optional(string)
    self                = optional(bool)
  }))
  default = []
}
