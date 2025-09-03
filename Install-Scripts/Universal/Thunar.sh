#!/bin/bash

SEPARATOR=$(printf "%-$(tput cols)s\n" "" | tr " " "=")
LOG_FILE="/System/Logs/Adellian_Installer/Universal_Thunar.log"

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

mkdir -p /System/LSW-VM
cd /System/LSW-VM

ENDL
LOG "[Thunar] - Installing Thunar...\n"
SEPARATE
{
	apt install --no-install-recommends -y	\
	thunar tumbler-common librsvg2-common ffmpegthumbnailer
} &>> ${LOG_FILE}


# Configuration is handled by the corresponding Adellian Branch.