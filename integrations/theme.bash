#!/bin/bash

# Load terminal theme using theme.sh
# see: https://github.com/lemnos/theme.sh

SMU_THEME="${SMU_THEME:-gruvbox}"

if command -v theme &>/dev/null; then
    case "$SMU_THEME" in
        gruvbox)
            theme gruvbox-material-dark-medium
            ;;
        nord)
            theme nord
            ;;
        catppuccin)
            theme catppuccin-macchiato
            ;;
    esac
fi
