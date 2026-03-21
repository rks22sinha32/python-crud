#!/bin/bash

set -e

echo "🔹 Updating system..."
sudo apt update
sudo apt upgrade -y

echo "🔹 Installing required packages..."
sudo apt install -y ca-certificates curl gnupg lsb-release

echo "🔹 Creating keyrings directory..."
sudo mkdir -p /etc/apt/keyrings

echo "🔹 Adding Docker GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "🔹 Adding Docker repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "🔹 Updating package list..."
sudo apt update

echo "🔹 Installing Docker Engine..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "🔹 Enabling Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

echo "🔹 Adding current user to docker group..."
sudo usermod -aG docker $USER

echo "✅ Docker installation completed!"
echo "ℹ️  Please log out and log back in OR run: newgrp docker"
