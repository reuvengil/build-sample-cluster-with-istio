
# export KUBE_CONFIG_PATH=~/.kube/config
provider "kubernetes" {
  config_context_cluster   = "minikube"
  config_path = "~/.kube/config"
}