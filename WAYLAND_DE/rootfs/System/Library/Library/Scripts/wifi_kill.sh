#!/bin/bash

# This is the script that runs when you middle click the Wifi module in Waybar

clear
/bin/bash /System/Library/Templates/authentification.sh "kill wireless connectivity"
/bin/bash /System/Library/Applications/sudo.sh "systemctl stop iwd"
