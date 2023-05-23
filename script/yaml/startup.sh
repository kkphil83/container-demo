#!/bin/bash
export NEW_USER="cloud-user"

sudo adduser -U -m $NEW_USER
echo "$NEW_USER:openshift" | chpasswd

sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
systemctl restart sshd
systemctl status sshd



