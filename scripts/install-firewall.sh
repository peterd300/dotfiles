#!/bin/bash
# Script install UFW firewall and modify some sshd settings


file="firewall"
logdir="$HOME/log"
mkdir -p $logdir
log_file="$logdir/$file.log"

exec > >(tee -a "$log_file") 2>&1

sudo xbps-install -Sy ufw gufw

# Change SSH port to 2222
sudo sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config

# enable SSHD logging
sudo sed -i 's/#SyslogFacility AUTH/SyslogFacility AUTH/' /etc/ssh/sshd_config
sudo sed -i 's/#LogLevel INFO/LogLevel VERBOSE/' /etc/ssh/sshd_config

sudo sv restart sshd

# enable ufw service
sudo ln -sf /etc/sv/ufw/ /var/service/

sudo sv status ufw

# setup default rules
sudo ufw default deny incoming
sudo ufw default allow outgoing

#enable inbound ssh traffic.
sudo ufw allow 2222/tcp

# enable logging
sudo ufw logging low

# enable firewall
sudo ufw enable

# Harden the tcp/ip stack

sudo mkdir -p /etc/sysctl.d

sudo tee /etc/sysctl.d/99-hardening.conf > /dev/null << 'EOF'
# Disable IP forwarding unless needed
net.ipv4.ip_forward = 0
net.ipv6.conf.all.forwarding = 0

# Ignore ICMP redirects
net.ipv4.conf.all.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0

# Ignore source-routed packets
net.ipv4.conf.all.accept_source_route = 0

# Enable SYN flood protection
net.ipv4.tcp_syncookies = 1

# Log martian packets
net.ipv4.conf.all.log_martians = 1
EOF

# apply settings
sudo sysctl -p /etc/sysctl.d/99-hardening.conf


