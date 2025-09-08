#!/bin/bash

SEPARATOR=$(printf "%-$(tput cols)s\n" "" | tr " " "=")
LOG_FILE="/System/Logs/Adellian_Installer/Universal_OCP.log"

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
LOG "[OCP] - Installing Open Cubic Player...\n"
SEPARATE
{
	apt install --no-install-recommends -y	\
	ocp
} &>> ${LOG_FILE}

# RootFS is handled by the Adellian Installer automatically.