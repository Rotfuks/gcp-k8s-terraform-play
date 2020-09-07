#####################################################################
# GKE Provider
#####################################################################
provider "google" {
  project = var.project
  region  = var.region
  credentials = file("gcp-service-key.json")
}