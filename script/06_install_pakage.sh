#!/bin/bash

# 설치할 패키지들의 목록
packages=("podman" "git")

# 패키지 설치
for package in "${packages[@]}"
do
    echo "Installing package: $package"
    if ! rpm -q "$package" >/dev/null 2>&1; then
        dnf install -y "$package" || { echo "Failed to install package: $package"; exit 1; }
    else
        echo "Package $package is already installed."
    fi
done

echo "Package installation completed."

