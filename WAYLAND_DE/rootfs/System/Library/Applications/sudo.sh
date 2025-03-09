#!/bin/bash

# Homemade, bootleg sudo.

Path=$(pwd)
Arguments=$@
su -m -p -c "cd $Path && $Arguments"
