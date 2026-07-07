variable "vpc_id" {
    type = string
}

variable "memos_alb_sg_name" {
  description = "Security Group Name for ALB"
  type        = string
}

variable "memos_alb_sg_description" {
    description = "Security Group Description for ALB"
    type = string
}

variable "inbound_cidr_ipv4" {
    description = "CIDR for ALB SG Inbound Rules"
    type = string
}

variable "inbound_ip_protocol" {
    description = "IP Type for ALB SG Inbound Rules"
}

variable "alb_from_port" {
    type = number
    description = "From Port for ALB SG Inbound Rules"
}

variable "alb_to_port" {
    type = number
    description = "To Port for ALB SG Inbound Rules"
}

variable "outbound_cidr_ipv4" {
    description = "CIDR for ALB SG Outbound Rules"
    type = string
}

variable "outbound_ip_protocol" {
    description = "IP Type for ALB SG Outbound Rules"
}

# Variables for HTTPS Inbound Rules
variable "https_inbound_cidr_ipv4" {
    description = "CIDR for ALB SG Inbound Rules"
    type = string
}

variable "https_inbound_ip_protocol" {
    description = "IP Type for ALB SG Inbound Rules"
}

variable "https_from_port" {
    type = number
    description = "From Port for ALB SG Inbound Rules"
}

variable "https_to_port" {
    type = number
    description = "To Port for ALB SG Inbound Rules"
}

variable "memos_ecs_sg_name" {
  description = "Security Group Name for ECS ALB"
  type        = string
}

variable "memos_ecs_sg_description" {
    description = "Security Group Description for ECS ALB"
    type = string
}

# ECS SG Variables
variable "ecs_inbound_ip_protocol" {
    description = "IP Type for ALB SG Inbound Rules"
}

variable "ecs_from_port" {
    description = "From Port for ALB SG Inbound Rules"
}

variable "ecs_to_port" {
    description = "To Port for ALB SG Inbound Rules"
}

variable "ecs_outbound_cidr_ipv4" {
    description = "CIDR for ECS SG Outbound Rules"
    type = string
}

variable "ecs_outbound_ip_protocol" {
    description = "IP Type for ECS SG Outbound Rules"
}


