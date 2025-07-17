peerings = [
  {
    name        = "peer-with-personal"
    peer_vpc_id = "vpc-09ae5bda14d06e230"
    peer_cidr   = "10.0.0.0/16"
  },
  {
    name        = "peer-with-main"
    peer_vpc_id = "vpc-0c28f6cd530e40b62"
    peer_cidr   = "10.1.0.0/16"
  }
]

peering_sg_rules = [
  {
    security_group_name = "Web-Access"
    type                = "ingress"
    from_port           = -1
    to_port             = -1
    protocol            = "icmp"
    cidr_blocks         = ["10.0.0.0/16"]
    description         = "peering-with-main"
  },
  {
    security_group_name = "Web-Access"
    type                = "ingress"
    from_port           = -1
    to_port             = -1
    protocol            = "icmp"
    cidr_blocks         = ["10.1.0.0/16"]
    description         = "peering-with-personal"
  }
]
