output "debug_github_token_prefix" {
  value = substr(var.github_token, 0, 10)
    sensitive = true

}