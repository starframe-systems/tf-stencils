output "iam_policy_arn" {
  value = {
    "read-only" = aws_iam_policy.read-only.arn
    "modify"    = aws_iam_policy.modify.arn
  }
}

output "hosted_zone_id" {
  value = (var.created_by_route53_registrar ?
    data.aws_route53_zone.default[0].zone_id
  : aws_route53_zone.default[0].zone_id)
}

output "hosted_zone_arn" {
  value = (var.created_by_route53_registrar ?
    data.aws_route53_zone.default[0].arn
  : aws_route53_zone.default[0].arn)
}

output "name_servers" {
  value = (var.created_by_route53_registrar ?
    data.aws_route53_zone.default[0].name_servers
  : aws_route53_zone.default[0].name_servers)
}

output "primary_name_server" {
  value = (var.created_by_route53_registrar ?
    data.aws_route53_zone.default[0].primary_name_server
  : aws_route53_zone.default[0].primary_name_server)
}
