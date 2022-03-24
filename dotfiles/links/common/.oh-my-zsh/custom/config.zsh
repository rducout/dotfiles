#!/bin/bash

setopt HIST_IGNORE_ALL_DUPS

setopt PROMPT_CR
setopt PROMPT_SP
export PROMPT_EOL_MARK=""

# Set UP arrow to trigger fzf history (default CTRL+R)
#bindkey "${key[Up]}" fzf-history-widget

# Copy of conda added content in ~:bashrc
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/$USER/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/$USER/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/$USER/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/$USER/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

