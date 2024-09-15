variable "eks_cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
  # default     = "k8s-cluster"
}

variable "cluster_role_arn" {
  description = "The ARN of the IAM role for the EKS cluster."
  type        = string
}

variable "public_subnet_ids" {
  description = "List of subnet IDs for the EKS cluster."
  type        = list(string)
}


variable "eks_version" {
  description = "EKS Version"
  type        = string
  default     = "1.26"
}

variable "desired_size" {
  description = "desired capacity of the cluster "
  type        = string
  default     = "1"

}

variable "max_size" {
  description = "maximum capacity of the cluster "
  type        = string
  default     = "2"

}

variable "min_size" {
  description = "minimum capacity of the cluster "
  type        = string
  default     = "1"

}

variable "instance_type" {
  description = "instance type of the cluster "
  type        = string
  default     = "t2.small"

}


variable "eks_key_name" {
  description = "The SSH key name for EKS nodes access."
  type        = string
}

variable "node_group_role_arn" {
  description = "The ARN of the IAM role for the EKS nodes."
  type        = string
}

variable "cluster_role_name" {
  description = "Name of the IAM role for the EKS cluster."
  type        = string
  default     = "eks-cluster-role"
}

variable "worker_node_role_name" {
  description = "Name of the IAM role for the EKS worker nodes."
  type        = string
  default     = "eks-worker-node-role"
}

variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
  default     = "k8s-cluster"
}