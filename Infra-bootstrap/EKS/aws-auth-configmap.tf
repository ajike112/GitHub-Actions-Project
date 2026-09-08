# ============================================
# EKS RBAC MAPPING (aws-auth)
# - Maps IAM role to Kubernetes RBAC groups
# - Grants GitHub Actions permissions inside EKS
# - Enables kubectl/Helm deployments
# ============================================
resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode([{
      rolearn  = aws_iam_role.github_actions.arn
      username = "github-actions"
      groups   = ["system:masters"]
    }])
  }
}
