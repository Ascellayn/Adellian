#!/bin/bash
echo -e "\e[31m=== AUTHENTIFICATION REQUIRED ===\e[0m"
echo "Please enter the root user's password to update the system."
su - -c "echo 'Updating System...' && apt update && apt upgrade --no-install-recommends -y && apt autoremove --purge -y && chown -R ascellayn -R -v /usr/share/code-insiders/"
