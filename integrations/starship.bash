#!/bin/bash

# Load starship prompt
# see: https://starship.rs

if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
fi
