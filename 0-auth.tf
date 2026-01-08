provider "aws" {
  region = var.region

  default_tags {
    tags = local.merged_tags
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.18.0"
    }
  }
}