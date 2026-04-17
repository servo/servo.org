#!/usr/bin/env zsh
# usage: list-commits-between.sh <path/to/servo> <from commit exclusive> <to commit inclusive> [--pulls-json-path=path/to/pulls.json] [--git-show-output-cache-path=path/to/cache]
# requires: git
set -euo pipefail -o bsdecho -o shwordsplit
if [ $# -lt 1 ]; then >&2 sed '1d;2s/^# //;2q' "$0"; exit 1; fi
missing() { >&2 echo "fatal: $1 not found"; exit 1; }
> /dev/null command -v git || missing git
servo_repo_path=$1; shift
from_commit_exclusive=$1; shift
to_commit_inclusive=$1; shift
while [ $# -gt 0 ]; do
  case "$1" in
  (--pulls-json-path=*)
    pulls_json_path=${${1#--pulls-json-path=}:a}
    shift
    ;;
  (--git-show-output-cache-path=*)
    git_show_output_cache_path=${${1#--git-show-output-cache-path=}:a}
    shift
    ;;
  (*)
    >&2 echo "fatal: unknown option: $1"
    exit 1
    ;;
  esac
done
cd -- "$(dirname -- "${0:a}")"

# Given a commit x, if git says x is grafted, then git log w..x will only log x
# and git log x..y will log the entire history of the repo. This can happen if
# x is missing its parents due to a shallow fetch (--depth=1), in which case you
# should fetch it again with --unshallow. Or something weirder may be happening.
if [ "$(git -C "$servo_repo_path" log --pretty=\%D -n 1 "$to_commit_inclusive")" = grafted ]; then
    >&2 echo "fatal: commit is grafted: $to_commit_inclusive"
    exit 1
fi

IFS=$'\t'
git -C "$servo_repo_path" log --reverse --pretty=$'tformat:%H\t%s\t%aE\t%(trailers:key=co-authored-by,valueonly,separator=%x09)' "$from_commit_exclusive".."$to_commit_inclusive" \
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

    # Hopefully helpful hints about the contents of the patch.
    printf '    ^ commit %s\n' "$hash"
    if git -C "$servo_repo_path" show --pretty= --name-only "$hash" | egrep -q '^components/servo/'; then
        printf '    ^ /!\ %s\n' 'contains libservo changes! does it affect the embedder?'
    fi
    if git -C "$servo_repo_path" show --pretty= --name-only "$hash" | egrep -q '^ports/servoshell/'; then
        printf '    ^ /!\ %s\n' 'contains servoshell changes! does it affect the user experience?'
    fi
    if git -C "$servo_repo_path" show --pretty= --name-only "$hash" | egrep -q '^tests/wpt/meta/'; then
        printf '    ^ /!\ %s\n' 'contains changes to WPT expectations! it probably affects the web platform'
    fi
    if git -C "$servo_repo_path" show --pretty= --name-only "$hash" | egrep -q '[.]webidl$'; then
        printf '    ^ /!\ %s\n' 'contains WebIDL changes! did we ship a new API?'
    fi
    if git -C "$servo_repo_path" show --pretty= --name-only "$hash" | egrep -q '^ports/servoshell/prefs[.]rs$'; then
        printf '    ^ /!\ %s\n' 'may contain changes to EXPERIMENTAL_PREFS'
    fi
    if git -C "$servo_repo_path" show --pretty= --name-only "$hash" | egrep -q '^components/config/prefs[.]rs$'; then
        printf '    ^ /!\ %s\n' 'may contain changes to feature flags'
    fi

    # If given a `--git-show-output-cache-path=`, cache the output of `git show`.
    if [ -n "${git_show_output_cache_path+set}" ]; then
        # show with stat (lines changed), summary (files created and deleted), and patch.
        # enable color in the output, even though stdout is not a tty.
        git -C "$servo_repo_path" show --color=always --stat --summary -p "$hash" > "$git_show_output_cache_path/$hash"
    fi

    if [ -n "${pulls_json_path+set}" ]; then
        # Get the PR description, strip carriage returns and HTML markup, word wrap to 120 without joining existing
        # lines, character wrap to 120, stop before any `---` line, delete empty lines, indent it with four spaces,
        # then print the result.
        jq -er --argjson number $pull_number 'select(.number == $number) | .body' "$pulls_json_path" \
        | tr -d \\r | sed -En 's/^/    # /;p' \
        || : # printf '    %s\n' '[Pull request description not found]'
    else
        # Print the commit message body, with a hard wrap and an indent.
        # This doesn’t work too well, because our repo is configured to concatenate the PR commit
        # messages, which often contain a subject only, rather than using the PR description.
        git -C "$servo_repo_path" log -n 1 --pretty=$'tformat:%w(120,4,4)%b' "$hash" | sed -E '/^ *$/d;/^    Signed-off-by: /d'
    fi
done
