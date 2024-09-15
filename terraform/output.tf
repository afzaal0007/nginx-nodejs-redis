output "vpc_id" {
  description = "The ID of the created VPC."
  value       = module.vpc.vpc_id
}

output "eks_cluster_id" {
  description = "The ID of the created EKS cluster."
  value       = module.eks.cluster_id
}

output "jenkins_instance_id" {
  description = "The ID of the Jenkins EC2 instance."
  value       = module.jenkins.jenkins_instance_id
}