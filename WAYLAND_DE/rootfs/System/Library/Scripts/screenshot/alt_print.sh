#!/bin/bash
cd ~
Folder="Pictures/Screenshots/$(date +%Y-%m)"
Filename="$(date +%H-%M_%S).png"
mkdir -p $Folder
hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | grim -g - "$Folder/$Filename" &&  wl-copy < "$Folder/$Filename"
