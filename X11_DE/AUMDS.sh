# Warning: this is old don't use this (probably)

clear
echo "Welcome to Ascellayn's Ultra-Minimal Debian Script v1.0"
echo "WARNING: **DO NOT RUN** THIS SCRIPT ON ANY OTHER DISTRIBUTION BUT A FULLY CLEAN DEBIAN SID INSTALL!!!"
echo "This script is NOT MEANT for the average public as it assumes you're always going to use Linux as root."
echo "In fact this script is actually personal. No one should ever use Linux this way!"
echo ""
read -p "If you are willing to continue, press enter to start the script." < /dev/tty
echo ""

echo "Updating the System..."
{
    apt-get update
    apt-get dist-upgrade -y
} &> /dev/null

echo "Deleting unused packages..."
apt-get purge laptop-detect sudo vim* -y > /dev/null

echo "Installing Essential Packages..."
apt-get install --no-install-recommends tmux htop wget 7zip gpg ufw -y > /dev/null

echo "Adding Mozilla Reposiotry (for Firefox Nightly)..."
{
    install -d -m 0755 /etc/apt/keyrings
    wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
    echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
} &> /dev/null
echo "Adding Visual Studio Code Repository..."
{
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | tee /etc/apt/sources.list.d/vscode.list > /dev/null
    rm -f packages.microsoft.gpg
} &> /dev/null
echo "Adding Spotify Repository..."
{
    #apt-get install --no-install-recommends curl -y # I FUCKING HATE CURL. Why? ... WHO KNOWS
    wget -qO- https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
    echo "deb http://repository.spotify.com stable non-free" | tee /etc/apt/sources.list.d/spotify.list
    #apt-get purge --purge curl -y # double purge for good mesure
    #rm -rf /etc/curl # making sure :) (smiley face)
} &> /dev/null

echo "Updating package list..."
apt-get update > /dev/null

cd /
mkdir ADDS
cd ADDS
echo "Downloading Discord Canary..."
wget -q "https://discord.com/api/download/canary?platform=linux&format=deb" > /dev/null
echo "Downloading Termius Beta..."
wget -q "https://www.termius.com/beta/download/linux/Termius Beta.deb" > /dev/null

echo "Downloading Sirio Network Root Package..."
cd /
wget -q "https://sirio-network.com/download/AUMDS/root.tar" > /dev/null

echo "Installing the Desktop Environement (XFCE4)"
apt-get install --no-install-recommends -y \
xserver-xorg-core xserver-xorg-input-libinput xinit \
xfconf xfwm4 xfce4-session xfce4-settings libxfce4ui-utils xfdesktop4 thunar dbus-bin librsvg2-common xterm \
code-insiders firefox-nightly spotify-client vlc \
pavucontrol pulseaudio \
libopengl0 libfuse2t64 > /dev/null

echo "Unpacking the Sirio Network Root Package..."
rm -rf /usr/share/backgrounds/xfce/*
tar -xf root.tar > /dev/null 2>&1

echo "Installing previously downloaded DEB files..."
cd /ADDS
mv "canary?platform=linux&format=deb" discord-canary.deb # don't ask.
{
    dpkg -i discord-canary.deb
    dpkg -i "Termius Beta.deb"
} &> /dev/null

echo "Installing Dependencies..."
apt-get install --no-install-recommends -f -y > /dev/null

echo "Updating GRUB..."
update-grub2 > /dev/null

echo "Disabling some services..."
systemctl disable pulseaudio.service > /dev/null
systemctl disable pulseaudio.socket > /dev/null

echo "Configuring Firewall..."
{
    ufw enable
    # Enter your firewall configuration here
} &> /dev/null
echo "Cleaning up..."
{
    cd /
    rm -rf /ADDS
    rm -f /root.tar
    apt-get autoremove --purge
    apt-get clean
    journalctl --vacuum-time=1s
    rm -rf /tmp/*
    rm -rf /var/tmp/*
    rm -rf /var/log/*
} &> /dev/null

echo ""

read -p "The script has now finished all tasks. Press any key to reboot." < /dev/tty
echo "Rebooting..."
systemctl reboot

