echo "Updating Experimental..."
apt update
apt upgrade -y --no-install-recommends
apt update -t experimental
apt upgrade -y --no-install-recommends -t experimental
apt install $(dpkg-query -f '${binary:Package}\n' -W) -t experimental --mark-auto

echo "Done"
