provider "aws" {
  region = "eu-west-2"
}

# The following is the only thing that should be here
module "vpc" {
  source                  = "../modules/vpc"
  vpc_cidr_block          = "10.0.0.0/16"
  public_subnet_cidr_a    = "10.0.1.0/24"
  public_subnet_cidr_b    = "10.0.2.0/24"
  private_subnet_cidr     = "10.0.3.0/24"
  route_table_cidr        = "0.0.0.0/0"
  eip_nat                 = "vpc" 
  vpc_nat_gateway         = "enabled"
}

module "security_groups" {
  source                    = "../modules/security_groups"
  vpc_id                    = module.vpc.vpc_id
  memos_alb_sg_name         = "memos_alb_sg"
  memos_alb_sg_description  = "Security Group for Memos ALB"
  inbound_cidr_ipv4         = "0.0.0.0/0"
  inbound_ip_protocol       = "tcp"
  alb_from_port             = "80"
  alb_to_port               = "80" 
  outbound_cidr_ipv4        = "0.0.0.0/0"
  outbound_ip_protocol      = "-1"
  memos_ecs_sg_name         = "memos_ecs_sg"
  memos_ecs_sg_description  = "Security group for ECS ALB"
  ecs_inbound_ip_protocol   = "tcp"
  ecs_from_port             = 8081
  ecs_to_port               = 8081
}

module "alb" {
  source                    = "../modules/alb"
  vpc_id                    = module.vpc.vpc_id
  alb_name                  = "memos-alb"
  alb_internal              = "false"
  alb_type                  = "application"
  alb_security_group_id     = module.security_groups.alb_security_group_id
  public_subnet_ids         = module.vpc.public_subnet_ids
  ip_tg_name                = "memos-tg"
  ip_tg_port                = 8081
  ip_tag_protocol           = "HTTP"
  ip_target_type            = "ip"
  tg_health_check_path      = "/healthz"
  tg_interval               = 30
  tg_timeout                = 10
  tg_healthy_threshold      = 2
  tg_unhealthy_threshold    = 5
}