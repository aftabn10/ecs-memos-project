# VPC
# This will give you 65,534 subnets
resource "aws_vpc" "vpc_memos" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "vpc_memos"
  }
}

# 1st Public Subnet
resource "aws_subnet" "public_subnet_memos_a" {
  vpc_id            = aws_vpc.vpc_memos.id
  cidr_block        = var.public_subnet_cidr_a
  availability_zone = "eu-west-2a" 

  tags = {
    Name = "public_subnet_memos_a"
  }
}

# 2nd Public Subnet
resource "aws_subnet" "public_subnet_memos_b" {
  vpc_id     = aws_vpc.vpc_memos.id
  cidr_block = var.public_subnet_cidr_b
  availability_zone = "eu-west-2b"

  tags = {
    Name = "public_subnet_memos_b"
  }
}

# 1st Private Subnet
resource "aws_subnet" "private_subnet_memos_a" {
  vpc_id     = aws_vpc.vpc_memos.id
  cidr_block = var.private_subnet_cidr_a
  availability_zone = "eu-west-2a"

  tags = {
    Name = "private_subnet_memos_a"
  }
}

# 2nd Private Subnet
resource "aws_subnet" "private_subnet_memos_b" {
  vpc_id     = aws_vpc.vpc_memos.id
  cidr_block = var.private_subnet_cidr_b
  availability_zone = "eu-west-2b"

  tags = {
    Name = "private_subnet_memos_b"
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
  subnet_id     = aws_subnet.public_subnet_memos_a.id

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

# Route Table Association - Public Subnet A
resource "aws_route_table_association" "subnet_a_assoc" {
  subnet_id      = aws_subnet.public_subnet_memos_a.id
  route_table_id = aws_route_table.route_table_memos.id
}

# Route Table Association - Public Subnet B
resource "aws_route_table_association" "subnet_b_assoc" {
  subnet_id      = aws_subnet.public_subnet_memos_b.id
  route_table_id = aws_route_table.route_table_memos.id
}

# Creating Route Table for NAT Gateway
resource "aws_route_table" "rt_NAT" {
    vpc_id = aws_vpc.vpc_memos.id
route {
        cidr_block = var.route_table_nat_cidr
        nat_gateway_id = aws_nat_gateway.vpc_nat_gateway.id
    }
tags = {
        Name = "Route Table for Private subnet"
    }
}

# Route Table Association - Private Subnet A
resource "aws_route_table_association" "private_subnet_a_assoc" {
    subnet_id      = aws_subnet.private_subnet_memos_a.id
    route_table_id = aws_route_table.rt_NAT.id
}

# Route Table Association - Private Subnet B
resource "aws_route_table_association" "private_subnet_b_assoc" {
    subnet_id      = aws_subnet.private_subnet_memos_b.id
    route_table_id = aws_route_table.rt_NAT.id
}