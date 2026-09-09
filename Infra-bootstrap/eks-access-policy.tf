# ============================================
# IAM POLICY FOR EKS DEPLOYMENT ACCESS
# - Grants GitHub Actions permission to:
#     * Describe EKS clusters
#     * Access Kubernetes API
#     * Interact with ECR (optional)
# - Attached to GitHub Actions IAM role
# ============================================
resource "aws_iam_policy" "eks_access" {
  name        = "github-actions-eks-access"
  description = "Allow GitHub Actions to interact with EKS"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "eks:DescribeCluster",
          "eks:ListClusters",
          "eks:AccessKubernetesApi",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:DescribeRepositories",
          "ecr:DescribeImages"
        ]
        Resource = "*"
        Resource : "arn:aws:ecr:us-east-1:536697262404:repository/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_eks_access" {
  role       = aws_iam_role.github_actions.name
  policy_arn = aws_iam_policy.eks_access.arn
}
