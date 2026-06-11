data "aws_iam_policy_document" "list" {
  statement {
    sid = "List"
    actions = [
      "s3:ListBucket",
      "s3:ListBucketVersions",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.default.id}",
      "arn:aws:s3:::${aws_s3_bucket.default.id}/*",
    ]
  }
}

data "aws_iam_policy_document" "get" {
  statement {
    sid = "Get"
    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:GetObjectTagging",
      "s3:GetObjectTorrent",
      "s3:GetObjectVersion",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectVersionTagging",
      "s3:GetObjectVersionTorrent",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.default.id}/*"
    ]
  }
}

data "aws_iam_policy_document" "put" {
  statement {
    sid = "Put"
    actions = [
      "s3:ListBucketMultipartUploads",
      "s3:ListMultipartUploadParts",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:PutObjectTagging",
      "s3:PutObjectVersionAcl",
      "s3:PutObjectVersionTagging",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.default.id}/*"
    ]
  }
}

data "aws_iam_policy_document" "delete" {
  statement {
    sid = "Delete"
    actions = [
      "s3:RestoreObject",
      "s3:DeleteObject",
      "s3:DeleteObjectTagging",
      "s3:DeleteObjectVersion",
      "s3:DeleteObjectVersionTagging",
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.default.id}/*"
    ]
  }
}

data "aws_iam_policy_document" "list_get" {
  source_policy_documents = [
    data.aws_iam_policy_document.list.json,
    data.aws_iam_policy_document.get.json,
  ]
}

data "aws_iam_policy_document" "list_get_put" {
  source_policy_documents = [
    data.aws_iam_policy_document.list.json,
    data.aws_iam_policy_document.get.json,
    data.aws_iam_policy_document.put.json,
  ]
}

data "aws_iam_policy_document" "list_get_put_delete" {
  source_policy_documents = [
    data.aws_iam_policy_document.list.json,
    data.aws_iam_policy_document.get.json,
    data.aws_iam_policy_document.put.json,
    data.aws_iam_policy_document.delete.json,
  ]
}

