#!/bin/bash

SERVICE_NEV=openvpn@

##	Mert mindenképpen ujra kell indulnia!!!

mkdir -p /etc/systemd/system/${SERVICE_NEV}.service.d
cat > /etc/systemd/system/${SERVICE_NEV}.service.d/override.conf <<EOF
#By Voli
[Service]
RestartSec=30
Restart=always

EOF

echo "VAGY: systemctl edit ${SERVICE_NEV}.service"
