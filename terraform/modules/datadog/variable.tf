# modules/datadog/variables.tf

variable "datadog_api_key" {
  description = "Datadog API key"
  type        = string
  sensitive   = true
}



variable "datadog_app_key" {
  description = "Datadog application key"
  type        = string
  sensitive   = true
}

variable "datadog_site" {
  description = "The Datadog site (e.g., datadoghq.com or datadoghq.eu)"
  type        = string
  default     = "datadoghq.com"
}