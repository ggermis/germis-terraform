# ---
#  The ACM SSL certificate used on our site. Note that this needs to be created in the
#  us-east-1 region in order to work with AWS CloudFront
# ---

resource "aws_acm_certificate" "website" {
  provider          = aws.us-east-1
  domain_name       = local.domain_name
  validation_method = "DNS"
  tags = {
    CreatedBy = "terraform"
  }
}

resource "aws_acm_certificate_validation" "validation" {
  provider                = aws.us-east-1
  certificate_arn         = aws_acm_certificate.website.arn
  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn]
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.website.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      type    = dvo.resource_record_type
      record  = dvo.resource_record_value
      zone_id = data.aws_route53_zone.main.zone_id
    }
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  zone_id         = each.value.zone_id
  type            = each.value.type
  ttl             = 60
}