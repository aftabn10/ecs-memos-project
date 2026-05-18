# Base SG for Memos ALB
resource "aws_security_group" "memos_alb_sg" {
  name              = var.memos_alb_sg_name
  description       = var.memos_alb_sg_description
  vpc_id            = var.vpc_id

  tags = {
    Name = "sg_alb_memos"
  }
}

# Allow HTTP (port 80) for ALB
resource "aws_vpc_security_group_ingress_rule" "memos_alb_inbound" {
  security_group_id = aws_security_group.memos_alb_sg.id
  cidr_ipv4         = var.inbound_cidr_ipv4
  ip_protocol       = var.inbound_ip_protocol
  from_port         = var.alb_from_port
  to_port           = var.alb_to_port
}

# Allow all outbound traffic
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.memos_alb_sg.id
  cidr_ipv4         = var.outbound_cidr_ipv4
  ip_protocol       = var.outbound_ip_protocol
}

#####################################################################

# # Base SG for ECS ALB
resource "aws_security_group" "memos_ecs_sg" {
  name              = var.memos_ecs_sg_name
  description       = var.memos_ecs_sg_description
  vpc_id            = var.vpc_id

  tags = {
    Name = "sg_ecs_memos"
  }
}

# ECS Security Group
resource "aws_vpc_security_group_ingress_rule" "memos_ecs_sg_inbound" {
  security_group_id = aws_security_group.memos_ecs_sg.id
  ip_protocol       = var.ecs_inbound_ip_protocol
  from_port         = var.ecs_from_port
  to_port           = var.ecs_to_port
  referenced_security_group_id = aws_security_group.memos_alb_sg.id
}