#!/bin/bash

mkdir -p ~/.local/bin

# bat
ln -sf $(which batcat) ~/.local/bin/bat

# fd
ln -sf $(which fdfind) ~/.local/bin/fd
