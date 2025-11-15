terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.11.0"
    }
  }
}

provider "google" {
  region      = "us-central1"
  project     = "kubernetes-the-hard-way-478119"
  credentials = "gcp-sa-keys"
}
