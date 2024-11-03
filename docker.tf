# build docker image
resource "docker_image" "my-docker-image" {
  name = module.ecr.repository_url
  build {
    context        = "."
    remote_context = local.git_repo
  }
  platform     = "linux/arm64"
  keep_locally = true

  depends_on = [
    module.ecr
  ]
}

# push image to ecr repo
resource "docker_registry_image" "upload" {
  name = docker_image.my-docker-image.name

  depends_on = [
    docker_image.my-docker-image
  ]
}
