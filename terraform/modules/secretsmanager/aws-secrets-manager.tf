# Create AWS Secrets Manager secret
resource "aws_secretsmanager_secret" "env_secrets-01" {
  name                    = "jenkins-secrets"
  description             = "Secrets for Jenkins environment variables"
  recovery_window_in_days = 7 # Optional: Grace period before permanent deletion
}

# Store the secrets for environment variables including AWS_ECR_LOGIN
resource "aws_secretsmanager_secret_version" "env_secrets_version" {
  secret_id = aws_secretsmanager_secret.env_secrets-01.id

  secret_string = jsonencode({
    AWS_REGION             = var.AWS_REGION
    SECRET_NAME            = var.SECRET_NAME
    ECR_REPO_URI           = var.ECR_REPO_URI
    GIT_REPO               = var.GIT_REPO
    AWS_ECR_LOGIN          = "aws ecr get-login-password --region ${var.AWS_REGION} | docker login --username AWS --password-stdin ${var.ECR_REPO_URI}"
    grafana_admin_password = var.grafana_admin_password # Ensure this variable is marked sensitive

  })
}

# # Create AWS Secrets Manager secret for Datadog API Key
# resource "aws_secretsmanager_secret" "datadog_api_key_secret-01" {
#   name        = "datadog-api-key"
#   description = "Datadog API key for monitoring"
# }

# # Store the Datadog API Key in Secrets Manager
# resource "aws_secretsmanager_secret_version" "datadog_api_key_secret_version" {
#   secret_id     = aws_secretsmanager_secret.datadog_api_key_secret-01.id
#   secret_string = jsonencode({ datadog_api_key = var.datadog_api_key })
# }

# resource "aws_secretsmanager_secret" "datadog_app_key_secret" {
#   name        = "datadog-app-key"
#   description = "Datadog app key for monitoring"
# }

# # Store the Datadog app Key in Secrets Manager
# resource "aws_secretsmanager_secret_version" "datadog_app_key_secret_version" {
#   secret_id     = aws_secretsmanager_secret.datadog_app_key_secret.id
#   secret_string = jsonencode({ datadog_app_key = var.datadog_app_key })
# }