#!/bin/bash
# Install everything I need
# Romain Ducout

DIRNAME=$(dirname "$0")

read var </proc/sys/kernel/osrelease
if echo $var | grep -iqF "Microsoft"; then
    PLATFORM="wsl"
else
    PLATFORM="ubuntu"
fi

( exec $DIRNAME/scripts/install_packages.sh $PLATFORM )
( exec $DIRNAME/scripts/install_code_packages.sh $PLATFORM )
( exec $DIRNAME/scripts/install_python.sh $PLATFORM )
