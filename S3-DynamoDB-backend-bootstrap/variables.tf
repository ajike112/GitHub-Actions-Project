# ============================================
# INPUT VARIABLES FOR BACKEND BOOTSTRAP
# --------------------------------------------
# Purpose:
# - Allow customization of S3 bucket name
# - Allow customization of DynamoDB table name
# - Allow region overrides
# - Provide tagging metadata
# ============================================

variable "aws_region" {
  description = "AWS region where backend resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket for Terraform remote state"
  type        = string
  default     = "adekunle-s3-backend-tfstate"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for Terraform state locking"
  type        = string
  default     = "tfstate-locks"
}

variable "owner" {
  description = "Owner tag for backend resources"
  type        = string
  default     = "Adekunle"
}

variable "environment" {
  description = "Environment tag for backend resources"
  type        = string
  default     = "bootstrap"
}
