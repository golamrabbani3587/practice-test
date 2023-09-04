terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Set the variable value in *.tfvars file

provider "digitalocean" {
  token = "dop_v1_e4d9ee690084f1d933372f2f294420fff95f7eb9a0391e4ff3cfbbd3ababeba3"
}
resource "digitalocean_droplet" "blue_server" {
  name    = "blue-server"
  region  = "nyc1"
  size    = "s-1vcpu-1gb"
  image   = "ubuntu-22-04-x64"
  ssh_keys = ["mykey"]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y software-properties-common
              apt-add-repository --yes --update ppa:ansible/ansible
              apt-get update
              apt-get install -y ansible

              # Configure firewall rules for ports 8701 to 8710
              for port in {8701..8710}; do
                sudo ufw allow $port
              done
              EOF
}
