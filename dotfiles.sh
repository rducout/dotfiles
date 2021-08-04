#!/bin/bash
# Initialises dotfiles for personal environment
# Romain Ducout

DIRNAME=$(dirname "$0")

read var </proc/sys/kernel/osrelease
if echo $var | grep -iqF "Microsoft"; then
    PLATFORM="wsl"
else
    PLATFORM="ubuntu"
fi

cd $DIRNAME
python3 -m dot_manager dotfiles/dotmanager_${PLATFORM}.json
