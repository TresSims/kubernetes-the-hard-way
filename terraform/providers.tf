terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.11.0"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "5.4.0"
    }
  }
}

ephemeral "vault_kv_secret_v2" "gcp" {
  mount = "tres"
  name  = "kubernetes-the-hard-way/gcp-service-account"
}

provider "google" {
  region      = "us-central1"
  project     = "kubernetes-the-hard-way-478119"
  credentials = jsonencode(ephemeral.vault_kv_secret_v2.gcp.data)
}

provider "vault" {

}
