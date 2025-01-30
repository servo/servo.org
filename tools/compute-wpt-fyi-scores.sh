#!/usr/bin/env zsh
# usage: get-wpt-subtest-score.sh <product> <iso 8601 date> [prefix]
# requires: curl jq
set -euo pipefail -o bsdecho -o shwordsplit
if [ "$#" -lt 1 ]; then >&2 sed '1d;2s/^# //;2q' "$0"; exit 1; fi
missing() { >&2 echo "fatal: $1 not found"; exit 1; }
> /dev/null command -v curl || missing curl
> /dev/null command -v jq || missing jq
cd -- "$(dirname -- "${0:a}")"
product=$1
date=$2
prefix=${3-/}

cached_curl() {
    if [ -e "$1" ]; then return; fi
    curl -fsSo ".cached_curl.$1" -- "$2"
    mv ".cached_curl.$1" "$1"
}

runs_url='https://wpt.fyi/api/runs?product='"$product"'&to='"$date"
runs_file=runs-$product-to-$date.json
cached_curl "$runs_file" "$runs_url"
results_url=$(jq -er '.[0].results_url' "$runs_file")
results_file=${results_url##*/}
cached_curl "$results_file" "$results_url"

# For tests with non-zero `.c`, the passing and total subtest counts are the sum of `.c.[0]` over the sum of `.c.[1]`,
# while for each test with zero `.c`, the passing count is 1 if the status is good (O/P), and the total count is 1.
# This seems to be the same algorithm that wpt.fyi uses for “Subtest Total”.
passing_subtests=$(jq -er --arg prefix "$prefix" 'with_entries(select(.key | startswith($prefix))) | (map(.c.[0]) | add) + (map(select(.c==[0,0] and (.s | inside("OP")))) | length)' "$results_file")
total_subtests=$(jq -er --arg prefix "$prefix" 'with_entries(select(.key | startswith($prefix))) | (map(.c.[1]) | add) + (map(select(.c==[0,0])) | length)' "$results_file")
passing_tests=$(jq -er --arg prefix "$prefix" 'with_entries(select(.key | startswith($prefix))) | (map(select(.c!=[0,0]) | .c.[0] / .c.[1]) | add) + (map(select(.c==[0,0] and (.s | inside("OP")))) | length)' "$results_file")
total_tests=$(jq -er --arg prefix "$prefix" 'with_entries(select(.key | startswith($prefix))) | length' "$results_file")
printf '%s,%s,%s,%s,%s\n' "$date" "$passing_subtests" "$total_subtests" "$passing_tests" "$total_tests"
