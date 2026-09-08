# ============================================
# LOCAL CONSTANTS & DERIVED VALUES
# --------------------------------------------
# Purpose:
# - Define reusable naming conventions
# - Construct resource names dynamically
# - Store common tags (environment, owner, project)
# - Normalize GitHub repo/org identifiers
#
# Notes:
# - Keeps Terraform DRY and consistent
# - Helps enforce enterprise naming standards
# ============================================

locals {
  # --------------------------------------------
  # GitHub metadata (used for OIDC trust policy)
  # --------------------------------------------
  github_org  = var.github_org
  github_repo = var.github_repo

  # Example: repo "my-app" becomes "my-app"
  repo_name_normalized = replace(local.github_repo, "_", "-")

  # --------------------------------------------
  # Naming conventions
  # --------------------------------------------
  project_name = "eks-ci-cd-bootstrap"
  environment  = var.environment

  # Example: eks-ci-cd-bootstrap-prod
  resource_prefix = "${local.project_name}-${local.environment}"

  # --------------------------------------------
  # Common tags applied to all resources
  # --------------------------------------------
  common_tags = {
    Project     = local.project_name
    Environment = local.environment
    ManagedBy   = "Terraform"
    Owner       = var.owner
  }
}
