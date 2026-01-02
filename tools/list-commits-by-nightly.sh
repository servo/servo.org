#!/usr/bin/env zsh
# usage: list-commits-by-nightly.sh <path/to/servo> [path/to/pulls.json]
# requires: zsh, gh, jq, tac, rg, git
set -euo pipefail -o bsdecho -o shwordsplit
if [ $# -lt 1 ]; then >&2 sed '1d;2s/^# //;2q' "$0"; exit 1; fi
missing() { >&2 echo "fatal: $1 not found"; exit 1; }
> /dev/null command -v gh || missing gh
> /dev/null command -v jq || missing jq
> /dev/null command -v tac && tac='tac' || tac='tail -r'
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

# Convert `runs.json` to `runs.tsv` with lines `<head commit>\t<timestamp>`.
< runs.json jq -r '.workflow_runs[] | "\(.head_sha)\t\(.updated_at)"' | $tac > runs.tsv

# We exclude `$minus_commit` and its ancestors from the next nightly’s list of
# commits, effectively as the `<from>` in `git log <from>..<to>`. Normally this
# is the head commit of the previous nightly, but there are some exceptions.
#
# If the previous nightly has commits that are not on the default branch (let’s
# call them “bespoke commits”), then let’s assume that it’s at least a fork of
# the default branch (the algorithm works fine either way). Often the head of
# such a nightly is still perfectly usable as `<from>`, because it forked from
# the head commit of the nightly before that. For example, `git log f..i` below
# is `i` minus `f`, which still yields `g`, `h`, `i`:
#
#     --a-b-c  < nightly before that (normal)
#            \-d-e-f  < previous nightly (has bespoke commits)
#             \------g-h-i  < next nightly
#
# But if the head of such a nightly forked from some earlier commit than the
# head of the nightly before that, it’s no longer usable as `<from>`. For
# example, `git log f..i` below is again `i` minus `f`, but that now yields
# `b` (duplicate), `c` (duplicate), `g`, `h`, `i`:
#
#     --a-b-c  < nightly before that (normal)
#        \   \----g-h-i  < next nightly
#         \-d-e-f  < previous nightly (has bespoke commits)
#
# To avoid this problem, `<from>` should actually be the head of the most recent
# previous nightly that did *not* have bespoke commits. The initial value is the
# head of the first nightly in the input that did not have bespoke commits, so
# everything up to and including that nightly will be skipped. For example:
#
#     --a-b-c  < nightly before that (normal)
#        \   \   • skipped for `git log`
#         \   \  • then set `minus_commit=c`
#          \   \
#           \   \------g-h-i  < next nightly
#            \                  • `git log c..i` = `g`, `h`, `i`
#             \
#              \-d-e-f  < previous nightly (has bespoke commits)
#                          • `git log c..f` = `d`, `e`, `f`
#                          • then leave `minus_commit` unchanged
unset minus_commit
< runs.tsv while read -r commit updated; do
  printf '>>> %s\n' "$updated" | rg .  # make it red if stdout is a tty

  # Sometimes we build a nightly from something other than the default branch,
  # so we may not have the commits locally.
  ./fetch-commit-if-needed.sh "$1" $commit

  # Check if the head of this nightly has bespoke commits.
  git -C "$1" merge-base --is-ancestor $commit $default_branch_head \
  && has_bespoke_commits=false \
  || has_bespoke_commits=true

  # Warn if the head of this nightly has bespoke commits. Such a nightly may
  # contain changes that disappear in the next nightly, or depending on how far
  # back it forked, it may be missing changes from previous nightlies.
  if [ $has_bespoke_commits = true ]; then
    >&2 echo "warning: not reachable from default branch: $commit"
  fi

  # If `$minus_commit` is not yet set, we don’t know enough to list the commits
  # in this nightly, so just skip it and move on.
  if [ "${minus_commit+set}" = set ]; then
    # Check if `$2` was set, but use `$pulls_json_path` below.
    if [ -n "${2+set}" ]; then
      ./list-commits-between.sh "$1" $minus_commit $commit "$pulls_json_path"
    else
      ./list-commits-between.sh "$1" $minus_commit $commit
    fi
  fi

  # If the head of this nightly does not have bespoke commits, we can use it
  # as the next value of `$minus_commit`.
  if [ $has_bespoke_commits = false ]; then
    minus_commit=$commit
  fi
done
