# Frontend subnet IDs
output "frontend_subnet_ids" {
  value = [for k, s in aws_subnet.this : s.id if s.tags["Tier"] == "frontend"]
  description = "List of frontend/private subnet IDs"
}

# Backend subnet IDs
output "backend_subnet_ids" {
  value = [for k, s in aws_subnet.this : s.id if s.tags["Tier"] == "backend"]
  description = "List of backend/private subnet IDs"
}

# Database subnet ID (single)
output "database_subnet_id" {
  value = [for k, s in aws_subnet.this : s.id if s.tags["Tier"] == "database"][0]
  description = "Database subnet ID"
}

# Public subnet ID (single)
output "public_subnet_id" {
  value = [for k, s in aws_subnet.this : s.id if s.tags["Tier"] == "public"]
  description = "Public subnet ID"
}
