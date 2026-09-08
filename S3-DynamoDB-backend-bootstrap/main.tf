# ============================================
# S3 BACKEND BUCKET + DYNAMODB LOCK TABLE
# --------------------------------------------
# Purpose:
# - Create S3 bucket for Terraform remote state
# - Create DynamoDB table for state locking
# - Must be applied BEFORE using backend.tf
# ============================================

resource "aws_s3_bucket" "tfstate" {
  bucket = var.bucket_name

  tags = {
    Name        = "Terraform Backend Bucket"
    Environment = var.environment
    Owner       = var.owner
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tfstate.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.tfstate.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "tfstate_lock" {
  name         = "tfstate-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform State Lock Table"
    Environment = "bootstrap"
    Owner       = "Adekunle"
  }
}
