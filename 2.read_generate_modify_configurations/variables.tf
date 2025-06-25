variable "region" {
  type        = string
  description = "the aws region to connect to"
}

variable "ami" {
  type        = map(any)
  description = "AMI per region"
  default = {
    eu-central-1   = "ami-092ff8e60e2d51e19",
    ap-northeast-1 = "ami-0bb2c57f7cfafb1cb"
  }
}

variable "ipv4_cidr" {
  type        = string
  description = "a better way of handling static values"
}

variable "port" {
  type = map(any)
  default = {
    web = "80",
    app = "8080",
    ssh = "443",
  }
}

variable "tags" {
  type = map(any)
}

/*variable "username" {
  type = list(number)
}*/
