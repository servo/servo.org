#!/usr/bin/env zsh
# usage: list-commits-between.sh <path/to/servo> <from commit exclusive> <to commit inclusive>
# requires: git
set -euo pipefail -o bsdecho -o shwordsplit
if [ $# -lt 1 ]; then >&2 sed '1d;2s/^# //;2q' "$0"; exit 1; fi
missing() { >&2 echo "fatal: $1 not found"; exit 1; }
> /dev/null command -v git || missing git
cd -- "$(dirname -- "${0:a}")"

# Given a commit x, if git says x is grafted, then git log w..x will only log x
# and git log x..y will log the entire history of the repo. This can happen if
# x is missing its parents due to a shallow fetch (--depth=1), in which case you
# should fetch it again with --unshallow. Or something weirder may be happening.
if [ "$(git -C "$1" log --pretty=\%D -n 1 "$3")" = grafted ]; then
    >&2 echo "fatal: commit is grafted: $3"
    exit 1
fi

IFS=$'\t'
git -C "$1" log --pretty=$'tformat:%H\t%s\t%aE\t%(trailers:key=co-authored-by,valueonly,separator=%x09)' "$2".."$3" \
| while read -r hash subject author coauthors; do
    pull_number=$(printf \%s\\n "$subject" | sed -E 's@.*[(]#([^)]+)[)].*@\1@')
    url=https://github.com/servo/servo/pull/$pull_number
    printf '%s\t(' "$url"
    for author in $author $coauthors; do
        # Convert “display name <email@address>” to “email@address”
        author=$(printf \%s\\n "$author" | sed -E 's/.*<(.*)>.*/\1/')
        # Convert “(n+)?handle@users.noreply.github.com” to “handle”
        author=$(printf \%s\\n "$author" | sed -E 's/^(.*[+])?([^@]+)@users[.]noreply[.]github[.]com$/\2/')
        # Look up any remaining “email@address” in authors.tsv
        if fgrep -q $'\t'"$author" authors.tsv; then
            author=$(fgrep $'\t'"$author" authors.tsv | cut -f 1)
        fi
        printf '@%s, ' "$author"
    done
    printf '#%s)\t%s\n' "$pull_number" "$subject"
done
