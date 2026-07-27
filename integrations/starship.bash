#!/bin/bash

# Load starship prompt
# see: https://starship.rs

SMU_PROMPT="${SMU_PROMPT:-starship}"

if [ "$SMU_PROMPT" = "classic" ]; then
    PS1='\u@\h:\w\$ '
elif command -v starship &>/dev/null; then
    eval "$(starship init bash)"
fi
