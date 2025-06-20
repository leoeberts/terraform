resource "aws_vpc_peering_connection" "personal" {
  peer_vpc_id = var.peer_personal_vpc_id
  vpc_id      = var.vpc_id

  tags = {
    Name = var.peer_personal_name
  }
}

resource "aws_vpc_peering_connection" "main" {
  peer_vpc_id = var.peer_main_vpc_id
  vpc_id      = var.vpc_id

  tags = {
    Name = var.peer_main_name
  }
}
