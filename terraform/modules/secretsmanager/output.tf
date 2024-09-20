output "aws_secretsmanager_secret_id" {
  description = "The ID of the AWS Secrets Manager secret."
  value       = aws_secretsmanager_secret.env_secrets-01.id
}

output "aws_secretsmanager_secret_arn" {
  description = "The ARN of the AWS Secrets Manager secret."
  value       = aws_secretsmanager_secret.env_secrets-01.arn
}

output "aws_secretsmanager_secret_version_id" {
  description = "The version ID of the secret."
  value       = aws_secretsmanager_secret_version.env_secrets_version.version_id
}

output "aws_region" {
  description = "The AWS Region for the secret."
  value       = jsondecode(aws_secretsmanager_secret_version.env_secrets_version.secret_string)["AWS_REGION"]
}

output "secret_name" {
  description = "The Secret Name."
  value       = jsondecode(aws_secretsmanager_secret_version.env_secrets_version.secret_string)["SECRET_NAME"]
}

output "ecr_repo_uri" {
  description = "The ECR Repository URI."
  value       = jsondecode(aws_secretsmanager_secret_version.env_secrets_version.secret_string)["ECR_REPO_URI"]
}

output "git_repo" {
  description = "The GitHub Repository."
  value       = jsondecode(aws_secretsmanager_secret_version.env_secrets_version.secret_string)["GIT_REPO"]
}

output "aws_ecr_login_command" {
  description = "The AWS ECR login command."
  value       = jsondecode(aws_secretsmanager_secret_version.env_secrets_version.secret_string)["AWS_ECR_LOGIN"]
}

output "grafana_admin_password" {
  description = "The Grafana Admin Password."
  sensitive   = true
  value       = jsondecode(aws_secretsmanager_secret_version.env_secrets_version.secret_string)["GRAFANA_ADMIN_PASSWORD"]
}
