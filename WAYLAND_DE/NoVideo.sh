wget https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb
dpkg -i cuda-keyring_1.1-1_all.deb
apt install linux-headers-amd64 --no-install-recommends -y
#apt install cuda-drivers -y # untested rn with my config
apt install nvidia-open -y
