#########################################
# EKS Cluster
#########################################
resource "aws_eks_cluster" "cluster" {
  name     = "${var.project_name}-cluster"
  role_arn = var.eks_role_arn

  vpc_config {
    subnet_ids = var.subnets_id
  }

  depends_on = [var.eks_role_arn]
}

#########################################
# Node Group
#########################################
resource "aws_eks_node_group" "default" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "${var.project_name}-nodegroup"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnets_id

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  instance_types = ["t3.micro"]

  ami_type = "AL2_x86_64"

  tags = {
    Name = "${var.project_name}-nodes"
  }
}
