#!/bin/bash

# We don't want sudo on server branches so we have a separate script for Sudo
SEPARATOR=$(printf "%-$(tput cols)s\n" "" | tr " " "=")
LOG_FILE="/System/Logs/Adellian_Installer/Universal_Sudo.log"

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


# RootFS is handled by the Adellian Installer automatically.