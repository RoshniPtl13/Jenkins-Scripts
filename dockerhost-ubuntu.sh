#!/bin/bash

# Update the system
sudo apt update

# Install required packages to use HTTPS
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker's repository
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package database
sudo apt update

# Install Docker Engine
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Add your user to the 'docker' group
sudo usermod -aG docker $USER

# Enable Docker to start on boot
sudo systemctl enable docker

# Create a directory for the Apache container
mkdir apache-container
cd apache-container

# Create a Dockerfile for the Apache container
cat <<EOF > Dockerfile
FROM ubuntu:latest
RUN apt update && apt install -y apache2 && apt clean
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
EOF

# Build the Docker image
sudo docker build -t my-apache-image .

# Run the Docker container
sudo docker run -d -p 80:80 --name my-apache-container my-apache-image

# Print Docker version
docker version
