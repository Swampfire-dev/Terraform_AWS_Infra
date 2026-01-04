module "vpc" {
  source               = "../../modules/vpc"
  vpc_cidr             = var.vpc_cidr
  env                  = var.env
  vpc_instance_tenancy = var.vpc_instance_tenancy
}


module "igw" {
  source      = "../../modules/igw"
  vpc_id      = module.vpc.vpc_id
  env         = var.env
}


module "subnet" {
  source  = "../../modules/subnet"
  vpc_id  = module.vpc.vpc_id
  env     = var.env
  azs     = var.azs
  subnet_cidrs = var.subnet_cidrs
}


module "security-groups" {
  source       = "../../modules/security-groups"
  vpc_id       = module.vpc.vpc_id
  env          = var.env
  my_ip_cidr   = var.my_ip_cidr
  backend_port = var.backend_port
  db_port      = var.db_port
  subnet_cidrs = var.subnet_cidrs
}


module "nat" {
  source            = "../../modules/nat"
  env               = var.env
  public_subnet_id  = module.subnet.public_subnet_id[0]
  igw_id            = module.igw.igw_id
}


module "route_tables" {
  source = "../../modules/route_table"
  env    = var.env
  vpc_id = module.vpc.vpc_id
  igw_id = module.igw.igw_id
  nat_gateway_id = module.nat.nat_gateway_id

  public_subnet_ids      = module.subnet.public_subnet_id
  private_app_subnet_ids = concat( module.subnet.frontend_subnet_ids, module.subnet.backend_subnet_ids )
  private_db_subnet_ids  = [module.subnet.database_subnet_id]
}


module "alb" {
  source                = "../../modules/alb"
  env                   = var.env
  vpc_id                = module.vpc.vpc_id
  public_subnets        = module.subnet.public_subnet_id
  backend_subnets       = module.subnet.backend_subnet_ids
  backend_port          = var.backend_port
  alb_sg_id             = module.security-groups.alb_sg_id
  backend_alb_sg_id     = module.security-groups.backend_alb_sg_id
  frontend_instance_ids = []
  backend_instance_ids  = []
}
