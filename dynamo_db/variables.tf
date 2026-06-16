variable "prefix" {
  type        = string
  description = "string for prefixing to all resource names"
}

variable "table_name" {
  type        = string
  description = "The non-prefixed table name"
}

variable "attributes" {
  type = list(object({
    name = string
    type = string
  }))
  description = "Additional, optional DynamoDB attributes in the form of a list of mapped values"
  default     = []
}

variable "global_secondary_indexes" {
  type = list(object({
    name               = string
    hash_key           = string
    projection_type    = string
    non_key_attributes = optional(list(string), [])
    read_capacity      = number
    write_capacity     = number
  }))
  description = "optional DynamoDB secondary indexes"
  default     = []
}

variable "hash_key" {
  description = "attribute to use as the hash key"
  type        = string
}

variable "hash_key_type" {
  type        = string
  default     = "S"
  description = "Hash Key type, which must be a scalar type: S (String), N (Number), or B (Binary); default S"
}

variable "range_key" {
  description = "attribute to use as the range key"
  type        = string
}

variable "range_key_type" {
  type        = string
  default     = "S"
  description = "Range Key type, which must be a scalar type: S (String), N (Number), or B (Binary); default S"
}

variable "capacity" {
  type = object({
    read_capacity  = number
    write_capacity = number
  })
  default     = null
  description = "Read and write capacity values for provisioned billing mode. If this variable is not set, billing mode is PAY_PER_REQUEST."
}

variable "enable_point_in_time_recovery" {
  type        = bool
  description = "Enable point in time recovery"
  default     = false
}

variable "enable_ttl" {
  description = "Enable or disable TTL on the table"
  type        = bool
  default     = false
}

variable "ttl_attribute_name" {
  description = "TTL attribute name"
  type        = string
  default     = "expiresAt"
}

variable "inherited_tags" {
  type        = map(string)
  description = "Map of tags inherited from parent context"
  default     = {}
}
