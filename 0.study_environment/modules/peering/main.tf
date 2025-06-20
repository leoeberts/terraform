resource "aws_vpc_peering_connection" "this" {
  for_each = { for p in var.peerings : p.name => p }

  vpc_id      = var.vpc_id
  peer_vpc_id = each.value.peer_vpc_id
  peer_region = lookup(each.value, "peer_region", null)

  tags = {
    Name = each.value.name
  }
}

resource "aws_route" "peering_routes" {
  for_each = {
    for pair in flatten([
      for peering in var.peerings : [
        for rt_name, rt_id in var.route_table_ids : {
          key            = "${peering.name}-${rt_name}"
          route_table_id = rt_id
          peer_cidr      = peering.peer_cidr
          peering_name   = peering.name
        }
      ]
    ]) :
    pair.key => {
      route_table_id = pair.route_table_id
      peer_cidr      = pair.peer_cidr
      peering_name   = pair.peering_name
    }
  }

  route_table_id            = each.value.route_table_id
  destination_cidr_block    = each.value.peer_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.this[each.value.peering_name].id
}

resource "aws_security_group_rule" "peering" {
  for_each = {
    for idx, rule in var.peering_sg_rules :
    "${rule.security_group_name}-${rule.type}-${rule.from_port}-${rule.to_port}-${rule.protocol}-${idx}" => rule
  }

  type                     = each.value.type
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  security_group_id        = var.security_group_ids[each.value.security_group_name]
  cidr_blocks              = try(each.value.cidr_blocks, null)
  ipv6_cidr_blocks         = try(each.value.ipv6_cidr_blocks, null)
  source_security_group_id = try(length(each.value.security_groups) > 0 ? var.security_group_ids[each.value.security_groups[0]] : null, null)
  description              = try(each.value.description, null)
}
