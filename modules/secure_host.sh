#!/bin/bash
# Changes to host.conf
cat > /etc/host.conf << "EOF"
order bind,hosts
nospoof on
EOF

