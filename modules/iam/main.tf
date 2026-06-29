# Trust policy for ECS tasks
data "aws_iam_policy_document" "ecs_task_trust" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Create the task execution role
resource "aws_iam_role" "ecs_execution" {
  name               = "ecs-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_trust.json

  tags = {
    Service   = "ecs"
    ManagedBy = "terraform"
  }
}

# Attach the AWS managed execution role policy
resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}