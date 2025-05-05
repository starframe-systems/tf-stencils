variable "enable_inheritance" {
  type        = bool
  description = "Expose inherited tags in output map when true"
  default     = true
}

variable "inherited_tags" {
  type        = map(string)
  description = "Map of inherited tags from parent context"
  default     = {}
}

variable "additional_tags" {
  type        = map(string)
  description = "Map of tags to add to the current context"
  default     = {}
}
