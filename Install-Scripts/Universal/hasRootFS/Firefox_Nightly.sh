#!/bin/bash

SEPARATOR=$(printf "%-$(tput cols)s\n" "" | tr " " "=")
LOG_FILE="/System/Logs/Adellian_Installer/Universal_Firefox.log"

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

cd /tmp

ENDL
LOG "[Firefox] - Installing the Firefox Nightly Repository...\n"
SEPARATE
{
	install -d -m 0755 /etc/apt/keyrings
	wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | tee /etc/apt/keyrings/packages.mozilla.org.asc
	echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | tee -a /etc/apt/sources.list.d/mozilla.list
} &>> ${LOG_FILE}


ENDL
LOG "[Firefox] - Installing Firefox Nightly...\n"
SEPARATE
{
	apt update
	apt install --no-install-recommends firefox-nightly
} &>> ${LOG_FILE}


# RootFS is handled by the Adellian Installer automatically.