variable "profile" {
  type = map(string)
  default = {
    study    = "terraform-study"
    personal = "terraform-personal"
  }
}

variable "region" {
  type    = string
  default = "eu-central-1"
}
