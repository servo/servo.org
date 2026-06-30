#!/usr/bin/env zsh
# usage: git-log-authors.sh <path/to/servo> <tip commit>
# requires: git
set -euo pipefail -o bsdecho -o shwordsplit
if [ $# -lt 2 ]; then >&2 sed '1d;2s/^# //;2q' "$0"; exit 1; fi
missing() { >&2 echo "fatal: $1 not found"; exit 1; }
> /dev/null command -v git || missing git
> /dev/null command -v rg || missing rg
servo_repo_path=$1; shift
tip_commit=$1; shift

IFS=$'\t'
git -C "$servo_repo_path" log --format=$'%H\t%at\t%aI\t%aN\t%(trailers:key=co-authored-by,valueonly,separator=%x09)' "$tip_commit" \
| while read -r hash unix iso author rest; do
    set -- $rest
    printf '%s\t%s\t%s\t%s' "$hash" "$unix" "$iso" "$author"
    for coauthor in "$@"; do
        printf '\t%s' "$(git -C "$servo_repo_path" check-mailmap -- "$coauthor" | rg -o '^@[^ ]+')"
    done
    printf \\n
done
