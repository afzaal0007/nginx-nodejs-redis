
# Call the VPC module
module "vpc" {
  source = "./modules/vpc"

}


# Jenkins Module

# Call the IAM module
# module "iam" {
#   source = "./modules/iam"

# }

# Call the EKS module
module "eks" {
  source = "./modules/eks"

  eks_cluster_name = var.cluster_name
  eks_key_name     = var.eks_key_name

  cluster_role_arn  = module.eks.eks_cluster_role_arn
  public_subnet_ids = concat(module.vpc.public_subnet_ids, module.vpc.private_subnet_ids)

  node_group_role_arn = module.eks.eks_worker_node_role_arn

}


module "jenkins" {
  source         = "./modules/jenkins"
  jenkins_name   = var.jenkins_name
  jenkins_ami_id = var.jenkins_ami_id
  instance_type  = var.jenkins_instance_type
  ssh_key_name   = var.ssh_key_name
  vpc_id         = module.vpc.vpc_id               # Pass the VPC ID to the Jenkins module
  subnet_id      = module.vpc.public_subnet_ids[0] # Example of passing a subnet ID


}
