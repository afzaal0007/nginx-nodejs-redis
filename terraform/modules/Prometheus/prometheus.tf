resource "helm_release" "kube_prometheus_stack" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = var.prometheus_chart_version
  namespace  = var.prometheus_namespace

  create_namespace = true

  # Reference external custom values.yaml template file
  values = [
    templatefile("${path.module}/values.yaml.tpl", {
      grafana_admin_password = var.grafana_admin_password,
      scrape_interval        = var.scrape_interval,     # Example custom variable
      evaluation_interval    = var.evaluation_interval, # Example custom variable
      nodejs_targets         = var.nodejs_targets       # Example list of Node.js app targets
    })
  ]
}
