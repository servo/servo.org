# Servo.org website

1. `npm install`
2. `npm run start`

## How to list commits that landed in each nightly

Note that the list of nightly builds is cached in tools/runs.json, so if it exists, you will need to delete it to fetch an updated list.

Make sure your Servo checkout is on the main branch, and that the branch is up to date. Then run the script below, passing it the path to your checkout:

```sh
$ tools/list-commits-by-nightly.sh /path/to/servo
```

## How to list this year’s pull request contributors

```sh
$ > 2023.json tools/list-pull-requests.sh servo/servo '2023-.*'
$ < 2023.json jq -r .user.login | sort | uniq -c | sort -nr
```
