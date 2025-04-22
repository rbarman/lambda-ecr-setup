provider "aws" {
    profile = "default"
    region = "us-east-2"
}

resource "aws_ecr_repository" "ecr_repo" {
  name                 = var.lambda_function_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}