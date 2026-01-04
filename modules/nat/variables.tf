variable "env" {
  description = "Environment name (dev, prod, etc.)"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID where the NAT Gateway will be created"
  type        = string
}

variable "igw_id" {
  description = "Internet Gateway ID (used only for dependency)"
  type        = string
}
