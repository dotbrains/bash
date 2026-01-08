#!/bin/bash

# Networking aliases

# Get local IP.
alias lip="ipconfig getifaddr en0"

# Get external IP.
alias xip="curl -s checkip.dyndns.org | grep -Eo \"[0-9\.]+\""

# `wttr` alias
alias wttr="curl wttr.in"
