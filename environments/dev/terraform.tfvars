vpc_cidr             = "92.10.0.0/22"
env                  = "dev"
vpc_instance_tenancy = "default"

azs = ["ap-southeast-2a", "ap-southeast-2b"]

subnet_cidrs = {
  "Frontend-1" = "92.10.0.0/26"
  "Frontend-2" = "92.10.0.64/26"
  "Backend-1"  = "92.10.1.0/26"
  "Backend-2"  = "92.10.1.64/26"
  "Database"   = "92.10.2.0/26"
  "Public-1"   = "92.10.3.0/26"
  "Public-2"   = "92.10.3.64/26"
}

my_ip_cidr   = "203.0.113.25/32"
backend_port = 8080
db_port      = 3306


