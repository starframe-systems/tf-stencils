
terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      # configuration_aliases = [aws.route53-provider, aws.acm-provider]
      version               = "~> 5.97.0"
    }
  }
}

provider "aws" {
  alias  = "acm_provider"
  region = "us-east-1"
}
