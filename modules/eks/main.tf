#########################################
# IAM ROLE – EKS CLUSTER
#########################################
resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.project_name}-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "eks.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

#########################################
# EKS CLUSTER
#########################################
resource "aws_eks_cluster" "cluster" {
  name     = "${var.project_name}-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = var.private_subnet_ids   # SOLO PRIVADAS
    endpoint_private_access = true
    endpoint_public_access  = true
  }
}

#########################################
# IAM ROLE – FARGATE
#########################################
resource "aws_iam_role" "fargate_role" {
  name = "${var.project_name}-fargate-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "eks-fargate-pods.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "fargate_policy" {
  role       = aws_iam_role.fargate_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
}

#########################################
# FARGATE PROFILE
#########################################
resource "aws_eks_fargate_profile" "default" {
  cluster_name           = aws_eks_cluster.cluster.name
  fargate_profile_name   = "${var.project_name}-fp"
  pod_execution_role_arn = aws_iam_role.fargate_role.arn
  subnet_ids             = var.private_subnet_ids  # SIEMPRE PRIVADAS

  selector {
    namespace = "default"
  }
}
