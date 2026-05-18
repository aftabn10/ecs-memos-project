output "alb_security_group_id" {
    value = aws_security_group.memos_alb_sg.id
}

output "ecs_security_group_id" {
    value = aws_security_group.memos_ecs_sg.id
}