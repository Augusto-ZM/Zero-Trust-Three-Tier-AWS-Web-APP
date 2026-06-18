terraform {
  required_version = ">= 1.6.0"

  backend "s3" {
    bucket         = "tf-state-714412036934-zero-trust"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-locks-zero-trust"
    encrypt        = true
    kms_key_id     = "alias/tf-state-key"
    profile        = "iamadmin"
  }
}
