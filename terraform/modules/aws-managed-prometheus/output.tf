output "prometheus_service_name" {
  value = module.prometheus.service_name
}

output "loki_service_name" {
  value = module.loki.service_name
}

output "fluentbit_service_name" {
  value = module.fluentbit.service_name
}