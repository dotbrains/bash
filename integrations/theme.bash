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
        # catppuccin and kanagawa have no theme.sh equivalent; skip terminal
        # palette sync for those (fzf/bat/nvim still get themed elsewhere)
    esac
fi
