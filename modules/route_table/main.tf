# -------------------------------
# Public Route Table
# -------------------------------
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "${var.env}-public-rt"
  }
}

# Associate Public RT with public subnets
resource "aws_route_table_association" "public" {
  for_each = { for i, subnet_id in var.public_subnet_ids : i => subnet_id }

  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

# -------------------------------
# Private App Route Table (Frontend + Backend)
# -------------------------------
resource "aws_route_table" "private_app" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }

  tags = {
    Name = "${var.env}-private-app-rt"
  }
}

# Associate with frontend & backend subnets
resource "aws_route_table_association" "private_app" {
  for_each = { for i, subnet_id in var.private_app_subnet_ids : i => subnet_id }

  subnet_id      = each.value
  route_table_id = aws_route_table.private_app.id
}

# -------------------------------
# Private DB Route Table (NO INTERNET)
# -------------------------------
resource "aws_route_table" "private_db" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.env}-private-db-rt"
  }
}

resource "aws_route_table_association" "private_db" {
  for_each = { for i, subnet_id in var.private_db_subnet_ids : i => subnet_id }

  subnet_id      = each.value
  route_table_id = aws_route_table.private_db.id
}
