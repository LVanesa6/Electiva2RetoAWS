#########################################
# OUTPUTS DEL MÓDULO EKS
#########################################

output "eks_cluster_id" {
  description = "Nombre/ID del cluster EKS"
  value       = aws_eks_cluster.cluster.id
}

output "eks_cluster_arn" {
  description = "ARN del cluster EKS"
  value       = aws_eks_cluster.cluster.arn
}

output "eks_cluster_endpoint" {
  description = "Endpoint del API server del cluster EKS"
  value       = aws_eks_cluster.cluster.endpoint
}

output "eks_cluster_certificate" {
  description = "Certificado (CA) del cluster EKS"
  value       = aws_eks_cluster.cluster.certificate_authority[0].data
}

output "eks_cluster_oidc_issuer" {
  description = "OIDC issuer URL del cluster EKS"
  value       = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

output "fargate_profile_name" {
  description = "Nombre del Fargate Profile creado"
  value       = aws_eks_fargate_profile.default.fargate_profile_name
}

output "eks_cluster_role_arn" {
  description = "ARN del IAM Role usado por el cluster"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "fargate_role_arn" {
  description = "ARN del IAM Role usado por Fargate"
  value       = aws_iam_role.fargate_role.arn
}
