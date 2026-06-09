variable "vpc_cidr_block" {
  description = "CIDR Block for VPC"
  type        = string
}

variable "public_subnet_cidr_a" {
  description = "CIDR Block for Public Subnet A"
  type = string
}

variable "public_subnet_cidr_b" {
  description = "CIDR Block for Public Subnet B"
  type = string
}

variable "private_subnet_cidr_a" {
  description = "CIDR Block for Private Subnet A"
  type = string
}

variable "private_subnet_cidr_b" {
  description = "CIDR Block for Private Subnet B"
  type = string
}

variable "vpc_nat_gateway" {
  description = "NAT Gateway for VPC"
  type = string
}

variable "route_table_cidr" {
  description = "CIDR for Route Table"
  type = string
}

variable "route_table_nat_cidr" {
  description = "CIDR for Private Route Table"
  type = string
}

variable "eip_nat" {
  description = "EIP Nat"
  type = string
}