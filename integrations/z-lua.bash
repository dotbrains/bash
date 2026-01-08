#!/bin/bash

# Load 'z.lua' configs.
# see: https://github.com/skywind3000/z.lua#install

if [[ -d "$HOME/.z.lua" ]]; then
    eval "$(lua "$HOME/.z.lua/z.lua" --init bash)"
fi
