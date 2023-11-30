#!/usr/bin/env zsh
# usage: list-commits-between.sh <path/to/servo> <from commit exclusive> <to commit inclusive>
# requires: git
set -eu
if [ $# -lt 1 ]; then >&2 sed '1d;2s/^# //;2q' "$0"; exit 1; fi
missing() { >&2 echo "fatal: $1 not found"; exit 1; }
> /dev/null command -v git || missing git
cd -- "$(dirname -- "${0:a}")"

git -C "$1" log --pretty=$'tformat:%H\t%s' "$2".."$3" \
| sed -E 's@([^\t]+)\t(.*[(]#([^)]+)[)].*)@\1\thttps://github.com/servo/servo/pull/\3\t\2@'
