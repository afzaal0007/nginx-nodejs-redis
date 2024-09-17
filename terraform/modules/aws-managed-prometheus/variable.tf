variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "namespace" {
  type        = string
  description = "Namespace for the Prometheus and Loki deployments"
}

variable "prometheus_name" {
  type        = string
  description = "Name of the Prometheus deployment"
}

variable "loki_name" {
  type        = string
  description = "Name of the Loki deployment"
}

variable "fluentbit_name" {
  type        = string
  description = "Name of the FluentBit deployment"
}