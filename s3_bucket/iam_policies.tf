
resource "aws_iam_policy" "list" {
  name   = "${aws_s3_bucket.default.id}-bucket-list"
  policy = data.aws_iam_policy_document.list.json
  tags   = local.resource_tags
}

resource "aws_iam_policy" "list_get" {
  name   = "${aws_s3_bucket.default.id}-bucket-list-get"
  policy = data.aws_iam_policy_document.list_get.json
  tags   = local.resource_tags
}

resource "aws_iam_policy" "list_get_put" {
  name   = "${aws_s3_bucket.default.id}-bucket-list-get-put"
  policy = data.aws_iam_policy_document.list_get_put.json
  tags   = local.resource_tags
}

resource "aws_iam_policy" "list_get_put_delete" {
  name   = "${aws_s3_bucket.default.id}-bucket-list-get-put-delete"
  policy = data.aws_iam_policy_document.list_get_put_delete.json
  tags   = local.resource_tags
}
