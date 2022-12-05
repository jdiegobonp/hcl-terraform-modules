# Locals definition with EKS configuration
locals {
  config = {
    name     = aws_eks_cluster.eks.name
    endpoint = aws_eks_cluster.eks.endpoint
    ca_data  = aws_eks_cluster.eks.certificate_authority[0].data
  }
}

# output with eks configuration
output "config" {
  value = local.config
}

