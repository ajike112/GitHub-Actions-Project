# ============================================
# IAM POLICY FOR RUNNING TERRAFORM FROM GITHUB ACTIONS
# - Grants GitHub Actions permission to:
#     * Read/write Terraform state in S3 and lock it in DynamoDB
#     * Manage the resources defined in Infra-bootstrap
#       (OIDC provider, deployer role, its policies, ECR repo)
# - Scoped to those specific resources only
# - Attached to GitHub Actions IAM role
# ============================================
resource "aws_iam_policy" "terraform_access" {
  name        = "github-actions-terraform"
  description = "Allow GitHub Actions to run Terraform for Infra-bootstrap"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      # --- TERRAFORM STATE (S3) ---
      {
        Effect   = "Allow"
        Action   = ["s3:ListBucket"]
        Resource = "arn:aws:s3:::adekunle-s3-backend-tfstate"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = "arn:aws:s3:::adekunle-s3-backend-tfstate/infra-bootstrap/*"
      },

      # --- TERRAFORM STATE LOCK (DYNAMODB) ---
      {
        Effect = "Allow"
        Action = [
          "dynamodb:DescribeTable",
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem"
        ]
        Resource = "arn:aws:dynamodb:us-east-1:536697262404:table/tfstate-locks"
      },

      # --- GITHUB OIDC PROVIDER ---
      {
        Effect = "Allow"
        Action = [
          "iam:GetOpenIDConnectProvider",
          "iam:CreateOpenIDConnectProvider",
          "iam:DeleteOpenIDConnectProvider",
          "iam:UpdateOpenIDConnectProviderThumbprint",
          "iam:AddClientIDToOpenIDConnectProvider",
          "iam:RemoveClientIDFromOpenIDConnectProvider",
          "iam:TagOpenIDConnectProvider",
          "iam:UntagOpenIDConnectProvider"
        ]
        Resource = "arn:aws:iam::536697262404:oidc-provider/token.actions.githubusercontent.com"
      },

      # --- DEPLOYER ROLE ---
      {
        Effect = "Allow"
        Action = [
          "iam:GetRole",
          "iam:CreateRole",
          "iam:DeleteRole",
          "iam:UpdateRole",
          "iam:UpdateAssumeRolePolicy",
          "iam:TagRole",
          "iam:UntagRole",
          "iam:ListRolePolicies",
          "iam:ListAttachedRolePolicies",
          "iam:ListInstanceProfilesForRole",
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy"
        ]
        Resource = "arn:aws:iam::536697262404:role/github-actions-deployer"
      },

      # --- DEPLOYER ROLE POLICIES ---
      {
        Effect = "Allow"
        Action = [
          "iam:GetPolicy",
          "iam:GetPolicyVersion",
          "iam:ListPolicyVersions",
          "iam:ListEntitiesForPolicy",
          "iam:CreatePolicy",
          "iam:CreatePolicyVersion",
          "iam:DeletePolicyVersion",
          "iam:DeletePolicy",
          "iam:TagPolicy",
          "iam:UntagPolicy"
        ]
        Resource = [
          "arn:aws:iam::536697262404:policy/github-actions-eks-access",
          "arn:aws:iam::536697262404:policy/github-actions-terraform"
        ]
      },

      # --- ECR REPOSITORY MANAGEMENT ---
      {
        Effect = "Allow"
        Action = [
          "ecr:CreateRepository",
          "ecr:DeleteRepository",
          "ecr:DescribeRepositories",
          "ecr:ListTagsForResource",
          "ecr:TagResource",
          "ecr:UntagResource",
          "ecr:PutImageScanningConfiguration",
          "ecr:PutImageTagMutability",
          "ecr:GetLifecyclePolicy",
          "ecr:PutLifecyclePolicy",
          "ecr:DeleteLifecyclePolicy",
          "ecr:GetRepositoryPolicy",
          "ecr:SetRepositoryPolicy",
          "ecr:DeleteRepositoryPolicy"
        ]
        Resource = "arn:aws:ecr:us-east-1:536697262404:repository/nodejs-app"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_terraform_access" {
  role       = aws_iam_role.github_actions.name
  policy_arn = aws_iam_policy.terraform_access.arn
}
