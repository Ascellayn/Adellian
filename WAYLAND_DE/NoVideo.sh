dpkg --add-architecture i386
wget https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb
dpkg -i cuda-keyring_1.1-1_all.deb
apt update
apt install linux-headers-amd64 --no-install-recommends -y -t experimental
apt install cuda-drivers -y # Not using -t experimental here because it usually fails for some reason
rm -rf cuda-keyring_1.1-1_all.deb
apt install nvidia-driver-libs:i386 -y # This is for steam
apt install nvidia-vaapi-driver -t experimental -y # Don't remember what it's for exactly, but Hyprland benefits from it or some shid, something about hardware acceleration and setting a specific env var for this
