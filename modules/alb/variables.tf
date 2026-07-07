variable "vpc_id" {
    type = string
}

variable "alb_name" {
  description = "Name of Load Balancer"
  type = string
}

variable "alb_type" {
    description = "Type of ALB used"
    type = string
}

variable "alb_internal" {
    description = "Internal ALB used"
}

variable "alb_security_group_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "ip_tg_name" {
    type = string
}

variable "ip_tg_port" {
    type = string
}
  
variable "ip_tag_protocol" {
    type = string
}

variable "ip_target_type" {
    type = string
}

variable "tg_health_check_path" {
    type = string
}

variable "tg_interval" {
    type = number
}

variable "tg_timeout" {
    type = number
}

variable "tg_healthy_threshold" {
    type = number
}

variable "tg_unhealthy_threshold" {
    type = number
} 

variable "listener_port" {
  type    = number
  default = 80
}

variable "listener_protocol" {
  type    = string
  default = "HTTP"
}

variable "https_listener_port" {
  type    = number
  default = 443
}

variable "https_listener_protocol" {
  type    = string
  default = "HTTP"
}

variable "certificate_arn" {
  type = string
}