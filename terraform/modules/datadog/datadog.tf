resource "helm_release" "datadog" {
  name       = "datadog"
  repository = "https://helm.datadoghq.com"
  chart      = "datadog" # Correct chart name
  namespace  = "datadog"

  create_namespace = true

  values = [
    templatefile("${path.module}/datadog-values.yaml.tpl", {
      datadog_api_key = var.datadog_api_key, # Passing API key
      datadog_app_key = var.datadog_app_key  # Passing App key
    })
  ]

  set {
    name  = "datadog.site"
    value = "datadoghq.com"
  }

  set {
    name  = "site"
    value = var.datadog_site # e.g., "datadoghq.com" or "datadoghq.eu"  
  }

  set {
    name  = "agents.enabled"
    value = "true" # Enable the Datadog Agent
  }

  set {
    name  = "agents.log.enabled"
    value = "true" # Enable log collection
  }

  set {
    name  = "apiKey"
    value = var.datadog_api_key # Your Datadog API key as a variable
  }


}
