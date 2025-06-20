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
        for rt_id in var.route_table_ids : {
          peering = peering
          rt_id   = rt_id
        }
      ]
    ]) :
    "${pair.peering.name}-${pair.rt_id}" => {
      route_table_id = pair.rt_id
      peer_cidr      = pair.peering.peer_cidr
      peering_name   = pair.peering.name
    }
  }

  route_table_id            = each.value.route_table_id
  destination_cidr_block    = each.value.peer_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.this[each.value.peering_name].id
}
