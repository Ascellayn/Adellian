#!/bin/bash

# Install and build the latest Hyprland Git
SEPARATOR=$(printf "%-$(tput cols)s\n" "" | tr " " "=")
LOG_FILE="/System/Logs/Adellian_Installer/HyprInit.log"

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

cd /System/Library
mkdir HyprWM
cd HyprWM

ENDL
LOG "[HyprInit] - Installing Required Dependencies...\n"
SEPARATE
{
	apt install --no-install-recommends -y																										\
	make cmake g++ pkg-config																													\
	libegl1-mesa-dev																															\
	libpugixml-dev																																\
	libpixman-1-dev																																\
	libseat-dev libinput-dev libwayland-dev wayland-protocols libdrm-dev libgbm-dev libdisplay-info-dev hwdata									\
	libzip-dev libcairo2-dev librsvg2-dev libtomlplusplus-dev																					\
	libmagic-dev																																\
	libxkbcommon-x11-dev libxcursor-dev libre2-dev libxcb-present-dev libxcb-icccm4-dev libxcb-composite0-dev libxcb-res0-dev libxcb-errors-dev	\
	dbus-user-session
} &>> ${LOG_FILE}
# Package requirements in order, certain things might depend on things from installed dependencies up.

# make cmake g++ pkg-config // C++
# libegl1-mesa-dev // Hyprland (Phase 1)
# libpugixml-dev // hyprwayland-scanner
# libpixman-1-dev // hyprutils
# libseat-dev libinput-dev libwayland-dev wayland-protocols libdrm-dev libgbm-dev libdisplay-info-dev hwdata // Aquamarine
# libzip-dev libcairo2-dev librsvg2-dev libtomlplusplus-dev // hyprcursor
# libmagic-dev // hyprgraphics
# libxkbcommon-x11-dev libxcursor-dev libre2-dev libxcb-present-dev libxcb-icccm4-dev libxcb-composite0-dev libxcb-res0-dev libxcb-errors-dev // Hyprland (Phase 2)
# dbus-user-session dconf-service // Hyprland (Phase 3)
SEPARATE





ENDL
LOG "[HyprInit] - Cloning hyprwayland-scanner...\n"
SEPARATE
{
	git clone https://github.com/hyprwm/hyprwayland-scanner
} &>> ${LOG_FILE}
SEPARATE

ENDL
LOG "[HyprInit] - Building hyprwayland-scanner...\n"
SEPARATE
{
	cd hyprwayland-scanner
	cmake -DCMAKE_INSTALL_PREFIX=/usr -B build
} &>> ${LOG_FILE}
SEPARATE
cmake --build build -j `nproc`

ENDL
LOG "[HyprInit] - Installing hyprwayland-scanner...\n"
SEPARATE
{
	cmake --install build
	cd ..
} &>> ${LOG_FILE}
SEPARATE





ENDL
LOG "[HyprInit] - Cloning hyprutils...\n"
SEPARATE
{
	git clone https://github.com/hyprwm/hyprutils
} &>> ${LOG_FILE}
SEPARATE

ENDL
LOG "[HyprInit] - Building hyprutils...\n"
SEPARATE
{
	cd hyprutils
	cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
} &>> ${LOG_FILE}
SEPARATE
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`


ENDL
LOG "[HyprInit] - Installing hyprutils...\n"
SEPARATE
{
	cmake --install build
	cd ..
} &>> ${LOG_FILE}
SEPARATE





ENDL
LOG "[HyprInit] - Cloning Aquamarine...\n"
SEPARATE
{
	git clone https://github.com/hyprwm/aquamarine
} &>> ${LOG_FILE}
SEPARATE

ENDL
LOG "[HyprInit] - Building Aquamarine...\n"
SEPARATE
{
	cd aquamarine
	cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
} &>> ${LOG_FILE}
SEPARATE
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`

ENDL
LOG "[HyprInit] - Installing Aquamarine...\n"
SEPARATE
{
	cmake --install build
	cd ..
} &>> ${LOG_FILE}
SEPARATE





ENDL
LOG "[HyprInit] - Cloning hyprlang...\n"
SEPARATE
{
	git clone https://github.com/hyprwm/hyprlang
} &>> ${LOG_FILE}
SEPARATE

ENDL
LOG "[HyprInit] - Building hyprlang...\n"
SEPARATE
{
	cd hyprlang
	cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
} &>> ${LOG_FILE}
SEPARATE
cmake --build ./build --config Release --target hyprlang -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`

ENDL
LOG "[HyprInit] - Installing hyprlang...\n"
SEPARATE
{
	cmake --install build
	cd ..
} &>> ${LOG_FILE}
SEPARATE




ENDL
LOG "[HyprInit] - Cloning hyprcursor...\n"
SEPARATE
{
	git clone https://github.com/hyprwm/hyprcursor
} &>> ${LOG_FILE}
SEPARATE

ENDL
LOG "[HyprInit] - Building hyprcursor...\n"
SEPARATE
{
	cd hyprcursor
	cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
} &>> ${LOG_FILE}
SEPARATE
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`

ENDL
LOG "[HyprInit] - Installing hyprcursor...\n"
SEPARATE
{
	cmake --install build
	cd ..
} &>> ${LOG_FILE}
SEPARATE




ENDL
LOG "[HyprInit] - Cloning hyprgraphics...\n"
SEPARATE
{
	git clone https://github.com/hyprwm/hyprgraphics
} &>> ${LOG_FILE}
SEPARATE

ENDL
LOG "[HyprInit] - Building hyprgraphics...\n"
SEPARATE
{
	cd hyprgraphics
	cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
} &>> ${LOG_FILE}
SEPARATE
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`

ENDL
LOG "[HyprInit] - Installing hyprgraphics...\n"
SEPARATE
{
	cmake --install build
	cd ..
} &>> ${LOG_FILE}
SEPARATE





ENDL
LOG "[HyprInit] - Cloning Hyprland...\n"
SEPARATE
{
	git clone --recursive https://github.com/hyprwm/Hyprland
} &>> ${LOG_FILE}
SEPARATE

ENDL
LOG "[HyprInit] - Building Hyprland...\n"
SEPARATE
cd Hyprland
make all
SEPARATE

ENDL
LOG "[HyprInit] - Installing Hyprland...\n"
SEPARATE
{
	make install
	cd ..
} &>> ${LOG_FILE}




# OPTIONAL
ENDL
LOG "[HyprInit] - Installing (Optional) Dependencies for Screensharing...\n"
SEPARATE
{
	apt install --no-install-recommends -y \
	qt6-base-dev libpipewire-0.3-dev libsdbus-c++-dev
} &>> ${LOG_FILE}
# qt6-base-dev // xdg-desktop-portal-hyprland

ENDL
LOG "[HyprInit] - Cloning xdg-desktop-portal-hyprland...\n"
SEPARATE
{
	git clone --recursive https://github.com/hyprwm/xdg-desktop-portal-hyprland
} &>> ${LOG_FILE}
SEPARATE

ENDL
LOG "[HyprInit] - Building xdg-desktop-portal-hyprland...\n"
SEPARATE
{
	cd xdg-desktop-portal-hyprland
	cmake -DCMAKE_INSTALL_LIBEXECDIR=/usr/lib -DCMAKE_INSTALL_PREFIX=/usr -B build
} &>> ${LOG_FILE}
SEPARATE
cmake --build build

ENDL
LOG "[HyprInit] - Installing xdg-desktop-portal-hyprland...\n"
SEPARATE
{
	cmake --install build
	cd ..
} &>> ${LOG_FILE}