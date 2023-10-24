#!/bin/bash
sudo nano /etc/prometheus/prometheus.yml
promtool check config /etc/prometheus/prometheus.yml
curl -X POST http://localhost:9090/-/reload
