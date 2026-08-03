output "ecs_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  value = aws_iam_role.ecs_execution.arn
}

output "github_actions_role_arn" {
  description = "ARN of the GitHub Actions OIDC role"
  value       = aws_iam_role.github_actions_oidc.arn
}