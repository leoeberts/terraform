variable "vpc_id" {
  type        = string
  description = "VPC ID that initiates the peering"
}

variable "peerings" {
  description = "List of static peering definitions"
  type = list(object({
    name        = string
    peer_vpc_id = string
    peer_cidr   = string
    peer_region = optional(string)
  }))
}

variable "route_table_ids" {
  description = "List of route table IDs to add peering routes to"
  type        = list(string)
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

variable "security_group_ids" {
  description = "Map of security group names to their IDs"
  type        = map(string)
}
