#!/bin/bash

# directory shortcuts
alias cdw='cd ~/Downloads'
alias cdc='cd ~/Documents'
alias cdd='cd ~/Desktop'
alias cdr='cd ~/repos'

# list sub directories in tree form
alias lstree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"

# ---------------------------------------------
# utilities
# ---------------------------------------------
# kill intellij
alias rd-kill-intellij='killall -9 chrome'
# list all vs code extensions
alias rd-code-extensions='code --list-extensions'

# anaconda
alias rd-conda-nav="conda run anaconda-navigator &"