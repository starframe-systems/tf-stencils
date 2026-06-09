# Github OIDC Policy

This module creates policy attachments to the account's Github OpenID Connect Provider.

## Example

```
module "GithubOIDCPolicy" {
    source = "git@github.com:starframe-systems/tfstencils.git//github_oidc_policy?ref=v0.1.5"

    repository = "username/repository"
    openid_connect_provider_arn = "arn:aws:iam:::oidc-provider/token.actions.githubusercontent.com"
    policy_arns = [
        module.s3_bucket.iam_policy_arn["ListGetPut"],
        module.cloudfront.iam_policy_arn["CreateInvalidation"]
    ]
}
```

## Variables

**`name`**

- **Description:** (Optional) A name for the OIDC policy. This will be used as a prefix for the IAM role and policy names.
- **Type:** `string`
- **Default:** `"GithubDeploy"`

**`repository`**

- **Description:** The GitHub repository in the format 'owner/repo' that will be allowed to assume the IAM role.
- **Type:** `string`

**`openid_connect_provider_arn`**

- **Description:** The ARN of the OIDC provider to use for the IAM role trust relationship.
- **Type:** `string`

**`policy_arns`**

- **Description:** (Optional) A list of IAM policy ARNs to attach to the GitHub deploy role.
- **Type:** `list(string)`
- **Default:** `[]`

**`inherited_tags`**

- **Description:** (Optional) Map of tags inherited from parent context.
- **Type:** `map(string)`
- **Default:** `{}`

## Outputs

None.
