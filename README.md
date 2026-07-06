# Servo.org website

- [How to write a monthly update](#how-to-write-a-monthly-update)
- [How to start a local dev server](#how-to-start-a-local-dev-server)
- [How to list commits that landed in each nightly](#how-to-list-commits-that-landed-in-each-nightly)
- [How to list this year’s pull request contributors](#how-to-list-this-years-pull-request-contributors)
- [How to analyse Servo WPT dashboard improvements](#how-to-analyse-servo-wpt-dashboard-improvements)
- [How to analyse wpt.fyi pass rate improvements](#how-to-analyse-wptfyi-pass-rate-improvements)
- [How to analyse wpt.fyi Browser Specific Failures improvements](#how-to-analyse-wptfyi-browser-specific-failures-improvements)
- [How to linkify GitHub handles and pull requests when finishing a post](#how-to-linkify-github-handles-and-pull-requests-when-finishing-a-post)
- [How to count the number of pull requests in a month](#how-to-count-the-number-of-pull-requests-in-a-month)
- [How to automatically triage automated PRs](#how-to-automatically-triage-automated-prs)
- [How to calculate monthly recurring donations](#how-to-calculate-monthly-recurring-donations)
- [How to calculate new contributors](#how-to-calculate-new-contributors)
- [Triaging commits in nightlies for monthly updates](#triaging-commits-in-nightlies-for-monthly-updates)
- [Hints for writing about changes](#hints-for-writing-about-changes)
- [Corrections](#corrections)

## How to write a monthly update

Each month, we write a **monthly update**, which is a blog post that [serves as the “extended” release notes](https://book.servo.org/for-maintainers/release-process.html) for the monthly release.
What goes in the monthly update has evolved over the years, but currently the recurring “core” is to write about **commits**, **donations**, and (if there are any) **conference talks**.

### Writing about commits

This is the most time-consuming part by far.
The earliest monthly updates (in 2023) were fairly manageable with an ad-hoc process and a bit of tooling, with maybe 100–150 commits to digest and write about.
But nowadays (in 2026) we have easily 400–500 commits to digest and write about, and keeping up with that requires a more efficient process.

At a high level, the current process (and the tooling) is designed to help you digest all of the commits that landed in the previous month’s [nightly builds](https://github.com/servo/servo-nightly-builds), so you can write about them.
This more or less corresponds to the commits that will land in the next [monthly release](https://github.com/servo/servo/releases), but where they differ, [we err on the side of](https://github.com/servo/book/pull/214#discussion_r3019920813) deferring the commit until the next monthly update.

**Future:** assuming the monthly releases are here to stay, we may want to rework the tooling to directly consider the commits that will land in the monthly release, rather than the commits that landed in last month’s nightlies.

The suggested workflow for efficiently triaging commits is as follows:

**Note that the list of nightly builds is cached in tools/runs.json, so if it exists, you will need to delete it to fetch an updated list.**

[Fetch pull request details](#how-to-list-this-years-pull-request-contributors) for the **last two months** (`2025-01 2025-02`):

```
$ rm tools/runs.json  # New month? Clear the cached list of nightly builds
$ tools/list-pull-requests.sh servo/servo 2025-01 2025-02 > tools/pulls-2025-01-2025-02.json
```

Generate **commits.txt** by [listing commits that landed in each nightly](#how-to-list-commits-that-landed-in-each-nightly) for **last month** (`/^>>> 2025-02-/,/^>>> 2025-03-/!d`):

```
$ tools/list-commits-by-nightly.sh /path/to/servo --pulls-json-path=tools/pulls-2025-01-2025-02.json 2>&1 | tee /dev/stderr | sed '/^>>> 2025-02-/,/^>>> 2025-03-/!d' > commits.txt
```

Open **commits.txt**.
For the best ergonomics, set the language mode to **Diff**, then **Fold All**.

Find any commits where the authors are still listed with an email address (you can do a regex search for `@[^,]+@[^,]+`).
For each of those, open the pull request, and note their GitHub handle in **tools/authors.tsv** by adding a line of the form `<GitHub handle>\t<email address>`.

Regenerate **commits.txt** with the corrected authors:

```
$ tools/list-commits-by-nightly.sh /path/to/servo --pulls-json-path=tools/pulls-2025-01-2025-02.json 2>&1 | tee /dev/stderr | sed '/^>>> 2025-02-/,/^>>> 2025-03-/!d' > commits.txt
```

**NOTE:** if you’ve already started triaging commits, the command above will blow away your work.
Save the corrected version to a different file, then use the **--update-commit-data** option in [commit-triage](https://github.com/jdm/commit-triage) to merge the corrected authors into your commits.txt.

For each commit:

- Read the description below to understand its impact (see [§ Hints for writing about changes](#hints-for-writing-about-changes))
- To exclude the commit from the post, prefix the line with `-`
- To include the commit in the post, prefix the line with `+` then:
    - Add a line immediately below of the form `    one or more tags` (four spaces, then space-separated tags)
    - To write some notes or additional context, append `; your notes` to that new tags line — be sure to include enough context to write about the change without the hints and description, because those will not be visible after the next step

Old workflow, pre-[commit-triage](https://github.com/jdm/commit-triage):

- Generate the outline: `tools/generate-outline.sh commits.txt > outline.txt`
- Open outline.txt — for the best ergonomics, set the language mode to **Diff**
- For each commit, write about it in the blog post, then change the leading `+` to `.`
- When none of the lines start with `+`, you’re done!

**TIP:** if you’re faced with hundreds of commits and it’s a real slog, try triaging the commits of one author at a time. Each author probably only works on a few things each month, so it’s a lot easier to keep the context of their work in your head.

We’re working on [a new tool](https://github.com/jdm/commit-triage) that will make the triage process even more efficient.

## How to start a local dev server

1. `npm install`
2. `npm run start`

## How to list commits that landed in each nightly

**Note that the list of nightly builds is cached in tools/runs.json, so if it exists, you will need to delete it to fetch an updated list.**

Make sure your Servo checkout is on the main branch, and that the branch is up to date. Then run the script below, passing it the path to your checkout:

```sh
$ rm tools/runs.json  # Optional: clear cached list of nightly builds
$ tools/list-commits-by-nightly.sh /path/to/servo
```

To copy the output to your clipboard for a specific calendar month only:

```sh
$ tools/list-commits-by-nightly.sh /path/to/servo 2>&1 | tee /dev/stderr | sed '/^>>> 2025-01-/,/^>>> 2025-02-/!d' | xclip -sel clip
```

**NOTE:** this will display the squash commit message of each commit, which has historically been less useful than the pull request description. To display pull request descriptions instead, pass in a pulls.json with `--pulls-json-path=` as documented in [§ Triaging commits in nightlies for monthly updates](#triaging-commits-in-nightlies-for-monthly-updates).

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
    const focusAreaCount = data.focus_areas.length;
    const rows = dates.map(expectedDate => data.scores.find(([date]) => date == expectedDate));
    rows.forEach((row, i) => {
        console.log(i, row);
        if (row == null) throw `no results for ${dates[i]}!`;
        if (row.length != 3 + focusAreaCount) throw "schema change? bad length";
        if (row[0] != dates[i]) throw "unreachable! incorrect date in [0]";
        if (!/^[0-9a-f]{9}$/.test(row[1])) throw "schema change? expected commit hash in [1]";
        if (!/^0[.]0[.]1-[0-9a-f]{7,9}$/.test(row[2])) throw "schema change? expected version in [2]";
    });
    const areas = data.focus_areas.map((focusAreaName, i) => ({focusAreaName, results: rows.map((row, j) => ({
        date: dates[j],
        score: row[3+i].total_score / row[3+i].total_tests,
        subtests: row[3+i].total_subtests_passed / row[3+i].total_subtests,
    }))}));
    console.log(">>> areas", areas);
    const analysis = areas
        .map(({focusAreaName, results: [p, q]}) => ({
            focusAreaName,
            scoreWas: p.score,
            scoreNow: q.score,
            subtestsWas: p.subtests,
            subtestsNow: q.subtests,
        }))
        .map(({focusAreaName, scoreWas, scoreNow, subtestsWas, subtestsNow}) => ({
            focusAreaName, scoreWas, scoreNow, subtestsWas, subtestsNow,
            scoreDelta: delta(scoreWas, scoreNow),
            subtestsDelta: delta(subtestsWas, subtestsNow),
        }));
    console.log(">>> analysis", analysis);
    const scoreAnalysisText = analysis
        .sort((p,q) => q.scoreDelta.pp - p.scoreDelta.pp)
        .map(({focusAreaName, scoreDelta, scoreNow}) => `${focusAreaName} (${scoreDelta.pp.toFixed(1)}pp to ${(scoreNow*100).toFixed(1)}%)\n`);
    console.log(`>>> top deltas (score, pp):\n${scoreAnalysisText.join("")}`);
    const subtestsAnalysisText = analysis
        .sort((p,q) => q.subtestsDelta.pp - p.subtestsDelta.pp)
        .map(({focusAreaName, subtestsDelta, subtestsNow}) => `${focusAreaName} (${subtestsDelta.pp.toFixed(1)}pp to ${(subtestsNow*100).toFixed(1)}%)\n`);
    console.log(`>>> top deltas (subtests, pp):\n${subtestsAnalysisText.join("")}`);
    function delta(p,q) { return {pp: (q-p)*100, percent: 100*(q-p)/p}; }
})(await (await fetch("https://wpt.servo.org/scores.json")).json(), fromDate, toDate)
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

If you’re using Visual Studio Code or Sublime Text:

- Replace `@([0-9A-Za-z_.-]+)` with `[@$1](https://github.com/$1)`
- Replace ` #([0-9]+)` with ` [#$1](https://github.com/servo/servo/pull/$1)`
- Replace ` ([0-9A-Za-z_.-]+)#([0-9]+)` with ` [$1#$2](https://github.com/servo/$1/pull/$2)`
- Replace ` ([0-9A-Za-z_.-]+)/([0-9A-Za-z_.-]+)#([0-9]+)` with ` [$1/$2#$3](https://github.com/$1/$2/pull/$3)`

Or in vim:

- `:%s/\v[@]([0-9A-Za-z_.-]+)/[@\1](https:\/\/github.com\/\1)/gc`
- `:%s/\v #([0-9]+)/ [#\1](https:\/\/github.com\/servo\/servo\/pull\/\1)/gc`
- `:%s/\v ([0-9A-Za-z_.-]+)#([0-9]+)/ [\1#\2](https:\/\/github.com\/servo\/\1\/pull\/\2)/gc`
- `:%s/\v ([0-9A-Za-z_.-]+)\/([0-9A-Za-z_.-]+)#([0-9]+)/ [\1\/\2#\3](https:\/\/github.com\/\1\/\2\/pull\/\3)/gc`

Or in emacs:

- Replace `@\([0-9A-Za-z_.-]+\)` with `[@\1](https://github.com/\1)`
- Replace ` #\([0-9]+\)` with ` [#\1](https://github.com/servo/servo/pull/\1)`
- Replace ` \([0-9A-Za-z_.-]+\)#\([0-9]+\)` with ` [\1#\2](https://github.com/servo/\1/pull/\2)`
- Replace ` \([0-9A-Za-z_.-]+\)/\([0-9A-Za-z_.-]+\)#\([0-9]+\)` with ` [\1/\2#\3](https://github.com/\1/\2/pull/\3)`

## How to count the number of pull requests in a month

After following the steps that generate `commits.txt`, run the following:

```
grep -E "^https://github.com/servo/servo/pull/" tools/commits.txt | sort | uniq | wc -l
```

To exclude dependabot PRs, run:

```
grep -E "^https://github.com/servo/servo/pull/" tools/commits.txt | grep -v dependabot | sort | uniq | wc -l
```

## How to automatically triage automated PRs

Note that on macOS and FreeBSD, you may need `-i ''`.

```
sed -i -E 's/^https:[^\t]+\t\(@dependabot\[bot\],/-&/' commits.txt
sed -i -E 's/^https:[^\t]+\t\(@servo-wpt-sync,/-&/' commits.txt
```

## How to calculate monthly recurring donations

### OpenCollective

- Go to <https://opencollective.com/dashboard/servo/incoming-contributions?limit=1000&status=ACTIVE&status=ERROR&frequency=MONTHLY&frequency=YEARLY>
- Make sure there is only one page of results; if there are more pages, we’ll need to update the process like we did for GitHub
- Make sure there is a column with “Monthly” or “Yearly”
- Run this code in devtools:
```js
$$("table tbody tr")
    .map(tr => [...tr.cells][2].innerText.split("\n"))
    .map(([amount, period]) => [amount.match(/[$](\S+)/)[1].replace(/[.,]/g, ""), period])
    .map(([cents, period]) => cents / {Monthly:1,Yearly:12}[period])
    .reduce((result, cents) => result + cents, 0)
```
- The result is USD cents/month

### GitHub

- Go to <https://github.com/sponsors/servo/dashboard/your_sponsors>
- Click **Export**, **All time**, then set **File format** to **JSON**
- Click **Start export**, then download the JSON emailed to infra@
- Run this code in devtools:
```js
sponsors = JSON.parse(`<JSON goes here>`);
sponsors
  .filter(sponsor => sponsor.transactions.length > 0)
	.map(sponsor => sponsor.transactions.sort((p,q) => q.transaction_date > p.transaction_date ? 1 : q.transaction_date < p.transaction_date ? -1 : 0).at(0))
	.map(tx => tx.tier_name.match(/^[$]([^ ]+) (.+)/).slice(1))
	.map(([amount, period]) => parseInt(amount,10) * {"a month":100,"one time":0}[period])
  .reduce((r,x) => r + x, 0)
```
- The result is USD cents/month

### thanks.dev

- Go to <https://thanks.dev/>
- Click **Sign in with GitHub** and follow the instructions (if any)
- Go to <https://thanks.dev/dashboard>
- Click **For maintainers**
- The number of donors is in “You currently have X donors.”
- If possible, make a payout: click **payouts**, click **withdraw**, click **withdraw**
- Click **income**, make sure the &lt;select> is set to **gh/servo**
- Run this code in devtools, changing `Jul 25` to the **date** column text for last month:
```js
monthText = "Jul 25";
columnHeadings = [...document.querySelectorAll("div")]
    .filter(div => div.textContent == "amount")
    .flatMap(div => [...div.parentNode.childNodes]);
if (new Set(columnHeadings.map(th => th.parentNode)).size != 1)
    throw new Error("Unexpected columnHeadings values");
headingRow = columnHeadings[0].parentNode;
// The parent is actually the whole page content area, not just the table >:(
contentArea = headingRow.parentNode;
dataRowStart = [...contentArea.childNodes].indexOf(headingRow) + 1;
dataRowEnd = [...contentArea.childNodes].length - 1;  // Total row (fragile?)
dataRows = [...contentArea.childNodes].slice(dataRowStart, dataRowEnd);
if (!dataRows.every(tr => tr.childNodes.length == columnHeadings.length))
    throw new Error("Unexpected table structure");
columnIndices = new Map(columnHeadings.map((th,i) => [th.textContent, i]));
getValue = (tr,columnName) => tr.childNodes[columnIndices.get(columnName)].textContent;
dataRows
    .filter(tr => getValue(tr, "date").endsWith(` ${monthText}`))
    .map(tr => getValue(tr, "amount"))
    .filter(amount => amount != "< $0.01")
    .map(amount => parseInt(amount.match(/^[$]([0-9]+[.][0-9][0-9])$/)[1].replace(".","")))
    .reduce((p, q) => p + q)
```
- The result is USD cents/month

## How to calculate new contributors

Before following the steps below, make sure your **tools/authors.tsv** and **commits.txt** have correct GitHub handles for all authors per [§ Writing about commits](#writing-about-commits).

Update your clone of Servo’s main repo, and replace the gitmailmap(5) with our own table for mapping GitHub handles, derived from **tools/authors.tsv** and all of the **@users.noreply.github.com** email addresses in Servo’s git history:

```sh
$ git -C /path/to/servo fetch origin
$ < tools/authors.tsv sed -E 's/(.*)\t(.*)/@\1 <\2>/' > /path/to/servo/.mailmap
$ git -C /path/to/servo log --format=\%aE origin/main | rg --pcre2 '.*@users[.]noreply[.]github[.]com$' | sed -E 's/^([0-9]+[+])?([^@]+)@.*$/@\2 <&>/' | sort -u >> /path/to/servo/.mailmap
```

Run this in DevTools against [commit-triage](https://github.com/jdm/commit-triage):

```js
[...new Set((await import("./search-dialog.js")).commits.flatMap(commit => commit.authors))].sort().join("\n")
```

Save the output to `this-month-authors.txt`, then generate a `tools/git-log-authors.txt`:

```sh
$ tools/git-log-authors.sh /path/to/servo origin/main > tools/git-log-authors.txt
```

Now compute the first-time authors, given a “cutoff” commit beyond which any contributions are no longer considered first-time:

```sh
$ cutoff_commit=v0.2.0
$ < this-month-authors.txt while read -r author; do tools/is-new-contributor.sh /path/to/servo tools/git-log-authors.txt "$author" "$cutoff_commit"; done
```

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
- WPT imports (“Update web-platform-tests” or “Sync WPT with upstream”)
- fixes for regressions that happened in the same month
- lint and warning fixes
- other CI changes
- refactors (unless large-scale)
- dependency cleanups

## Hints for writing about changes

**Focus on the web-facing impact,** for web platform features. In other words, changes to web platform features should be described in terms of how they’re observable from the platform. When in doubt, check if it exists on [MDN](https://developer.mozilla.org/en-US/docs/) or check the spec. For example, [servo#38163](https://github.com/servo/servo/pull/38163) says “DocumentOrShadowDOM”, but [DocumentOrShadowRoot](https://dom.spec.whatwg.org/#documentorshadowroot) is a mixin included by [Document](https://dom.spec.whatwg.org/#document) and [ShadowRoot](https://dom.spec.whatwg.org/#shadowroot), so we should mention those interfaces, not the mixin ([July 2025](https://servo.org/blog/2025/08/15/this-month-in-servo/)).

**Always check the correct names of people and API features.** People like it when their names are spelled correctly, of course, but sometimes authors refer to API features by incorrect names. When in doubt, check the spec. For example, [servo#32642](https://github.com/servo/servo/pull/32642) says “ShaderCompilationInfo” in the title, but the interface is actually [GPUCompilationInfo](https://developer.mozilla.org/en-US/docs/Web/API/GPUCompilationInfo), returned by the [getCompilationInfo() method on GPUShaderModule](https://developer.mozilla.org/en-US/docs/Web/API/GPUShaderModule/getCompilationInfo) ([July 2024](https://servo.org/blog/2024/07/31/this-month-in-servo/)).

**Always check for patches with co-authors.** Look for any “Co-authored-by” lines in the pull request description, as well as in the descriptions of commits with multiple avatars in the commits tab. If a commit has a “Co-authored-by” line, it will have multiple avatars, but a commit can also have multiple avatars for other reasons, like the committer being different from the author. For example, [servo#32576](https://github.com/servo/servo/pull/32576) has a co-author in both the pull request description and the description of [its only commit](https://github.com/servo/servo/pull/32576/commits/5f19babbae505de98fd95f60717c89d554e6f078) ([July 2024](https://servo.org/blog/2024/07/31/this-month-in-servo/)).

**Check for partial implementations.** Sometimes a patch appears to implement an API feature, but the feature may actually be incomplete. If support is not complete or mostly complete, describe only what is supported or use phrases like “partial”, “basic”, or “initial support”. For example, the title of [servo#32576](https://github.com/servo/servo/pull/32576) suggests that it implements FontFaceSet, but the description and diff explains that only document.fonts.ready is actually implemented ([July 2024](https://servo.org/blog/2024/07/31/this-month-in-servo/)).

**Check for experimental implementations.** Sometimes a patch appears to implement an API feature, but the feature is gated by a pref. If the user needs to enable a pref to use a feature, make sure you mention that. For example, [servo#31108](https://github.com/servo/servo/pull/31108) implements ResizeObserver, but the user needs to run servoshell with `--pref dom.resize_observer.enabled` ([June 2024](https://servo.org/blog/2024/06/28/input-text-emoji-devtools/)).

**Check for disabled implementations.** Sometimes a patch appears to implement an API feature, but the feature is still completely disabled. In this case, it may not be worth writing about the feature at all, unless a lot of work went into the patch. For example, [servo#30752](https://github.com/servo/servo/pull/30752) implements some :has() selector features, but the feature is completely disabled ([November 2023](https://servo.org/blog/2023/11/30/embedding-floats-color-mix/)).

**Check if changes in `servo` (formerly `libservo`) or `embedder_traits` affect our public API.** Such changes are important to highlight in the monthly updates, especially if they are breaking changes.

- Changes to `embedder_traits` [items](https://doc.rust-lang.org/1.88.0/reference/items.html) often affect the public API because many of them are re-exported by `libservo` with `pub use`. To check if an `embedder_traits` item is actually part of the public API, go to [our online API docs](https://doc.servo.org/servo/) and search for it. If the search result for that item starts with `servo::`, then it’s part of the public API. If the search result starts with `embedder_traits::`, then it’s not part of the public API.

- You can use tools like cargo-semver-checks and cargo-public-api to diff two versions of our public API. For example, with cargo-public-api: `cargo public-api diff -p servo <old commit>..<new commit>`

## Corrections

When we make mistakes, we issue corrections on the blog and on social media.

- [**November 2023**](https://servo.org/blog/2023/11/30/embedding-floats-color-mix/) — [An earlier version](https://github.com/servo/servo.org/pull/126) of this post said that Servo now supports the :has() selector, but this was incorrect. While some of the code implementing the feature has landed, it is [not yet enabled](https://github.com/servo/servo/blob/7bcb25c85c98c367c6423ebc0fed964dd08cad56/components/selectors/parser.rs#L276-L279).
- [**March 2024**](https://servo.org/blog/2024/03/12/sponsoring-servo/) — [An earlier version](https://github.com/servo/servo.org/pull/139) of this post said that over 94% of amounts donated to Servo go directly to the project, with only 6% in fees, but this was incorrect. The actual fees depend on the payment method and the amount you donate, but in most cases they are between 10% and 20%. We are still working on clarifying the exact rules about fees with our crowdfunding platforms, so check our [Sponsorship](https://servo.org/sponsorship/) page for the latest information.
- [**November 2025**](https://servo.org/blog/2025/12/15/november-in-servo/) — [An earlier version](https://github.com/servo/servo.org/pull/282) of this post said that Servo now has full support for ChaCha20-Poly1305, but this was incorrect. We had only landed the ‘importKey’ and ‘exportKey’ operations. The ‘encrypt’, ‘decrypt’, and ‘generateKey’ options landed in the following month.
