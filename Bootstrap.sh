#!/bin/bash

# Install the necessary packages to then run the Adellian Installer 
SEPARATOR=$(printf "%-$(tput cols)s\n" "" | tr " " "=")
LOG_FILE="/System/Logs/Adellian_Installer/Bootstrap.log"

SEPARATE() {
	printf "${SEPARATOR}" >> ${LOG_FILE}
}

LOG() {
	printf "$1"
	printf "$1" >> ${LOG_FILE}
}

mkdir -p /System/Logs/Adellian_Installer/

printf "Welcome to Adellian.\n"
printf "Welcome to Adellian.\n" > ${LOG_FILE}
LOG "\n[Bootstrap] - Configuring Root Directories...\n\n"
mkdir -p /System/Library
cd /System

LOG "\n[Bootstrap] - Uninstalling Unused Packages...\n" >> ${LOG_FILE}
SEPARATE
{
	apt-get purge --allow-remove-essential -y						\
	eject fdisk lapt-getop-detect os-prober							\
	vim-common vim-tiny
} &>> ${LOG_FILE}
SEPARATE





LOG "\n\n[Bootstrap] - Adding and configuring repostories...\n\n" >> ${LOG_FILE}
printf "# Debian Unstable/Experimental - Adellian
deb https://deb.debian.org/debian experimental main contrib non-free non-free-firmware
deb https://deb.debian.org/debian sid main contrib non-free non-free-firmware

deb-src https://deb.debian.org/debian experimental main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian sid main contrib non-free non-free-firmware
" > /etc/apt/preferences.d/sources.list

printf "# Debian Experimental Override - Adellian
# Both priorities are the same so that Debian can install Experimental Packages when available but still fallback to Unstable when needed.


# Debian Experimental
Package: *
Pin: release a=experimental
Pin-Priority: 900

# Debian Unstable
Package: *
Pin: release a=unstable
Pin-Priority: 900
" > /etc/apt/preferences.d/adellian-experimental



LOG "[Bootstrap] - Upgrading to Debian Experimental...\n\n" >> ${LOG_FILE}
SEPARATE
{
	apt-get update
	apt-get dist-upgrade -y --no-install-recommends
	apt-get upgrade -y --no-install-recommends
} &>> ${LOG_FILE}
SEPARATE

LOG "\n[Bootstrap] - Installing Essential CLI Tools...\n\n" >> ${LOG_FILE}
{
	apt-get install -y --no-install-recommends	\
	python3 wget git
} &>> ${LOG_FILE}

LOG "\n[Bootstrap] - Purging Unused Packages...\n\n" >> ${LOG_FILE}
SEPARATE
{
	apt-get autoremove --purge -y
} &>> ${LOG_FILE}
SEPARATE

LOG "\n[Bootstrap] - Installing TSN Abstracter..." >> ${LOG_FILE}
SEPARATE
{
	cd /System/Library
	git clone https://github.com/Ascellayn/TSN_Abstracter
	printf "\n[Bootstrap] - Adding to .bashrc TSN Abstracter...\n"
	printf "\n# Adellian Bootstrap - TSN Abstracter Installation\nexport PYTHONPATH=/System/Library/TSN_Abstracter:$\n" >> /root/.bashrc
} &>> ${LOG_FILE}
SEPARATE

LOG "\n[Bootstrap] - Installing Adellian Setup Files..." >> ${LOG_FILE}
SEPARATE
{
	cd /System
	git clone https://github.com/Ascellayn/Adellian
} &>> ${LOG_FILE}
SEPARATE

LOG "\n\n\nScript finished. Please reboot your computer and then run 'python3 /System/Adellian/Installer.py' to continue installation."