#!/bin/bash
# Initialises dotfiles for personal environment
# Romain Ducout

DIRNAME=$(dirname "$0")

cd $DIRNAME/../
python -m dot_manager dotmanager.json
