variable "domain_name" {
  type        = string
  description = "Name of the Route53 Hosted Zone"
}

variable "created_by_route53_registrar" {
  description = "True if the Route53 Zone was automatically created by the AWS Domain Registrar"
  type        = bool
  default     = false
}

variable "account_name" {
  description = "Account alias of the AWS account within the Organization heirarchy"
  type        = string
  default     = null
}

variable "role_name" {
  description = "Name of the IAM Role that provides cross-account Route53 access"
  type        = string
}

variable "inherited_tags" {
  type        = map(string)
  description = "Map of tags inherited from parent context"
  default     = {}
}
