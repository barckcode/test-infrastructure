# Terraform Backend
terraform {
  backend "s3" {
    bucket 			= "terraform-state.helmcode.com"
    key    			= "key/terraform_state_dev"
    region 			= "eu-west-1"
		encrypt 		= true
		kms_key_id 	= "arn:aws:kms:eu-west-1:243849010608:key/e76bf441-b7b0-4bf1-b2a4-09f7a5611093"
  }

	required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}


# Provider
provider "aws" {}
