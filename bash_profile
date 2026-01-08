#!/bin/bash

# shellcheck source=/dev/null

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# XDG Base Directory Specification
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Bash Configuration Directory
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

BASH_CONFIG_DIR="${XDG_CONFIG_HOME}/bash"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Bash History (XDG State Directory)
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Create state directory if it doesn't exist
mkdir -p "${XDG_STATE_HOME}/bash"

# Use XDG-compliant location for bash history
export HISTFILE="${XDG_STATE_HOME}/bash/history"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Source Bash Configuration Files
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

source_bash_files() {
    local config_dir="$1"
    shift
    local files=("$@")
    
    for file in "${files[@]}"; do
        local file_path="${config_dir}/${file}"
        [[ -r "$file_path" ]] && . "$file_path"
    done
}

# Source core configuration files
source_bash_files "${BASH_CONFIG_DIR}/core" \
    "exports.bash" \
    "options.bash" \
    "colors.bash" \
    "autocomplete.bash" \
    "keybindings.bash"

# Source aliases
source_bash_files "${BASH_CONFIG_DIR}/aliases" \
    "navigation.bash" \
    "system.bash" \
    "networking.bash" \
    "git.bash" \
    "package-managers.bash"

# Source functions
source_bash_files "${BASH_CONFIG_DIR}/functions" \
    "general.bash" \
    "file-operations.bash" \
    "utilities.bash" \
    "piknik.bash" \
    "git.bash" \
    "github.bash" \
    "asciinema.bash" \
    "overmind.bash"

# Source integrations
source_bash_files "${BASH_CONFIG_DIR}/integrations" \
    "bash-sensible.bash" \
    "fzf.bash" \
    "z-lua.bash" \
    "thefuck.bash" \
    "emoji-log.bash" \
    "theme.bash" \
    "starship.bash"

# Cleanup
unset -f source_bash_files

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Homebrew Configuration
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Check to see if the Mac needs Rosetta installed by testing the processor
processor=$(/usr/sbin/sysctl -n machdep.cpu.brand_string 2>/dev/null | grep -o "Apple")

if [[ -n $processor ]]; then
    # Apple Silicon - 'brew' configurations
    [[ -x "/opt/homebrew/bin/brew" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
else
    # Intel - 'brew' configurations
    [[ -x "/usr/local/bin/brew" ]] && eval "$(/usr/local/bin/brew shellenv)"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Optional: Start tmux on bash startup
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Uncomment to enable tmux auto-start
# see: https://unix.stackexchange.com/a/260248

#if test -z "$TMUX"; then
#  session_num=$(
#    tmux list-sessions 2>/dev/null |
#    grep -v attached |
#    grep -oE '^\d+:' |
#    grep -oE '^\d+' |
#    head -1
#  )
#  if test "$session_num"; then
#    exec tmux attach -t "$session_num"
#  else
#    exec tmux
#  fi
#fi
