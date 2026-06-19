# Cloudfront Distribution

Creates a Cloudfront Distribution, with either an S3 Bucket or a custom domain as the origin.

## Example

```
module "frontend_cdn" {
  source = "git@github.com:starframe-systems/tf-stencils.git//cloudfront_distribution?ref=v0.1.13"

  description              = "Cloudfront Distribution to serve frontend assets"
  bucket_name              = "origin-bucket.organization-internal"
  distribution_domain_name = "cdn.example.org"
  route53_zone_id          = "ROUTE53_ZONE_ID"
}
```

## Variables

**`bucket_name`**

- **Description:** (Optional) The name of the S3 bucket that will serve as the origin for the CloudFront distribution.
- **Type:** `string`

**`origin_domain_name`**

- **Description:** (Optional) The domain name of the origin that will serve as the origin for the CloudFront distribution. This can be used instead of bucket_name if the origin is not an S3 bucket.
- **Type:** `string`

**`distribution_domain_name`**

- **Description:** The domain name to use for the CloudFront distribution.
- **Type:** `string`

**`description`**

- **Description:** A comment to describe the CloudFront distribution.
- **Type:** `string`

**`route53_zone_id`**

- **Description:** The ID of the Route 53 hosted zone that contains the domain name.
- **Type:** `string`

**`inherited_tags`**

- **Description:** Map of tags inherited from parent context.
- **Type:** `object(string)`

## Outputs

**`domain_name`**

- **Description:** The domain name of the CloudFront distribution. This is used to create Route 53 alias records.
