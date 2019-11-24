#!/bin/bash

# History configuration
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# comment the following line to disable colored prompt
force_color_prompt=yes

__git_is_paired() {
    [[ $(git config user.name) == *" and "* ]]
}

__parse_git_branch() {
    local branch="$(git symbolic-ref -q HEAD 2>/dev/null)"
    [ $? -le 1 ] || return

    branch="${branch##refs/heads/}"
    [ ${#branch} -ge 20 ] && branch="${branch:0:17}..."

    [ -z "$branch" ] && return

    if __git_is_paired; then
        echo "${branch:-HEAD} paired)"
    else
        echo "(${branch:-HEAD})"
    fi
}

__config_prompt() {
    if [ -n "$force_color_prompt" ]; then
        if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
            # We have color support; assume it's compliant with Ecma-48
            # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
            # a case would tend to support setf rather than setaf.)
            color_prompt=yes
        else
            color_prompt=
        fi
    fi
    if [ "$color_prompt" = yes ]; then
        colored_branch_details='\[\033[01;31m\]$(__parse_git_branch)\[\033[00m\]'
        export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w${colored_branch_details}\$ "
    else
        export PS1='BB${debian_chroot:+($debian_chroot)}\u@\h:\w$(__parse_git_branch)\$ '
    fi
}

__config_prompt
