output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "ecr_repo" {
  value = module.ecr.repository_url
}

output "docker_image" {
  value = docker_image.my-docker-image.image_id
}

output "rds_url" {
  value = aws_db_instance.mydb.address
}

output "load_balancer_hostname" {
  value = kubernetes_service.myapp.status.0.load_balancer.0.ingress.0.hostname
}
