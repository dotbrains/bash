#!/bin/bash

# Load terminal theme using theme.sh
# see: https://github.com/lemnos/theme.sh

SMU_THEME="${SMU_THEME:-gruvbox}"

if command -v theme &>/dev/null; then
    case "$SMU_THEME" in
        gruvbox)
            theme gruvbox-dark
            ;;
        nord)
            theme nord
            ;;
        catppuccin)
            theme catppuccin-macchiato
            ;;
        tokyo-night)
            theme tokyo-night
            ;;
        rose-pine)
            theme rose-pine
            ;;
        dracula)
            theme dracula
            ;;
        everforest)
            theme everforest
            ;;
        solarized)
            theme solarized-dark
            ;;
        kanagawa)
            theme kanagawa
            ;;
    esac
fi
