variable "domain_name" {
  type        = string
  description = "The domain name for the ACM certificate"
}

variable "validation_method" {
  type        = string
  description = "The validation method for the ACM certificate (DNS or EMAIL)"
  default     = "DNS"
}

variable "route53_zone_name" {
  type        = string
  description = "The Route 53 hosted zone name"
}