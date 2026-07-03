output "alb_dns_name" {
  value = aws_lb.memos_alb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.ip_target_group.arn
}

output "listener_arn" {
  value = aws_lb_listener.http_listener.arn
}

output "alb_zone_id" {
  value = aws_lb.memos_alb.zone_id
}