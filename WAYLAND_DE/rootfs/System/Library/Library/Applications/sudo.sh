#!/bin/bash

# Homemade, bootleg sudo.

Arguments=$@
su - -c "$Arguments"
