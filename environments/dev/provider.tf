terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = "iamadmin"

  default_tags {
    tags = {
      Project     = "ZeroTrustApp"
      Environment = "dev"
      ManagedBy   = "terraform"
    }
  }
}
