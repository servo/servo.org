#!/usr/bin/env zsh
# usage: generate-outline.sh <path/to/output/of/list-commits-by-nightly.txt>
# requires: zsh, rg
set -euo pipefail -o bsdecho -o shwordsplit
if [ $# -lt 1 ]; then >&2 sed '1d;2s/^# //;2q' "$0"; exit 1; fi
missing() { >&2 echo "fatal: $1 not found"; exit 1; }
> /dev/null command -v rg || missing rg
post_path=${1:a}
cd -- "$(dirname -- "${0:a}")"

# Find all of the tags used when we marked a commit as interesting.
tags=$(< "$post_path" rg -v '^    # ' | rg --pcre2 -o '(?<=^    )([^;]+)' | tr ' ' \\n | sort -u)
# For each tag...
for tag in $tags; do
  printf '- %s\n' "$tag"
  # ...find all of the commits that we marked with that tag. Each commit consists of two lines.
  # The first line of the input is of the form `+https://url\t(@author, #123)\tPull request title`.
  # The second line of the input is of the form `    one or more tags` or `    tags; notes`.
  # Tags must not contain spaces or PCRE regex metacharacters.
  < "$post_path" rg -v '^    # ' \
  | rg --pcre2 -B1 --no-context-separator '(?<=^    )(([^;]+ )?'"$tag"'( [^;]+)?)(;|$)' \
  | while read -r list_commits_by_nightly_line; do
    read -r tags_and_notes_line
    printf '    - %s\n      %s\n' "${list_commits_by_nightly_line#+}" "${tags_and_notes_line#    }"
  done
done
