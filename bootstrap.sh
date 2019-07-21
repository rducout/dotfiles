#!/bin/bash
# Bootstrap script for setting up everythong on a newly environment
# Romain Ducout

if [[ ! $(sudo echo 0) ]]; then exit; fi

DIRNAME=$(dirname "$0")

#install required packages
( exec $DIRNAME/scripts/install.sh )

# initialises dotfiles links
( exec $DIRNAME/scripts/dotfiles.sh )
