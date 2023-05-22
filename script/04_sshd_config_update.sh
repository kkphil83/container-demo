#!/bin/bash

cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

echo "Reloading sshd service..."
service sshd reload || { echo "Failed to reload sshd service"; exit 1; }

echo "sshd_config modification completed."

echo "Reloading sshd service..."
if command -v systemctl &>/dev/null; then
    systemctl reload sshd || { echo "Failed to reload sshd service"; exit 1; }
elif command -v service &>/dev/null; then
    service sshd reload || { echo "Failed to reload sshd service"; exit 1; }
else
    echo "Failed to reload sshd service. Unsupported service management."
    exit 1
fi

echo "sshd_config modification completed."
