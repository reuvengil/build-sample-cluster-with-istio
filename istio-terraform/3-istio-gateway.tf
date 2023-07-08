# helm repo add istio https://istio-release.storage.googleapis.com/charts
# helm repo update
# helm uninstall gateway -n istio-ingress --create-namespace istio/gateway
resource "helm_release" "gateway" {
  name = "gateway"

  repository       = "https://istio-release.storage.googleapis.com/charts"
  chart            = "gateway"
  namespace        = "istio-ingress"
  create_namespace = true
  version          = "1.18.0"
  timeout = 3600
  depends_on = [
    helm_release.istio_base,
    helm_release.istiod
  ]
}