echo "Removing unused packages..."
apt purge laptop-detect os-prober eject vim* fdisk --allow-remove-essential -y
apt autoremove --purge -y

echo "Installing Terminal Tools..."
# Terminal Tools
apt install --no-install-recommends -y     \
htop wget git gpg tmux                  \

echo "Installing temporary dependencies..."
apt install --no-install-recommends sassc dconf-cli -y
cd /tmp
echo "Downloading Fluent GTK & Icon Theme..."
git clone https://github.com/vinceliuice/Fluent-gtk-theme
git clone https://github.com/vinceliuice/Fluent-icon-theme
echo "Downloading Adellian Configuration Files..."
git clone https://github.com/siriusbyt/TBD_Name
cd Fluent-gtk-theme
echo "Building Fluent..."
./install.sh -t red -c dark -s compact -i debian -l --tweaks round blur noborder float
cd /tmp
cd Fluent-icon-theme
./install.sh red
cd /tmp
echo "Merging Adellian rootfs..."
cd TBD_Name
cd WAYLAND_DE
dconf load / < adellian_dconf.txt
apt purge dconf-cli sassc -y
apt autoremove --purge -y
cd rootfs
cp -R -v * /
cd /tmp
echo "Cleaning up..."
rm -rf Fluent-gtk-theme
rm -rf Fluent-icon-theme
rm -rf TBD_Name

echo "Updating sources and migrating to Experimental..."
apt update
apt upgrade -y --no-install-recommends
apt update -t experimental
apt upgrade -y --no-install-recommends -t experimental

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
apt install --no-install-recommends -y -t experimental         \
wireplumber pipewire                    \
hyprland foot tofi waybar swaybg pavucontrol        \
thunar firefox-nightly                  \
librsvg2-common                     \

echo "Installing non-essential stuff..."
# Non-essential Stuff
apt install --no-install-recommends         \
code-insiders

echo "Done"
