#!/bin/bash
echo -e "\e[31m=== AUTHENTIFICATION REQUIRED ===\e[0m"
echo "Please enter the root user's password to enable wireless connectivity."
su - -c "echo 'Connecting...' && systemctl start iwd && dhclient"
