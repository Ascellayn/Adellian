#!/bin/bash

# Hyprland's XDG Desktop Portal, at least on the latest Git, seems entirely fucked with OBS at this moment on Adellian.
# I would look into this but right now it's deadass easier just to download Debian's Hyprland XDG, thankfully not that out of date.

# Install and build the latest Hyprland Git
SEPARATOR=$(printf "%-$(tput cols)s\n" "" | tr " " "=")
LOG_FILE="/System/Logs/Adellian_Installer/HyprXDG.log"

SEPARATE() {
	printf "${SEPARATOR}" >> ${LOG_FILE}
}

LOG() {
	printf "$1"
	printf "$1" >> ${LOG_FILE}
}

ENDL() {
	printf "\n" >> ${LOG_FILE}
}

cd /System/Library
mkdir HyprWM
cd HyprWM

# OPTIONAL
ENDL
LOG "[HyprInit] - Installing (Optional) Dependencies for Screensharing...\n"
SEPARATE
{
	apt install --no-install-recommends -y \
	qt6-base-dev libpipewire-0.3-dev libsdbus-c++-dev
} &>> ${LOG_FILE}
# qt6-base-dev // xdg-desktop-portal-hyprland

ENDL
LOG "[HyprInit] - Cloning xdg-desktop-portal-hyprland...\n"
SEPARATE
{
	git clone --recursive https://github.com/hyprwm/xdg-desktop-portal-hyprland
} &>> ${LOG_FILE}
SEPARATE

ENDL
LOG "[HyprInit] - Building xdg-desktop-portal-hyprland...\n"
SEPARATE
{
	cd xdg-desktop-portal-hyprland
	cmake -DCMAKE_INSTALL_LIBEXECDIR=/usr/lib -DCMAKE_INSTALL_PREFIX=/usr -B build
} &>> ${LOG_FILE}
SEPARATE
cmake --build build

ENDL
LOG "[HyprInit] - Installing xdg-desktop-portal-hyprland...\n"
SEPARATE
{
	cmake --install build
	cd ..
} &>> ${LOG_FILE}