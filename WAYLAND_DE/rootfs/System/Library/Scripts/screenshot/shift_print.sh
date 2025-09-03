#!/bin/bash
cd ~
Folder="Pictures/Screenshots/$(date +%Y-%m)"
Filename="$(date +%H-%M_%S).mp4"
mkdir -p $Folder
wf-recorder -g "$(slurp)" -a -c hevc_nvenc -C flac -D -r 60 -f "$Folder/$Filename"
