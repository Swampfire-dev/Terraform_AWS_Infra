resource "aws_subnet" "this" {
  for_each = {
    for subnet_name, cidr in var.subnet_cidrs : subnet_name => {
      tier = (
        contains(local.subnet_groups.frontend, subnet_name) ? "frontend" :
        contains(local.subnet_groups.backend, subnet_name)  ? "backend"  :
        contains(local.subnet_groups.database, subnet_name) ? "database" :
        contains(local.subnet_groups.public, subnet_name)   ? "public" :
        null
      )
      cidr = cidr
    } if contains(flatten(values(local.subnet_groups)), subnet_name)
  }

  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = var.azs[local.az_index[each.key]]

  map_public_ip_on_launch = local.subnet_types[each.value.tier]

  tags = {
    Name = "${var.env}-${each.key}"
    Tier = each.value.tier
  }
}
