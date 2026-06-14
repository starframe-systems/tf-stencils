variable "name" {
  type        = string
  description = "A unique name for the S3 Bucket"
}

variable "description" {
  type        = string
  description = "A description of the S3 Bucket"
  default     = null
}

variable "inherited_tags" {
  type        = map(string)
  description = "Map of tags inherited from parent context"
  default     = {}
}

variable "enable_versioning" {
  description = "(optional) whether bucket versioning is enabled on the bucket"
  type        = bool
  default     = false
}

variable "object_lock_retention_rules" {
  description = "(optional) object retention rules to apply to bucket objects; requires bucket versioning to be enabled"
  type = list(object({
    mode = string
    days = number
  }))
  default = []
}

variable "force_destroy" {
  description = "(optional) Indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. Defaults false"
  type        = bool
  default     = false
}

variable "lifecycle_enabled" {
  type    = bool
  default = false
}

variable "bucket_policy_json" {
  description = "(optional) json object for the bucket policy; defaults to no policy"
  default     = null
}

variable "bucket_public_access" {
    description = "(optional) Bucket public access flags: block_public_acls, block_public_policy, ignore_public_acls, restrict_public_buckets; All default to true."
    type = object({
      block_public_acls = optional(bool)
      block_public_policy = optional(bool)
      ignore_public_acls = optional(bool)
      restrict_public_buckets = optional(bool)
    })
    default = {
      # These values are set by the default value passed to the lookup function in the aws_s3_bucket_public_access_block resource
      # block_public_acls = true
      # block_public_policy = true
      # ignore_public_acls = true
      # restrict_public_buckets = true
    }
}

variable "bucket_object_ownership" {
  type        = string
  description = "(optional) Object ownership. Valid values: BucketOwnerPreferred, ObjectWriter or BucketOwnerEnforced"
  default     = "BucketOwnerEnforced"
  validation {
    condition     = contains(["BucketOwnerPreferred", "ObjectWriter", "BucketOwnerEnforced"], var.bucket_object_ownership)
    error_message = "Valid values: BucketOwnerPreferred, ObjectWriter or BucketOwnerEnforced"
  }
}

variable "bucket_enable_ttl" {
  type        = bool
  description = "(optional) Enable TTL for the bucket"
  default     = false
}

variable "bucket_ttl_days" {
  type        = number
  description = "(optional) TTL in days for the bucket"
  default     = 0
}

variable "bucket_enable_intelligent_tiering" {
  type        = bool
  description = "(optional) Enable Intelligent Tiering for the bucket"
  default     = true
}
