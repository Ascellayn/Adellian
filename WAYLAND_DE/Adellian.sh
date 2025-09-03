#!/bin/bash
if [ $(whoami) != "root"]; then
    echo "You must be running this script as root, with no other users other than root on the system."
    exit
fi

AdellianTitle="Adellian - DEV_240920 (WAYLAND_DE)"
InitialWarning=\
"[!] WARNING [!]\n\
This script does many changes to your current install of Debian. It is not advised to run this script on a non-clean install of Debian SID.\n\
Please note that the way I use Linux is very odd, you shouldn't consider this script like a distribution.\n\
\n\
If you are willing to continue, press <OK> to start the script.\n"
whiptail --msgbox --title "$AdellianTitle" "$InitialWarning" 25 80
InstallMenu()

:'
# TBD: TUI Menu similar to Debians expert install
InstallMenu() {
    RootOnly()
}

# This will ask if the OS will be used exclusively as root.
RootOnly() {

}

Install_BaseSystem() {
    echo "Installing base system..."
    apt-get install --no-install-recommends -y \
    htop ufw wget # i cant be fucked finishing this rn whatev, i dont remember all the packages i need damn it
}

Minimize_System() {
    # These packages are getting removed regardless of whats selected
    echo "Minimizing the system..."
    apt-get purge -y \
    eject laptop-detect \
    vim-common vim-tiny \
    grub-common fdisk
    # These packages will require confirmation by the user to delete them or not. (Right now they dont because Im lazy)
    # If it looks ridiculous thats because it is.
    apt-get purge -y os-prober
    apt-get purge -y iproute2
    apt-get purge -y iputils-ping

    # Cleanup
    apt-get autoremove --purge -y
}
'