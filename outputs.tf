output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_env" {
  description = "Kubernetes Envinroment"
  value       = var.env
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}