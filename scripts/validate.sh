#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$repo_root"

find . -type f \( -name '*.sh' -o -name '*.bash' \) -not -path '*/.git/*' -print0 |
    xargs -0 -r bash -n
printf "OK bash syntax\\n"
