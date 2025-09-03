#!/bin/bash

SEPARATOR=$(printf "%-$(tput cols)s\n" "" | tr " " "=")
LOG_FILE="/System/Logs/Adellian_Installer/Universal_Fonts.log"

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
mkdir 

ENDL
LOG "[Fonts] - Downloading and installing Basic Fonts...\n"
SEPARATE
{
	apt update
	apt install -y --no-install-recommends \
	fonts-unifont fonts-font-awesome fonts-roboto
} &>> ${LOG_FILE}


ENDL
LOG "[Fonts] - Downloading Fonts...\n"
SEPARATE
wget https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg
wget https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg
wget https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg
wget https://github.com/13rac1/twemoji-color-font/releases/download/v15.1.0/TwitterColorEmoji-SVGinOT-Linux-15.1.0.tar.gz
wget https://raw.githubusercontent.com/foxoman/fixedsys/refs/heads/main/FSEX302-alt.ttf

ENDL
LOG "[Fonts] - Unpacking Fonts...\n"
SEPARATE
{
	# This looks bad because this is from old Adellian, but it works so idgaf
	7z x SF-Compact.dmg -y -sdel
	7z x "SFCompactFonts/SF Compact Fonts.pkg" -y -sdel
	7z x "SFCompactFonts.pkg" -y -sdel
	7z x "Payload~" -y -sdel
	mv -v "Library/Fonts" "Library/Fonts/SF-Compact"

	7z x SF-Pro.dmg -y -sdel
	7z x "SFProFonts/SF Pro Fonts.pkg" -y -sdel
	7z x "SFProFonts.pkg" -y -sdel
	7z x "Payload~" -y -sdel
	mv -v "Library/Fonts" "Library/Fonts/SF-Pro"

	7z x SF-Mono.dmg -y -sdel
	7z x "SFMonoFonts/SF Mono Fonts.pkg" -y -sdel
	7z x "SFMonoFonts.pkg" -y -sdel
	7z x "Payload~" -y -sdel
	mv -v "Library/Fonts" "Library/Fonts/SF-Mono"

	tar xf TwitterColorEmoji-SVGinOT-Linux-15.1.0.tar.gz
} &>> ${LOG_FILE}

ENDL
LOG "[Fonts] - Installing Fonts...\n"
SEPARATE
{
	# Apple Fonts
	mkdir -p "/usr/share/fonts/Apple Fonts"
	mv -v Library/* "/usr/share/fonts/Apple Fonts"

	# Tweetmoji
	mv -v "TwitterColorEmoji-SVGinOT-Linux-15.1.0/TwitterColorEmoji-SVGinOT.ttf" "/usr/share/fonts/"

	# Fixedsys Excelsior
	mv -v "FSEX302-alt.ttf" "/usr/share/fonts/"
} &>> ${LOG_FILE}

fc-cache

ENDL
LOG "[Fonts] - Cleaning up...\n"
SEPARATE
{
	rm -rf /System/Temp
} &>> ${LOG_FILE}