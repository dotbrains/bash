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

LESS_TERMCAP_md="$(
	tput bold 2>/dev/null
	tput setaf 2 2>/dev/null
)"
export LESS_TERMCAP_md
LESS_TERMCAP_me="$(tput sgr0 2>/dev/null)"
export LESS_TERMCAP_me

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
		gem_bindir="$(gem environment gemdir)/bin"
		export PATH="$gem_bindir:$PATH"
		unset gem_bindir
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
# Available themes: gruvbox, nord, catppuccin, tokyo-night, rose-pine,
# dracula, everforest, solarized, kanagawa
# Set SMU_THEME or BASH_THEME to change (default: gruvbox)
SMU_PROFILE="${XDG_CONFIG_HOME:-$HOME/.config}/set-me-up/profile.env"
if [ -f "$SMU_PROFILE" ]; then
    smu_theme_before="${SMU_THEME:-}"
    smu_prompt_before="${SMU_PROMPT:-}"
    # shellcheck source=/dev/null
    . "$SMU_PROFILE"
    [ -n "$smu_theme_before" ] && SMU_THEME="$smu_theme_before"
    [ -n "$smu_prompt_before" ] && SMU_PROMPT="$smu_prompt_before"
    unset smu_theme_before smu_prompt_before
fi

export SMU_THEME="${SMU_THEME:-gruvbox}"
export SMU_PROMPT="${SMU_PROMPT:-starship}"
BASH_THEME="${BASH_THEME:-$SMU_THEME}"

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

    catppuccin)
        # Catppuccin Macchiato for fzf
        # see: https://github.com/catppuccin/fzf
        export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
            --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796
            --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6
            --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796'

        # Catppuccin for Bat
        export BAT_THEME="Catppuccin-macchiato"

        # Reuse the neutral dir_colors fallback until a Catppuccin file exists.
        THEME_DIR_COLORS="dir_colors"
        ;;

    tokyo-night)
        export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
            --color=fg:#c0caf5,bg:#1a1b26,hl:#7aa2f7
            --color=fg+:#c0caf5,bg+:#283457,hl+:#7aa2f7
            --color=info:#bb9af7,prompt:#f7768e,pointer:#9ece6a
            --color=marker:#7dcfff,spinner:#bb9af7,header:#7dcfff'
        export BAT_THEME="TokyoNight"
        THEME_DIR_COLORS="dir_colors"
        ;;

    rose-pine)
        export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
            --color=fg:#e0def4,bg:#191724,hl:#9ccfd8
            --color=fg+:#e0def4,bg+:#393552,hl+:#9ccfd8
            --color=info:#c4a7e7,prompt:#eb6f92,pointer:#31748f
            --color=marker:#ebbcba,spinner:#c4a7e7,header:#ebbcba'
        export BAT_THEME="Rose Pine"
        THEME_DIR_COLORS="dir_colors"
        ;;

    dracula)
        export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
            --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9
            --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9
            --color=info:#ff79c6,prompt:#ff5555,pointer:#50fa7b
            --color=marker:#8be9fd,spinner:#ff79c6,header:#8be9fd'
        export BAT_THEME="Dracula"
        THEME_DIR_COLORS="dir_colors"
        ;;

    everforest)
        export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
            --color=fg:#d3c6aa,bg:#2d353b,hl:#7fbbb3
            --color=fg+:#d3c6aa,bg+:#3a515d,hl+:#7fbbb3
            --color=info:#d699b6,prompt:#e67e80,pointer:#a7c080
            --color=marker:#83c092,spinner:#d699b6,header:#83c092'
        export BAT_THEME="Everforest Dark"
        THEME_DIR_COLORS="dir_colors"
        ;;

    solarized)
        export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
            --color=fg:#839496,bg:#002b36,hl:#268bd2
            --color=fg+:#93a1a1,bg+:#073642,hl+:#268bd2
            --color=info:#6c71c4,prompt:#dc322f,pointer:#859900
            --color=marker:#2aa198,spinner:#6c71c4,header:#2aa198'
        export BAT_THEME="Solarized (dark)"
        THEME_DIR_COLORS="dir_colors"
        ;;

    kanagawa)
        export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
            --color=fg:#dcd7ba,bg:#1f1f28,hl:#7e9cd8
            --color=fg+:#dcd7ba,bg+:#2d4f67,hl+:#7e9cd8
            --color=info:#957fb8,prompt:#c34043,pointer:#76946a
            --color=marker:#7aa89f,spinner:#957fb8,header:#7aa89f'
        export BAT_THEME="Kanagawa"
        THEME_DIR_COLORS="dir_colors"
        ;;
    
    *)
        echo "Warning: Theme '$BASH_THEME' not found."
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
