resource "aws_ecs_task_definition" "service" {
  family                   = "service"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.task_definition_cpu
  memory                   = var.task_definition_memory
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
  volume {
    name                   = var.volume_name
  }
  container_definitions    = jsonencode([
    {
      name                 = "ecs"
      image                = "${var.ecr_image_url}:v3"
      essential            = true
      portMappings         = [
        {
          containerPort    = 5230
          hostPort         = 5230
        }
      ]
      mountPoints = [{
          sourceVolume     = var.volume_name
          containerPath    = var.container_mount_path
          readOnly         = false
        }]
      logConfiguration = {
      logDriver = "awslogs"

      options = {
        awslogs-group         = "/ecs/memos"
        awslogs-region        = "eu-west-2"
        awslogs-stream-prefix = "ecs"
      }
    }
  }
])
}