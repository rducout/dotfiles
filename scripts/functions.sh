#!/bin/bash

read_install_files() {
    local -n FILE_LIST=$1
    local -n RES=$2
    for CURR_FILE in "${FILE_LIST[@]}"
    do
        if [ -f $CURR_FILE ]; then
            readarray -t CURR_ITEMS < $CURR_FILE
            RES+=("${CURR_ITEMS[@]}")
        fi
    done
}

# Succeed if package in parameter is installed
function is_package_installed {
	if dpkg --get-selections | grep -q "^$1[[:space:]]*install$" >/dev/null ; then
		return 0
	else
		return 1
	fi
}

function install_prompt_configuration {
	# Oh my zsh
	sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	# themes
	git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
}

function install_nvm {
	wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
}

# Adds Google Chrome repository only if Chrome not already installed
function add_google_chrome_repository {
    if [ -f /etc/apt/sources.list.d/google-chrome.list ]; then
		return 1
	fi
	echo "Adding Google Chrome repository..."
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
	return 0
}

function add_github_cli_repository {
    if [ -f /etc/apt/sources.list.d/github-cli.list ]; then
		return 1
	fi
	echo "Adding Github CLI repository..."
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
	return 0
}

# Adds missing repositories only if they are not already installed
function add_missing_repository_ubuntu {
	need_update=false
	if add_google_chrome_repository ; then need_update=true ; fi
	if add_github_cli_repository ; then need_update=true ; fi
	
	if $need_update ; then
		sudo apt-get update
	fi
}