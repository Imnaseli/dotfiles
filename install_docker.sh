#!/bin/bash

# Update package lists
if [ -f /etc/debian_version ]; then
    sudo apt-get update
elif [ -f /etc/centos-release ]; then
    sudo yum update
else
    echo "Unsupported OS"
    exit 1
fi

# Install curl if not installed
if ! command -v curl &> /dev/null; then
    if [ -f /etc/debian_version ]; then
        sudo apt-get install -y curl
    elif [ -f /etc/centos-release ]; then
        sudo yum install -y curl
    fi
fi

# Install Docker
echo "Installing Docker..."
curl -sS https://get.docker.com/ | sh

# Verify Docker installation
echo "Verifying Docker installation..."
sudo docker run hello-world

# Set up non-root access to Docker
echo "Setting up non-root access to Docker..."
sudo groupadd docker
sudo usermod -aG docker YOUR_USER
echo "You may need to log out and log back in for the changes to take effect."

# Enable Docker to start with the OS
echo "Configuring Docker to start with the OS..."
sudo systemctl enable docker

echo "Docker installation and configuration completed."

