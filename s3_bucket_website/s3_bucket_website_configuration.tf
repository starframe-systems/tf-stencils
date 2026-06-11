resource "aws_s3_bucket_website_configuration" "default" {
  bucket = var.bucket_name

  index_document {
    suffix = var.index_document_suffix
  }

  error_document {
    key = var.error_document
  }

  routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": ""
    }
}]
EOF
}