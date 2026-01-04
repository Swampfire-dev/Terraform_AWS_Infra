variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "igw_id" {
  description = "Internet Gateway ID"
  type        = string
}

variable "nat_gateway_id" {
  description = "NAT Gateway ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs (ALB, Bastion, NAT)"
  type        = list(string)
}

variable "private_app_subnet_ids" {
  description = "Private app subnet IDs (Frontend + Backend)"
  type        = list(string)
}

variable "private_db_subnet_ids" {
  description = "Private DB subnet IDs"
  type        = list(string)
}
