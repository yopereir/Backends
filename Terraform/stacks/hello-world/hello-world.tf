check "health_check" {
  data "http" "opentofu_org" {
    url = "https://www.opentofu.org"
  }

  assert {
    condition     = data.http.opentofu_org.status_code == 200
    error_message = "${data.http.opentofu_org.url} returned an unhealthy status code"
  }
}
locals {
  mylocvar = jsondecode(file("./test.json"))
}
output "madata" { value = local.mylocvar.Gods }

provider "kubernetes" {
  config_path = "~/.kube/config"
  host        = "https://127.0.0.1:6443"
}
resource "kubernetes_namespace" "example" {
  metadata {
    name = "my-first-namespace"
  }
}

resource "kubernetes_deployment" "hello_world" {
  metadata {
    name      = "hello-world"
    namespace = "my-first-namespace"
    labels = {
      app = "hello-world"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "hello-world"
      }
    }

    template {
      metadata {
        labels = {
          app = "hello-world"
        }
      }

      spec {
        container {
          name  = "hello-world"
          image = "us-docker.pkg.dev/google-samples/containers/gke/hello-app:1.0"
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "hello_world" {
  metadata {
    name      = "hello-world"
    namespace = "my-first-namespace"
  }

  spec {
    selector = {
      app = "hello-world"
    }

    port {
      port        = 80
      target_port = 8080
    }
  }
}
resource "kubernetes_ingress_v1" "example" {
  wait_for_load_balancer = true
  metadata {
    name      = "example"
    namespace = "my-first-namespace"
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = "hello.test"
      http {
        path {
          path = "/"
          backend {
            service {
              name = "hello-world"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
resource "kubernetes_manifest" "hello_world" {
  manifest = yamldecode(file("./hello-world.yaml"))
}