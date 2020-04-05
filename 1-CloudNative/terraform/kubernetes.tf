provider "kubernetes" {
  version                = "~> 1.11"
  host                   = data.template_file.gke_host_endpoint.rendered
  token                  = data.template_file.access_token.rendered
  cluster_ca_certificate = data.template_file.cluster_ca_certificate.rendered
  load_config_file       = false
}

resource "kubernetes_service_account" "kubectl-admin" {
  metadata {
    name      = "kubectl-admin"
    namespace = "kube-system"
  }
}

resource "kubernetes_secret" "kubectl-admin" {
  metadata {
    name      = "kubectl-admin"
    namespace = "kube-system"
    annotations = {
      "kubernetes.io/service-account.name" = "${kubernetes_service_account.kubectl-admin.metadata.0.name}"
    }
  }
  lifecycle {
    ignore_changes = [
      data
    ]
  }
  type = "kubernetes.io/service-account-token"
}

data "kubernetes_secret" "kubectl-admin-token" {
  metadata {
    name      = kubernetes_service_account.kubectl-admin.default_secret_name
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role_binding" "kubectl-admin" {
  metadata {
    name = "kubectl-admin"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "kubectl-admin"
    namespace = "kube-system"
  }
}

