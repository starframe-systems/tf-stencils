
variable "iam_role_policy_map" {
  description = "Map of repository names to policy ARNs"
  type        = map(string)
  default     = {}
}

variable "inherited_tags" {
  type        = map(string)
  description = "Map of tags inherited from parent context"
  default     = {}
}
