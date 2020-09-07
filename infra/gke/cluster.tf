#####################################################################
# GKE Cluster
#####################################################################
resource "google_container_cluster" "rotfuks-cluster" {
  name               = "rotfuks-cluster"
  location           = var.region
  remove_default_node_pool = true
  initial_node_count = 1

  master_auth {
    username = var.username
    password = var.password
  }
}

resource "google_container_node_pool" "free-tier-nodes" {
  name       = "free-tier-nodes"
  location   = var.region
  cluster    = google_container_cluster.rotfuks-cluster.name
  node_count = 1

  autoscaling {
    max_node_count = 3
    min_node_count = 1
  }

  node_config {
    preemptible  = true
    machine_type = "g1-small"

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

#####################################################################
# Output for K8S
#####################################################################
output "client_certificate" {
  value     = google_container_cluster.rotfuks-cluster.master_auth[0].client_certificate
  sensitive = true
}

output "client_key" {
  value     = google_container_cluster.rotfuks-cluster.master_auth[0].client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = google_container_cluster.rotfuks-cluster.master_auth[0].cluster_ca_certificate
  sensitive = true
}

output "host" {
  value     = google_container_cluster.rotfuks-cluster.endpoint
  sensitive = true
}