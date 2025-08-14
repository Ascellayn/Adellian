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

ENDL() {
	printf "\n" >> ${LOG_FILE}
}

mkdir -p /System/Logs/Adellian_Installer/

printf "Welcome to Adellian.\n"
printf "Welcome to Adellian.\n" > ${LOG_FILE}
LOG "[Bootstrap] - Configuring Root Directories...\n"
mkdir -p /System/Library
cd /System


ENDL
LOG "[Bootstrap] - Uninstalling Unused Packages...\n"
SEPARATE
{
	apt purge --allow-remove-essential -y						\
	fdisk laptop-detect os-prober							\
	vim-common vim-tiny
} &>> ${LOG_FILE}
SEPARATE




ENDL
LOG "[Bootstrap] - Adding and configuring repostories...\n"
printf "# Debian Unstable/Experimental - Adellian
deb https://deb.debian.org/debian experimental main contrib non-free non-free-firmware
deb https://deb.debian.org/debian sid main contrib non-free non-free-firmware

#deb-src https://deb.debian.org/debian experimental main contrib non-free non-free-firmware
#deb-src https://deb.debian.org/debian sid main contrib non-free non-free-firmware
" > /etc/apt/sources.list

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


ENDL
LOG "[Bootstrap] - Upgrading to Debian Experimental...\n"
LOG "WARNING: At the time of writing this, Debian Experimental currently has a critical bug related to keyboard input in the TTY.\nYou may need to manually run 'apt dist-upgrade' later.\n"
SEPARATE
{
	apt update
	apt upgrade -y --no-install-recommends
} &>> ${LOG_FILE}
#{
#	apt-get update
#	apt-get dist-upgrade -y --no-install-recommends
#} &>> ${LOG_FILE}
SEPARATE


ENDL
LOG "[Bootstrap] - Installing Essential CLI Tools...\n"
{
	apt install -y --no-install-recommends	\
	python3 wget git
} &>> ${LOG_FILE}


ENDL
LOG "[Bootstrap] - Purging Unused Packages...\n"
SEPARATE
{
	apt autoremove --purge -y
} &>> ${LOG_FILE}
SEPARATE


ENDL
LOG "[Bootstrap] - Installing TSN Abstracter...\n"
SEPARATE
{
	cd /System/Library
	git clone https://github.com/Ascellayn/TSN_Abstracter
	SEPARATE

	ENDL
	LOG "[Bootstrap] - Adding to .bashrc TSN Abstracter...\n"
	printf "\n# Adellian Bootstrap - TSN Abstracter Installation\nexport PYTHONPATH=/System/Library/TSN_Abstracter:$\n" >> /root/.bashrc
} &>> ${LOG_FILE}
SEPARATE


ENDL
LOG "[Bootstrap] - Installing Adellian Setup Files...\n"
SEPARATE
{
	cd /System
	git clone https://github.com/Ascellayn/Adellian
} &>> ${LOG_FILE}
SEPARATE

cd ~
printf "#!/bin/bash
python3 /System/Adellian/Installer/Setup.py" > Adellian_Installer.sh
chmod +x Adellian_Installer.sh

LOG "\n\n\nScript finished. Please reboot your computer and then run './Adellian_Installer.sh' to continue installation.\n"