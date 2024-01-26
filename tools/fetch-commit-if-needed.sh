#!/usr/bin/env zsh
# usage: fetch-commit-if-needed.sh <path/to/servo> <commit>
# requires: git
set -eu
if [ $# -lt 1 ]; then >&2 sed '1d;2s/^# //;2q' "$0"; exit 1; fi
missing() { >&2 echo "fatal: $1 not found"; exit 1; }
> /dev/null command -v git || missing git
cd -- "$(dirname -- "${0:a}")"

# If we don’t have the commit locally, fetch it and all of its ancestors.
# Based on <https://stackoverflow.com/a/30701724> minus --depth=1, because we
# want the ancestors too.
if ! git -C "$1" cat-file commit "$2" > /dev/null 2>&1; then
    git -C "$1" fetch https://github.com/servo/servo.git "$2"
fi
