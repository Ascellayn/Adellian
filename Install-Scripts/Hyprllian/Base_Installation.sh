#!/bin/bash

# Base Installation Script for Adellian's Server Branch
SEPARATOR=$(printf "%-$(tput cols)s\n" "" | tr " " "=")
LOG_FILE="/System/Logs/Adellian_Installer/Hyprllian_Branch.log"

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
mkdir Hyprllian
cd Hyprllian

ENDL
LOG "[Hyprllian] - Installing Base System...\n"
SEPARATE
{
	apt install --no-install-recommends -y	\
	thunar
} &>> ${LOG_FILE}


# TBD File