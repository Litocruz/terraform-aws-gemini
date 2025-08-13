# providers.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  access_key                  = "test"
  secret_key                  = "test"
  s3_use_path_style           = true # Esto fuerza el path-style, evitando el endpoint especial de S3
  endpoints {
    ec2 = "http://localhost:4566"
  }
}
