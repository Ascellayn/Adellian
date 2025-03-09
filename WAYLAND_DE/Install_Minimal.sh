adduser ascellayn

# Note: We use /root/tmp instead of /tmp due to tmpfs size issues

echo "Removing unused packages..."
apt purge laptop-detect os-prober eject vim* fdisk --allow-remove-essential -y
apt autoremove --purge -y

echo "Installing Terminal Tools..."
# Terminal Tools
apt install --no-install-recommends -y \
htop wget git gpg tmux 7zip \

echo "Installing temporary dependencies..."
apt install --no-install-recommends sassc dconf-cli -y

mkdir /root/tmp
cd /root/tmp

echo "Downloading Fluent GTK & Icon Theme..."
git clone https://github.com/vinceliuice/Fluent-gtk-theme
git clone https://github.com/vinceliuice/Fluent-icon-theme
echo "Downloading Adellian Configuration Files..."
git clone https://github.com/siriusbyt/TBD_Name
cd Fluent-gtk-theme
echo "Building Fluent..."
./install.sh -t red -c dark -s compact -i debian -l --tweaks round blur noborder float
./install.sh -t pink -c light -s compact -i debian -l --tweaks round blur noborder float
cd /root/tmp
cd Fluent-icon-theme
./install.sh red
./install.sh pink
cd /root/tmp
echo "Merging Adellian rootfs..."
cd TBD_Name
cd WAYLAND_DE
dconf load / < "Adellian_Dark.dconf"
mv "Adellian_Light.dconf" /tmp/
chown ascellayn /tmp/Adellian_Light.dconf
chmod 7777 /tmp/Adellian_Light.dconf
su - ascellayn -c 'dconf load / < /tmp/Adellian_Light.dconf'
rm -rf /tmp/Adellian_Light.dconf
apt purge dconf-cli sassc -y
apt autoremove --purge -y
cd rootfs
cp -R -v * /
cd /root/tmp

echo "Updating sources and migrating to Experimental..."
rm -rf /etc/apt/sources.list
apt update
apt upgrade -y --no-install-recommends
apt update -t experimental
apt upgrade -y --no-install-recommends -t experimental
apt install $(dpkg-query -f '${binary:Package}\n' -W) -t experimental --mark-auto

echo "Adding Firefox Nightly Repository..."
# Firefox Nightly
install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | tee /etc/apt/keyrings/packages.mozilla.org.asc
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | tee -a /etc/apt/sources.list.d/mozilla.list

echo "Adding VSCode Insiders Repository..."
# VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg

echo "Updating repositories..."
apt update

echo "Installing the Desktop Environnement and its essential tools..."
# Desktop Environement & Essential Tools
apt install --no-install-recommends -y -t experimental \
wireplumber pipewire \
hyprland foot tofi waybar swaybg pavucontrol \
thunar firefox-nightly \
librsvg2-common \
fonts-unifont fonts-font-awesome

echo "Installing non-essential stuff..."
# Non-essential Stuff
apt install --no-install-recommends \
code-insiders

mkdir "Apple Fonts"
mkdir "AppleDownload"
cd "AppleDownload"

echo "Downloading Apple SF Fonts..."
wget https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg
wget https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg
wget https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg

echo "Unpacking Fonts..."
# For some reason, Extracting Payload doesn't work when in a one liner, so shits seperated.
7z x SF-Compact.dmg -y && 7z x "SFCompactFonts/SF Compact Fonts.pkg" -y && 7z x "SFCompactFonts.pkg" -y
7z x "Payload~" -y
mv -v "Library/Fonts" "/root/tmp/Apple Fonts/SF-Compact"

7z x SF-Pro.dmg -y && 7z x "SFProFonts/SF Pro Fonts.pkg" -y &&  7z x "SFProFonts.pkg" -y
7z x "Payload~" -y
mv -v "Library/Fonts" "/root/tmp/Apple Fonts/SF-Pro"

7z x SF-Mono.dmg -y && 7z x "SFMonoFonts/SF Mono Fonts.pkg" -y &&  7z x "SFMonoFonts.pkg" -y
7z x "Payload~" -y
mv -v "Library/Fonts" "/root/tmp/Apple Fonts/SF-Mono"

echo "Installing Apple Fonts..."
mv -v "/root/tmp/Apple Fonts" /usr/share/fonts/

echo "Downloading Tweetmoji Font..."
wget https://github.com/13rac1/twemoji-color-font/releases/download/v15.1.0/TwitterColorEmoji-SVGinOT-Linux-15.1.0.tar.gz
echo "Unpacking Tweetmoji Font..."
tar xf TwitterColorEmoji-SVGinOT-Linux-15.1.0.tar.gz
echo "Installing Tweetmoji Font..."
mv -v /root/tmp/TwitterColorEmoji-SVGinOT-Linux-15.1.0/TwitterColorEmoji-SVGinOT.ttf /usr/share/fonts/

echo "Downloading Fixedsys Excelsior Font..."
wget https://raw.githubusercontent.com/foxoman/fixedsys/refs/heads/main/FSEX302.ttf
echo "Installing Fixedsys Excelsior Font..."
mv FSEX302.ttf "Fixedsys Excelsior.ttf"
mv -v "Fixedsys Excelsior.ttf" /usr/share/fonts/

fc-cache

echo "Cleaning up..."
rm -rf /root/tmp

echo "Fixing Permissions..."
chmod -R 7777 /System/
chown -R -v ascellayn /home/ascellayn/
chown -R -v ascellayn /System/

echo "Done"
