locals {
  region             = var.aws_region
  name               = "${var.local_name.name}-${var.local_name.env}"
  vpc_cidr           = var.vpc_cidr_block
  azs                = slice(data.aws_availability_zones.available.names, 0, var.vpc_subnets_count)
  kubernetes_version = "1.31"
  instance_types     = ["t3.small"] #t3.micro don't work
  eks_nodes_ami_type = "AL2023_x86_64_STANDARD"
  container_port     = var.container_port
  container_image    = var.container_image
  git_repo           = var.git_repo
  db_parameters = {
    ###############
    # SecureString
    ###############
    "db_username" = {
      type        = "SecureString"
      data_type   = "text"
      value       = var.db_username
      tier        = "Standard"
      description = "RDS DB user"
    }

    "db_password" = {
      type        = "SecureString"
      data_type   = "text"
      value       = var.db_password
      tier        = "Standard"
      description = "RDS DB user password"
    }

    "db_database" = {
      type        = "SecureString"
      data_type   = "text"
      value       = var.db_database
      tier        = "Standard"
      description = "RDS default database"
    }
  }

  tags = {
    Terraform = "true",
    Name      = var.local_name.name,
    Env       = var.local_name.env
  }
}
