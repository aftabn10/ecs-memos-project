resource "aws_ecs_service" "ecr_memo_service" {
  name                              = var.service_name
  cluster                           = aws_ecs_cluster.fargate_cluster.arn 
  task_definition                   = aws_ecs_task_definition.service.arn 
  launch_type                       = var.service_launch_type
  desired_count                     = var.service_desired_count
  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  depends_on = [
    aws_ecs_cluster.fargate_cluster,
    aws_ecs_task_definition.service
  ]

  # Network configuration (required for Fargate)
  network_configuration {
    subnets                         = var.private_subnet_ids
    security_groups                 = [var.ecs_service_sg_id]
    assign_public_ip                = false
  }

  load_balancer {
    target_group_arn                = var.target_group_arn
    container_name                  = "ecs"
    container_port                  = 8081
  }
}