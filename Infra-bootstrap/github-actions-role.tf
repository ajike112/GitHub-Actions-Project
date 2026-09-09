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
        Federated = "arn:aws:iam::536697262404:oidc-provider/token.actions.githubusercontent.com"
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "token.actions.githubusercontent.com:sub" = "repo:ajike112@101846555/GitHub-Actions-Project@1360944397:ref:refs/heads/master",
          "token.actions.githubusercontent.com:aud" : "sts.amazonaws.com"
        }
      }
    }]
  })
}
