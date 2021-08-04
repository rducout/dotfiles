#!/bin/bash

mkdir -p ~/.local/bin

# bat
ln -sf $(which batcat) ~/.local/bin/bat

# fd
ln -s $(which fdfind) ~/.local/bin/fd
