#####################################################################
# Variables
#####################################################################
variable "project" {
  default = "rotfuks-43de4"
}
variable "image" {
  default = "test"
}
variable "region" {
  default = "us-central1"
}
variable "username" {
  default = "admin"
}
variable "password" {
  default = "<SAVE_16_CHARS_PASSWORD>"
}

#####################################################################
# Modules
#####################################################################
module "gke" {
  source = "./gke"
  project = var.project
  region = var.region
  username = var.username
  password = var.password
}

module "k8s" {
  source = "./k8s"
  host = module.gke.host
  project = var.project
  image = var.image
  username = var.username
  password = var.password

  client_certificate = module.gke.client_certificate
  client_key = module.gke.client_key
  cluster_ca_certificate = module.gke.cluster_ca_certificate
}