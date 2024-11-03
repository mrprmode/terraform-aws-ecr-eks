variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = ""
}

variable "local_name" {
  description = "Infra stack/cluster name and Environent for resources local name"
  type        = map(string)
  default = {
    name = "",
    env  = ""
  }

  # Load balancer names must be no more than 32 characters long, and can only contain a limited set of characters.
  validation {
    condition     = length(var.local_name["name"]) <= 16 && length(regexall("[^a-zA-Z0-9-]", var.local_name["name"])) == 0
    error_message = "The project tag must be no more than 16 characters, and only contain letters, numbers, and hyphens."
  }

  validation {
    condition     = length(var.local_name["env"]) <= 8 && length(regexall("[^a-zA-Z0-9-]", var.local_name["env"])) == 0
    error_message = "The environment tag must be no more than 8 characters, and only contain letters, numbers, and hyphens."
  }
}

variable "vpc_cidr_block" {
  description = "Main VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_subnets_count" {
  description = "no. of subnets to launch"
  type        = number
  default     = 2 # For EKS, you need at least two availability zones??
}

variable "container_image" {
  description = "ECR image for k8s deployment"
  type        = string
  default     = ""
}

variable "container_port" {
  description = "Container port to be exposed and mapped to host"
  type        = number
  default     = 80
}

variable "db_username" {
  description = "RDS DB User name"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "RDS DB User password"
  type        = string
  sensitive   = true
}

variable "db_database" {
  description = "RDS default database for application"
  type        = string
  sensitive   = true
}

variable "git_repo" {
  description = "Git repo to build Docker image from"
  type        = string
  default     = ""
}
