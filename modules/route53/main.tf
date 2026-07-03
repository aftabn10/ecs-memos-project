data "aws_route53_zone" "primary" {
  name        = var.domain_name
}

resource "aws_route53_record" "alb_alias" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = var.record_name
  type    = "A"

  alias {
    name                   = var.dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}