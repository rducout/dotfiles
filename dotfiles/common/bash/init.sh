#!/bin/bash

function run_bash_script () {
    if [ -f $1 ]; then
        . $1
    fi
}

run_bash_script ${BASH_SOURCE%/*}/config.sh
run_bash_script ${BASH_SOURCE%/*}/aliases.sh
run_bash_script ${BASH_SOURCE%/*}/functions.sh
