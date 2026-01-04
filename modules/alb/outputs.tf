output "public_alb_arn" {
  value = aws_lb.public_alb.arn
}

output "backend_alb_arn" {
  value = aws_lb.backend_alb.arn
}

output "frontend_target_group_arn" {
  value = aws_lb_target_group.frontend_tg.arn
}

output "backend_target_group_arn" {
  value = aws_lb_target_group.backend_tg.arn
}
