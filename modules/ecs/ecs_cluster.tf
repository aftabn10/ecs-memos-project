resource "aws_ecs_cluster" "fargate_cluster" {
  name = var.ecs_fargate_cluster_name
# No setting block means Container Insights is OFF by default
}

# 2. Force the cluster to use Fargate exclusively
resource "aws_ecs_cluster_capacity_providers" "fargate_only" {
  cluster_name = aws_ecs_cluster.fargate_cluster.name

  capacity_providers = ["FARGATE"]
}