provider "aws" {
  region = local.region
}

provider "kubernetes" {
  # host                   = data.aws_eks_cluster.example.endpoint
  host = module.eks.cluster_endpoint
  # cluster_ca_certificate = base64decode(data.aws_eks_cluster.example.certificate_authority[0].data)
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    command     = "aws"
  }
}

provider "docker" {
  registry_auth {
    address  = data.aws_ecr_authorization_token.token.proxy_endpoint
    username = data.aws_ecr_authorization_token.token.user_name
    password = data.aws_ecr_authorization_token.token.password
  }
}
