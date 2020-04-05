module "gke_cluster" {
  source = "./modules/gke-cluster"

  name = var.cluster_name

  project                = var.project_id
  location               = var.location
  network                = module.vpc_network.network
  subnetwork             = module.vpc_network.public_subnetwork
  master_ipv4_cidr_block = var.master_ipv4_cidr_block

  enable_private_nodes    = "false"
  disable_public_endpoint = "false"
  master_authorized_networks_config = [
    {
      cidr_blocks = [
        {
          cidr_block   = "0.0.0.0/0"
          display_name = var.cluster_name
        },
      ]
    },
  ]

  cluster_secondary_range_name = module.vpc_network.public_subnetwork_secondary_range_name
}

resource "google_container_node_pool" "worker_pool" {
  provider = google-beta
  name     = "worker-pool"
  project  = var.project_id
  location = var.location
  cluster  = module.gke_cluster.name

  initial_node_count = "2"

  autoscaling {
    min_node_count = "1"
    max_node_count = "10"
  }

  management {
    auto_repair  = "true"
    auto_upgrade = "true"
  }

  node_config {
    image_type   = "COS"
    machine_type = "n1-standard-1"

    disk_size_gb = "100"
    disk_type    = "pd-standard"
    preemptible  = true

    service_account = module.gke_service_account.email

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  lifecycle {
    ignore_changes = [initial_node_count]
  }

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }
}

module "gke_service_account" {
  source = "./modules/gke-service-account"

  name        = var.cluster_service_account_name
  project     = var.project_id
  description = var.cluster_service_account_description
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

module "vpc_network" {
  source = "github.com/gruntwork-io/terraform-google-network.git//modules/vpc-network?ref=v0.2.1"

  name_prefix = "${var.cluster_name}-network-${random_string.suffix.result}"
  project     = var.project_id
  region      = var.region

  cidr_block           = var.vpc_cidr_block
  secondary_cidr_block = var.vpc_secondary_cidr_block
}

data "template_file" "gke_host_endpoint" {
  template = module.gke_cluster.endpoint
}

data "template_file" "access_token" {
  template = data.google_client_config.client.access_token
}

data "template_file" "cluster_ca_certificate" {
  template = module.gke_cluster.cluster_ca_certificate
}
