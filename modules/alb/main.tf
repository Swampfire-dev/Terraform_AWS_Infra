# ------------------------------
# PUBLIC ALB
# ------------------------------
resource "aws_lb" "public_alb" {
  name               = "${var.env}-public-alb"
  internal           = false               # internet-facing
  load_balancer_type = "application"
  subnets            = var.public_subnets  # list of public subnet IDs
  enable_deletion_protection = false
  security_groups    = [var.alb_sg_id]     # attach SG allowing 80/443 from internet
}

resource "aws_lb_target_group" "frontend_tg" {
  name     = "${var.env}-frontend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 30
    timeout             = 5
  }
}

resource "aws_lb_listener" "public_http" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "frontend_attach" {
  for_each = toset(var.frontend_instance_ids)  # can be empty for now
  target_group_arn = aws_lb_target_group.frontend_tg.arn
  target_id        = each.value
  port             = 80
}

# ------------------------------
# BACKEND ALB (Internal)
# ------------------------------
resource "aws_lb" "backend_alb" {
  name               = "${var.env}-backend-alb"
  internal           = true                  # internal-only
  load_balancer_type = "application"
  subnets            = var.backend_subnets   # list of private backend subnet IDs
  enable_deletion_protection = false
  security_groups    = [var.backend_alb_sg_id] # attach SG allowing only frontend ALB
}

resource "aws_lb_target_group" "backend_tg" {
  name     = "${var.env}-backend-tg"
  port     = var.backend_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/health"
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 30
    timeout             = 5
  }
}

resource "aws_lb_listener" "backend_listener" {
  load_balancer_arn = aws_lb.backend_alb.arn
  port              = var.backend_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "backend_attach" {
  for_each = toset(var.backend_instance_ids)  # can be empty for now
  target_group_arn = aws_lb_target_group.backend_tg.arn
  target_id        = each.value
  port             = var.backend_port
}
