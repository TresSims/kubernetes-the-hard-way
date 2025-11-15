terraform {
  backend "gcs" {
    bucket = "terraform-kubernetes-the-hard-way"
    prefix = "kubernetes-the-hard-way"
  }
}
