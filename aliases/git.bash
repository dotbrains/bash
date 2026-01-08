#!/bin/bash

# Git aliases

command -v "hub" &>/dev/null && {
    alias git=hub
}

alias acp="git add -A && git commit -v && git push"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# `lazygit` aliases

command -v "lazygit" &>/dev/null && {
    alias lg="lazygit"
}
