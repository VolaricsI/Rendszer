#!/bin/bash

SERVICE_NEV=mythtv-backend

mkdir -p /etc/systemd/system/${SERVICE_NEV}.service.d
cat > /etc/systemd/system/${SERVICE_NEV}.service.d/override.conf <<EOF
#By Voli
[Unit]
Requires=mysql.service
EOF

echo "VAGY: systemctl edit ${SERVICE_NEV}.service"

