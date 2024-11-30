apt update
apt upgrade
apt purge laptop-detect os-prober eject vim* dictionaries-common wamerican ibritish iamerican fdisk --allow-remove-essential
apt autoremove --purge

# Terminal Tools
apt install --no-install-recommends         \
htop wget git gpg tmux                  \

# Firefox Nightly
install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | tee /etc/apt/keyrings/packages.mozilla.org.asc
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | tee -a /etc/apt/sources.list.d/mozilla.list

# VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg

apt update
apt upgrade

# Desktop Environement & Essential Tools
apt install --no-install-recommends         \
wireplumber pipewire                    \
hyprland foot tofi waybar swaybg pavucontrol        \
thunar firefox-nightly                  \
librsvg2-common                     \

# Non-essential Stuff
apt install --no-install-recommends         \
code-insiders

apt install --no-install-recommends sassc
cd /tmp
git clone https://github.com/vinceliuice/Fluent-gtk-theme
git clone https://github.com/vinceliuice/Fluent-icon-theme
git clone https://github.com/siriusbyt/TBD_Name
cd Fluent-gtk-theme
./install.sh -t red -c dark -s compact -i debian -l --tweaks round blur noborder float
cd ..
cd Fluent-icon-theme
./install.sh red
apt purge sassc
apt autoremove --purge
rm -rf Fluent-gtk-theme
rm -rf Fluent-icon-theme
cd TBD_Name
cd WAYLAND_DE
apt install --no-install-recommends dconf-cli
dconf load / < adellian_dconf.txt
apt purge dconf-cli
apt autoremove --purge
cd rootfs
mv -R -v * /
cd /tmp
rm -rf TBD_Name


