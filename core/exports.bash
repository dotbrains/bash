#!/bin/bash

# Bash Variables.
# https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Make `nvim` the default editor.

export EDITOR="nvim"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Ignore commands that start with spaces and duplicates.

export HISTCONTROL=ignoreboth

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Increase the maximum number of lines of history
# persisted in the history file (default value is 500).

export HISTFILESIZE=10000

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Don't add certain commands to the history file.

export HISTIGNORE="&:[bf]g:c:clear:history:exit:q:pwd:* --help"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Increase the maximum number of commands recorded
# in the command history (default value is 500).

export HISTSIZE=10000

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Prefer US English and use UTF-8 encoding.

export LANG="en_US"
export LC_ALL="en_US.UTF-8"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Use custom `less` colors for `man` pages.

export LESS_TERMCAP_md="$(
	tput bold 2>/dev/null
	tput setaf 2 2>/dev/null
)"
export LESS_TERMCAP_me="$(tput sgr0 2>/dev/null)"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Don't clear the screen after quitting a `man` page.

export MANPAGER="less -X"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Increase the maximum number of lines of history persisted
# in the `Node` REPL history file (default value is 1000).
#
# https://github.com/nodejs/node/blob/c948877688ff2b6a37f2c88724b656aae495c7b2/doc/api/repl.md#persistent-history

export NODE_REPL_HISTORY_SIZE=10000

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Make new shells get the history lines from all previous
# shells instead of the default "last window closed" history.

export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Make Python use UTF-8 encoding for output to stdin/stdout/stderr.

export PYTHONIOENCODING="UTF-8"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Ruby configurations
# Adds "GEMS_PATH" to "$PATH"
# Fixes "I INSTALLED GEMS WITH --user-install AND THEIR COMMANDS ARE NOT AVAILABLE"
# see: https://guides.rubygems.org/faqs/#user-install

if command -v gem &>/dev/null; then
	if [ -d "$(gem environment gemdir)/bin" ]; then
		export PATH="$(gem environment gemdir)/bin:$PATH"
	fi
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Add ~/.local/bin to $PATH

if [ -d "$HOME/.local/bin" ]; then
	export PATH="$HOME/.local/bin:$PATH"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Add /snap/bin to $PATH

if [ -d "/snap/bin" ]; then
	export PATH="/snap/bin:$PATH"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Theme Configuration
# Available themes: nord, gruvbox
# Set BASH_THEME environment variable to change (default: gruvbox)
BASH_THEME="${BASH_THEME:-gruvbox}"

case "$BASH_THEME" in
    gruvbox)
        # Gruvbox Dark Medium for fzf
        # see: https://github.com/morhetz/gruvbox
        export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
            --color=fg:#d5c4a1,bg:#282828,hl:#fabd2f
            --color=fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
            --color=info:#83a598,prompt:#fb4934,pointer:#b8bb26
            --color=marker:#8ec07c,spinner:#d3869b,header:#8ec07c'
        
        # Gruvbox for Bat
        export BAT_THEME="gruvbox-dark"
        
        # Set Gruvbox dir_colors
        THEME_DIR_COLORS="dir_colors_gruvbox"
        ;;
    
    nord)
        # Nord for fzf
        # see: https://github.com/ianchesal/nord-fzf
        export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
            --color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1
            --color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1
            --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
            --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'
        
        # Nord for Bat
        export BAT_THEME="Nord"
        
        # Set Nord dir_colors
        THEME_DIR_COLORS="dir_colors_nord"
        ;;
    
    *)
        echo "Warning: Theme '$BASH_THEME' not found. Available themes: nord, gruvbox"
        echo "Defaulting to gruvbox..."
        BASH_THEME="gruvbox"
        THEME_DIR_COLORS="dir_colors_gruvbox"
        ;;
esac

# Apply dir_colors
# Check if running on macOS or Linux
if [[ "$OSTYPE" == "darwin"* ]]; then
	DIRCOLORS_CMD="gdircolors"
else
	DIRCOLORS_CMD="dircolors"
fi

test -r "${XDG_CONFIG_HOME:-$HOME/.config}/bash/themes/$THEME_DIR_COLORS" && eval "$($DIRCOLORS_CMD "${XDG_CONFIG_HOME:-$HOME/.config}/bash/themes/$THEME_DIR_COLORS")"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Add ~/set-me-up to $PATH

if [ -d "$HOME/set-me-up" ]; then
	export PATH="$HOME/set-me-up:$PATH"
fi

# Add ~/set-me-up/set-me-up-installer to $PATH
if [ -d "$HOME/set-me-up/set-me-up-installer" ]; then
	export PATH="$HOME/set-me-up/set-me-up-installer:$PATH"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Configure linuxbrew
# see: https://docs.brew.sh/Homebrew-on-Linux#install

if test -d ~/.linuxbrew; then
    export PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
elif test -d /home/linuxbrew/.linuxbrew; then
    export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Make a global variable to access the dotfiles repository

export DOTFILES="$HOME/set-me-up"
