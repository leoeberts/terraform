variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "sg_default_name" {
  type = string
}

variable "sg_web_name" {
  type = string
}

variable "sg_internal_name" {
  type = string
}
