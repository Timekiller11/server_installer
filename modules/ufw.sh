#!/bin/bash
# Dependencies
apt-get install -y ufw

ufw default deny incoming
ufw default deny outgoing

# SSH
ufw allow 22/tcp

# DNS
ufw allow 53/tcp
# HTTP
ufw allow 80/tcp
# HTTPS
ufw allow 443/tcp
# SMTP
ufw allow 25/tcp
# SMTPS
ufw allow 465/tcp

ufw --force disable
ufw --force enable
