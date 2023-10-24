#!/bin/bash
# Fix Docker login failed error
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
