output "cluster_endpoint" {
  value       = aws_eks_cluster.eks.endpoint
  description = "The endpoint of the EKS cluster."
}
# output "public_subnet_id" {
#   description = "The public subnet IDs where the EKS cluster is deployed."
#   value       = aws_eks_cluster.eks.eks_public_subnet.*.id
# }


output "eks_cluster_role_arn" {
  description = "The ARN of the IAM role for the EKS cluster."
  value       = aws_iam_role.eks_cluster_role.arn
}

output "eks_worker_node_role_arn" {
  description = "The ARN of the IAM role for the EKS worker nodes."
  value       = aws_iam_role.eks_worker_node_role.arn
}


output "cluster_id" {
  description = "The ID of the EKS cluster."
  value       = aws_eks_cluster.eks.id
}

# output "cluster_endpoint" {
#   description = "The endpoint of the EKS cluster."
#   value       = aws_eks_cluster.eks.endpoint
# }

output "cluster_certificate_authority_data" {
  description = "The base64 encoded certificate data required to communicate with the cluster."
  value       = aws_eks_cluster.eks.certificate_authority[0].data
}

# output "cluster_security_group_id" {
#   description = "Security group ID attached to the EKS cluster."
#   value       = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
# }
