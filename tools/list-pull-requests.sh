#!/usr/bin/env zsh
# usage: list-pull-requests.sh <org/repo> <merged date regex> | jq -s > pulls.json
# requires: zsh, gh, jq, rg
set -euo pipefail
if [ $# -lt 2 ]; then >&2 sed '1d;2s/^# //;2q' "$0"; exit 1; fi
missing() { >&2 echo "fatal: $1 not found"; exit 1; }
> /dev/null command -v gh || missing gh
> /dev/null command -v jq || missing jq
> /dev/null command -v rg || missing rg
cd -- "$(dirname -- "${0:a}")"
org_repo_slug=$1; shift
merged_date_regex=$1; shift

found_any=0
i=1; while :; do
  >&2 echo page $i

  # We want to filter by merged and sort by the merged date, but the github
  # api only supports filtering by closed and sorting by updated >:(
  gh api '/repos/'"$org_repo_slug"'/pulls?state=closed&sort=updated&direction=desc&per_page=100&page='$i > out.json

  # If we see a whole page of results that fail the merged date regex, stop to
  # save time, despite the small chance of accidentally stopping early.
  if ! jq -r '.[] | .merged_at | select(. != null)' out.json | rg -q '^'"$merged_date_regex"'$'; then
    if [ $found_any -eq 1 ]; then
      >&2 echo done
      break
    else
      >&2 echo no results on this page
    fi
  else
    found_any=1

    # Filter the results by the merged date regex, this time using jq.
    jq '.[] | select(.merged_at != null) | select(.merged_at | test("^'"$merged_date_regex"'$"))' out.json
  fi

  i=$((i+1))
done
