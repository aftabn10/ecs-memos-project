variable "vpc_cidr_block" {
  description = "CIDR Block for VPC"
  type        = string
}

# created dynamically with for_each and map(object)
variable "public_subnets" {
  type = map(object({
    availability_zone = string
    cidr_block        = string
  }))
}

# This is for the private subnet
variable "private_subnets" {
  type = map(object({
    availability_zone = string
    cidr_block        = string
  }))
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