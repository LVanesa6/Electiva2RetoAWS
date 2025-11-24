output "cluster_name" {
  value = aws_eks_cluster.cluster.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}

output "cluster_ca" {
  value = aws_eks_cluster.cluster.certificate_authority[0].data
}

output "node_group_sg_id" {
  value = aws_security_group.node_group_sg.id
}
output "cluster_oidc_url" {
  value = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}
output "cluster_version" {
  value = aws_eks_cluster.cluster.version
}
