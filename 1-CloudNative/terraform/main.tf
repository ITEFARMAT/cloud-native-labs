provider "google" {
  version = "~> 2.9.0"
  project = var.project_id
  region  = "europe-west4"

  scopes = [
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
    "https://www.googleapis.com/auth/devstorage.full_control",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

provider "google-beta" {
  version = "3.13.0"
}

data "google_client_config" "client" {}
data "google_client_openid_userinfo" "terraform_user" {}

