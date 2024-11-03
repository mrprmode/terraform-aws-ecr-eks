resource "aws_security_group" "rds" {
  name        = "${local.name}_inbound_rds_from_eks"
  description = "Allow MySQL inbound traffic at RDS from EKS nodes"
  vpc_id      = module.vpc.vpc_id
  tags        = local.tags
}

resource "aws_security_group" "eks" {
  name        = "${local.name}_outboud_eks_to_rds"
  description = "Allow MySQL outbound traffic at EKS nodes to RDS"
  vpc_id      = module.vpc.vpc_id
  tags        = local.tags
}

module "rds_inbound_from_eks" { #inbound mysql at RDS from ECS-sg
  source            = "terraform-aws-modules/security-group/aws"
  create_sg         = false
  security_group_id = aws_security_group.rds.id
  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = aws_security_group.eks.id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1
}

module "eks_outbound_to_rds" { #outbound mysql at ECS to RDS-sg
  source            = "terraform-aws-modules/security-group/aws"
  create_sg         = false
  security_group_id = aws_security_group.eks.id
  computed_egress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = aws_security_group.rds.id
    }
  ]
  number_of_computed_egress_with_source_security_group_id = 1
}
