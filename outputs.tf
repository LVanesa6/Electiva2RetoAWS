output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnets" {
  value = module.network.public_subnet_ids
}

output "private_subnets" {
  value = module.network.private_subnet_ids
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_node_group_sg" {
  value = module.eks.node_group_sg_id
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}
