resource "aws_security_group" "this" {
  for_each    = { for sg in var.security_groups : sg.name => sg }
  name        = each.value.name
  description = each.value.description
  vpc_id      = var.vpc_id
}

# Rules with self = true
resource "aws_security_group_rule" "self" {
  for_each = {
    for k, rule in var.security_group_rules : k => rule
    if lookup(rule, "self", false) == true
  }
  type              = each.value.type
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  security_group_id = aws_security_group.this[each.value.security_group_name].id
  self              = true
  description       = lookup(each.value, "description", null)
}

# Rules with source_security_group_id
resource "aws_security_group_rule" "sg" {
  for_each = {
    for k, rule in var.security_group_rules : k => rule
    if length(coalesce(lookup(rule, "security_groups", []), [])) > 0
  }
  type                     = each.value.type
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  security_group_id        = aws_security_group.this[each.value.security_group_name].id
  source_security_group_id = aws_security_group.this[lookup(each.value, "security_groups", [])[0]].id
  description              = lookup(each.value, "description", null)
}

# Rules with cidr_blocks
resource "aws_security_group_rule" "cidr" {
  for_each = {
    for k, rule in var.security_group_rules : k => rule
    if length(coalesce(lookup(rule, "cidr_blocks", []), [])) > 0
  }
  type              = each.value.type
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  security_group_id = aws_security_group.this[each.value.security_group_name].id
  cidr_blocks       = each.value.cidr_blocks
  description       = lookup(each.value, "description", null)
}

# Rules with ipv6_cidr_blocks
resource "aws_security_group_rule" "ipv6" {
  for_each = {
    for k, rule in var.security_group_rules : k => rule
    if length(coalesce(lookup(rule, "ipv6_cidr_blocks", []), [])) > 0
  }
  type              = each.value.type
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  security_group_id = aws_security_group.this[each.value.security_group_name].id
  ipv6_cidr_blocks  = each.value.ipv6_cidr_blocks
  description       = lookup(each.value, "description", null)
}
