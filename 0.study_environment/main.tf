module "network" {
  source            = "./modules/network"
  vpc               = var.vpc
  igw_name          = var.igw_name
  default_acl_id    = var.default_acl_id
  default_acl_name  = var.default_acl_name
  subnets           = var.subnets
  route_tables      = var.route_tables
  routes            = var.routes
  associations      = var.associations
  network_acl_rules = var.network_acl_rules
}

module "security" {
  source = "./modules/security"

  vpc_id = module.network.vpc_id

  security_groups = var.security_groups
  security_group_rules = concat(
    var.default_sg_rules,
    var.web_access_rules,
    var.internal_access_rules
  )
}

module "peering" {
  source             = "./modules/peering"
  vpc_id             = module.network.vpc_id
  peerings           = var.peerings
  route_table_ids    = [for k, v in module.network.route_table_ids : v]
  peering_sg_rules   = var.peering_sg_rules
  security_group_ids = module.security.security_group_ids
}
