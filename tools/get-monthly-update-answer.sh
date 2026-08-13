#!/usr/bin/env zsh
# usage: get-monthly-update-answer.sh <https://api.github.com/repos/servo/servo/issues/.../comments>
# requires: zsh, gh, jq
set -euo pipefail -o bsdecho -o shwordsplit
if [ $# -lt 1 ]; then >&2 sed '1d;2s/^# //;2q' "$0"; exit 1; fi
missing() { >&2 echo "fatal: $1 not found"; exit 1; }
> /dev/null command -v gh || missing gh
> /dev/null command -v jq || missing jq
gh api --paginate "$1" | jq -er '.[] | select(.user.login != "servo-highfive") | select(.body | contains("@servo-highfive monthly update answer")) | .body'
