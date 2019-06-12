#!/bin/bash

SERVICE_NEV=docker

mkdir -p /etc/systemd/system/${SERVICE_NEV}.service.d
cat > /etc/systemd/system/${SERVICE_NEV}.service.d/override.conf <<EOF
#By Voli
[Unit]
ConditionPathIsMountPoint=/var/lib/docker
EOF

echo "VAGY: systemctl edit ${SERVICE_NEV}.service"
