#!/bin/bash
# Initialises github repositories
# Romain Ducout

ROOT_PATH=~/repos

function install {
    echo Setting up github repositories...

    gh auth login

    mkdir -p $ROOT_PATH

    readarray -t REPO_LIST < <(gh repo list | awk '{print $1}' | awk -F "/" '{print $2}')

    for CURR_REPO in "${REPO_LIST[@]}"
    do
        TARGET_PATH=$ROOT_PATH/$CURR_REPO
        if [ ! -d $TARGET_PATH ]; then
            gh repo clone $CURR_REPO $TARGET_PATH
        fi
    done
    echo Github repositories setup done.
}

echo -e "============================================================"
echo -e "You are about to setup your github repositories in $ROOT_PATH:"
echo -e "============================================================"
read -r -p "Are you sure? [y|N] " configresponse
echo
if [[ $configresponse =~ ^(y|yes|Y) ]];then
	install
else
	echo "Skipping github repositories setup.";
fi
