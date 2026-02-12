# Terraform State and State Lock

This module creates resources for storing Terraform state and state locks for resources in the current account.

## Example

The module takes no arguments and creates an S3 bucket for Terraform state and a DynamoDB table for state locks. The resources are named using the AWS account ID and the region the resources are deployed in.

Generally there should be one module for each account. Terraform provider configuration allows the state resources to be in a region other than where resources are primarily being created.

```
module "staging-tf-state" {
    source = "git@github.com:starframe-systems/tf-stencils.git//terraform_state?ref=v0.1.4"
}
```
