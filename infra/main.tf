provider "aws" {
  region = "eu-west-2"
}

# The following is the only thing that should be here
module "vpc" {
  source                = "../modules/vpc"
  vpc_cidr_block        = "10.0.0.0/16"
  public_subnet_cidr    = "10.0.1.0/24"
  private_subnet_cidr   = "10.0.2.0/24"
  route_table_cidr      = "0.0.0.0/0"
  eip_nat               = "vpc" 
  vpc_nat_gateway       = "enabled"
}

module "security_groups" {
  source                    = "../modules/security_groups"
  vpc_id                    = module.vpc.vpc_id 
  memos_alb_sg_name         = "memos_alb_sg"
  memos_alb_sg_description  = "Security Group for Memos ALB"
}