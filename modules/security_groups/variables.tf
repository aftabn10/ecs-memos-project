variable "vpc_id" {
  type = string
}

variable "memos_alb_sg_name" {
  description = "Security Group Name for ALB"
  type        = string
}

variable "memos_alb_sg_description" {
  description = "Security Group Description for ALB"
  type        = string
}

# Updated Inbound Rules
variable "memos_alb_inbound" {
  type = map(object({
    cidr_ipv4   = string
    ip_protocol = string
    from_port   = number
    to_port     = number
    # Fix CKV_AWS_23: Ensure every SG and rule has a description
    description = string
  }))
}

#here
# variable "inbound_cidr_ipv4" {
#   description = "CIDR for ALB SG Inbound Rules"
#   type        = string
# }

# variable "inbound_ip_protocol" {
#   description = "IP Type for ALB SG Inbound Rules"
# }

# variable "alb_from_port" {
#   type        = number
#   description = "From Port for ALB SG Inbound Rules"
# }

# variable "alb_to_port" {
#   type        = number
#   description = "To Port for ALB SG Inbound Rules"
# }
# to here

variable "outbound_cidr_ipv4" {
  description = "CIDR for ALB SG Outbound Rules"
  type        = string
}

variable "outbound_ip_protocol" {
  description = "IP Type for ALB SG Outbound Rules"
}

# Variables for HTTPS Inbound Rules
# variable "https_inbound_cidr_ipv4" {
#   description = "CIDR for ALB SG Inbound Rules"
#   type        = string
# }

# variable "https_inbound_ip_protocol" {
#   description = "IP Type for ALB SG Inbound Rules"
# }

# variable "https_from_port" {
#   type        = number
#   description = "From Port for ALB SG Inbound Rules"
# }

# variable "https_to_port" {
#   type        = number
#   description = "To Port for ALB SG Inbound Rules"
# }
# stop here

variable "memos_ecs_sg_name" {
  description = "Security Group Name for ECS ALB"
  type        = string
}

variable "memos_ecs_sg_description" {
  description = "Security Group Description for ECS ALB"
  type        = string
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
  type        = string
}

variable "ecs_outbound_ip_protocol" {
  description = "IP Type for ECS SG Outbound Rules"
}

# Fix CKV_AWS_23: Ensure every SG and rule has a description
variable "outbound_description" {
  description = "Allow all outbound traffic"
}
variable "ecs_inbound_description" {
  description = "Allow inbound reverse-proxy traffic from the ALB"
}
variable "ecs_outbound_description" {
  description = "Allow all container outbound traffic to the internet"
}
# Fix CKV_AWS_23: Complete