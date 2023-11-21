#!/bin/bash

# Install Docker Machine
sudo curl -L https://github.com/docker/machine/releases/download/v0.14.0/docker-machine-$(uname -s)-$(uname -m) > /usr/local/bin/docker-machine
sudo chmod +x /usr/local/bin/docker-machine

docker-machine create \
    -d digitalocean \
    --digitalocean-access-token $DO_PAT \
    --digitalocean-image ubuntu-18-04-x64 \
    --digitalocean-region sgp1 \
    --digitalocean-backups=false \
    --engine-install-url "https://releases.rancher.com/install-docker/19.03.9.sh" \
    docker-nginx

# Environment Variables for this DigitalOcean Docker Engine
docker-machine env docker-nginx

# Add the keys
curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update
sudo apt install -y terraform
