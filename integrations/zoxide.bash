#!/bin/bash

# Initialize zoxide (smart cd)
# Keep this block at the very end of bash_profile.
# zoxide doctor warns when initialization is not last.
# Gate on interactive shells so non-interactive invocations (e.g. tooling
# that sources the config per command) don't trigger the doctor warning.
# see: https://github.com/ajeetdsouza/zoxide

if [[ $- == *i* ]] && command -v zoxide &>/dev/null; then
    eval "$(zoxide init --cmd cd bash)"
fi
