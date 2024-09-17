
# Call the VPC module
module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr_block       = local.vpc_cidr_block
  vpc_name             = local.vpc_name
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
  availability_zones   = local.availability_zones
  rt_cidr_block        = local.rt_cidr_block

}

module "SecretsManager" {

  source        = "./modules/secretsmanager"
  SECRET_NAME   = local.SECRET_NAME
  AWS_REGION    = local.region
  ECR_REPO_URI  = local.ECR_REPO_URI
  GIT_REPO      = local.GIT_REPO
  AWS_ECR_LOGIN = local.AWS_ECR_LOGIN
}

# Call the EKS module
module "eks" {
  source = "./modules/eks"

  eks_cluster_name         = local.cluster_name
  eks_key_name             = local.eks_key_name
  EkS_Worker_Node_Instance = local.EkS_Worker_Node_Instance[0]
  desired_size             = local.desired_size
  min_size                 = local.min_size
  max_size                 = local.max_size
  eks_version              = local.eks_version

  cluster_role_arn  = module.eks.eks_cluster_role_arn
  public_subnet_ids = concat(module.vpc.public_subnet_ids, module.vpc.private_subnet_ids)

  node_group_role_arn = module.eks.eks_worker_node_role_arn

}


module "jenkins" {
  source         = "./modules/jenkins"
  jenkins_name   = local.jenkins_name
  jenkins_ami_id = local.jenkins_ami
  instance_type  = local.jenkins_instance_type
  ssh_key_name   = local.ssh_key_name
  vpc_id         = module.vpc.vpc_id               # Pass the VPC ID to the Jenkins module
  subnet_id      = module.vpc.public_subnet_ids[0] # Example of passing a subnet ID
  cluster_name   = local.cluster_name
  region         = local.region

}


module "prometheus" {
  source  = "terraform-aws-modules/prometheus/aws"
  version = "~> 1.0"

  name        = "aws-managed-prometheus"
  environment = var.environment
  tags = {
    Name        = "aws-managed-prometheus"
    Environment = var.environment
  }
}



module "loki" {
  source = "./modules/loki"
  # Pass necessary variables to the Loki module
}

module "fluentbit" {
  source = "./modules/fluentbit"
  # Pass necessary variables to the FluentBit module
}