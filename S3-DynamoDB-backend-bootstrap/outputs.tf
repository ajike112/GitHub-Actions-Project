# ============================================
# OUTPUT VALUES FOR BACKEND BOOTSTRAP
# --------------------------------------------
# Purpose:
# - Expose S3 bucket name
# - Expose DynamoDB table name
# - Provide metadata for backend.tf in infra-bootstrap
# ============================================

output "tfstate_bucket_name" {
  description = "Name of the S3 bucket storing Terraform remote state"
  value       = aws_s3_bucket.tfstate.bucket
}

output "tfstate_dynamodb_table" {
  description = "Name of the DynamoDB table used for Terraform state locking"
  value       = aws_dynamodb_table.tfstate_lock.name
}
