#!/bin/bash

# Base Installation Script for Adellian's Server Branch
SEPARATOR=$(printf "%-$(tput cols)s\n" "" | tr " " "=")
LOG_FILE="/System/Logs/Adellian_Installer/Universal_BaseInstall.log"

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

ENDL
LOG "[Universal] - Installing Base System...\n"
SEPARATE
{
	apt install --no-install-recommends -y	\
	htop
} &>> ${LOG_FILE}


# TBD File