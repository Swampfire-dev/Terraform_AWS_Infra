variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
}

variable "env" {
  type        = string
}

variable "vpc_instance_tenancy" {
  type        = string
  description = "VPC Instance Tenancy"
}
