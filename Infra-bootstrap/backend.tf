# ============================================
# TERRAFORM REMOTE BACKEND CONFIGURATION
# --------------------------------------------
# Purpose:
# - Store Terraform state in S3 (remote backend)
# - Enable team collaboration and CI/CD automation
# - Provide state locking via DynamoDB
# - Prevent local state corruption or drift
#
# Notes:
# - You must create the S3 bucket + DynamoDB table
#   BEFORE running `terraform init`
# - These can be provisioned via Terraform in a
#   separate "bootstrap" step or manually once
# ============================================

terraform {
  backend "s3" {
    bucket         = "adekunle-s3-backend-tfstate"
    key            = "infra-bootstrap/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfstate-locks"
    encrypt        = true
  }
}
