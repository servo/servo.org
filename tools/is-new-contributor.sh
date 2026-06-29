#!/usr/bin/env zsh
# usage: is-new-contributor.sh <path/to/servo> <path/to/git-log-authors.txt> <@author> <cutoff commit>
# requires: git
set -euo pipefail -o bsdecho -o shwordsplit
if [ $# -lt 4 ]; then >&2 sed '1d;2s/^# //;2q' "$0"; exit 1; fi
missing() { >&2 echo "fatal: $1 not found"; exit 1; }
> /dev/null command -v git || missing git
> /dev/null command -v rg || missing rg
servo_repo_path=$1; shift
git_log_authors_path=$1; shift
author_to_find=$1; shift
cutoff_commit=$1; shift

printf '>>> %s\n' "$author_to_find"

if ! < "$git_log_authors_path" rg '\t'"$author_to_find"'(\t|$)' \
    | tail -1 \
    | read -r hash rest; then
    >&2 echo 'error: author not found in git-log-authors.txt'
    exit 1
fi

printf '%s\t%s\n' "$hash" "$rest"

# equivalent to `git merge-base --is-ancestor "$(git merge-base "$cutoff_commit" origin/main)" "$hash"`
if git -C "$servo_repo_path" log -n 1 "$cutoff_commit".."$hash" | fgrep -q ''; then
    echo 'first-time author!'
else
    echo 'not a first-time author'
fi

# print the author’s “github display name (@githubHandle)”
git -C "$servo_repo_path" log -n 1 "$cutoff_commit".."$hash" --no-mailmap --format='%an (%aN)'
# print the usual git-log(1) output, header only, using the author’s github display name
git -C "$servo_repo_path" log -n 1 "$cutoff_commit".."$hash" --no-mailmap --format=short
# print the usual git-log(1) output, in full, using the author’s @githubHandle
git -C "$servo_repo_path" log -n 1 "$cutoff_commit".."$hash"
