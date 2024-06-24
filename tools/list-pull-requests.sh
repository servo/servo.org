#!/usr/bin/env zsh
# usage: list-pull-requests.sh <org/repo> <merged from date> <merged to date> | jq -s > pulls.json
# requires: zsh, gh, jq, rg
set -euo pipefail
if [ $# -lt 2 ]; then >&2 sed '1d;2s/^# //;2q' "$0"; exit 1; fi
missing() { >&2 echo "fatal: $1 not found"; exit 1; }
> /dev/null command -v gh || missing gh
> /dev/null command -v jq || missing jq
> /dev/null command -v rg || missing rg
cd -- "$(dirname -- "${0:a}")"
org_repo_slug=$1; shift
from_date=$1; shift
to_date=$1; shift

case "${from_date%Z}" in
(*-*-*T*:*:*) from_date=${from_date%Z}Z ;;
(*-*-*T*:*) from_date=${from_date%Z}:00Z ;;
(*-*-*T*) from_date=${from_date%Z}:00:00Z ;;
(*-*-*) from_date=${from_date%Z}T00:00:00Z ;;
(*-*) from_date=${from_date%Z}-01T00:00:00Z ;;
(*) from_date=${from_date%Z}-01-01T00:00:00Z ;;
esac

case "${to_date%Z}" in
(*-*-*T*:*:*) to_date=${to_date%Z}Z ;;
(*-*-*T*:*) to_date=${to_date%Z}:60Z ;;
(*-*-*T*) to_date=${to_date%Z}:59:60Z ;;
(*-*-*) to_date=${to_date%Z}T23:59:60Z ;;
(*-*) to_date=${to_date%Z}-31T23:59:60Z ;;
(*) to_date=${to_date%Z}-12-31T23:59:60Z ;;
esac

i=1; while :; do
  >&2 echo page $i

  # We want to request
  #  (a) only merged pull requests
  #  (b) whose .merged_at was between some range of dates
  #  (c) in .merged_at order
  # but the github api only allows us to request
  #  (a) closed pull requests
  #  (b) with any date
  #  (c) in .updated_at order >:(
  gh api '/repos/'"$org_repo_slug"'/pulls?state=closed&sort=updated&direction=desc&per_page=100&page='$i > out.json

  # Filter the results by the given .merged_at range.
  #
  # Note that in both jq scripts, we compare date strings lexicographically,
  # which is safe for RFC 3339 timestamps. Converting them to instants with
  # `fromdateiso8601` means the $from_date and $to_date expansion code above
  # would need to know which years are leap years or have leap seconds.
  jq -r --arg from_date "$from_date" --arg to_date "$to_date" \
    '.[] | select($from_date <= .merged_at and .merged_at <= $to_date)' out.json

  # If .updated_at was always equal to .merged_at, then the results would indeed
  # be in .merged_at order, but .updated_at can be greater than .merged_at if it
  # gets bumped by comments or branch deletions, sometimes *years* later. As a
  # result, it’s hard to know whether we’ve requested enough pages from the api.
  #
  # For example, say we take a .merged_at regex and give up after seeing a whole
  # page of results whose .merged_at is outside our date range, as long as we’ve
  # already seen some results. If *any* of those results get bumped far enough
  # out of our date range, we’ll split the results and give up too early. And if
  # someone bumps a large enough number of older results *into* our date range,
  # we’ll split the results into chunks and give up too early.
  #
  # But since .updated_at can never be less than .merged_at, it’s safe to give
  # up as soon as we see results whose .updated_at is less than some start date.
  # Any earlier and we might give up too early.
  if [ "$(jq -r --arg from_date "$from_date" 'map(select(.updated_at < $from_date)) | length' out.json)" -gt 0 ]; then
    >&2 echo done
    break
  fi

  i=$((i+1))
done
