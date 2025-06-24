variable "region" {
  type        = string
  description = "the aws region to connect to"
}

variable "ami" {
  type        = string
  description = "the region AMI"
}

variable "ipv4_cidr" {
  type        = string
  description = "a better way of handling static values"
}

variable "app_port" {
  default = "8080"
}

variable "ssh_port" {
  default = "443"
}

variable "username" {
  type = list(number)
}
