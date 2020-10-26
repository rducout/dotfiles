#!/bin/bash
# Install required python packages
# Romain Ducout

DIRNAME=$(dirname "$0")
readarray -t PACKAGES_LIST < $DIRNAME/install.python

# Install all required extensions
function install {
	sudo pip3 install "${PACKAGES_LIST[@]}"
}

echo -e "============================================================"
echo -e "You are about to install the following python packages:"
( IFS=$'\n'; echo "${PACKAGES_LIST[*]}" )
echo -e "============================================================"
read -r -p "Are you sure? [y|N] " configresponse
echo
if [[ $configresponse =~ ^(y|yes|Y) ]];then
	install
else
	echo "Skipping python packages install.";
fi
