#!/bin/bash

# Step 0: Install Docker and Docker Compose
echo "Installing Docker and Docker Compose..."

# Update the package index
sudo apt-get update

# Install packages to allow apt to use a repository over HTTPS
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the stable repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Install Docker Compose (optional if needed)
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Step 1: Clone the repository with submodules
echo "Cloning the repository..."
sudo git clone --recurse-submodules https://github.com/opengisch/QFieldCloud.git
cd QFieldCloud

# Step 2: Pull the latest changes and update submodules
echo "Updating submodules..."
sudo git pull --recurse-submodules && sudo git submodule update --recursive

# Step 3: Copy the .env example file to .env
echo "Copying .env.example to .env..."
sudo cp .env.example .env

# Step 4: Open .env file for editing using nano
echo "Opening .env file in nano for editing..."
sudo nano .env

# Script will stop here, allowing you to edit the .env file manually.
