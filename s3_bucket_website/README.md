# S3 Bucket Website Configuration

Enables static website hosting from an S3 Bucket.

## Example

## Variables

**`bucket_name`**

- **Description:** The name of the S3 Bucket that is hosting the website
- **Type:** `string`

**`index_document_suffix`**

- **Description:** (Optional) Suffix that is appended to a request for a directory on the website endpoint.
- **Type:** `string`
- **Default:** `"index.html"`

**`error_document`**

- **Description:** (Optional) Object key name to use when a 4XX class error occurs.
- **Type:** `string`
- **Default:** `"error.html"`

**`inherited_tags`**

- **Description:** Map of tags inherited from parent context.
- **Type:** `map(string)`
- **Default:** `{}`

## Outputs

**`website_domain`**

- **Description:** Domain of the website endpoint. This is used to create Route 53 alias records.

**`website_endpoint`**

- **Description:** URL of the website endpoint. This is used to access the website.
