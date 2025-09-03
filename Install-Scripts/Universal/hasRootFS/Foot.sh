#!/bin/bash

SEPARATOR=$(printf "%-$(tput cols)s\n" "" | tr " " "=")
LOG_FILE="/System/Logs/Adellian_Installer/Universal_Foot.log"

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
LOG "[Foot] - Installing Dependencies...\n"
SEPARATE
{
	apt install --no-install-recommends -y	\
	foot
} &>> ${LOG_FILE}


# RootFS is handled by the Adellian Installer automatically.