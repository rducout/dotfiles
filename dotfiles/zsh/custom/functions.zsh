#!/bin/bash

hello () {
    echo "Hello you!!! Have a good day!"
}

mkd() {
    mkdir -p "$1";
    cd "$1"
}
