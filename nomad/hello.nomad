job "hello-app" {
  datacenters = ["dc1"]
  group "example" {
    task "hello" {
      driver = "docker"
      config {
        image = "hashicorp/http-echo"
        args  = ["-text=hello from nomad"]
        port_map {
          http = 5678
        }
      }
      resources {
        network {
          port "http" { static = 5678 }
        }
      }
    }
  }
}
