resource "kubernetes_namespace" "myapp" {
  metadata {
    name = local.name
  }
}

resource "kubernetes_deployment" "myapp" {
  metadata {
    name      = local.name
    namespace = kubernetes_namespace.myapp.metadata.0.name
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = local.name
      }
    }
    template {
      metadata {
        labels = {
          app = local.name
        }
      }
      spec {
        container {
          image = module.ecr.repository_url
          name  = local.name
          port {
            container_port = local.container_port
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "256Mi"
            }
          }

          # ToDo: List of Env. variables passed in thru tfvars to be injected into container.
          env {
            name  = "DB_USER"
            value = module.db_params.db_username.secure_value
          }
          env {
            name  = "DB_PWD"
            value = module.db_params.db_password.secure_value
          }
          env {
            name  = "DB_HOST"
            value = aws_db_instance.mydb.address
          }
          env {
            name  = "DB_DATABASE"
            value = module.db_params.db_database.secure_value
          }

        }
      }
    }
  }
  depends_on = [
    aws_db_instance.mydb,
    docker_registry_image.upload
  ]
}

resource "kubernetes_service" "myapp" {
  wait_for_load_balancer = true
  metadata {
    name      = local.name
    namespace = kubernetes_namespace.myapp.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.myapp.spec.0.template.0.metadata.0.labels.app
    }
    type = "LoadBalancer"
    port {
      port        = 80
      target_port = local.container_port
    }
  }
}
