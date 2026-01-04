variable "vpc_id" {
  description = "VPC ID where SGs will be created"
  type        = string
}

variable "env" {
  description = "Environment name for tagging"
  type        = string
}

variable "my_ip_cidr" {
  description = "Your public IP CIDR for Bastion SSH access"
  type        = string
}

variable "backend_port" {
  description = "Port used by backend servers"
  type        = number
  default     = 8000
}

variable "db_port" {
  description = "Database port (MySQL/PostgreSQL)"
  type        = number
  default     = 3306
}

variable "subnet_cidrs" {
  description = "Map of subnet names to CIDR blocks"
  type        = map(string)
}
