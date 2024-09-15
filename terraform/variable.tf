# AWS Region
variable "aws_region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "ap-south-1"
}

# VPC Configuration
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
  default     = "eks-vpc"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets."
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones for the subnets."
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]
}

# IAM Configuration
variable "eks_role_name" {
  description = "The name of the IAM role for the EKS cluster."
  type        = string
  default     = "eks-cluster-role"
}

# EKS Cluster Configuration
variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
  default     = "k8s-cluster"
}

variable "cluster_version" {
  description = "The Kubernetes version for the EKS cluster."
  type        = string
  default     = "1.27"
}

variable "desired_capacity" {
  description = "The desired number of worker nodes in the EKS cluster."
  type        = number
  default     = 2
}

variable "min_size" {
  description = "The minimum number of worker nodes in the EKS cluster."
  type        = number
  default     = 1
}

variable "max_size" {
  description = "The maximum number of worker nodes in the EKS cluster."
  type        = number
  default     = 3
}

variable "instance_type" {
  description = "The instance type for the worker nodes."
  type        = string
  default     = "t3.medium"
}

variable "eks_node_ami_type" {
  description = "The AMI type for the worker nodes."
  type        = string
  default     = "AL2_x86_64" # Amazon Linux 2
}

variable "eks_key_name" {
  description = "The SSH key name for accessing worker nodes."
  type        = string
  default     = "EKS-Key-PAIR" # Provide your SSH key name if you want SSH access
}

variable "tags" {
  description = "A map of tags to assign to resources."
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "eks-terraform"
  }
}


variable "jenkins_ami" {

  type    = string
  default = "ami-0e53db6fd757e38c7"

}

variable "jenkins_name" {
  description = "The name of the Jenkins server."
  type        = string
  default     = "jenkins"
}

variable "jenkins_ami_id" {
  description = "AMI ID for the Jenkins server."
  type        = string
  default     = "ami-0e53db6fd757e38c7" # Ubuntu 20.04 LTS
}

variable "jenkins_instance_type" {
  description = "EC2 instance type for Jenkins."
  type        = string
  default     = "t3.medium"
}

variable "ssh_key_name" {
  description = "The name of the SSH key pair to use for the Jenkins server."
  type        = string
  default     = "EKS-Key-PAIR"
}

# variable "vpc_id" {
#   description = "The VPC ID where the Jenkins server will be deployed."
#   type        = string
# }

variable "subnet_id" {
  description = "The subnet ID where the Jenkins server will be deployed."
  type        = string
  default     = "10.0.1.0/24"
}





