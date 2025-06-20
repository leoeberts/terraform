resource "aws_vpc" "main" {
  cidr_block                       = var.vpc_cidr_block
  assign_generated_ipv6_cidr_block = var.vpc_assign_generated_ipv6_cidr_block
  enable_dns_support               = var.vpc_enable_dns_support
  enable_dns_hostnames             = var.vpc_enable_dns_hostnames
  instance_tenancy                 = var.vpc_instance_tenancy

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "private_1a" {
  vpc_id                          = aws_vpc.main.id
  cidr_block                      = var.subnet_private_1a_cidr
  availability_zone               = var.subnet_private_1a_az
  ipv6_cidr_block                 = var.subnet_private_1a_ipv6
  map_public_ip_on_launch         = false
  assign_ipv6_address_on_creation = false

  tags = {
    Name = var.subnet_private_1a_name
  }
}

resource "aws_subnet" "private_1b" {
  vpc_id                          = aws_vpc.main.id
  cidr_block                      = var.subnet_private_1b_cidr
  availability_zone               = var.subnet_private_1b_az
  ipv6_cidr_block                 = var.subnet_private_1b_ipv6
  map_public_ip_on_launch         = false
  assign_ipv6_address_on_creation = false

  tags = {
    Name = var.subnet_private_1b_name
  }
}

resource "aws_subnet" "private_1c" {
  vpc_id                          = aws_vpc.main.id
  cidr_block                      = var.subnet_private_1c_cidr
  availability_zone               = var.subnet_private_1c_az
  ipv6_cidr_block                 = var.subnet_private_1c_ipv6
  map_public_ip_on_launch         = false
  assign_ipv6_address_on_creation = false

  tags = {
    Name = var.subnet_private_1c_name
  }
}

resource "aws_subnet" "public_1a" {
  vpc_id                          = aws_vpc.main.id
  cidr_block                      = var.subnet_public_1a_cidr
  availability_zone               = var.subnet_public_1a_az
  ipv6_cidr_block                 = var.subnet_public_1a_ipv6
  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true

  tags = {
    Name = var.subnet_public_1a_name
  }
}

resource "aws_subnet" "public_1b" {
  vpc_id                          = aws_vpc.main.id
  cidr_block                      = var.subnet_public_1b_cidr
  availability_zone               = var.subnet_public_1b_az
  ipv6_cidr_block                 = var.subnet_public_1b_ipv6
  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true

  tags = {
    Name = var.subnet_public_1b_name
  }
}

resource "aws_subnet" "public_1c" {
  vpc_id                          = aws_vpc.main.id
  cidr_block                      = var.subnet_public_1c_cidr
  availability_zone               = var.subnet_public_1c_az
  ipv6_cidr_block                 = var.subnet_public_1c_ipv6
  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true

  tags = {
    Name = var.subnet_public_1c_name
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.public_route_table_name
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw_name
  }
}

resource "aws_route" "public_igw_ipv4" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route" "public_igw_ipv6" {
  route_table_id              = aws_route_table.public.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.main.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.private_route_table_name
  }
}

resource "aws_route_table_association" "private_1a" {
  subnet_id      = aws_subnet.private_1a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_1b" {
  subnet_id      = aws_subnet.private_1b.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_1c" {
  subnet_id      = aws_subnet.private_1c.id
  route_table_id = aws_route_table.private.id
}

resource "aws_default_network_acl" "default" {
  default_network_acl_id = var.default_acl_id
  subnet_ids = [
    aws_subnet.private_1a.id,
    aws_subnet.private_1b.id,
    aws_subnet.private_1c.id,
    aws_subnet.public_1a.id,
    aws_subnet.public_1b.id,
    aws_subnet.public_1c.id
  ]

  ingress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    rule_no         = 101
    protocol        = "-1"
    action          = "allow"
    ipv6_cidr_block = "::/0"
    from_port       = 0
    to_port         = 0
  }

  egress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    rule_no         = 101
    protocol        = "-1"
    action          = "allow"
    ipv6_cidr_block = "::/0"
    from_port       = 0
    to_port         = 0
  }

  tags = {
    Name = var.default_acl_name
  }
}
