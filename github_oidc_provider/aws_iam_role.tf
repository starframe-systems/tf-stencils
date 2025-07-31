data "aws_iam_policy_document" "default" {
  for_each = var.iam_role_policy_map

  statement {
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.default.id]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${each.key}:*"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values = [
        "sts.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "default" {
  for_each = data.aws_iam_policy_document.default

  name                 = "${each.key}-GithubOidcRolePolicy"
  description          = "Deploy access for Github Actions on authorized repositories"
  max_session_duration = 3600 # 1h
  assume_role_policy   = each.value.json
}

resource "aws_iam_role_policy_attachment" "default" {
  for_each = aws_iam_role.default

  role       = each.value.name
  policy_arn = var.iam_role_policy_map[each.key]
}
