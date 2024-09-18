
variable "tags" {
  description = "A map of tags to assign to resources."
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "eks-terraform"
  }
}

# variables.tf

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