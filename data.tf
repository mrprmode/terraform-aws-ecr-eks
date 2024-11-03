data "aws_availability_zones" "available" {}

# for docker push
data "aws_ecr_authorization_token" "token" {
  registry_id = module.ecr.repository_registry_id
}
