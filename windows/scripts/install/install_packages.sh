#!/bin/bash
# Install packages for programs, tools and languages used often used
# Romain Ducout

if [[ ! $(sudo echo 0) ]]; then exit; fi

DIRNAME=$(dirname "$0")
# Package list to install via apt-get
readarray -t PACKAGE_LIST_APT < $DIRNAME/install.apt

# Adds missing repositories only if they are not already installed
function add_missing_rep {
	need_update=false
	if added_chrome_rep ; then need_update=true ; fi
	
	if $need_update ; then
		sudo apt-get update
	fi
}

# Install all required packages
function install {
	add_missing_rep
	sudo apt -y install "${PACKAGE_LIST_APT[@]}"
}

function install_prompt_configuration {
	# Oh my zsh
	sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	# themes
	git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
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
	install_prompt_configuration
else
	echo "Skipping package install.";
fi
