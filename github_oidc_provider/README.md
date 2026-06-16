# Github OpenID Connect Provider

This module creates an OpenID Connect provider which allows Github Tokens to authenticate via the assume role mechanism. The module's input is a map of repository names and the role policy ARN to associate with the given repository.

## Example

In this example, an OpenID Connect provider resource is created with GitHub's public key thumbprint and policy documents for each repository are created. The policy document should be the service's assertion of the minimal permissions needed for GitHub automated workflows.

```
module "GithubOIDC" {
    source = "git@github.com:starframe-systems/tf-stencils.git//github_oidc_provider?ref=v0.1.9"

    iam_role_policy_map = {
        "organization/repo-one" = module.ServiceOne.iam_policy_arn['oidc_deploy']
        "organization/repo-two" = module.ServiceTwo.iam_policy_arn['oidc_deploy']
    }
}
```

---

In an alternative configuration, the service's infrastructure code can define the policy and use the `github_oidc_policy` module to attach policy ARNs to a known OIDC Provider ARN.

In the account infrastructure declaration:

```
module "GithubOIDC" {
    source = "git@github.com:starframe-systems/tf-stencils.git//github_oidc_provider?ref=v0.1.9"
}
```

And in the service's infrastructure declaration:

```
module "GithubOIDCPolicy" {
    source = git@github.com:starframe-systems/tfstencils.git//github_oidc_policy?ref=v0.1.7"

    repository = "username/repository"
    openid_connect_provider_arn = "arn:aws:iam:::oidc-provider/token.actions.githubusercontent.com"
    policy_arns = [
        module.s3_bucket.iam_policy_arn["ListGetPut"],
        module.cloudfront.iam_policy_arn["CreateInvalidation"]
    ]
}
```

## Variables

**`iam_role_policy_map`**

- **Description:** (Optional) A map of GitHub repository names to IAM Policy ARNs
- **Type:** `map(string)`

**`inherited_tags`**
