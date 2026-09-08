# ============================================
# PROVIDER CONFIGURATION & TERRAFORM SETTINGS
# --------------------------------------------
# Purpose:
# - Configure AWS provider
# - Set required provider versions
# - Define global Terraform settings
#
# Notes:
# - This is the entry point for the module
# ============================================

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
