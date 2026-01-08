#!/bin/bash

#------------------#
# Section: General #
#------------------#

# Label: Editor
# Description: Open file in default editor.
# Parameters: $1 (optional) - The file path.
e() {
  if [ -z "$1" ]; then
    $EDITOR -- # Open editor at current path
    return 0
  fi

  # Check if the path exists
  if [ ! -e "$1" ]; then
    printf "%s\n" "ERROR: File does not exist."
    return 1
  fi

  # - - - - - - - - - - - - - - - - - - - - - - - -

  cd "$(dirname "$1")" || return 1 # cd to the path
  $EDITOR --                       # Open editor at the path
}

# Label: Tab to Space
# Description: Convert file from tab to space indendation.
# Parameters: $1 (required) - The file to convert, $2 (optional) - The number of spaces, default: 2.
t2s() {
  if [[ "$2" ]]; then
    local number_of_spaces=$2
  else
    local number_of_spaces=2
  fi

  if [[ "$1" ]]; then
    local temp_file=$(mktemp -t tabs_to_spaces) || {
      printf "\n%s\n" "ERROR: Unable to create temporary file."
      return
    }
    expand -t "$number_of_spaces" "$1" >"$temp_file"
    cat "$temp_file" >"$1"
    printf "%s\n" "Converted: $1."
    rm -f "$temp_file"
  else
    printf "%s\n" "ERROR: File must be supplied."
    return 1
  fi
}

# Label: Colorized Type
# Description: Identical to "type" system command but with Bat support.
# Parameters: $1 (required) - The alias or function to inspect source code for.
cype() {
  local name="$1"

  if [[ -n "$name" ]]; then
    type "$name" | cat --language "bash"
  fi
}

# Label: Environment Update
# Description: Update environment with latest software.
# Updates Linux apps, brew, npm, fish, fisher, omf, pip, pip3 and their installed packages.
function u() {
  sudo apt update
  sudo apt upgrade -y
  sudo apt dist-upgrade -y
  sudo apt full-upgrade -y
  sudo apt autoremove -y
  sudo apt clean

  if command -v "brew" &>/dev/null; then
    brew update
    brew upgrade
  fi

  if command -v "basher" &>/dev/null; then
    basher update
  fi

  if command -v "fish" &>/dev/null; then
    fish -c "type -q fisher && \
			fisher && \
			fisher self-update"

    fish -c "type -q omf && \
			omf update"

    fish -c "fish_update_completions"
  fi

  if command -v "npm" &>/dev/null; then
    sudo npm i -g npm@latest

    if command -v "npm-check" &>/dev/null; then
      npm-check --global --update-all
    fi
  fi

  if command -v "pip3" &>/dev/null; then
    pip3 install -U pip
  fi

  if command -v "pip" &>/dev/null; then
    pip install --quiet --user --upgrade pip
    pip install --quiet --user --upgrade setuptools

    if command -v "pip-review" &>/dev/null; then
      pip-review -a
    fi
  fi

  if [[ -d "$HOME/.vim/plugins/Vundle.vim" ]]; then
    vim +PluginUpdate +qall
  fi
}

# Label: ISO
# Description: Builds an ISO image from mounted volume.
# Parameters: $1 (required) - Volume source path. $2 (required) - ISO output file path.
iso() {
  local source_path="$1"
  local output_path="$HOME/Downloads/$2.iso"

  if [[ ! -d "$source_path" ]]; then
    printf "%s\n" "Source path must be supplied or doesn't exist: $source_path."
    return 1
  fi

  if [[ -z "$2" ]]; then
    printf "%s\n" "ISO file name must be supplied."
    return 1
  fi

  printf "%s\n" "Creating $output_path..."
  hdiutil makehybrid -iso -joliet -o "$output_path" "$source_path"
}

# Label: Kill Process
# Description: Kill errant/undesired process.
# Parameters: $1 (required) - The search query, $2 (optional) - The signal. Default: 15.
kilp() {
  local query="$1"
  local signal=${2:-15}

  pkill -"$signal" -l -f "$query"
}

# Bash: Kill Vim when “Vim: Warning: Output not to a terminal”
# see: https://stackoverflow.com/a/46432233/5290011
vim() {
  [ -t 1 ] &&
    command vim "$@"
}

# ghf - [G]rep [H]istory [F]or top ten commands and execute one
# usage:
#  Most frequent command in recent history
#   ghf
#  Most frequent instances of {command} in all history
#   ghf {command}
#  Execute {command-number} after a call to ghf
#   !! {command-number}
function latest-history { history | tail -n 50; }
function grepped-history { history | grep "$1"; }
function chop-first-column { awk '{for (i=2; i<NF; i++) printf $i " "; print $NF}'; }
function add-line-numbers { awk '{print NR " " $0}'; }
function top-ten { sort | uniq -c | sort -r | head -n 10; }
function unique-history { chop-first-column | top-ten | chop-first-column | add-line-numbers; }
function ghf {
  if [ $# -eq 0 ]; then latest-history | unique-history; fi
  if [ $# -eq 1 ]; then grepped-history "$1" | unique-history; fi
  if [ $# -eq 2 ]; then
    grepped-history "$1" | unique-history | grep ^"$2" | chop-first-column
  fi
}

# Search for text within the current directory.
qt() {
  grep -ir --color=always "$*" --exclude-dir=".git" --exclude-dir="node_modules" . | less -RX
  #     │└─ search all files under each directory, recursively
  #     └─ ignore case
}

# Create new directories and enter the first one.
mkd() {
  if [ -n "$*" ]; then

    mkdir -p "$@"
    #      └─ make parent directories if needed

    cd "$@" ||
      exit 1

  fi
}
