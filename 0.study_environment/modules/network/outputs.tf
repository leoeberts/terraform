output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the VPC"
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "default_network_acl_id" {
  value = aws_default_network_acl.default.id
}
