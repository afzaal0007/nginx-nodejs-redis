

variable "environment" {
  description = "The environment to deploy (e.g., dev, prod)"
  type        = string

}

variable "prometheus_chart_version" {
  description = "Version of the kube-prometheus-stack Helm chart"
  type        = string
  # Use the latest stable version
}

variable "grafana_admin_password" {
  description = "Admin password for Grafana"
  type        = string
  sensitive   = true
}

#  variable prometheus_namespace

variable "prometheus_namespace" {
  description = "Namespace for Prometheus"
  type        = string
}



variable "scrape_interval" {
  type        = string
  description = "Prometheus scrape interval"
}

variable "evaluation_interval" {
  type = string

  description = "Prometheus evaluation interval"
}

variable "nodejs_targets" {
  type = list(string)

  description = "List of targets for scraping by Prometheus"
}
