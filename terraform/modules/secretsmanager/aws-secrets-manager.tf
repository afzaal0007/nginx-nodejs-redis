# Create AWS Secrets Manager secret
resource "aws_secretsmanager_secret" "env_secrets" {
  name        = "jenkins-env-secrets"
  description = "Secrets for Jenkins environment variables"
}


# Store the secrets for environment variables including AWS_ECR_LOGIN
resource "aws_secretsmanager_secret_version" "env_secrets_version" {
  secret_id = aws_secretsmanager_secret.env_secrets.id

  secret_string = jsonencode({
    AWS_REGION    = var.AWS_REGION
    SECRET_NAME   = var.SECRET_NAME
    ECR_REPO_URI  = var.ECR_REPO_URI
    GIT_REPO      = var.GIT_REPO
    AWS_ECR_LOGIN = var.AWS_ECR_LOGIN
  })
}
