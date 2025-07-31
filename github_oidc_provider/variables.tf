
variable "iam_role_policy_map" {
  description = "Map of repository names to policy ARNs"
  type        = map(string, string)
  default     = {}
}
