# ============================================
# IAM ROLE FOR GITHUB ACTIONS
# - Trusts GitHub OIDC provider
# - Allows GitHub workflows to assume this role
# - Scoped to specific repo/branch
# ============================================
resource "aws_iam_role" "github_actions" {
  name = "github-actions-deployer"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = aws_iam_openid_connect_provider.github.arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringLike = {
          "token.actions.githubusercontent.com:sub" = "repo:ajike112/GitHub-Actions-Project:ref:refs/heads/master"
        }
      }
    }]
  })
}
