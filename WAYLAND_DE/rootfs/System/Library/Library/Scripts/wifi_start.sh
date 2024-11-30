#!/bin/bash

# A simple script that enables wireless connectivity and runs dhclient.
if [[ $(/usr/bin/id -u) -ne 0 ]] then
	/bin/bash /System/Library/Templates/authentification.sh "enable wireless connectivity"
	/bin/bash /System/Library/Applications/sudo.sh "/bin/bash /System/Library/Scripts/wifi_start.sh"
else
	echo ""
	echo -e "\e[32mAuthentificated succesfully, now enabling wireless connectivity.\e[0m"
	systemctl start iwd

	echo -e "\e[34mRunning dhclient...\e[0m"
	dhclient
	exit
fi
