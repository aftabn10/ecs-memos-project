provider "aws" {
  region = "eu-west-2"
}

# VPC
# This will give you 65,534 subnets
resource "aws_vpc" "vpc_memos" {
  cidr_block = "10.0.0.0/16"
}

# Public Subnet
resource "aws_subnet" "pub_subnet_ecs_memos" {
  vpc_id     = aws_vpc.vpc_memos.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public_subnet_memos"
  }
}

# Private Subnet
resource "aws_subnet" "priv_subnet_ecs_memos" {
  vpc_id     = aws_vpc.vpc_memos.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "private_subnet_memos"
  }
}

resource "aws_eip" "nat" {
  domain         = "vpc" 
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_memos.id

  tags = {
    Name = "igw_memos"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.pub_subnet_ecs_memos.id

  tags = {
    Name = "gw_NAT"
  }
  depends_on = [aws_internet_gateway.igw]
}

# Route Table
resource "aws_route_table" "rt_pub_memos" {
  vpc_id = aws_vpc.vpc_memos.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "rt_public_memos"
  }
}

# Route Table Association
resource "aws_route_table_association" "subnet_assoc" {
  subnet_id      = aws_subnet.pub_subnet_ecs_memos.id
  route_table_id = aws_route_table.rt_pub_memos.id
}

# Base SG for Memos ALB
resource "aws_security_group" "memos_alb_sg" {
  name        = "memos_alb_sg"
  description = "Security group for Memos ALB"
  vpc_id      = aws_vpc.vpc_memos.id

  tags = {
    Name = "sg_memos"
  }
}

# Phase 2 - Security Groups

# Allow HTTP (port 80) for ALB
resource "aws_vpc_security_group_ingress_rule" "memos_alb_inbound" {
  security_group_id = aws_security_group.memos_alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
}

# Allow all outbound traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.memos_alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Base SG for ECS ALB
resource "aws_security_group" "memos_sg" {
  name        = "memos_sg"
  description = "Security group for ECS ALB"
  vpc_id      = aws_vpc.vpc_memos.id

  tags = {
    Name = "sg_memos"
  }
}

# ECS Security Group
resource "aws_vpc_security_group_ingress_rule" "memos_sg_inbound" {
  security_group_id = aws_security_group.memos_sg.id
  ip_protocol       = "tcp"
  from_port         = 8081
  to_port           = 8081
  referenced_security_group_id = aws_security_group.memos_alb_sg.id
}
