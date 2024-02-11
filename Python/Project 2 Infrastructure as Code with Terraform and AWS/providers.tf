terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>5.36"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}