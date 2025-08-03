
variable "inherited_tags" {
  type        = map(string)
  description = "Map of tags inherited from parent context"
  default     = {}
}
