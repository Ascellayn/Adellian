#!/bin/bash
echo -e "\e[31m=== AUTHENTIFICATION REQUIRED ===\e[0m"
echo "Please enter the root user's password to kill wireless connectivity."
su - -c "systemctl stop iwd"
