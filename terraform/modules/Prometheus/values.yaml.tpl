grafana:
  adminPassword: "${grafana_admin_password}"
  enabled: true
  service:
    type: LoadBalancer

prometheus:
  prometheusSpec:
    externalLabels:
      environment: "${var.environment}"
    scrape_interval: ${scrape_interval}          # New value for scrape interval
    evaluation_interval: ${evaluation_interval}  # New value for evaluation interval
    scrape_configs:
      - job_name: 'nodejs-app'
        static_configs:
          - targets: ${nodejs_targets}          # New value for scraping Node.js app

alertmanager:
  alertmanagerSpec:
    externalLabels:
      environment: "${var.environment}"

serviceMonitorSelector:
  matchLabels:
    release: "kube-prometheus-stack"
