variable "ami_filter" {
  type = list(object({
    name   = string,
    values = list(string)
  }))
  description = "Filter to apply to the AMI search"
  default = [
    {
      name   = "name"
      values = ["al*-ami-20*-kernel-6*-x86_64"]
    },
    {
      name   = "architecture"
      values = ["x86_64"]
    },
    {
      name   = "virtualization-type"
      values = ["hvm"]
    }
  ]
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "the instance type to use"
}
