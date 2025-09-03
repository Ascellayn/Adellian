#!/bin/bash

SEPARATOR=$(printf "%-$(tput cols)s\n" "" | tr " " "=")
LOG_FILE="/System/Logs/Adellian_Installer/Universal_QEMU.log"

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
LOG "[QEMU] - Installing Dependencies...\n"
SEPARATE
{
	apt install --no-install-recommends -y	\
	qemu-system-amd64 qemu-utils qemu-system-gui qemu-utils ovmf
} &>> ${LOG_FILE}


# RootFS is handled by the Adellian Installer automatically.