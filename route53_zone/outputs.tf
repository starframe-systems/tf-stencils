output "iam_policy_arn" {
  value = {
    "read-only" = aws_iam_policy.read-only.arn
    "modify"    = aws_iam_policy.modify.arn
  }
}

output "hosted_zone_id" {
  value = (var.created_by_route53_registrar ?
    data.aws_route53_zone.default[0].hosted_zone_id
  : aws_route53_zone.default[0].hosted_zone_id)
}

output "hosted_zone_arn" {
  value = (var.created_by_route53_registrar ?
    data.aws_route53_zone.default[0].arn
  : aws_route53_zone.default[0].arn)
}
