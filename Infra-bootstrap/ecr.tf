# ============================================
# ECR REPOSITORY FOR THE NODE.JS APP
# - CI pushes images here (see .github/workflows/ci.yml)
# - Helm values reference this repository
# ============================================
resource "aws_ecr_repository" "nodejs_app" {
  name                 = "nodejs-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
