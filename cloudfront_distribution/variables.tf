
variable "bucket_name" {
  description = "(Optional) The name of the S3 bucket that will serve as the origin for the CloudFront distribution."
  type        = string
  default     = null
}

variable "origin_domain_name" {
  description = "(Optional) The domain name of the origin that will serve as the origin for the CloudFront distribution. This can be used instead of bucket_name if the origin is not an S3 bucket."
  type        = string
  default     = null
}

variable "distribution_domain_name" {
  description = "The domain name to use for the CloudFront distribution."
  type        = string
}

variable "description" {
  description = "A comment to describe the CloudFront distribution."
  type        = string
  default     = ""
}

variable "route53_zone_id" {
  description = "The ID of the Route 53 hosted zone that contains the domain name."
  type        = string
}

variable "inherited_tags" {
  type = map(string)
    description = "Map of tags inherited from parent context."
    default = {}
}
