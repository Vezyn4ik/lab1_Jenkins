terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
# Configure AWS provider
provider "aws" {
  region = "us-east-1"
  shared_config_files = [
    "C:/.aws/config"]
  shared_credentials_files = [
    "C:/.aws/credentials"]
  profile = "default"
}

# Create S3 bucket to store Terraform state files
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-bucket-lab2-additional"
  acl    = "public"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# Create DynamoDB table for Terraform state locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.terraform_state.id
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_locks.id
}
