#!/bin/bash

function run_bash_script () {
    if [ -f $1 ]; then
        . $1
    fi
}

run_bash_script config.sh
run_bash_script aliases.sh
run_bash_script functions.sh
