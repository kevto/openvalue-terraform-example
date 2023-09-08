terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.81.0"
    }
  }
}

provider "google" {
  project = var.gcloud_project_id
  region = "europe-west1"
}
