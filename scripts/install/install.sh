#!/bin/bash
# Install everything I need
# Romain Ducout

DIRNAME=$(dirname "$0")

( exec $DIRNAME/install_packages.sh )
( exec $DIRNAME/install_code_packages.sh )
