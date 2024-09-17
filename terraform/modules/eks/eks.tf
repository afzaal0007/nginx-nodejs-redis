resource "aws_eks_cluster" "eks" {
  name     = var.eks_cluster_name
  role_arn = var.cluster_role_arn
  version  = var.eks_version
  vpc_config {
    subnet_ids = var.public_subnet_ids
  }

  tags = {
    Name = var.eks_cluster_name
  }
}