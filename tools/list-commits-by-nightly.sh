#!/usr/bin/env zsh
# usage: list-commits-by-nightly.sh <path/to/servo> [path/to/pulls.json]
# requires: zsh, gh, jq, tac, rg, git
set -euo pipefail -o bsdecho -o shwordsplit
if [ $# -lt 1 ]; then >&2 sed '1d;2s/^# //;2q' "$0"; exit 1; fi
missing() { >&2 echo "fatal: $1 not found"; exit 1; }
> /dev/null command -v gh || missing gh
> /dev/null command -v jq || missing jq
> /dev/null command -v tac || missing tac
> /dev/null command -v rg || missing rg
> /dev/null command -v git || missing git
pulls_json_path=${${2-/dev/null}:a}
cd -- "$(dirname -- "${0:a}")"

# Fetch the default branch, so we can warn if commits aren’t reachable from it.
git -C "$1" fetch https://github.com/servo/servo.git
default_branch_head=$(cut -f 1 "$1/.git/FETCH_HEAD")

if ! [ -e runs.json ]; then
  gh api '/repos/servo/servo/actions/workflows/nightly.yml/runs?status=success&per_page=62' > runs.json
fi
< runs.json jq -r '.workflow_runs[] | "\(.head_sha)\t\(.updated_at)"' | tac > runs.tsv
< runs.tsv sed -En '1!{H;x;s/\n//;p;x;};s/\t.*//;s/$/\t/;h' \
| while read -r from to updated; do
  printf '>>> %s\n' "$updated" | rg .  # make it red if stdout is a tty

  # Sometimes we build a nightly from something other than the default branch,
  # so we may not have the commits locally.
  ./fetch-commit-if-needed.sh "$1" $from
  ./fetch-commit-if-needed.sh "$1" $to

  # Warn if we find a nightly that seems to have been built from outside the
  # default branch. That nightly may contain changes that disappear in the next
  # nightly, or depending on how far back it forked, it may be missing changes
  # from previous nightlies.
  if ! git -C "$1" merge-base --is-ancestor $to $default_branch_head; then
    >&2 echo "warning: not reachable from default branch: $to"
  fi

  # Check if `$2` was set, but use `$pulls_json_path` below.
  if [ -n "${2+set}" ]; then
    ./list-commits-between.sh "$1" $from $to "$pulls_json_path"
  else
    ./list-commits-between.sh "$1" $from $to
  fi
done
