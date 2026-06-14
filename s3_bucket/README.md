# S3 Bucket

The S3 Bucket module creates an S3 Bucket and associated configuration for some common bucket usage patterns.

## Example

## Variables

**`name`**

- **Description:** A unique name for the S3 Bucket

**`description`**

- **Description:** A description of the S3 Bucket

**`inherited_tags`**

- **Description:** Map of tags inherited from parent context

**`enable_versioning`**

- **Description:** (optional) whether bucket versioning is enabled on the bucket
- **Type:** `bool`
- **Default:** `false`

**`object_lock_retention_rules`**

- **Description:** (optional) object retention rules to apply to bucket objects; requires bucket versioning to be enabled
- **Type:** `list(object({mode = string, days = number}))`

**`force_destroy`**

- **Description:** (optional) Indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable.
- **Type:** `bool`
- **Default:** `false`

**`lifecycle_enabled`**

- **Description:**
- **Type:** `bool`
- **Default:** `false`

**`bucket_policy_json`**

- **Description:**

**`bucket_public_access`**

- **Description:** (optional) Bucket public access flags: block_public_acls, block_public_policy, ignore_public_acls, restrict_public_buckets
- **Type:**
  ```
  object({
      block_public_acls = optional(bool)
      block_public_policy = optional(bool)
      ignore_public_acls = optional(bool)
      restrict_public_buckets = optional(bool)
  })
  ```
- **Default:**
  ```hcl
  {
      block_public_acls = true
      block_public_policy = true
      ignore_public_acls = true
      restrict_public_buckets = true
  }
  ```

**`bucket_object_ownership`**

- **Description:** (optional) Object ownership. Valid values: BucketOwnerPreferred, ObjectWriter or BucketOwnerEnforced
- **Type:** `string`
- **Default:** `"BucketOwnerEnforced"`

**`bucket_enable_ttl`**

- **Description:** (optional) Enable TTL for the bucket
- **Type:** `bool`
- **Default:** `false`

**`bucket_ttl_days`**

- **Description:** (optional) TTL in days for the bucket
- **Type:** `number`
- **Default:** `0`

**`bucket_enable_intelligent_tiering`**

- **Description:** (optional) Enable Intelligent Tiering for the bucket
- **Type:** `bool`
- **Default:** `true`

## Outputs

**`bucket`**

- **Description:** The S3 Bucket resource

**`bucket_name`**

- **Description:** The name of the S3 Bucket

**`bucket_arn`**

- **Description:** The ARN identifying the S3 Bucket

**`bucket_region`**

- **Description:** The region the S3 Bucket is deployed in

**`domain_name`**

- **Description:** The domain name of the S3 Bucket

**`iam_policy_arn`**

- **Description:** A dictionary of IAM policies that can be attached to execution roles on other resources

  Available policy keys are `List`, `ListGet`, `ListGetPut`, and `ListGetPutDelete`.
