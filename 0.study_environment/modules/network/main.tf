resource "aws_vpc" "main" {
  cidr_block                       = var.vpc.cidr_block
  assign_generated_ipv6_cidr_block = var.vpc.assign_generated_ipv6_cidr_block
  enable_dns_support               = var.vpc.enable_dns_support
  enable_dns_hostnames             = var.vpc.enable_dns_hostnames
  instance_tenancy                 = var.vpc.instance_tenancy
  tags                             = { Name = var.vpc.name }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = var.igw_name }
}

resource "aws_subnet" "this" {
  for_each                        = { for s in var.subnets : s.name => s }
  vpc_id                          = aws_vpc.main.id
  cidr_block                      = each.value.cidr_block
  availability_zone               = each.value.az
  ipv6_cidr_block                 = each.value.ipv6_cidr_block
  map_public_ip_on_launch         = each.value.map_public_ip_on_launch
  assign_ipv6_address_on_creation = each.value.assign_ipv6_address_on_creation
  tags                            = { Name = each.value.name }
}

resource "aws_route_table" "this" {
  for_each = { for rt in var.route_tables : rt.name => rt }
  vpc_id   = aws_vpc.main.id
  tags     = { Name = each.value.name }
}

resource "aws_route" "this" {
  for_each                    = { for r in var.routes : r.key => r }
  route_table_id              = aws_route_table.this[each.value.route_table_name].id
  destination_cidr_block      = lookup(each.value, "destination_cidr_block", null)
  destination_ipv6_cidr_block = lookup(each.value, "destination_ipv6_cidr_block", null)
  gateway_id = (
    (each.value.gateway_id != null) ? each.value.gateway_id :
    (each.value.route_table_name == "Public-RT" ? aws_internet_gateway.main.id : null)
  )
  nat_gateway_id            = each.value.nat_gateway_id != null ? each.value.nat_gateway_id : null
  transit_gateway_id        = each.value.transit_gateway_id != null ? each.value.transit_gateway_id : null
  vpc_peering_connection_id = each.value.vpc_peering_connection_id != null ? each.value.vpc_peering_connection_id : null
  network_interface_id      = each.value.network_interface_id != null ? each.value.network_interface_id : null
  egress_only_gateway_id    = each.value.egress_only_gateway_id != null ? each.value.egress_only_gateway_id : null
  lifecycle {
    ignore_changes = [gateway_id]
  }
}

resource "aws_route_table_association" "this" {
  for_each       = { for a in var.associations : a.key => a }
  subnet_id      = aws_subnet.this[each.value.subnet_name].id
  route_table_id = aws_route_table.this[each.value.route_table_name].id
}

resource "aws_default_network_acl" "default" {
  default_network_acl_id = var.default_acl_id
  subnet_ids             = [for s in var.subnets : aws_subnet.this[s.name].id]
  tags                   = { Name = var.default_acl_name }

  lifecycle {
    ignore_changes = [ingress, egress]
  }
}

resource "aws_network_acl_rule" "this" {
  for_each        = { for r in var.network_acl_rules : r.key => r }
  network_acl_id  = aws_default_network_acl.default.id
  rule_number     = each.value.rule_number
  egress          = each.value.egress
  protocol        = each.value.protocol
  rule_action     = each.value.action
  cidr_block      = lookup(each.value, "cidr_block", null)
  ipv6_cidr_block = lookup(each.value, "ipv6_cidr_block", null)
  from_port       = each.value.from_port
  to_port         = each.value.to_port
}
