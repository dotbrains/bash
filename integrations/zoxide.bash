#!/bin/bash

# Initialize zoxide (smart cd)
# Keep this block at the very end of bash_profile.
# zoxide doctor warns when initialization is not last.
# see: https://github.com/ajeetdsouza/zoxide

if command -v zoxide &>/dev/null; then
    eval "$(zoxide init --cmd cd bash)"
fi
