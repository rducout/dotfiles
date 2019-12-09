#!/bin/bash

# directory shortcuts
alias cdw='cd ~/Downloads'
alias cdc='cd ~/Documents'
alias cdd='cd ~/Desktop'
alias cdr='cd ~/repos'

# git shortcuts
alias rd-git-st='git status'
alias rd-git-rank='git shortlog -sn --no-merges'
alias rd-git-l='git log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short'
alias rd-git-ll='git log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'
alias rd-git-lll='git log -u'
alias rd-git-amend='git commit --amend --no-edit'

# ---------------------------------------------
# utilities
# ---------------------------------------------
# kill intellij
alias rd-kill-intellij='killall -9 chrome'
# list all vs code extensions
alias rd-code-ext='code --list-extensions'

# anaconda
alias rd-conda-nav="conda run anaconda-navigator &"