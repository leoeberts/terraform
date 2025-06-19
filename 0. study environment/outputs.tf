output "main_route_table_id" {
  value = module.network.public_route_table_id
}

output "default_network_acl_id" {
  value = module.network.default_network_acl_id
}