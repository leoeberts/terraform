variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "security_groups" {
  description = "List of security groups"
  type = list(object({
    name        = string
    description = string
  }))
}

variable "security_group_rules" {
  description = "List of security group rules"
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
  }))
}
