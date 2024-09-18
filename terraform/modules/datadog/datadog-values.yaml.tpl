datadog:
  apiKey: "${datadog_api_key}"
  appKey: "${datadog_app_key}"

agents:
  containerLogs:
    enabled: true
    containerCollectAll:
      enabled: true

  process:
    enabled: true

  apm:
    enabled: true

  kubeStateMetrics:
    enabled: true
