#!/bin/bash

scriptDir=$(cd $(dirname "${BASH_SOURCE[0]}"); pwd)

if ! grep -q $scriptDir ~/.gitconfig; then
    git config --global --add include.path "$scriptDir/aliases"
    git config --global alias.alias "! git config --get-regexp ^alias\. | sed -e s/^alias\.// -e s/\ /\ =\ /"
fi
