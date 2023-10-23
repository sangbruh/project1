#!/bin/bash
sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y

# Install and set up Docker
sudo apt-get update
sudo apt-get install docker.io -y
sudo usermod -aG docker $USER  # Replace with your system's username, e.g., 'ubuntu'
newgrp docker
sudo chmod 777 /var/run/docker.sock
