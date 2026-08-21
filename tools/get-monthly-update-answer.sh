#!/usr/bin/env zsh
# usage: get-monthly-update-answer.sh <https://api.github.com/repos/servo/servo/issues/.../comments>
#    or: get-monthly-update-answer.sh <issue number>
# requires: zsh, gh, jq
set -euo pipefail -o bsdecho -o shwordsplit
if [ $# -lt 1 ]; then >&2 sed '1d;s/^# //;3q' "$0"; exit 1; fi
missing() { >&2 echo "fatal: $1 not found"; exit 1; }
> /dev/null command -v gh || missing gh
> /dev/null command -v jq || missing jq
case "$1" in
(https://*)
  comments_url=$1
  ;;
([0-9]*)
  comments_url=https://api.github.com/repos/servo/servo/issues/$1/comments
  ;;
(*)
  >&2 echo "fatal: not a URL or a pull request number"
  exit 1
  ;;
esac
gh api --paginate "$comments_url" | jq -er '.[] | select(.user.login != "servo-highfive") | select(.body | contains("@servo-highfive monthly update answer")) | .body'
