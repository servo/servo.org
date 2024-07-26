# Servo.org website

1. `npm install`
2. `npm run start`

## How to list commits that landed in each nightly

Note that the list of nightly builds is cached in tools/runs.json, so if it exists, you will need to delete it to fetch an updated list.

Make sure your Servo checkout is on the main branch, and that the branch is up to date. Then run the script below, passing it the path to your checkout:

```sh
$ rm tools/runs.json  # Optional: clear CI history cache
$ tools/list-commits-by-nightly.sh /path/to/servo
```

## How to list this year’s pull request contributors

```sh
$ > 2023.json tools/list-pull-requests.sh servo/servo 2023 2023
$ < 2023.json jq -r .user.login | sort | uniq -c | sort -nr
```

Or for some other range of dates:

```sh
$ > pull-requests.json tools/list-pull-requests.sh servo/servo 2023-03-16 2024-03-16
```

## How to analyse WPT pass rate improvements

1. Go to <https://wpt.servo.org/> and open devtools
2. `fromDate = "2024-01-25"`
3. `toDate = "2024-02-26"`
4. Run the code below

```js
((data, ...dates) => {
    const stride = data.area_keys.length;
    const rows = dates.map(expectedDate => data.scores.find(([date]) => date == expectedDate));
    rows.forEach((row, i) => {
        if (row == null) throw `no results for ${dates[i]}!`;
        if (row.length != 3 + stride + 2 + stride) throw "schema change? bad length";
        if (row[0] != dates[i]) throw "unreachable! incorrect date in [0]";
        if (!/^[0-9a-f]{9}$/.test(row[1])) throw "schema change? expected commit hash in [1]";
        if (!/^0[.]0[.]1-[0-9a-f]{7}$/.test(row[2])) throw "schema change? expected version in [2]";
        if (!/^[0-9a-f]{9}$/.test(row[3+stride])) throw "schema change? expected commit hash in [3+stride]";
        if (!/^0[.]0[.]1-[0-9a-f]{7}$/.test(row[4+stride])) throw "schema change? expected version in [4+stride]";
    });
    const areas = data.area_keys.map((key, i) => ({key, results: rows.map((row, j) => ({
        date: dates[j],
        legacy: row[3+i],
        servo: row[5+stride+i],
    }))}));
    console.log(">>> areas", areas);
    const analysis = areas
        .map(({key, results: [p, q]}) => ({
            key,
            regressionWas: p.legacy - p.servo,
            regressionNow: q.legacy - q.servo,
            legacyWas: p.legacy,
            legacyNow: q.legacy,
            servoWas: p.servo,
            servoNow: q.servo,
        }))
        .map(({key, regressionWas, regressionNow, legacyWas, legacyNow, servoWas, servoNow}) => ({
            key, regressionWas, regressionNow, legacyWas, legacyNow, servoWas, servoNow,
            legacyDelta: delta(legacyWas, legacyNow),
            servoDelta: delta(servoWas, servoNow),
            regressionDelta: delta(regressionWas, regressionNow),
        }));
    console.log(">>> analysis", analysis);
    const deltaAnalysisText = analysis
        .sort((p,q) => q.servoDelta.pp - p.servoDelta.pp)
        .map(({key, servoDelta, servoNow}) => `${key} (${servoDelta.pp.toFixed(1)}pp to ${(servoNow/10).toFixed(1)}%)\n`);
    console.log(`>>> top deltas (servo, pp):\n${deltaAnalysisText.join("")}`);
    const regressionAnalysisText = analysis
        .filter(({regressionWas}) => regressionWas >= 0)
        .sort((p,q) => p.regressionDelta.percent - q.regressionDelta.percent)
        .map(({key, regressionDelta, regressionWas, regressionNow}) => `${key} (${regressionDelta.percent.toFixed(1)}% from ${(regressionWas/10).toFixed(1)}pp to ${(regressionNow/10).toFixed(1)}pp)\n`);
    console.log(`>>> top cuts in legacy regression (%):\n${regressionAnalysisText.join("")}`);
    function delta(p,q) { return {pp: (q-p)/10, percent: 100*(q-p)/p}; }
})(await (await fetch("scores.json")).json(), fromDate, toDate)
```

## How to linkify GitHub handles and pull requests when finishing a post

To avoid false positives, be sure to step through each replacement rather than using Replace All.

- Replace `@([0-9A-Za-z_.-]+)` with `[@$1](https://github.com/$1)`
- Replace ` #([0-9]+)` with ` [#$1](https://github.com/servo/servo/pull/$1)`
- Replace ` ([0-9A-Za-z_.-]+)#([0-9]+)` with ` [$1#$2](https://github.com/servo/$1/pull/$2)`
- Replace ` ([0-9A-Za-z_.-]+)/([0-9A-Za-z_.-]+)#([0-9]+)` with ` [$1/$2#$3](https://github.com/$1/$2/pull/$3)`

## Triaging commits in nightlies for monthly updates

Generally we want to include...

- gecko upgrades (stylo, webrender, mozjs)
- web-facing changes
- DX-affecting CI changes
- MSRV and Rust edition changes
- platform support changes
- platform bustage fixes
- crash fixes

And generally we want to exclude...

- dependabot updates (“build(deps)”)
- WPT imports (“Update web-platform-tests”)
- lint and warning fixes
- other CI changes
- refactors (unless large-scale)
- dependency cleanups

## Hints for writing about changes

- Always check the correct names of people and API features

## How to calculate monthly recurring donations

OpenCollective:

- Go to <https://opencollective.com/dashboard/servo/incoming-contributions?limit=100&status=ACTIVE&status=ERROR&type=RECURRING>
- Make sure there is a column with “month” or “year”, because some table filters hide that column
- Run this code in devtools:
```js
$$("table tbody tr")
    .map(tr => [...tr.cells][2].innerText.match(/[$](\S+)\s*USD\s*[/]\s*(\S+)/))
    .map(match => match && [+match[1].replace(/[.,]/g, ""), match[2]])
        .map(([cents, period]) => cents / {month:1,year:12}[period])
        .reduce((result, cents) => result + cents, 0)
```
- The result is USD cents/month

GitHub:

- Go to <https://github.com/sponsors/servo/dashboard/your_sponsors>
- Run this code in devtools:
```js
seen = new Set; centsPerMonth = 0
```
- Click through each page of the table and run this code in devtools:
```js
centsPerMonth += $$("table tbody tr")
    .map(tr => [...tr.cells])
    .map(cells => [cells[1].querySelector("a").href, cells])
    .filter(([donorHref, cells]) => !seen.has(donorHref))
    .map(([donorHref, cells]) => (seen.add(donorHref), cells))
    .map(cells => cells.slice(2,4).map(td => td.innerText).join(" "))
    .map(text => text.match(/[$](\S+)\s*(.+)/))
    .map(match => [100 * match[1], match[2].replace(/ [(]custom[)]/, "")])
    .filter(([cents, period]) => period != "One time")
    .map(([cents, period]) => cents / {Monthly:1}[period])
    .reduce((result, cents) => result + cents, 0)
```
- After running it on every page, the result is USD cents/month

LFX:

- Go to <https://crowdfunding.lfx.linuxfoundation.org/projects/e98e012f-479e-45d0-8781-4d7f616baa9d/financial>
    - You may need to open it in private browsing to avoid getting a 404, not sure why
- Manually add up the amounts for one month, stopping when you see the same donor repeated
