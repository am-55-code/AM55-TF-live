provider "kubernetes" {
  config_path = "~/.kube/config"
  config_context = "docker-desktop"
}

module "k8s-webapp" {
  source = "git@github.com:am-55-code/TF-modules.git//services/k8s-app?ref=v0.7.1"

  name = "simple-webapp"
  image = "training/webapp"
  replicas = 2
  container_port = 5000
}

