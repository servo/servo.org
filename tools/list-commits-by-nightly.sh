#!/usr/bin/env zsh
# usage: list-commits-by-nightly.sh <path/to/servo>
# requires: zsh, gh, jq, tac, rg, git
set -eu
if [ $# -lt 1 ]; then >&2 sed '1d;2s/^# //;2q' "$0"; exit 1; fi
missing() { >&2 echo "fatal: $1 not found"; exit 1; }
> /dev/null command -v gh || missing gh
> /dev/null command -v jq || missing jq
> /dev/null command -v tac || missing tac
> /dev/null command -v rg || missing rg
> /dev/null command -v git || missing git
cd -- "$(dirname -- "${0:a}")"

if ! [ -e runs.json ]; then
  gh api '/repos/servo/servo/actions/workflows/nightly.yml/runs?status=success&per_page=100' > runs.json
fi
< runs.json jq -r '.workflow_runs[] | "\(.head_sha)\t\(.updated_at)"' | tac > runs.tsv
< runs.tsv sed -En '1!{H;x;s/\n//;p;x;};s/\t.*//;s/$/\t/;h' \
| while read -r from to updated; do
  printf '>>> %s\n' "$updated" | rg --color=always .  # make it red
  ./list-commits-between.sh "$1" $from $to
done
