#####################################################################
# K8S Service
#####################################################################
resource "kubernetes_service" "rotfuks-test-services" {
  metadata {
    name = "rotfuks-test-services"
  }
  spec {
    selector = {
      app = kubernetes_deployment.rotfuks-test-deployment.spec.0.template.0.metadata[0].labels.app
    }
    port {
      name = "test-api"
      port = 3000
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}