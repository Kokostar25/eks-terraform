resource "aws_eks_cluster" "aws_eks" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = module.vpc.public_subnets
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy
    
  ]

  tags = {
      Name = var.cluster_name
  }
}

resource "aws_eks_node_group" "node" {
  cluster_name    = var.cluster_name
  node_group_name = "koko_eks_nodegroup"
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = module.vpc.public_subnets

  scaling_config {
    desired_size = 3
    max_size     = 3
    min_size     = 3
  }

 
depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]

   tags = {
      Name = "${var.cluster_name}-node"
  }
}
