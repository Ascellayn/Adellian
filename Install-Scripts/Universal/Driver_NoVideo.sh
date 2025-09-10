#!/bin/bash

# Nvidia Driver install script
SEPARATOR=$(printf "%-$(tput cols)s\n" "" | tr " " "=")
LOG_FILE="/System/Logs/Adellian_Installer/Driver_NoVideo.log"

ADELLIAN_BRANCH=$1

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
LOG "[NoVideo] - Adding i386 Architecture...\n"
SEPARATE
{
	dpkg --add-architecture i386
} &>> ${LOG_FILE}

ENDL
LOG "[NoVideo] - Installing the Nvidia Repository...\n"
SEPARATE
{
	wget https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb
	dpkg -i cuda-keyring_1.1-1_all.deb
	rm -rf cuda-keyring_1.1-1_all.deb
	printf "# Nvidia Driver Override - Adellian
Package: *
Pin: release a=experimental
Pin-Priority: 900

# Debian Unstable
Package: *
Pin: release o=NVIDIA
Pin-Priority: 1000
" > /etc/apt/preferences.d/adellian-nvidia
} &>> ${LOG_FILE}


# We need this otherwise the upgrade may get interrupted by interactive prompts.
export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a

ENDL
LOG "[NoVideo] - Updating the System...\n"
SEPARATE
{
	apt update
	apt upgrade -y --no-install-recommends
} &>> ${LOG_FILE}

ENDL
LOG "[NoVideo] - Installing the Nvdia Open Drivers...\n"
SEPARATE
{
	apt install nvidia-open nvidia-driver-libs:i386 nvidia-vaapi-driver -y
} &>> ${LOG_FILE} # We don't fuck around with NoVideo, so we install all the recommended shit.

ENDL
LOG "[NoVideo] - Installing the Nvdia Open Drivers...\n"
SEPARATE
{
	apt install nvidia-open nvidia-driver-libs:i386 nvidia-vaapi-driver -y
} &>> ${LOG_FILE} # We don't fuck around with NoVideo, so we install all the recommended shit.

if [ ADELLIAN_BRANCH == "Hyprllian" ]; then
	ENDL
	LOG "[NoVideo] - Editing Hyprllian Config...\n"
	SEPARATE
	{
		printf "\n# Adellian - NoVideo Driver Install\nsource	=	/System/Configuration/Hyprland/Nvidia.conf" >> /System/Configuration/User/main.conf
		printf "# ===============================================
# NoVideo Environment Variables
# https://wiki.hyprland.org/Nvidia/
# ===============================================

env	=	LIBVA_DRIVER_NAME,						nvidia
env	=	__GLX_VENDOR_LIBRARY_NAME,				nvidia
env	=	NVD_BACKEND,							nvidia
env	=	__GL_SHADER_DISK_CACHE_SKIP_CLEANUP,	1

opengl	{
	nvidia_anti_flicker	=	false
}
" > /System/Configuration/User/Nvidia.conf
	} &>> ${LOG_FILE}
fi

ENDL
LOG "[NoVideo] - Fixing Precompiled Shaders fuckery...\n"
SEPARATE
{
	printf "\n# This fixes fuckery related to precompiling shaders on Nvidia
__GL_SHADER_DISK_CACHE_SKIP_CLEANUP=1" >> /etc/environment
} &>> ${LOG_FILE}
# I play THE FINALS a shit ton. The precompiled shaders sometimes fuck off and delete themselves when they shouldn't, resulting in painfully long loading times.
# EVERY TIME. THE GAME. FUCKING RESTARTS. So this is why we do this.

ENDL
LOG "[NoVideo] - Fixing Sleep...\n"
SEPARATE
{
	systemctl enable nvidia-resume
	systemctl enable nvidia-suspend
} &>> ${LOG_FILE}