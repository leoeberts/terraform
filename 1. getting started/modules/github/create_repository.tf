resource "github_repository" "repo" {
    name = var.repo_name
    description =  var.repo_description
    visibility = "public"
}