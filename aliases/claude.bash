#!/bin/bash

# Claude Code aliases
# see: https://docs.anthropic.com/en/docs/claude-code

command -v "claude" &>/dev/null && {
    alias claude='claude --model opus --dangerously-skip-permissions'
}
