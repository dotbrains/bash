#!/bin/bash

# System aliases

alias :q="exit"
alias c="clear"
alias ch="history -c && > \${XDG_STATE_HOME:-\$HOME/.local/state}/bash/history"
alias m="man"
alias path='printf "%b\n" "${PATH//:/\\n}"'
alias q="exit"

command -v "xclip" &>/dev/null && {
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
}

alias +x="chmod +x"
alias z="zoxide"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# 'ls' aliases

command -v "eza" &>/dev/null && {
    alias ls="eza"

    # List all files colorized in long format
    alias l="eza -l"
}

# List only directories
alias lsd="ls -lF --color | grep --color=never '^d'"
# List only hidden files
alias lsh="ls -ld .?*"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Better `rm`

# Option 1: `rip` - a safer and more user-friendly alternative to 'rm'
# see: https://github.com/nivekuil/rip

if command -v rip &>/dev/null; then
    alias rm="rip"
fi

# Option 2: `trash` - safer alternative to 'rm'
# see: https://github.com/andreafrancia/trash-cli

if command -v trash &>/dev/null; then
    alias rm="trash"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# 'fzy' aliases

command -v "fzy" &>/dev/null && {
    alias fzyf="find . -type f | fzy"
    alias fzyd="find . -type d | fzy"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Lock screen.

# Check operating system type
case "$(uname)" in
Darwin)
    # MacOS alias
    alias afk='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
    ;;

Linux)
    # Check for gnome-screensaver-command
    if command -v gnome-screensaver-command &>/dev/null; then
        alias afk='gnome-screensaver-command -l'
    # Check for dm-tool
    elif command -v dm-tool &>/dev/null; then
        alias afk='dm-tool lock'
    fi
    ;;
esac

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Hide/Show desktop icons.

# Hide desktop icons
case "$(uname)" in
Darwin)
    alias hide-desktop-icons='defaults write com.apple.finder CreateDesktop -bool false; killall Finder'
    ;;

Linux)
    # For GNOME
    alias hide-desktop-icons='gsettings set org.gnome.desktop.background show-desktop-icons false'
    ;;
esac

# Show desktop icons
case "$(uname)" in
Darwin)
    alias show-desktop-icons='defaults write com.apple.finder CreateDesktop -bool true; killall Finder'
    ;;

Linux)
    # For GNOME
    alias show-desktop-icons='gsettings set org.gnome.desktop.background show-desktop-icons true'
    ;;
esac
