wget https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb
dpkg -i cuda-keyring_1.1-1_all.deb
apt update
apt install linux-headers-amd64 --no-install-recommends -y -t experimental
apt install cuda-drivers -y
rm -rf cuda-keyring_1.1-1_all.deb
