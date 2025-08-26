#!/bin/bash

# Base Installation Script for Adellian's Server Branch
SEPARATOR=$(printf "%-$(tput cols)s\n" "" | tr " " "=")
LOG_FILE="/System/Logs/Adellian_Installer/Siriollian_Branch.log"

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
mkdir Siriollian
cd Siriollian

ENDL
LOG "[Siriollian] - Installing Base System...\n"
SEPARATE
{
	apt install --no-install-recommends -y	\
	tmux htop openssh-server				\
	python3-venv ufw wireguard				\
} &>> ${LOG_FILE}


# TBD:
# Install Adellian Server Tools such as the Wireguard Configuration Tool
# Configure UFW
# Install Siriollian RootFS