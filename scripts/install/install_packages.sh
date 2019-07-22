#!/bin/bash
# Install packages for programs, tools and languages used often used
# Romain Ducout

if [[ ! $(sudo echo 0) ]]; then exit; fi

PACKAGE_TOOLS_LIST=(
    gimp inkscape meld vlc xclip
)

PACKAGE_IDE_LIST=(
    intellij-idea-community code
)

# full list of packages required
PACKAGE_LIST=(
    git google-chrome-stable nodejs
    "${PACKAGE_IDE_LIST[@]}"
    "${PACKAGE_TOOLS_LIST[@]}"
)

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

# Adds Microsoft repository only if Visual Code not already installed
function add_visual_code_rep {
	if is_package_installed "code"; then
		return 1
	fi
	echo "Adding Visual Code repository..."
	wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
	sudo add-apt-repository -y "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
	return 0
}

# Adds Intellij repository only if Intellij not already installed
function add_intellij_rep {
	if is_package_installed "intellij-idea-community"; then
		return 1
	fi
	echo "Adding Intellij repository..."
	sudo add-apt-repository -y ppa:mmk2410/intellij-idea
	return 0
}

# Adds missing repositories only if they are not already installed
function add_missing_rep {
	need_update=false

	if added_chrome_rep ; then need_update=true ; fi
	if add_visual_code_rep ; then need_update=true ; fi
	if add_intellij_rep ; then need_update=true ; fi
	
	if $need_update ; then
		sudo apt-get update
	fi
}

# Install all required packages
function install {
	add_missing_rep
	sudo apt -y install "${PACKAGE_LIST[@]}"
}

echo -e "============================================================"
echo -e "You are about to install the following packages:"
( IFS=$'\n'; echo "${PACKAGE_LIST[*]}" )
echo -e "============================================================"
read -r -p "Are you sure? [y|N] " configresponse
echo
if [[ $configresponse =~ ^(y|yes|Y) ]];then
	install
else
	echo "Skipping package install.";
fi
