resource "aws_vpc" "Production-Abhishek-VPC" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = var.vpc_instance_tenancy

  tags = {
    Name = "${var.env}-vpc"
  }
}
