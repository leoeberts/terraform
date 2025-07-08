variable "region" {
  type        = string
  default     = "eu-central-1"
  description = "the aws region to connect to"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "the instance type to use"
}
