output "cluster_name" {
    value = aws_eks_cluster.cluster.name
}

output "node_group_sg_id" {
    value = aws_security_group.node_sg.id
}
