data "template_file" "kubeconfig" {
  template = "${file("${path.module}/config.tpl")}"

  vars = {
    token                  = data.kubernetes_secret.kubectl-admin-token.data.token
    cluster_ca_certificate = base64encode(data.template_file.cluster_ca_certificate.rendered)
    endpoint               = data.template_file.gke_host_endpoint.rendered
  }
}

resource "local_file" "kubeconfig" {
  content  = data.template_file.kubeconfig.rendered
  filename = var.kubeconfig
}
