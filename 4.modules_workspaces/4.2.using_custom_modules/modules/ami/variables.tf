variable "most_recent" {
  type        = bool
  description = "Whether to use the most recent AMI"
  default     = true
}

variable "owners" {
  type        = list(string)
  description = "List of AMI owners"
  default     = ["amazon"]
}

variable "filter" {
  type = list(object({
    name   = string,
    values = list(string)
  }))
  description = "Filter to apply to the AMI search"
}
