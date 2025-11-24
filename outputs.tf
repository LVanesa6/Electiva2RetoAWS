output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnets" {
  value = module.network.public_subnets
}


output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_node_group_sg" {
  value = module.eks.node_group_sg_id
}