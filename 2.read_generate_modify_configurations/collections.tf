variable "my_list" {
  type        = list(string)
  default     = ["gato", "foxy", "gato"]
  description = "Values are indexed, ordered, and can contain duplicates"
}

variable "my_set" {
  type        = set(string)
  default     = ["gato", "foxy", "gato"]
  description = "Values are unordered, unique, and cannot contain duplicates"
}

variable "my_map" {
  type = map(string)
  default = {
    gato = "gato"
    foxy = "foxy"
    gato = "gato 2 (override previous)"
  }
  description = "Keys are unordered, unique, and cannot contain duplicates"
}

variable "my_tuple" {
  type        = tuple([string, string, string])
  default     = ["gato", "foxy", "gato"]
  description = "Values are ordered, fixed-length, and can contain duplicates"
}

output "my_list_output" {
  value = var.my_list
}

output "my_set_output" {
  value = var.my_set
}

output "my_map_output" {
  value = var.my_map
}

output "my_tuple_output" {
  value = var.my_tuple
}
