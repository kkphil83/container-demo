#!/bin/sh

USER="$USER"
PASSWORD="$PASSWORD"
URL="registry.redhat.io"

podman login -u $USER -p $PASSWORD $URL
