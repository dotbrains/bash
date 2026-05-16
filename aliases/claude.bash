#!/bin/bash

# Claude Code aliases
# see: https://docs.anthropic.com/en/docs/claude-code

command -v "claude" &>/dev/null && {
    alias cl='claude --dangerously-skip-permissions'
}
