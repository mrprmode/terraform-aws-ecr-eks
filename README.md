# terraform-aws-ecr-eks
Terraform configs to dockerize a git repo, push to ECR, spin up a EKS cluster &amp; RDS host, update SSM with DB credentials, deploy a Loadbalanced service on AWS

### All you need to pass via `terraform.tfvars` or is:
```
aws_region = "us-west-2"
git_repo   = "https://github.com/mrprmode/mountains.git"
local_name = {
  name = "mountains",
  env  = "dev"
}
container_port = 80
db_username    = "YuYingNan"
db_password    = "ShiSheng8848"
db_database    = "TheZuMountainSaga"
```
or `terraform apply -var db_username="some_name" -var aws_region="some-aws-region" ...........`