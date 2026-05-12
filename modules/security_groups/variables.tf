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