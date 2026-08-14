#!/bin/bash

# Initialize atuin
# see: https://github.com/atuinsh/atuin

if [[ $- == *i* ]] && command -v atuin &>/dev/null; then
    eval "$(atuin init bash)"
fi
