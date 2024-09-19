resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${var.eks_cluster_name}-node-group"
  node_role_arn   = var.node_group_role_arn
  subnet_ids      = var.public_subnet_ids
  instance_types  = [var.EkS_Worker_Node_Instance]
  disk_size       = 30
  version         = var.eks_version



  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  remote_access {
    ec2_ssh_key = var.eks_key_name
  }

  lifecycle {
    create_before_destroy = true
  }
  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}