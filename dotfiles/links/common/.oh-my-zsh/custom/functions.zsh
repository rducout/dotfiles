#!/bin/bash

hello () {
    echo "Hello you!!! Have a good day!"
}

mkd() {
    mkdir -p "$1";
    cd "$1"
}

rd-vpn() {
    nordvpn connect $1
}

rd-netflix-tv() {
    echo "Starting TV session"
    nordvpn connect $1
    pactl set-card-profile 1 output:hdmi-stereo
    google-chrome https://www.netflix.com/ --new-window
    echo "TV session started"
}

rd-netflix-tv-stop() {
    echo "Stoping TV session"
    nordvpn disconnect
    pactl set-card-profile 1 output:analog-stereo
    echo "TV session stopped"
}
