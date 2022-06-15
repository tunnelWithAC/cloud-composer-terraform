provider "google" {
  project = var.project
  region = var.region
  zone = var.zone
}

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    google-beta = {
      source = "hashicorp/google-beta"
    }
  }
  required_version = ">= 0.13"
  backend "gcs" {}
}
