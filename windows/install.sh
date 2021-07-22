#!/bin/bash
# Install everything I need
# Romain Ducout

DIRNAME=$(dirname "$0")

( exec $DIRNAME/scripts/install/install_packages.sh )
( exec $DIRNAME/scripts/install/install_code_packages.sh )
( exec $DIRNAME/scripts/install/install_python.sh )
