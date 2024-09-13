#!/bin/bash
DistroRaw=$(cat /etc/issue)
Distro=${DistroRaw// \\n \\l/}

echo -e "$Distro $(hostname) tty1"
echo ""
echo "$(hostname) login: root"
