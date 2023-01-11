# Servo Blog

This is code for the Servo blog: https://servo.org/blog/

# Contributing

To add a blog post, write it in a markdown file at `_posts/YYYY-MM-DD-title.md`
and submit a pull request to this repository.

# Writing This Week in Servo

First, copy one of the other instances of the TWiS posts, changing the filename and two
places within the file to have the date for the Monday.

To get the list of PRs merged across all Servo organization repos in the last week, do the following query, using
the Monday of last week to the Sunday of this week (performed on Monday):
```
  https://github.com/pulls?page=1&q=is%3Apr+is%3Amerged+closed%3A2015-09-27..2015-10-05+user%3Aservo
```

New contributors can be retrieved by updating your Servo repo, checking out a hash for first thing
Monday morning, and then running a script similar to the following:

```
#!/bin/sh

INITIAL_COMMIT=ce30d45
START_COMMIT=`git log --before="last week" --pretty=format:%H|head -n1`
ALL_NAMES=`git log $INITIAL_COMMIT.. --pretty=format:%an|sort|uniq`
OLD_NAMES=`git log $INITIAL_COMMIT..$START_COMMIT --pretty=format:%an|sort|uniq`
echo "$OLD_NAMES">names_old.txt
echo "$ALL_NAMES">names_all.txt
diff names_old.txt names_all.txt
rm names_old.txt names_all.txt
```

Note that sometimes the names that come out will be unique due to somebody changing their
git client username or similar.
