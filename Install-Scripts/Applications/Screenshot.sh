#!/bin/bash

# Install Adellian Screenshot
SEPARATOR=$(printf "%-$(tput cols)s\n" "" | tr " " "=")
LOG_FILE="/System/Logs/Adellian_Installer/Application_Screenshot.log"

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

cd /System/Applications

ENDL
LOG "[Adellian Screenshot] - Installing Dependencies...\n"
SEPARATE
{
	apt install --no-install-recommends -y	\
	grim imv pipewire slurp wf-recorder wl-clipboard wireplumber
} &>> ${LOG_FILE}


ENDL
LOG "[Adellian Screenshot] - Installing Adellian Screenshot...\n"
SEPARATE
{
	git clone https://github.com/Ascellayn/Adellian_Screenshot
} &>> ${LOG_FILE}

