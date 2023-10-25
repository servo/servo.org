# Servo.org website

1. `npm install`
2. `npm run start`

## How to list commits that landed in each nightly

Note that the list of nightly builds is cached in tools/runs.json, so if it exists, you will need to delete it to fetch an updated list.

```sh
$ tools/list-commits-by-nightly.sh /path/to/servo
```
