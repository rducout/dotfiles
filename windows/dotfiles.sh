#!/bin/bash
# Initialises dotfiles for personal environment
# Romain Ducout

DIRNAME=$(dirname "$0")

cd $DIRNAME/..
python3 -m dot_manager windows/dotmanager.json
