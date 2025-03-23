#!/bin/bash
cd ~
Folder="Pictures/Screenshots/$(date +%Y-%m)"
Filename="$(date +%H-%M_%S).png"
mkdir -p $Folder
slurp | grim -g - "$Folder/$Filename" &&  wl-copy < "$Folder/$Filename"
