# ============================================
# OUTPUT VALUES
# - Exposes IAM role ARN for GitHub Actions
# - Exposes OIDC provider ARN
# - Exposes any useful EKS access metadata
# ============================================
output "github_actions_role_arn" {
  value = aws_iam_role.github_actions.arn
}
