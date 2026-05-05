#!/bin/bash
set -euxo pipefail

# Install Docker + compose
apt-get update -y
apt-get install -y docker.io docker-compose-v2 git

# Allow ubuntu user to run docker without sudo
usermod -aG docker ubuntu
systemctl enable --now docker

# Clone the app repo into ubuntu's home
sudo -u ubuntu git clone https://github.com/ashwinok/notes-api.git /home/ubuntu/notes-api

# Bring the stack up using the pre-built image from GHCR
cd /home/ubuntu/notes-api
docker compose pull
docker compose up -d
