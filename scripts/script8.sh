#!/bin/bash
# Install dependencies
sudo apt-get update
sudo apt-get install -y apt-transport-https software-properties-common

# Add the GPG Key
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

# Add Grafana Repository
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

# Update and Install Grafana
sudo apt-get update
sudo apt-get -y install grafana

# Enable and Start Grafana Service
sudo systemctl enable grafana-server
sudo systemctl start grafana-server
sudo systemctl status grafana-server
