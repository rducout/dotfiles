#!/bin/bash
# Initialises dotfiles for personal environment
# Romain Ducout

DIRNAME=$(dirname "$0")
echo $DIRNAME

python $DIRNAME/../dotmanager/dotmanager.py $DIRNAME/../dotmanager.json
