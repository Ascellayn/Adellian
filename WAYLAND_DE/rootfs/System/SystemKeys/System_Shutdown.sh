#!/bin/bash
echo -e "\e[31m=== AUTHENTIFICATION REQUIRED ===\e[0m"
echo "Please enter the root user's password to shutdown."
su - -c "shutdown now"
