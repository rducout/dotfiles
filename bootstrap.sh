#!/bin/bash
# Bootstrap script for setting up everythong on a newly environment
# Romain Ducout

if [[ ! $(sudo echo 0) ]]; then exit; fi

DIRNAME=$(dirname "$0")

# install required packages
source $DIRNAME/install.sh

# initialises dotfiles links
source $DIRNAME/dotfiles.sh

# initialises github repositories
source $DIRNAME/gitinit.sh
