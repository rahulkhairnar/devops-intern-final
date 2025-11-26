job "hello-app" {
  datacenters = ["dc1"]
  type        = "service"

  group "hello-group" {
    count = 1

    network {
      port "http" {
        static = 8080
      }
    }

    task "hello-task" {
      driver = "docker"

      config {
        image = "rahulkhairnar/devops-intern-final:latest"
        ports = ["http"]
      }

      resources {
        cpu    = 100
        memory = 128
      }

      service {
        name = "hello-service"
        port = "http"
        check {
          type     = "http"
          path     = "/"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
