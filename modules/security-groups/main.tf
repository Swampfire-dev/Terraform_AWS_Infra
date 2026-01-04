################################
# Public ALB SG
################################
resource "aws_security_group" "alb_sg" {
  name        = "${var.env}-public-alb-sg"
  description = "Public ALB SG"
  vpc_id      = var.vpc_id
  tags        = { Name = "${var.env}-public-alb-sg" }
}

resource "aws_security_group_rule" "alb_http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_https_ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_egress_frontend" {
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.alb_sg.id
  source_security_group_id = aws_security_group.frontend_sg.id
}

################################
# Bastion SG
################################
resource "aws_security_group" "bastion_sg" {
  name        = "${var.env}-bastion-sg"
  description = "Bastion SG"
  vpc_id      = var.vpc_id
  tags        = { Name = "${var.env}-bastion-sg" }
}

resource "aws_security_group_rule" "bastion_ssh_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.bastion_sg.id
  cidr_blocks       = [var.my_ip_cidr]
}

resource "aws_security_group_rule" "bastion_egress_frontend" {
  type                     = "egress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.bastion_sg.id
  source_security_group_id = aws_security_group.frontend_sg.id
}

resource "aws_security_group_rule" "bastion_egress_backend" {
  type                     = "egress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.bastion_sg.id
  source_security_group_id = aws_security_group.backend_sg.id
}

resource "aws_security_group_rule" "bastion_egress_db" {
  type                     = "egress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.bastion_sg.id
  source_security_group_id = aws_security_group.db_sg.id
}

################################
# Frontend SG
################################
resource "aws_security_group" "frontend_sg" {
  name        = "${var.env}-frontend-sg"
  description = "Frontend SG"
  vpc_id      = var.vpc_id
  tags        = { Name = "${var.env}-frontend-sg" }
}

resource "aws_security_group_rule" "frontend_http_ingress" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.frontend_sg.id
  source_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "frontend_https_ingress" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.frontend_sg.id
  source_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "frontend_ssh_ingress" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.frontend_sg.id
  source_security_group_id = aws_security_group.bastion_sg.id
}

resource "aws_security_group_rule" "frontend_backend_alb_egress" {
  type                     = "egress"
  from_port                = var.backend_port
  to_port                  = var.backend_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.frontend_sg.id
  source_security_group_id = aws_security_group.backend_alb_sg.id
}

resource "aws_security_group_rule" "frontend_all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.frontend_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

################################
# Backend ALB SG
################################
resource "aws_security_group" "backend_alb_sg" {
  name        = "${var.env}-backend-alb-sg"
  description = "Backend ALB SG"
  vpc_id      = var.vpc_id
  tags        = { Name = "${var.env}-backend-alb-sg" }
}

resource "aws_security_group_rule" "backend_alb_ingress" {
  type                     = "ingress"
  from_port                = var.backend_port
  to_port                  = var.backend_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.backend_alb_sg.id
  source_security_group_id = aws_security_group.frontend_sg.id
}

resource "aws_security_group_rule" "backend_alb_egress" {
  type                     = "egress"
  from_port                = var.backend_port
  to_port                  = var.backend_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.backend_alb_sg.id
  source_security_group_id = aws_security_group.backend_sg.id
}

################################
# Backend SG
################################
resource "aws_security_group" "backend_sg" {
  name        = "${var.env}-backend-sg"
  description = "Backend SG"
  vpc_id      = var.vpc_id
  tags        = { Name = "${var.env}-backend-sg" }
}

resource "aws_security_group_rule" "backend_ingress_alb" {
  type                     = "ingress"
  from_port                = var.backend_port
  to_port                  = var.backend_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.backend_sg.id
  source_security_group_id = aws_security_group.backend_alb_sg.id
}

resource "aws_security_group_rule" "backend_ssh_ingress" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.backend_sg.id
  source_security_group_id = aws_security_group.bastion_sg.id
}

resource "aws_security_group_rule" "backend_db_egress" {
  type                     = "egress"
  from_port                = var.db_port
  to_port                  = var.db_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.backend_sg.id
  source_security_group_id = aws_security_group.db_sg.id
}

resource "aws_security_group_rule" "backend_all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.backend_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

################################
# Database SG
################################
resource "aws_security_group" "db_sg" {
  name        = "${var.env}-db-sg"
  description = "Database SG"
  vpc_id      = var.vpc_id
  tags        = { Name = "${var.env}-db-sg" }
}

resource "aws_security_group_rule" "db_ingress_backend" {
  type                     = "ingress"
  from_port                = var.db_port
  to_port                  = var.db_port
  protocol                 = "tcp"
  security_group_id        = aws_security_group.db_sg.id
  source_security_group_id = aws_security_group.backend_sg.id
}
