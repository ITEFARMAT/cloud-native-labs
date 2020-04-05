variable "kubeconfig" {
  description = "Name of output kubeconfig file"
}

variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "cluster_name" {
  description = "The project ID to host the cluster in"
}

variable "cluster_service_account_name" {
  description = "The name of the custom service account used for the GKE cluster. This parameter is limited to a maximum of 28 characters."
}

variable "cluster_service_account_description" {
  description = "A description of the custom service account used for the GKE cluster."
}

variable "location" {
  description = "The location of cluster"
}

variable "region" {
  description = "The region for the network. If the cluster is regional, this must be the same region. Otherwise, it should be the region of the zone."
}

variable "master_ipv4_cidr_block" {
  description = "The IP range in CIDR notation (size must be /28) to use for the hosted master network. This range will be used for assigning internal IP addresses to the master or set of masters, as well as the ILB VIP. This range must not overlap with any other ranges in use within the cluster's network."
}

# For the example, we recommend a /16 network for the VPC. Note that when changing the size of the network,
# you will have to adjust the 'cidr_subnetwork_width_delta' in the 'vpc_network' -module accordingly.
variable "vpc_cidr_block" {
  description = "The IP address range of the VPC in CIDR notation. A prefix of /16 is recommended. Do not use a prefix higher than /27."
}

# For the example, we recommend a /16 network for the secondary range. Note that when changing the size of the network,
# you will have to adjust the 'cidr_subnetwork_width_delta' in the 'vpc_network' -module accordingly.
variable "vpc_secondary_cidr_block" {
  description = "The IP address range of the VPC's secondary address range in CIDR notation. A prefix of /16 is recommended. Do not use a prefix higher than /27."
}
