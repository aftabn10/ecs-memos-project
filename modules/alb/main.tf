resource "aws_lb" "memos_alb" {
  name                = var.alb_name
  internal            = var.alb_internal
  load_balancer_type  = var.alb_type
  
  security_groups     = [var.alb_security_group_id]
  subnets             = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Environment = "memos-alb"
  }
}

resource "aws_lb_target_group" "ip_target_group" {
  name                = var.ip_tg_name
  port                = var.ip_tg_port
  protocol            = var.ip_tag_protocol
  target_type         = var.ip_target_type
  vpc_id              = var.vpc_id

health_check {
  path                = var.tg_health_check_path
  interval            = var.tg_interval
  timeout             = var.tg_timeout
  healthy_threshold   = var.tg_healthy_threshold
  unhealthy_threshold = var.tg_unhealthy_threshold    
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.memos_alb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ip_target_group.arn
  }
}

################################################################################
# create a listener on port 80 with redirect action
################################################################################
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.memos_alb.arn
  port              = var.https_listener_port
  protocol          = var.https_listener_protocol

  certificate_arn = var.certificate_arn
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ip_target_group.arn
  }
}
