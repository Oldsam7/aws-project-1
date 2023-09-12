data "aws_route53_zone" "zone" {
  name         = var.zone_name
  private_zone = false
  provider     = aws
}

resource "aws_route53_record" "ap1" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "ap1.${data.aws_route53_zone.zone.name}"
  type    = "CNAME"
  ttl     = "60"
  records = ["${var.alb_dns}"]
}