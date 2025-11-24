output "aws_lb_controller_role_arn" {
  value = aws_iam_role.lb_controller.arn
}

output "cluster_oidc_url" {
  value = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}
