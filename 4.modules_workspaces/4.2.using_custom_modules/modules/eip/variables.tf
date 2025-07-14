variable "domain" {
  type        = string
  description = "The domain of the EIP"
  nullable    = false
  default     = "vpc"
}

variable "instance_id" {
  type        = string
  description = "The ID of the instance to attach the EIP to"
  nullable    = false
}
