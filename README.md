# Servo.org website

- [How to start a local dev server](#how-to-start-a-local-dev-server)
- [How to list commits that landed in each nightly](#how-to-list-commits-that-landed-in-each-nightly)
- [How to list this year’s pull request contributors](#how-to-list-this-years-pull-request-contributors)
- [How to analyse Servo WPT dashboard improvements](#how-to-analyse-servo-wpt-dashboard-improvements)
- [How to analyse wpt.fyi pass rate improvements](#how-to-analyse-wptfyi-pass-rate-improvements)
- [How to analyse wpt.fyi Browser Specific Failures improvements](#how-to-analyse-wptfyi-browser-specific-failures-improvements)
- [How to linkify GitHub handles and pull requests when finishing a post](#how-to-linkify-github-handles-and-pull-requests-when-finishing-a-post)
- [How to calculate monthly recurring donations](#how-to-calculate-monthly-recurring-donations)
- [Triaging commits in nightlies for monthly updates](#triaging-commits-in-nightlies-for-monthly-updates)
- [Hints for writing about changes](#hints-for-writing-about-changes)
- [Corrections](#corrections)

## How to start a local dev server

1. `npm install`
2. `npm run start`

## How to list commits that landed in each nightly

Note that the list of nightly builds is cached in tools/runs.json, so if it exists, you will need to delete it to fetch an updated list.

Make sure your Servo checkout is on the main branch, and that the branch is up to date. Then run the script below, passing it the path to your checkout:

```sh
$ rm tools/runs.json  # Optional: clear CI history cache
$ tools/list-commits-by-nightly.sh /path/to/servo
```

To copy the output to your clipboard for a specific calendar month only:

```sh
$ tools/list-commits-by-nightly.sh ~/code/servo 2>&1 | tee /dev/stderr | sed '/^>>> 2025-01-/,/^>>> 2025-02-/!d' | xclip -sel clip
```

## How to list this year’s pull request contributors

```sh
$ > tools/2023.json tools/list-pull-requests.sh servo/servo 2023 2023
$ < tools/2023.json jq -r .user.login | sort | uniq -c | sort -nr
```

Or for some other range of dates:

```sh
$ > tools/pull-requests.json tools/list-pull-requests.sh servo/servo 2023-03-16 2024-03-16
```

## How to analyse [Servo WPT dashboard](https://wpt.servo.org) improvements

**NOTE:** this uses Servo’s WPT dashboard scoring, which currently differs from wpt.fyi scoring in two ways. Subtests are weighted such that one test = 1, and the overall score is the fraction of that score over the *enabled* tests as of the date of the latest run.

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

## How to analyse [wpt.fyi](https://wpt.fyi) pass rate improvements

For example, to compare end of 2024 vs end of 2023:

- For end of 2024, go to <https://wpt.fyi/runs?to=2025-01-01T00%3A00&product=servo>
- Click the Servo logo in the first row of the table, then click **VIEW RUN**
- Write down the `run_id` in the query string, e.g. **6281304587108352**
- For end of 2023, go to <https://wpt.fyi/runs?to=2024-01-01T00%3A00&product=servo>
- Click the Servo logo in the first row of the table, then click **VIEW RUN**
- Write down the `run_id` in the query string, e.g. **5195430563938304**
- Go to <https://wpt.fyi/results/?run_id=6281304587108352&run_id=5195430563938304>

Normally you can just click two runs (Servo logos) and click **VIEW RUNS** or **VIEW DIFF**, but this only works if you can see both runs on the same page. For two runs a year apart, that would require a *lot* of scrolling.

To compute the passing/total subtest and test counts as shown on wpt.fyi:

```sh
$ tools/compute-wpt-fyi-scores.sh servo 2024-01-01
$ tools/compute-wpt-fyi-scores.sh servo 2025-01-01
```

To compute those counts for only a specific suite:

```sh
$ tools/compute-wpt-fyi-scores.sh servo 2024-01-01 /css/
$ tools/compute-wpt-fyi-scores.sh servo 2025-01-01 /css/
```

## How to analyse [wpt.fyi](https://wpt.fyi) Browser Specific Failures improvements

First build the tooling:

```sh
git clone https://github.com/web-platform-tests/results-analysis.git
cd results-analysis
npm i
```

Create an unaligned.patch as follows:

```diff
diff --git a/lib/runs.js b/lib/runs.js
index 03671476..044bc036 100644
--- a/lib/runs.js
+++ b/lib/runs.js
@@ -84,7 +84,7 @@ async function fetchAlignedRunsFromServer(products, from, to, experimental) {
   for (const product of products) {
     params += `&product=${product}`;
   }
-  const runsUri = `${RUNS_API}?aligned=true&max-count=1&${params}`;
+  const runsUri = `${RUNS_API}?max-count=1&${params}`;
 
   console.log(`Fetching aligned runs from ${from.format('YYYY-MM-DD')} ` +
       `to ${to.format('YYYY-MM-DD')}`);
@@ -122,6 +122,7 @@ async function fetchAlignedRunsFromServer(products, from, to, experimental) {
     } catch (e) {
       // No cache hit; load from the server instead.
       const url = `${runsUri}&from=${formattedFrom}&to=${formattedTo}`;
+      console.info(url);
       const response = await fetch(url);
       runs = await response.json();
 
@@ -138,8 +139,8 @@ async function fetchAlignedRunsFromServer(products, from, to, experimental) {
     }
 
     if (runs.length !== products.length) {
-      throw new Error(
-          `Fetched ${runs.length} runs, expected ${products.length}`);
+      console.warn(`Not enough product runs for this day (${runs.length} < ${products.length})`);
+      continue;
     }
 
     if (
```

Create a git-write.patch as follows:

```diff
diff --git a/git-write.js b/git-write.js
index f50269f1..6cadb645 100644
--- a/git-write.js
+++ b/git-write.js
@@ -157,28 +157,15 @@ async function main() {
   const maxAge = maxAgeDays ? moment().subtract(maxAgeDays, 'days') : null;

   const products = [
-    'android_webview',
-    'chrome',
-    'chrome_android',
-    'chromium',
-    'deno',
-    'edge',
-    'epiphany',
-    'firefox',
-    'firefox_android',
-    'flow',
-    'node.js',
-    'safari',
-    'servo',
-    'uc',
-    'webkitgtk',
-    'wktr',
+    'ladybird',
   ];

   for (const product of products) {
     let productRuns = 0;
     let stop = false;
+    let i = 0;
     for await (const run of runs.getIterator({product})) {
+      console.debug(`Run ${i++}`);
       productRuns++;
       totalRuns++;
       // Skip runs of affected tests for PRs.
```

If running NixOS, create a nixos.patch as follows:

```diff
diff --git a/shell.nix b/shell.nix
new file mode 100644
index 00000000..b46af2b7
--- /dev/null
+++ b/shell.nix
@@ -0,0 +1,19 @@
+{ pkgs ? import <nixpkgs> {} }:
+
+# /usr/bin/file: No such file or directory
+# https://github.com/nodegit/nodegit/issues/1247
+(pkgs.buildFHSEnv {
+  name = "results-analysis-env";
+  targetPkgs = pkgs: (with pkgs; [
+    krb5.dev  # krb5-config: command not found
+    file  # see above
+
+    # npm error configure: WARNING: secure clearing/zeroing of memory is not supported by the selected crypto backend
+    # npm error configure: error: Required dependencies are missing!
+    openssl openssl.dev
+    libgcrypt libgcrypt.dev
+    pkg-config
+  ]);
+  multiPkgs = pkgs: (with pkgs; [
+  ]);
+}).env
```

Then clone and build the tooling this way instead:

```sh
git clone https://github.com/web-platform-tests/results-analysis.git
cd results-analysis
git apply unaligned.patch
git apply git-write.patch
git apply nixos.patch  # NixOS only
nix-shell
npm i
```

Now calculate the BSF for Servo and the three major browsers:

```sh
node browser-specific-failures.js --from 2024-01-01 --to 2025-01-01 --products chrome,firefox,safari,servo --experimental
```

## How to linkify GitHub handles and pull requests when finishing a post

To avoid false positives, be sure to step through each replacement rather than using Replace All.

- Replace `@([0-9A-Za-z_.-]+)` with `[@$1](https://github.com/$1)`
- Replace ` #([0-9]+)` with ` [#$1](https://github.com/servo/servo/pull/$1)`
- Replace ` ([0-9A-Za-z_.-]+)#([0-9]+)` with ` [$1#$2](https://github.com/servo/$1/pull/$2)`
- Replace ` ([0-9A-Za-z_.-]+)/([0-9A-Za-z_.-]+)#([0-9]+)` with ` [$1/$2#$3](https://github.com/$1/$2/pull/$3)`

## How to calculate monthly recurring donations

OpenCollective:

- Go to <https://opencollective.com/dashboard/servo/incoming-contributions?limit=1000&status=ACTIVE&status=ERROR&frequency=MONTHLY&frequency=YEARLY>
- Make sure there is only one page of results; if there are more pages, we’ll need to update the process like we did for GitHub
- Make sure there is a column with “monthly” or “yearly”
- Run this code in devtools:
```js
$$("table tbody tr")
    .map(tr => [...tr.cells].slice(2,4).map(td => td.innerText))
    .map(([amount, period]) => [amount.match(/[$](\S+)/)[1].replace(/[.,]/g, ""), period])
    .map(([cents, period]) => cents / {monthly:1,yearly:12}[period])
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
    .map(match => [100 * match[1], match[2].replace(/[(]custom[)]|Via bulk sponsorship/g, "").trim()])
    .filter(([cents, period]) => period != "One time")
    .map(([cents, period]) => cents / {Monthly:1}[period])
    .reduce((result, cents) => result + cents, 0)
```
- After running it on every page, the result is USD cents/month

LFX:

- Go to <https://crowdfunding.lfx.linuxfoundation.org/projects/e98e012f-479e-45d0-8781-4d7f616baa9d/financial>
    - You may need to open it in private browsing to avoid getting a 404, not sure why
- Manually add up the amounts for one month, stopping when you see the same donor repeated

thanks.dev:

- Go to <https://thanks.dev/>
- Click **Sign in with GitHub** and follow the instructions (if any)
- Go to <https://thanks.dev/dashboard>
- Click **For maintainers**
- The number of donors is in “You currently have X donors.”

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

The suggested workflow for efficiently triaging commits is as follows:

- [Fetch pull request details](#how-to-list-this-years-pull-request-contributors) for the last two months, as follows:

```
$ tools/list-pull-requests.sh servo/servo 2025-01 2025-02 > tools/pulls-2025-01-2025-02.json
```

- [List commits that landed in each nightly](#how-to-list-commits-that-landed-in-each-nightly) last month, as follows:

```
$ tools/list-commits-by-nightly.sh ~/code/servo tools/pulls-2025-01-2025-02.json 2>&1 | tee /dev/stderr | sed '/^>>> 2025-02-/,/^>>> 2025-03-/!d' > commits.txt
```

- Open commits.txt — for the best ergonomics in VS Code, **Fold All**, then **Change Language Mode** > **Diff**
- For each commit, read the description below to understand its impact (see [§ Hints for writing about changes](#hints-for-writing-about-changes))
- For each commit to be excluded from the post, prefix the line with `-`
- For each commit to be included in the post, prefix the line with `+` then:
    - Add a line immediately below of the form `    one or more tags` (four spaces, then space-separated tags)
    - To write some notes or additional context, append `; your notes` to that new tags line
- Generate the outline: `tools/generate-outline.sh commits.txt`

## Hints for writing about changes

**Always check the correct names of people and API features.** People like it when their names are spelled correctly, of course, but sometimes authors refer to API features by incorrect names. When in doubt, check the spec. For example, [servo#32642](https://github.com/servo/servo/pull/32642) says “ShaderCompilationInfo” in the title, but the interface is actually [GPUCompilationInfo](https://developer.mozilla.org/en-US/docs/Web/API/GPUCompilationInfo), returned by the [getCompilationInfo() method on GPUShaderModule](https://developer.mozilla.org/en-US/docs/Web/API/GPUShaderModule/getCompilationInfo) ([July 2024](https://servo.org/blog/2024/07/31/this-month-in-servo/)).

**Always check for patches with co-authors.** Look for any “Co-authored-by” lines in the pull request description, as well as in the descriptions of commits with multiple avatars in the commits tab. If a commit has a “Co-authored-by” line, it will have multiple avatars, but a commit can also have multiple avatars for other reasons, like the committer being different from the author. For example, [servo#32576](https://github.com/servo/servo/pull/32576) has a co-author in both the pull request description and the description of [its only commit](https://github.com/servo/servo/pull/32576/commits/5f19babbae505de98fd95f60717c89d554e6f078) ([July 2024](https://servo.org/blog/2024/07/31/this-month-in-servo/)).

**Check for partial implementations.** Sometimes a patch appears to implement an API feature, but the feature may actually be incomplete. If support is not complete or mostly complete, describe only what is supported or use phrases like “partial”, “basic”, or “initial support”. For example, the title of [servo#32576](https://github.com/servo/servo/pull/32576) suggests that it implements FontFaceSet, but the description and diff explains that only document.fonts.ready is actually implemented ([July 2024](https://servo.org/blog/2024/07/31/this-month-in-servo/)).

**Check for experimental implementations.** Sometimes a patch appears to implement an API feature, but the feature is gated by a pref. If the user needs to enable a pref to use a feature, make sure you mention that. For example, [servo#31108](https://github.com/servo/servo/pull/31108) implements ResizeObserver, but the user needs to run servoshell with `--pref dom.resize_observer.enabled` ([June 2024](https://servo.org/blog/2024/06/28/input-text-emoji-devtools/)).

**Check for disabled implementations.** Sometimes a patch appears to implement an API feature, but the feature is still completely disabled. In this case, it may not be worth writing about the feature at all, unless a lot of work went into the patch. For example, [servo#30752](https://github.com/servo/servo/pull/30752) implements some :has() selector features, but the feature is completely disabled ([November 2023](https://servo.org/blog/2023/11/30/embedding-floats-color-mix/)).

## Corrections

When we make mistakes, we issue corrections on the blog and on social media.

- [**November 2023**](https://servo.org/blog/2023/11/30/embedding-floats-color-mix/) — [An earlier version](https://github.com/servo/servo.org/pull/126) of this post said that Servo now supports the :has() selector, but this was incorrect. While some of the code implementing the feature has landed, it is [not yet enabled](https://github.com/servo/servo/blob/7bcb25c85c98c367c6423ebc0fed964dd08cad56/components/selectors/parser.rs#L276-L279).
- [**March 2024**](https://servo.org/blog/2024/03/12/sponsoring-servo/) — [An earlier version](https://github.com/servo/servo.org/pull/139) of this post said that over 94% of amounts donated to Servo go directly to the project, with only 6% in fees, but this was incorrect. The actual fees depend on the payment method and the amount you donate, but in most cases they are between 10% and 20%. We are still working on clarifying the exact rules about fees with our crowdfunding platforms, so check our [Sponsorship](https://servo.org/sponsorship/) page for the latest information.
