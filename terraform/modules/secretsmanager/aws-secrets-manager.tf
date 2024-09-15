# Create AWS Secrets Manager secret
resource "aws_secretsmanager_secret" "env_secrets" {
  name        = "jenkins-env-secrets"
  description = "Secrets for Jenkins environment variables"
}

# Store the secrets for environment variables including AWS_ECR_LOGIN
resource "aws_secretsmanager_secret_version" "env_secrets_version" {
  secret_id = aws_secretsmanager_secret.env_secrets.id

  secret_string = jsonencode({
    AWS_REGION    = "ap-south-1"
    SECRET_NAME   = "jenkins-env-secrets"
    ECR_REPO_URI  = "772149515781.dkr.ecr.ap-south-1.amazonaws.com"
    GIT_REPO      = "https://github.com/afzaal0007/nginx-nodejs-redis.git"
    AWS_ECR_LOGIN = "aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 772149515781.dkr.ecr.ap-south-1.amazonaws.com"
  })
}
