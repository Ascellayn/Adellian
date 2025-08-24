#!/bin/bash

# This file will never ever change. It automatically downloads Bootstrap.sh, include this file on your USB key for easy Adellian Installation.

LOG() {
	printf "$1"
}

ENDL() {
	printf "\n"
}

ENDL
LOG "[Ignition] - Installing WGET...\n"
{
	apt install wget -y --no-install-recommends
} &>> ${LOG_FILE}

ENDL
LOG "[Ignition] - Downloading Adellian's Bootstrap Script...\n"
{
	wget "https://ascellayn.github.io/Adellian/Bootstrap.sh" -O Bootstrap.sh
} &>> ${LOG_FILE}

chmod +x Bootstrap.sh # Make sure the fucker is executable
LOG "\n\n\nScript finished. Run './Bootstrap.sh' to proceed with the installation.\n"