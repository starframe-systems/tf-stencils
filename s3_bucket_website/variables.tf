
variable "bucket_name" {
  description = "The name of the S3 Bucket that is hosting the website"
  type        = string
}

variable "index_document_suffix" {
  description = "(Optional) Suffix that is appended to a request for a directory on the website endpoint. (e.g., 'index.html')"
  type        = string
  default     = null
  # If not provided AND both redirect_all_requests_to and routing_rules are not provided, AWS will default to 'index.html'
}

variable "error_document" {
  description = "(Optional) Object key name to use when a 4XX class error occurs."
  type        = string
  default     = null
  # If not provided AND both redirect_all_requests_to and routing_rules are not provided, AWS will default to 'error.html'
}

variable "redirect_all_requests_to" {
  description = "(Optional) If all requests to the website endpoint should be redirected to another host name, specify the host name and protocol here."
  type        = object({
    host_name = string
    protocol = string
  })
  default     = null
}

variable "routing_rules" {
  description = "(Optional) A JSON string describing rules that define when a redirect is applied and the redirect behavior."
  type        = string
  default     = null
}

variable "inherited_tags" {
  type        = map(string)
  description = "Map of tags inherited from parent context."
  default     = {}
}
