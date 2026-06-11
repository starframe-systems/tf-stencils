
# resource "aws_iam_policy" "github-deploy" {
#   name_prefix = "${replace(var.name, " ", "")}GithubDeploy"
#   policy      = data.aws_iam_policy_document.github-deploy-policy.json
# }

# data "aws_iam_policy_document" "github-deploy-policy" {
#   statement {
#     effect  = "Allow"
#     actions = ["s3:ListBucket"]
#     resources = [
#       "${module.client_static_hosting.bucket_arn}",
#     ]
#   }
#   statement {
#     effect = "Allow"
#     actions = [
#       "s3:PutObject",
#       "s3:GetObject",
#       "s3:DeleteObject",
#     ]
#     resources = [
#       "${module.client_static_hosting.bucket_arn}",
#       "${module.client_static_hosting.bucket_arn}/*",
#     ]
#   }

#   statement {
#     effect = "Allow"
#     actions = [
#       "cloudfront:CreateInvalidation",
#     ]
#     resources = [
#       "${aws_cloudfront_distribution.static-hosting.arn}",
#     ]
#   }
# }
