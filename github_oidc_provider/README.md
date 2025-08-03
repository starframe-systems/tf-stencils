# Github OpenID Connect Provider

This module creates an OpenID Connect provider which allows Github Tokens to authenticate via the assume role mechanism. The module's input is a map of repository names and the role policy ARN to associate with the given repository.

## Example

In this example, an OpenID Connect provider resource is created with GitHub's public key thumbprint and policy documents for each repository are created. The policy document should be the service's assertion of the minimal permissions needed for GitHub automated workflows.

```
module "GitHubOIDC" {
    source = "git@github.com:starframe-systems/tf-stencils.git//github_oidc_provider?ref=v0.1.0"

    iam_role_policy_map = {
        "organization/repo-one" = module.ServiceOne.iam_policy_arn['oidc_deploy']
        "organization/repo-two" = module.ServiceTwo.iam_policy_arn['oidc_deploy']
    }
}
```

## Variables

**`iam_role_policy_map`**

- **Description:** A map of GitHub repository names to IAM Policy ARNs
- **Type:** `map(string)`
