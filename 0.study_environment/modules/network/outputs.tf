output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the VPC"
}

output "subnet_ids" {
  value       = { for k, s in aws_subnet.this : k => s.id }
  description = "Map of subnet names to subnet IDs"
}

output "route_table_ids" {
  value       = { for k, rt in aws_route_table.this : k => rt.id }
  description = "Map of route table names to IDs"
}

output "default_network_acl_id" {
  value = aws_default_network_acl.default.id
}

output "network_acl_rule_ids" {
  value       = { for k, r in aws_network_acl_rule.this : k => r.id }
  description = "Map of network ACL rule keys to IDs"
}
