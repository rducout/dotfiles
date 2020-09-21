#!/bin/bash
# Install packages for programs, tools and languages used often used
# Romain Ducout

if [[ ! $(sudo echo 0) ]]; then exit; fi

DIRNAME=$(dirname "$0")
# Package list to install via apt-get
readarray -t PACKAGE_LIST_APT < $DIRNAME/install.apt
# Package list to install via snap
readarray -t PACKAGE_LIST_SNAP < $DIRNAME/install.snap

# Succeed if package in parameter is installed
function is_package_installed {
	if dpkg --get-selections | grep -q "^$1[[:space:]]*install$" >/dev/null ; then
		return 0
	else
		return 1
	fi
}

# Adds Google Chrome repository only if Chrome not already installed
function add_google_chrome_rep {
	if is_package_installed "google-chrome-stable"; then
		return 1
	fi
	echo "Adding Google Chrome repository..."
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
	return 0
}

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

	for package in "${PACKAGE_LIST_SNAP[@]}"
	do
		sudo snap install "${package}" --classic
	done
}

function install_nvm {
	wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
}

function install_prompt_configuration {
	# Oh my zsh
	sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	# powerlevel9k theme
	git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
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
