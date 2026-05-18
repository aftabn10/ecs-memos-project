output "alb_dns_name" {
  value = aws_lb.memos-alb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.ip_target_group.arn
}

output "listener_arn" {
  value = aws_lb_listener.http_listener.arn
}