# ============================================
# INPUT VARIABLES
# - AWS region
# - GitHub org/repo identifiers
# - Any environment-specific inputs
# ============================================
# ============================================
# INPUT VARIABLES FOR INFRA-BOOTSTRAP
# ============================================

variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "us-east-1"
}

variable "github_org" {
  description = "GitHub organization or username"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "bootstrap"
}

variable "owner" {
  description = "Owner tag for resources"
  type        = string
  default     = "Adekunle"
}
