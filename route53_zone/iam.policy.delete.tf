data "aws_iam_policy_document" "write" {
  statement {
    sid = "route53hostedzone"

    actions = [
      "route53:AssociateVPCWithHostedZone",
      "route53:ChangeResourceRecordSets",
      "route53:ChangeTagsForResource",
      "route53:DisableHostedZoneDNSSEC",
      "route53:DisassociateVPCFromHostedZone",
      "route53:EnableHostedZoneDNSSEC",
      "route53:GetHostedZone",
      "route53:ListResourceRecordSets",
      "route53:ListTagsForResource",
      "route53:ListTagsForResources",
      "route53:UpdateHostedZoneComment",
    ]

    resources = [
      var.created_by_route53_registrar ? data.aws_route53_zone.this[0].arn : aws_route53_zone.this[0].arn
    ]
  }

  statement {
    sid = "route53change"

    actions = [
      "route53:GetChange",
    ]

    resources = [
      "arn:aws:route53:::change/*"
    ]
  }

  statement {
    sid = "route53listhostedzones"

    actions = [
      "route53:ListHostedZones"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "write" {
  name        = "${local.prefix}Route53WriteAccess"
  description = "Route53 cross-account access for ${local.prefix}"
  policy      = data.aws_iam_policy_document.write.json
}

resource "aws_iam_role_policy_attachment" "write" {
  role       = var.role_name
  policy_arn = aws_iam_policy.write.arn
}
