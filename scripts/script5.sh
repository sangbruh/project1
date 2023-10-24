#!/bin/bash
# Installing Node Exporter
sudo useradd --system --no-create-home --shell /bin/false node_exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz

# Extract Node Exporter files, move the binary, and clean up
tar -xvf node_exporter-1.6.1.linux-amd64.tar.gz
sudo mv node_exporter-1.6.1.linux-amd64/node_exporter /usr/local/bin/
rm -rf node_exporter*

# Create a systemd unit configuration file for Node Exporter
sudo nano /etc/systemd/system/node_exporter.service

# Enable and start Node Exporter
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

# Verify the Node Exporter's status
sudo systemctl status node_exporter
