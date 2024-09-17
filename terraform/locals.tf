locals {
  // AWS Secrets Manager Variable Values
  AWS_REGION    = "ap-south-1"
  SECRET_NAME   = "jenkins-secrets"
  ECR_REPO_URI  = "772149515781.dkr.ecr.ap-south-1.amazonaws.com"
  GIT_REPO      = "https://github.com/afzaal0007/nginx-nodejs-redis.git"
  AWS_ECR_LOGIN = "aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 772149515781.dkr.ecr.ap-south-1.amazonaws.com"

  region = "ap-south-1"

  // VPC Variables Values

  vpc_cidr_block = "10.0.0.0/16"

  vpc_name = "eks-vpc"

  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]

  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]

  availability_zones = ["ap-south-1a", "ap-south-1b"]

  rt_cidr_block = "0.0.0.0/0"

  // EKS Cluster Variables Values

  cluster_name  = "eks-cluster"
  eks_key_name  = "EKS-Key-PAIR"
  eks_version   = "1.30"
  desired_size  = 1
  min_size      = 1
  max_size      = 2
  instance_type = "t2.small"

  cluster_role_name        = "eks-cluster-role"
  worker_node_role_name    = "eks-worker-node-role"
  EkS_Worker_Node_Instance = ["t2.small"]
  eks_node_ami_type        = "AL2_x86_64"




  // Jenlins Variable Values

  jenkins_ami = "ami-0e53db6fd757e38c7"

  jenkins_name = "jenkins"

  jenkins_instance_type = "t2.micro"

  jenins_subnet_id = "10.0.1.0/24"

  ssh_key_name = "EKS-Key-PAIR"

}