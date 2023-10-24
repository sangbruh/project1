#!/bin/bash
# Searches for package updates and installs them
sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y

# Create user for Prometheus and install Prometheus
sudo useradd --system --no-create-home --shell /bin/false prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.47.1/prometheus-2.47.1.linux-amd64.tar.gz

# Unzip and prepare Prometheus files
tar -xvf prometheus-2.47.1.linux-amd64.tar.gz
cd prometheus-2.47.1.linux-amd64/
sudo mkdir -p /data /etc/prometheus
sudo mv prometheus promtool /usr/local/bin/
sudo mv consoles/ console_libraries/ /etc/prometheus/
sudo mv prometheus.yml /etc/prometheus/prometheus.yml

# Set ownership for directories
sudo chown -R prometheus:prometheus /etc/prometheus/ /data/

# Create a systemd unit configuration file for Prometheus
sudo nano /etc/systemd/system/prometheus.service

