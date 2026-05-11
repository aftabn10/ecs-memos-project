# VPC
# This will give you 65,534 subnets
resource "aws_vpc" "vpc_memos" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "vpc_memos"
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet_memos" {
  vpc_id     = aws_vpc.vpc_memos.id
  cidr_block = var.public_subnet_cidr

  tags = {
    Name = "public_subnet_memos"
  }
}

# Private Subnet
resource "aws_subnet" "private_subnet_memos" {
  vpc_id     = aws_vpc.vpc_memos.id
  cidr_block = var.private_subnet_cidr

  tags = {
    Name = "private_subnet_memos"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw_memos" {
  vpc_id = aws_vpc.vpc_memos.id

  tags = {
    Name = "igw_memos"
  }
}

# eip
resource "aws_eip" "eip_nat" {
  domain         = var.eip_nat 
}

# NAT Gateway
resource "aws_nat_gateway" "vpc_nat_gateway" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = aws_subnet.public_subnet_memos.id

  tags = {
    Name = "vpc_nat_gateway"
  }
  depends_on = [aws_internet_gateway.igw_memos]
}

# Route Table
resource "aws_route_table" "route_table_memos" {
  vpc_id = aws_vpc.vpc_memos.id

  route {
    cidr_block = var.route_table_cidr
    gateway_id = aws_internet_gateway.igw_memos.id
  }

  tags = {
    Name = "route_table_memos"
  }
}

# Route Table Association
resource "aws_route_table_association" "subnet_assoc" {
  subnet_id      = aws_subnet.public_subnet_memos.id
  route_table_id = aws_route_table.route_table_memos.id
}