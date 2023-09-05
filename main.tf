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
  token = "dop_v1_d43b477c0eb0703718dd575a359cf57a36c03f5c70e9e320a79353983489b117"
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
