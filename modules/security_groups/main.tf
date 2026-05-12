# Base SG for Memos ALB
resource "aws_security_group" "memos_alb_sg" {
  name        = var.memos_alb_sg_name
  description = var.memos_alb_sg_description
  vpc_id      = var.vpc_id

  tags = {
    Name = "sg_memos"
  }
}

# # Phase 2 - Security Groups

# # Allow HTTP (port 80) for ALB
# resource "aws_vpc_security_group_ingress_rule" "memos_alb_inbound" {
#   security_group_id = aws_security_group.memos_alb_sg.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "tcp"
#   from_port         = 80
#   to_port           = 80
# }

# # Allow all outbound traffic
# resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
#   security_group_id = aws_security_group.memos_alb_sg.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1"
# }

# # Base SG for ECS ALB
# resource "aws_security_group" "memos_sg" {
#   name        = "memos_sg"
#   description = "Security group for ECS ALB"
#   vpc_id      = aws_vpc.vpc_memos.id

#   tags = {
#     Name = "sg_memos"
#   }
# }

# # ECS Security Group
# resource "aws_vpc_security_group_ingress_rule" "memos_sg_inbound" {
#   security_group_id = aws_security_group.memos_sg.id
#   ip_protocol       = "tcp"
#   from_port         = 8081
#   to_port           = 8081
#   referenced_security_group_id = aws_security_group.memos_alb_sg.id
# }