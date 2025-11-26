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
        # Replace this image with the correct image you have published
        image = "rahulkhairnar/devops-intern-final:latest"
        ports = ["http"]
      }

      resources {
        cpu    = 100    # minimal CPU shares
        memory = 128    # minimal memory (MB)
      }

      # Optional: simple health check (adjust if your app does not serve /)
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
