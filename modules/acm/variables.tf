variable "domain_name" {
    type        = string
    description = "The domain name for the ACM certificate"
}

variable "validation_method" {
    type        = string
    description = "The validation method for the ACM certificate (DNS or EMAIL)"
    default     = "DNS"
}