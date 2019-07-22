#!/bin/bash
# Install required visual studio code extensions
# Romain Ducout

EXTENSIONS_LIST=(
    akamud.vscode-theme-onedark
    dbaeumer.vscode-eslint
    Equinusocio.vsc-material-theme
    GrapeCity.gc-excelviewer
    jasonnutter.search-node-modules
    ms-python.python
    msjsdiag.debugger-for-chrome
    Orta.vscode-jest
    PKief.material-icon-theme
    rokoroku.vscode-theme-darcula
    trinm1709.dracula-theme-from-intellij
)

# Install all required extensions
function install {
    for extensions in "${EXTENSIONS_LIST[@]}"
    do
        code --install-extension $extensions
    done
	#sudo apt -y install "${EXTENSIONS_LIST[@]}"
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
