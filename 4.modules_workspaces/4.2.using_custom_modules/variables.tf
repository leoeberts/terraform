variable "regions" {
  type        = map(object({
    region = string,
    alias = string
  }))
  description = "Map of regions and aliases"
  default = {
    default = {
      region = "eu-central-1"
      alias = "default"
    }
    ireland = {
      region = "eu-west-1"
      alias = "ireland"
    }
  }
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "the instance type to use"
}
