variable "vpc_id" {
  type        = string
  description = "VPC ID that initiates the peering"
}

variable "peer_personal_vpc_id" {
  type = string
}

variable "peer_personal_name" {
  type = string
}

variable "peer_main_vpc_id" {
  type = string
}

variable "peer_main_name" {
  type = string
}
