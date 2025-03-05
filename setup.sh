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

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Step 1: Clone the specific release of QFieldCloud
echo "Cloning QFieldCloud v0.32.3..."
sudo git clone --branch v0.32.3 --recurse-submodules https://github.com/opengisch/QFieldCloud.git
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

# Step 5: Build and start QFieldCloud services
echo "Building and starting QFieldCloud services..."
sudo docker compose up -d --build

# Step 6: Run database migrations
echo "Running database migrations..."
sudo docker compose exec app python manage.py migrate

# Step 7: Collect static files
echo "Collecting static files..."
sudo docker compose run app python manage.py collectstatic --noinput

# Step 8: Check app status
echo "Checking app status..."
sudo docker compose exec app python manage.py status

# Step 9: Create superuser
echo "Creating superuser..."
sudo docker compose run app python manage.py createsuperuser --username kentemman --email super@user.com

echo "QFieldCloud setup is complete! 🎉"
