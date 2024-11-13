terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.73.0"
    }
  }
  backend "s3" {
    bucket         = "elvis-gs02"
    key            = "terraform.tfstate"
    dynamodb_table = "elvis-gs02"
    region         = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}