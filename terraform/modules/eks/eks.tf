# resource "aws_eks_cluster" "k8s_cluster" {
#   name     = var.cluster_name
#   role_arn = var.cluster_role_arn
#   version  = var.cluster_version


#   vpc_config {
#     subnet_ids = var.subnet_ids
#   }
# }


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

# resource "aws_eks_node_group" "eks_node_group" {
#   cluster_name    = aws_eks_cluster.eks.name
#   node_group_name = "${var.eks_cluster_name}-node-group"
#   node_role_arn   = var.node_group_role_arn
#   subnet_ids      = var.public_subnet_ids

#   scaling_config {
#     desired_size = var.desired_size
#     max_size     = var.max_size
#     min_size     = var.min_size
#   }

#   instance_types = [var.instance_type]

#   tags = {
#     Name = "eks-node-group"
#   }
# }
