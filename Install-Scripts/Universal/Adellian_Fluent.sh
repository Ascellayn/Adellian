#!/bin/bash

# Install Adellian Screenshot
SEPARATOR=$(printf "%-$(tput cols)s\n" "" | tr " " "=")
LOG_FILE="/System/Logs/Adellian_Installer/Adellian_Fluent.log"

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

mkdir -p /System/Temp
cd /System/Temp

ENDL
LOG "[Adellian Fluent] - Downloading Adellian Fluent...\n"
SEPARATE
git clone https://github.com/Ascellayn/Adellian_Fluent


ENDL
LOG "[Adellian Fluent] - Installing Adellian Fluent...\n"
SEPARATE
{
	cd Adellian_Fluent
	./install.sh -c light
	./install.sh -c dark
} &>> ${LOG_FILE}


ENDL
LOG "[Adellian Fluent] - Downloading Fluent Icons...\n"
SEPARATE
git clone https://github.com/vinceliuice/Fluent-icon-theme
ENDL
LOG "[Adellian Fluent] - Installing Fluent Icons...\n"
SEPARATE
{
	cd Fluent-icon-theme
	./install.sh pink
	./install.sh purple
} &>> ${LOG_FILE}


ENDL
LOG "[Adellian Fluent] - Cleaning up...\n"
SEPARATE
{
	rm -rf /System/Temp
} &>> ${LOG_FILE}