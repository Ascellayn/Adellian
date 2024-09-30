#!/bin/bash

# A simple script that updates the system.
if [[ $(/usr/bin/id -u) -ne 0 ]] then
	/bin/bash /System/Library/Templates/authentification.sh "update the system"
	/bin/bash /System/Library/Applications/sudo.sh "/bin/bash /System/Library/Scripts/update.sh"
else
	echo ""
	echo -e "\e[32mAuthentificated succesfully, now updating the system.\e[0m"
	apt update
	apt upgrade --no-install-recommends
	apt autoremove --purge -y

	# Fixes for VSCode Bullshit
	echo -e "\e[34mRunning post update commands...\e[0m"
	chown -R ascellayn /usr/share/code-insiders
	echo -e "\e[32mFinished updating the system.\e[0m"
	read -p "Press any key to continue." < /dev/tty
	exit
fi
