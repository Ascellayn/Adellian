#!/bin/bash

# We don't want sudo on server branches so we have a separate script for Sudo
SEPARATOR=$(printf "%-$(tput cols)s\n" "" | tr " " "=")
LOG_FILE="/System/Logs/Adellian_Installer/Universal_Sudo.log"

ADELLIAN_BRANCH=$1
ADELLIAN_USER=$2

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

ENDL
LOG "[Sudo] - Installing Sudo...\n"
SEPARATE
{
	apt install --no-install-recommends -y	\
	sudo
} &>> ${LOG_FILE}

ENDL
LOG "[Sudo] - Allowing $ADELLIAN_USER to use sudo...\n"
printf "# Adellian - Sudoer Autoconfiguration
$ADELLIAN_USER ALL=(ALL:ALL) ALL
" > /etc/sudoers.d/$ADELLIAN_USER

# RootFS is handled by the Adellian Installer automatically.