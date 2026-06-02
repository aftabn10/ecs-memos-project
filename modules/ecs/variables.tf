variable "ecr_image_url" {
  type = string
}

variable "task_definition_cpu" {
    type = number
}

variable "task_definition_memory" {
    type = number
}

variable "execution_role_arn" { 
    type = string 
}

variable "task_role_arn"      { 
    type = string
    default = null
}

# Cluster
variable "ecs_fargate_cluster_name" {
    type = string
}

#Volume
variable "volume_name" {
    type = string
}

# Mount Point Path
variable "container_mount_path" {
    type = string
}

variable "service_name" {
    type = string
}

variable "service_launch_type" {
    type = string
}

variable "service_desired_count" {
    type = string
}

variable "health_check_grace_period_seconds" {
    type = number
}

variable "private_subnet_ids" { 
    type = list(string) 
}

variable "ecs_service_sg_id" { 
    type = string 
}

variable "target_group_arn" { 
    type = string 
}
