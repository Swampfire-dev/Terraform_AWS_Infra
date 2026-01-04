resource "aws_internet_gateway" "dev-igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.env}-igw"
  }
}
