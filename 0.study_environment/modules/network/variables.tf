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
