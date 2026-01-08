#!/bin/bash

# Load 'bash-sensible' configs.
# see: https://github.com/mrzool/bash-sensible

if [[ -d "${XDG_CONFIG_HOME:-$HOME/.config}/bash/bash-sensible" ]]; then
    . "${XDG_CONFIG_HOME:-$HOME/.config}/bash/bash-sensible/sensible.bash"
fi
