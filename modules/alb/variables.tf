variable "env" {}

variable "vpc_id" {}

variable "public_subnets" {
  type = list(string)
}

variable "alb_sg_id" {}

variable "backend_alb_sg_id" {}

variable "backend_subnets" {
  type = list(string)
}

variable "backend_port" {
  type = number
}

variable "frontend_instance_ids" {
  type = list(string)
}

variable "backend_instance_ids" {
  type = list(string)
}
