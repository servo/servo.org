#!/usr/bin/env python3
# usage: generate-changelog.py <path/to/commits.txt>
# requires: python3

import re
import sys

# (tag, section title), in order of priority and of appearance in the output.
SECTIONS = [
    ("web", "Highlights"),
    ("api", "Embedding API"),
    ("dom", "Web platform (DOM)"),
    ("layout", "Web platform (layout)"),
    ("perf", "Performance"),
    ("crash", "Stability"),
    ("devtools", "DevTools"),
    ("servoshell", "servoshell"),
    ("wip", "Work in progress"),
]
OTHER = "Other changes"


# Reads commits.txt and returns the accepted (`+`) and done (`.`) commits.
#
# Each commit takes two lines in commits.txt:
#   +https://github.com/servo/servo/pull/48474<TAB>(@Loirooriol, #48474)<TAB>stylo: Enable … (#48474)
#       layout; progress() enabled by default
def readFile(path):
    lines = open(path, encoding="utf-8").read().splitlines()
    commits = []
    for i, line in enumerate(lines):
        if not (line.startswith("+https://") or line.startswith(".https://")):
            continue

        # Drop the leading `+` or `.`, then split the three tab-separated fields.
        fields = line[1:].split("\t")
        url = fields[0]
        author_info = fields[1]
        title = fields[2]

        # "(@mrobinson, @Loirooriol, #48564)": authors and pull request number.
        parts = author_info.strip("()").split(", ")
        number = parts[-1]
        authors = parts[:-1]

        # The label is the next line.
        label = ""
        if i + 1 < len(lines):
            next_line = lines[i + 1]
            if next_line.startswith("    ") and not next_line.startswith(("    ^", "    #")):
                label = next_line[4:]

        # "layout perf; some notes": tags "layout perf" and note "some notes".
        if ";" in label:
            tags, note = label.split(";", 1)
        else:
            tags, note = label, ""

        note = clean_note(note)
        if note == "":
            note = title

        commits.append({
            "url": url,
            "number": number,
            "authors": authors,
            "tags": tags.split(),
            "note": note,
        })
    return commits


# Removes "by/from @someone", since the changelog already credits the authors.
def clean_note(note):
    return re.sub(r"\s*\b(by|from) @[0-9A-Za-z_.-]+", "", note).strip()


def section_for(tags):
    for tag, title in SECTIONS:
        if tag in tags:
            return title
    return OTHER


# Joins commits with the same label (tags and note) into a single entry.
def group(commits):
    entries = []
    for commit in commits:
        entry = None
        for existing in entries:
            if existing["tags"] == commit["tags"] and existing["note"] == commit["note"]:
                entry = existing
        if entry is None:
            entry = {"tags": commit["tags"], "note": commit["note"], "authors": [], "pulls": []}
            entries.append(entry)

        for author in commit["authors"]:
            if author not in entry["authors"]:
                entry["authors"].append(author)
        entry["pulls"].append((commit["number"], commit["url"]))
    return entries


def print_changelog(entries):
    # Section titles in SECTIONS order, without duplicates, then OTHER.
    titles = []
    for tag, title in SECTIONS:
        if title not in titles:
            titles.append(title)
    titles.append(OTHER)

    print("# Changelog")
    print()
    for title in titles:
        section = []
        for entry in entries:
            if section_for(entry["tags"]) == title:
                section.append(entry)
        if len(section) == 0:
            continue

        # Bigger groups of work first.
        section.sort(key=lambda entry: len(entry["pulls"]), reverse=True)

        print(f"## {title}")
        print()
        for entry in section:
            credits = []
            for author in entry["authors"]:
                credits.append(f"[{author}](https://github.com/{author[1:]})")
            for number, url in entry["pulls"]:
                credits.append(f"[{number}]({url})")
            print(f"- {entry['note']} ({', '.join(credits)})")
        print()


if len(sys.argv) != 2:
    sys.exit("usage: generate-changelog.py <path/to/commits.txt>")
print_changelog(group(readFile(sys.argv[1])))
