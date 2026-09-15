resource "aws_ecs_cluster" "fargate_cluster" {
  name = var.ecs_fargate_cluster_name
  # Fix  CKV_AWS_65: Ensure container insights are enabled on ECS cluster
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

# 2. Force the cluster to use Fargate exclusively
resource "aws_ecs_cluster_capacity_providers" "fargate_only" {
  cluster_name = aws_ecs_cluster.fargate_cluster.name

  capacity_providers = ["FARGATE"]
}