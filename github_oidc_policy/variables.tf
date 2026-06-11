
variable "name" {
  description = "A name for the OIDC policy. This will be used as a prefix for the IAM role and policy names."
  type        = string
  default     = "GithubDeploy"
}

variable "repository" {
  description = "The GitHub repository in the format 'owner/repo' that will be allowed to assume the IAM role."
  type        = string
}

variable "openid_connect_provider_arn" {
  description = "The ARN of the OIDC provider to use for the IAM role trust relationship."
  type        = string
}

variable "policy_arns" {
  description = "A list of IAM policy ARNs to attach to the GitHub deploy role."
  type        = list(string)
  default     = []
}

variable "inherited_tags" {
  type        = map(string)
  description = "Map of tags inherited from parent context."
  default     = {}
}
