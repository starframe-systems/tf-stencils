
variable "bucket_name" {
  description = "The name of the S3 Bucket that is hosting the website"
  type        = string
}

variable "index_document_suffix" {
  description = "(Optional) Suffix that is appended to a request for a directory on the website endpoint. (e.g., 'index.html')"
  type        = string
  default     = "index.html"
}

variable "error_document" {
  description = "(Optional) Object key name to use when a 4XX class error occurs."
  type        = string
  default     = "error.html"
}

variable "inherited_tags" {
  type        = map(string)
  description = "Map of tags inherited from parent context."
  default     = {}
}
