terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.50.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIATQZCSB7G2YNAAIO7"
  secret_key = "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"
}

