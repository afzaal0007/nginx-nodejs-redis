# modules/monitoring/values.yaml.tpl

grafana:
  adminPassword: "${grafana_admin_password}"
  enabled: true
  service:
    type: LoadBalancer

prometheus:
  prometheusSpec:
    externalLabels:
      environment: "${environment}"
    scrapeInterval: "${scrape_interval}"  # Custom scrape interval
    evaluationInterval: "${evaluation_interval}" # Custom evaluation interval
    additionalScrapeConfigs:
      - job_name: 'nodejs-apps'
        static_configs:
          - targets:" ${nodejs_targets}"  # Node.js app targets as list

alertmanager:
  alertmanagerSpec:
    externalLabels:
      environment: "${environment}"

serviceMonitorSelector:
  matchLabels:
    release: "kube-prometheus-stack"
