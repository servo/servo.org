#!/usr/bin/env zsh
# usage: list-commits-by-nightly.sh --pull-numbers-only | filter-has-monthly-update-label.sh <path/to/pulls.json>
# requires: zsh, gh, jq
set -euo pipefail -o bsdecho -o shwordsplit
if [ $# -lt 1 ]; then >&2 sed '1d;2s/^# //;2q' "$0"; exit 1; fi
missing() { >&2 echo "fatal: $1 not found"; exit 1; }
> /dev/null command -v gh || missing gh
> /dev/null command -v jq || missing jq
# parses the given pulls.json only once (it can be expensive!)
jq -r --slurpfile pulls "$1" '. as $number | $pulls[] | select(.number == $number) | select(IN("monthly update"; .labels[].name)) | "\(.number)\t\(.comments_url)"'
