#!/bin/bash

# Homemade, bootleg sudo.

Path=$(pwd)
Arguments=$@
su - -c "cd $Path && $Arguments"

if [[ $(/usr/bin/id -u) -ne 0 ]] then
	su - -c "cd $Path && $Arguments"
else
	$Arguments
fi