#!/bin/bash

# Codex CLI aliases
# see: https://developers.openai.com/codex

command -v "codex" &>/dev/null && {
    alias cx='codex --full-auto'
    alias cxd='codex --dangerously-bypass-approvals-and-sandbox'
}
