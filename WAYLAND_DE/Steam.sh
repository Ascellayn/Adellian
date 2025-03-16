wget https://cdn.fastly.steamstatic.com/client/installer/steam.deb
dpkg -i steam.deb
apt install -f --no-install-recommends -y -t experimental
apt install bubblewrap libc6:amd64 libcurl4t64:i386 \
libegl1:amd64 libegl1:i386 \
libgbm1:amd64 libgbm1:i386 \
steam-libs-amd64:amd64 steam-libs-i386:i386 \
xdg-desktop-portal xdg-desktop-portal-gtk \
-t experimental --no-install-recommends -y
