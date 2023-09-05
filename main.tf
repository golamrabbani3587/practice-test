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
  token = "dop_v1_5920dc590621fd30519f8fe494eccc496e90e327a36b13e2eff1dcd72740e04f"
}

# resource "digitalocean_droplet" "blue_server" {
#   name    = "blue-server"
#   region  = "nyc1"
#   size    = "s-1vcpu-1gb"
#   image   = "ubuntu-22-04-x64"
#   ssh_keys = ["mykey"]

#   user_data = <<-EOF
#               #!/bin/bash
#               apt-get update
#               apt-get install -y software-properties-common
#               apt-add-repository --yes --update ppa:ansible/ansible
#               apt-get update
#               apt-get install -y ansible

#               # Configure firewall rules for ports 8701 to 8710
#               for port in {8701..8710}; do
#                 sudo ufw allow $port
#               done
#               EOF
# }


resource "digitalocean_droplet" "web" {
  name = "test-web-vm"
  image   = "ubuntu-22-04-x64"
  region = "nyc1"
  size = "s-1vcpu-1gb"
  monitoring = true
  ipv6 = true
  private_networking = true

  user_data = <<-EOF
            #!/bin/bash
            apt-get update
            apt-get install -y software-properties-common
            apt-add-repository --yes --update ppa:ansible/ansible
            apt-get update
            apt-get install -y ansible
            EOF
}