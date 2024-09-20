#!/bin/bash
clear
echo "Adellian - DEV_240920 (WAYLAND_DE)"
echo "[!] WARNING [!]"
echo "This script does many changes to your current install of Debian. It is not advised to run this script on a non-clean install of Debian SID."
echo "Please note that the way I use Linux is very odd, you shouldn't consider this script like a distribution;"
echo ""
read -p "If you are willing to continue, press enter to start the script." < /dev/tty
echo ""
InstallMenu()

# TBD: TUI Menu similar to Debian's expert install
InstallMenu() {
    RootOnly()
}

# This will ask if the OS will be used exclusively as root.
RootOnly() {

}

Install_BaseSystem() {
    echo "Installing base system..."
    apt-get install --no-install-recommends -y \
    htop ufw wget # i can't be fucked finishing this rn whatev, i dont remember all the packages i need damn it
}