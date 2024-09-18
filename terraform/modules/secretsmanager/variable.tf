# Ensure the sensitive variables are defined in your variables.tf file
variable "AWS_REGION" {
  type        = string
  description = "AWS Region"
}

variable "SECRET_NAME" {
  type        = string
  description = "Name of the AWS Secrets Manager secret"
}

variable "ECR_REPO_URI" {
  type        = string
  description = "URI of the ECR repository"
}

variable "GIT_REPO" {
  type        = string
  description = "Git repository URL"
}

variable "grafana_admin_password" {
  type        = string
  description = "Admin password for Grafana"
  sensitive   = true
}

variable "datadog_api_key" {
  type        = string
  description = "API Key for Datadog"
  sensitive   = true
  default     = "a67dae18-9d3c-4adf-a8f0-6dbc1b404d51"
}

variable "datadog_app_key" {
  type        = string
  description = "APP Key for Datadog"
  sensitive   = true
  default     = "897fcef61c15a9877f0bbbd5e288d256a1ec1253"
}


