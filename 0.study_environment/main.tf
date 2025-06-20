module "network" {
  source = "./modules/network"

  vpc_cidr_block                       = var.vpc_cidr_block
  vpc_enable_dns_support               = var.vpc_enable_dns_support
  vpc_enable_dns_hostnames             = var.vpc_enable_dns_hostnames
  vpc_assign_generated_ipv6_cidr_block = var.vpc_assign_generated_ipv6_cidr_block
  vpc_instance_tenancy                 = var.vpc_instance_tenancy
  vpc_name                             = var.vpc_name

  igw_name = var.igw_name

  public_route_table_name  = var.public_route_table_name
  private_route_table_name = var.private_route_table_name

  subnet_private_1a_cidr = var.subnet_private_1a_cidr
  subnet_private_1a_az   = var.subnet_private_1a_az
  subnet_private_1a_ipv6 = var.subnet_private_1a_ipv6
  subnet_private_1a_name = var.subnet_private_1a_name

  subnet_private_1b_cidr = var.subnet_private_1b_cidr
  subnet_private_1b_az   = var.subnet_private_1b_az
  subnet_private_1b_ipv6 = var.subnet_private_1b_ipv6
  subnet_private_1b_name = var.subnet_private_1b_name

  subnet_private_1c_cidr = var.subnet_private_1c_cidr
  subnet_private_1c_az   = var.subnet_private_1c_az
  subnet_private_1c_ipv6 = var.subnet_private_1c_ipv6
  subnet_private_1c_name = var.subnet_private_1c_name

  subnet_public_1a_cidr = var.subnet_public_1a_cidr
  subnet_public_1a_az   = var.subnet_public_1a_az
  subnet_public_1a_ipv6 = var.subnet_public_1a_ipv6
  subnet_public_1a_name = var.subnet_public_1a_name

  subnet_public_1b_cidr = var.subnet_public_1b_cidr
  subnet_public_1b_az   = var.subnet_public_1b_az
  subnet_public_1b_ipv6 = var.subnet_public_1b_ipv6
  subnet_public_1b_name = var.subnet_public_1b_name

  subnet_public_1c_cidr = var.subnet_public_1c_cidr
  subnet_public_1c_az   = var.subnet_public_1c_az
  subnet_public_1c_ipv6 = var.subnet_public_1c_ipv6
  subnet_public_1c_name = var.subnet_public_1c_name

  default_acl_id   = var.default_acl_id
  default_acl_name = var.default_acl_name
}

module "security" {
  source = "./modules/security"

  vpc_id = module.network.vpc_id

  sg_default_name = var.sg_default_name

  sg_web_name = var.sg_web_name

  sg_internal_name = var.sg_internal_name
}

module "peering" {
  source          = "./modules/peering"
  vpc_id          = module.network.vpc_id
  peerings        = var.peerings
  route_table_ids = [module.network.public_route_table_id, module.network.private_route_table_id]
}
