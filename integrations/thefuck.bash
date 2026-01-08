#!/bin/bash

# thefuck - Magnificent app which corrects your previous console command.
# see: https://github.com/nvbn/thefuck/wiki/Shell-aliases#bash

command -v thefuck &>/dev/null && {
    eval "$(thefuck --alias)"
}
