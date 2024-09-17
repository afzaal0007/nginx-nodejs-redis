# Step 2: Create an AWS Managed Prometheus Workspace  
resource "aws_prometheus_workspace" "my_workspace" {
  alias = "my-prometheus-workspace"
  tags  = { Name = "MyWorkspace" }
}

module "aws_managed_prometheus" {
  source = "./modules/aws_managed_prometheus"

  # Pass necessary variables to the module
  cluster_name    = var.cluster_name
  namespace       = var.namespace
  prometheus_name = var.prometheus_name
  loki_name       = var.loki_name
  fluentbit_name  = var.fluentbit_name
}


# Attach AWS Managed Prometheus Policy to the role  
resource "aws_iam_role_policy_attachment" "fluent_bit_prometheus" {
  role       = aws_iam_role.fluent_bit_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonPrometheusRemoteWrite"
}  