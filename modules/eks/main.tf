
#################################################
# IAM ROLE – EKS CLUSTER
#################################################
resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.project_name}-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "eks.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

#################################################
# EKS CLUSTER
#################################################
resource "aws_eks_cluster" "cluster" {
  name     = "${var.project_name}-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids              = var.public_subnets
    endpoint_private_access = false
    endpoint_public_access  = true
  }
}

#################################################
# IAM ROLE – NODE GROUP
#################################################
resource "aws_iam_role" "node_group_role" {
  name = "${var.project_name}-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKSWorkerNodePolicy" {
  role       = aws_iam_role.node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "node_AmazonEC2ContainerRegistryReadOnly" {
  role       = aws_iam_role.node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKS_CNI_Policy" {
  role       = aws_iam_role.node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "node_SSM" {
  role       = aws_iam_role.node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

#################################################
# SECURITY GROUP for Node Group
#################################################
resource "aws_security_group" "node_group_sg" {
  name        = "${var.project_name}-nodes-sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = var.vpc_id

  # allow all traffic between nodes
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  # allow incoming traffic from ALB on specified port
  ingress {
    from_port   = var.node_allowed_from_alb_port
    to_port     = var.node_allowed_from_alb_port
    protocol    = "tcp"
    cidr_blocks = var.node_allowed_from_alb_cidrs
    description = "Allow ALB to nodes"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-nodes-sg"
  }
}

#################################################
# EKS NODE GROUP (managed)
#################################################
resource "aws_eks_node_group" "ng" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "${var.project_name}-ng"
  node_role_arn   = aws_iam_role.node_group_role.arn
  subnet_ids      = var.public_subnets

  scaling_config {
    desired_size = var.node_desired_capacity
    max_size     = var.node_max_size
    min_size     = var.node_min_size
  }

  # Aquí se elimina el bloque remote_access para no habilitar SSH

  tags = {
    Name = "${var.project_name}-ng"
  }

  force_update_version = true
}

