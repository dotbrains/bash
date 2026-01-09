#!/bin/bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set LS_COLORS (GNU).
#
#  - `ls` displays colors if the `--color` option is passed.
#
#  - The actual colors are configured through the `LS_COLORS`
#    environment variable (built-in defaults are used if this
#    variable is not set).

LS_COLORS=""

LS_COLORS+="no=0;39:"   # Global default
LS_COLORS+="di=0;36:"   # Directory
LS_COLORS+="ex=0;32:"   # Executable file
LS_COLORS+="fi=0;39:"   # File
LS_COLORS+="ec=:"       # Non-filename text
LS_COLORS+="mi=1;31:"   # Non-existent file pointed to by a symlink
LS_COLORS+="ln=target:" # Symbolic link
LS_COLORS+="or=31;01"   # Symbolic link pointing to a non-existent file

export LS_COLORS

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Enable color support.

# Check if running on macOS or Linux
if [[ "$OSTYPE" == "darwin"* ]]; then
    DIRCOLORS_CMD="gdircolors"
else
    DIRCOLORS_CMD="dircolors"
fi

if [ -x "$(command -v $DIRCOLORS_CMD)" ]; then

    # Use theme-specific dir_colors if THEME_DIR_COLORS is set (from exports.bash)
    if [ -n "$THEME_DIR_COLORS" ] && test -r "${XDG_CONFIG_HOME:-$HOME/.config}/bash/themes/$THEME_DIR_COLORS"; then
        eval "$($DIRCOLORS_CMD -b "${XDG_CONFIG_HOME:-$HOME/.config}/bash/themes/$THEME_DIR_COLORS")"
    elif test -r "${XDG_CONFIG_HOME:-$HOME/.config}/bash/themes/dir_colors"; then
        eval "$($DIRCOLORS_CMD -b "${XDG_CONFIG_HOME:-$HOME/.config}/bash/themes/dir_colors")"
    else
        eval "$($DIRCOLORS_CMD -b)"
    fi

    alias dir="dir --color=auto"
    alias egrep="egrep --color=auto"
    alias fgrep="fgrep --color=auto"
    alias grep="grep --color=auto"
    alias ls="ls --color=auto"
    alias vdir="vdir --color=auto"

fi
