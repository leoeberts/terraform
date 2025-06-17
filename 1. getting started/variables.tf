variable "github_token" {
  type        = string
  sensitive   = true
  description = "Github access token"
}

variable "github_owner" {
  type = string
  description = "Github owner"
}

variable "repo_name" {
  type = string
  description = "Github repository name"

}

variable "repo_description" {
  type = string
  description = "Github repository description"
}
