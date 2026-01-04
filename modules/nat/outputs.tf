output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = aws_nat_gateway.aws_nat.id
}

output "nat_eip_id" {
  description = "Elastic IP ID attached to NAT Gateway"
  value       = aws_eip.nat.id
}

output "nat_eip_public_ip" {
  description = "Public IP address of the NAT Gateway"
  value       = aws_eip.nat.public_ip
}
