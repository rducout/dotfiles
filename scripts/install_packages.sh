#!/bin/bash
# Install packages for programs, tools and languages used often used
# Romain Ducout

if [[ ! $(sudo echo 0) ]]; then exit; fi

DIRNAME=$(dirname "$0")
PLATFORM=$1

source $DIRNAME/functions.sh

declare -a APT_FILE_LIST=(
    $DIRNAME/../installs/common/install.apt
    $DIRNAME/../installs/$PLATFORM/install.apt
)
declare -a SNAP_FILE_LIST=(
    $DIRNAME/../installs/common/install.snap
    $DIRNAME/../installs/$PLATFORM/install.snap
)

# Package list to install via apt-get
declare -a PACKAGE_LIST_APT=()
read_install_files APT_FILE_LIST PACKAGE_LIST_APT

# Package list to install via snap
declare -a PACKAGE_LIST_SNAP=()
read_install_files SNAP_FILE_LIST PACKAGE_LIST_SNAP

function install {
	if [[ "${PLATFORM}" == "ubuntu" ]]; then
	    add_missing_repository_ubuntu
	fi
	sudo apt -y install "${PACKAGE_LIST_APT[@]}"

	for package in "${PACKAGE_LIST_SNAP[@]}"
	do
		sudo snap install "${package}" --classic
	done

	install_prompt_configuration
}

echo -e "============================================================"
echo -e "You are about to install the following packages:"
( IFS=$'\n'; echo "${PACKAGE_LIST_APT[*]}" )
( IFS=$'\n'; echo "${PACKAGE_LIST_SNAP[*]}" )
echo -e "============================================================"
read -r -p "Are you sure? [y|N] " configresponse
echo
if [[ $configresponse =~ ^(y|yes|Y) ]];then
    install
else
	echo "Skipping package install.";
fi
