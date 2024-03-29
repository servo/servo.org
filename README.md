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
$ > 2023.json tools/list-pull-requests.sh servo/servo '2023-.*'
$ < 2023.json jq -r .user.login | sort | uniq -c | sort -nr
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
