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
