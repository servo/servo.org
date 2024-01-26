#!/usr/bin/env zsh
# usage: list-commits-between.sh <path/to/servo> <from commit exclusive> <to commit inclusive>
# requires: git
set -eu
if [ $# -lt 1 ]; then >&2 sed '1d;2s/^# //;2q' "$0"; exit 1; fi
missing() { >&2 echo "fatal: $1 not found"; exit 1; }
> /dev/null command -v git || missing git
cd -- "$(dirname -- "${0:a}")"

# Given a commit x, if git says x is grafted, then git log w..x will only log x
# and git log x..y will log the entire history of the repo. This can happen if
# x is missing its parents due to a shallow fetch (--depth=1), in which case you
# should fetch it again with --unshallow. Or something weirder may be happening.
if [ "$(git -C "$1" log --pretty=\%D -n 1 "$3")" = grafted ]; then
    >&2 echo "fatal: commit is grafted: $3"
    exit 1
fi

git -C "$1" log --pretty=$'tformat:%H\t%s' "$2".."$3" \
| sed -E 's@([^\t]+)\t(.*[(]#([^)]+)[)].*)@\1\thttps://github.com/servo/servo/pull/\3\t\2@'
