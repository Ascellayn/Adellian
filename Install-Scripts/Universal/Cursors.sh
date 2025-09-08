#!/bin/bash

SEPARATOR=$(printf "%-$(tput cols)s\n" "" | tr " " "=")
LOG_FILE="/System/Logs/Adellian_Installer/Universal_Cursors.log"

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
LOG "[Cursors] - Downloading Cursors...\n"
SEPARATE
wget https://github.com/ful1e5/apple_cursor/releases/download/v2.0.1/macOS.tar.xz

ENDL
LOG "[Cursors] - Installing Cursors...\n"
SEPARATE
{
	7z x macOS.tar.xz
	mv -v macOS /usr/share/icons/
	mv -v macOS-White /usr/share/icons/
} &>> ${LOG_FILE}

update-icon-caches /usr/share/icons

ENDL
LOG "[Cursors] - Cleaning up...\n"
SEPARATE
{
	rm -rf /System/Temp
} &>> ${LOG_FILE}