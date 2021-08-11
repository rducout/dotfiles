#!/bin/bash
# Install required visual studio code extensions
# Romain Ducout

DIRNAME=$(dirname "$0")
PLATFORM=$1

source $DIRNAME/functions.sh

declare -a CODE_FILE_LIST=(
    $DIRNAME/../installs/common/install.code
    $DIRNAME/../installs/$PLATFORM/install.code
)
declare -a EXTENSIONS_LIST=()
read_install_files CODE_FILE_LIST EXTENSIONS_LIST

# Install all required extensions
function install {
    for extensions in "${EXTENSIONS_LIST[@]}"
    do
        code --install-extension $extensions
    done
}

echo -e "============================================================"
echo -e "You are about to install the following visual code extensions:"
( IFS=$'\n'; echo "${EXTENSIONS_LIST[*]}" )
echo -e "============================================================"
read -r -p "Are you sure? [y|N] " configresponse
echo
if [[ $configresponse =~ ^(y|yes|Y) ]];then
	install
else
	echo "Skipping visual code extensions install.";
fi
