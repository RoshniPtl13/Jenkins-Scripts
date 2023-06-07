#!/bin/bash

# Update the system
sudo apt update

# Install Java Development Kit (JDK)
sudo apt install -y default-jdk

# Add the Jenkins repository key
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -

# Add the Jenkins repository to package sources
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

# Update the package database
sudo apt update

# Install Jenkins
sudo apt install -y jenkins

# Start Jenkins service
sudo systemctl start jenkins

# Enable Jenkins service to start on boot
sudo systemctl enable jenkins

# Print Jenkins status
sudo systemctl status jenkins
