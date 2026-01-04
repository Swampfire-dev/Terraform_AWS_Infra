# ------------------------------------------
# Variables 
# ------------------------------------------

variable "vpc_id" {
  description = "The ID of the VPC where subnets will be created"
  type        = string
}

variable "env" {
  description = "The environment name (used in subnet names)"
  type        = string
}

variable "azs" {
  description = "List of availability zones to deploy subnets in"
  type        = list(string)
}

variable "subnet_cidrs" {
  description = "Map of subnet names to their CIDR blocks"
  type        = map(string)
}


# ------------------------------------------
# Locals: subnet groups and AZ mapping
# ------------------------------------------
locals {
  subnet_groups = {
    frontend = ["Frontend-1", "Frontend-2"]
    backend  = ["Backend-1", "Backend-2"]
    database = ["Database"]
    public   = ["Public-1", "Public-2"]
  }

  az_index = {
    Frontend-1 = 0
    Frontend-2 = 1
    Backend-1  = 0
    Backend-2  = 1
    Database   = 0
    Public-1   = 0
    Public-2   = 1
  }

  subnet_types = {
    frontend = false
    backend  = false
    database = false
    public   = true
  }
}
