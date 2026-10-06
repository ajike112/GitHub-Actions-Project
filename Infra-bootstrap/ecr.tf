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

# Keep only the 10 most recent images so storage doesn't grow with every push
resource "aws_ecr_lifecycle_policy" "nodejs_app" {
  repository = aws_ecr_repository.nodejs_app.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep last 10 images"
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 10
      }
      action = {
        type = "expire"
      }
    }]
  })
}
