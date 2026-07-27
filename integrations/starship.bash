#!/bin/bash

# Load starship prompt
# see: https://starship.rs

SMU_PROMPT="${SMU_PROMPT:-starship}"
prompt_adapter="${BASH_CONFIG_DIR:-$HOME/.config/bash}/prompts/${SMU_PROMPT}.bash"

if [ -r "$prompt_adapter" ]; then
    # shellcheck source=/dev/null
    . "$prompt_adapter"
elif command -v starship &>/dev/null; then
    eval "$(starship init bash)"
else
    PS1='\u@\h:\w\$ '
fi

unset prompt_adapter
