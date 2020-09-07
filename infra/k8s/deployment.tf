#####################################################################
# K8S Deployment
#####################################################################
resource "kubernetes_deployment" "rotfuks-test-deployment" {
  metadata {
    name = "rotfuks-test-deployment"

    labels = {
      app = "rotfuks-test-deployment"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "rotfuks-test-deployment"
      }
    }

    template {
      metadata {
        labels = {
          app = "rotfuks-test-deployment"
        }
      }
      spec {

        container {
          image = "gcr.io/${var.project}/${var.image}:latest"
          name = var.image

          port {
            container_port = 3000
          }

          env {
            name = "SOME_VAR"
            value = "some_var"
          }

          resources {
            limits {
              cpu = "0.5"
              memory = "1024Mi"
            }
            requests {
              cpu = "250m"
              memory = "512Mi"
            }
          }
        }
      }
    }
  }
}