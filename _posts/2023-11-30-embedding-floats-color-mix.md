---
layout:     post
tags:       blog
title:      "This month in Servo: better floats, color-mix(), try job labels, and more!"
date:       2023-11-30
summary:    Sneak peek into our embedding effort, changes to pull requests, plus nightly updates to browser UI, floats, inline layout, CSS, and tooling.
categories:
---

<aside class="_correction">

**Correction (2023-12-04)**

[An earlier version](https://github.com/servo/servo.org/pull/126) of this post said that Servo now supports the **:has() selector**, but this was incorrect.
While some of the code implementing the feature has landed, it is [not yet enabled](https://github.com/servo/servo/blob/7bcb25c85c98c367c6423ebc0fed964dd08cad56/components/selectors/parser.rs#L276-L279).
</aside>

November has been another exciting month for Servo!

Our nightly example browser, servoshell, is now easier to navigate, **accepting URLs without http:// or https://** both in the location bar and on the command line ([@atbrakhi](https://github.com/atbrakhi), [#30148](30148)), and should no longer lock up when run with `--no-minibrowser` ([@wusyong](https://github.com/wusyong), [#30598](https://github.com/servo/servo/pull/30598)).
Local paths can also be given on the command line, and are still preferred when the path points to a file that exists.

Work is now underway to [improve our embedding story]({{ '/blog/2023/10/26/css-filters-testing-tauri/#embeddable-web-engine' | url }}) and prepare Servo for integration with [Tauri](https://tauri.app), starting with **precompiled [ANGLE](https://en.wikipedia.org/wiki/ANGLE_(software))** for faster initial builds ([@atbrakhi](https://github.com/atbrakhi)), better support for **offscreen rendering** ([@delan](https://github.com/delan), [#30767](https://github.com/servo/servo/pull/30767)), and support for **multiple webviews** ([@delan](https://github.com/delan), [#30648](https://github.com/servo/servo/pull/30648)).
These changes haven’t landed yet, but once they do, apps will be able to open, move, resize, and interleave Servo with other widgets.

<figure class="_fig">
<div class="_flex">
    <a href="{{ '/img/blog/servoshell-mdi.png' | url }}"><img src="{{ '/img/blog/servoshell-mdi.png' | url }}"
        alt="servoshell with a multiple-document interface, showing three overlapping egui windows of different sizes inside a native window"></a>
</div>
<figcaption>

A very early prototype of a Servo-based multiple-document interface ([@delan](https://github.com/delan), [#30785](https://github.com/servo/servo/pull/30785)), taking advantage of upcoming embedding improvements to interleave Servo with [egui](https://www.egui.rs) windows.
</figcaption>
</figure>


## Floats and inline layout

We’ve made several improvements to Servo’s inline layout system, which handles the flow and wrapping of text, images, and inline blocks, delivering welcome bumps to our [WPT]({{ '/blog/2023/07/20/servo-web-platform-tests/' | url }}) pass rates ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [@mukilan](https://github.com/mukilan)):

- 61.4% in the CSS2 `linebox` test suite (+2.8pp), with better handling of line heights and forced line breaks ([#30519](https://github.com/servo/servo/pull/30519))
- 78.9% in `floats` (+1.0pp) and 73.3% in `floats-clear` (+0.5pp), by allowing trailing whitespace to overlap with floats ([#30586](https://github.com/servo/servo/pull/30586))
- 78.1% in `normal-flow` (+1.1pp), by fixing inlines split by boxes and paving the way for fragments that span boxes ([#30608](https://github.com/servo/servo/pull/30608))
- 82.2% in `floats` (a further +3.3pp), by fixing the fragmentation of unbreakable fragments that span multiple boxes ([#30628](https://github.com/servo/servo/pull/30628))

## CSS updates

Several components and dependencies have been upgraded, the biggest being **Stylo**, our Rust-based CSS engine that is now part of Firefox.
We’ve caught up with upstream Stylo by 311 commits, bringing our CSS support from August 2022 to June 2023 ([@Loirooriol](https://github.com/Loirooriol), [@mrobinson](https://github.com/mrobinson), [#30646](https://github.com/servo/servo/pull/30646), [#30681](https://github.com/servo/servo/pull/30681), [#30692](https://github.com/servo/servo/pull/30692), [#30748](https://github.com/servo/servo/pull/30748), [#30770](https://github.com/servo/servo/pull/30770)), and bumped **cssparser** to 0.31.2 ([@Loirooriol](https://github.com/Loirooriol), [#30771](https://github.com/servo/servo/pull/30771)).

As a result, Servo now passes 60.5% of the CSSOM test suite (+3.3pp).
We also no longer incorrectly transition properties that are inherently “discrete” ([@Loirooriol](https://github.com/Loirooriol), [#30565](https://github.com/servo/servo/pull/30565)), passing a further (net) 294 test cases.

Thanks to the recent work on Stylo by Mozilla and others, Servo now supports **color-mix()** and the **new color spaces** from [CSS Color 4](https://drafts.csswg.org/css-color-4/) ([@Loirooriol](https://github.com/Loirooriol), [#30752](https://github.com/servo/servo/pull/30752))!
These new color features allow authors to:
- select colors from wider gamuts than in sRGB (`display-p3`, `a98-rgb`, `prophoto-rgb`, `rec2020`)
- mix colors as if mixing intensities of colored light in real life (`srgb-linear`, `xyz`)
- select a variety of colors with consistent perceived lightness (`oklab`, `lab`)
- select colors with consistent perceived lightness and hue (`oklch`, `lch`)

<figure class=_fig>
<iframe src="https://bucket.daz.cat/work/igalia/servo/5.html" id="_color_mix_demo"></iframe>
<figcaption>

The results of mixing `lime` and `blue` in a variety of CSS color spaces, based on [a demo](https://codepen.io/web-dot-dev/full/MWBXVLV) from [this post](https://developer.chrome.com/articles/css-color-mix/). The background color is the same as this blog post mixed with 10% white, or `color-mix(in oklch, #121619, white 10%)`.
</figcaption>
</figure>

## Dependency upgrades

Our upgrade efforts also affect the tooling Servo uses.
Servo now builds on Ubuntu 22.04 ([@mukilan](https://github.com/mukilan), [#30162](https://github.com/servo/servo/pull/30162)) and macOS 13 on CI, which in turn has made upgrading LLVM and Python (for mach) more urgent.
As a result, we’ve started upgrading Python from 3.10 to 3.12 ([@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [@sagudev](https://github.com/sagudev), [#30638](https://github.com/servo/servo/pull/30638), [#30645](https://github.com/servo/servo/pull/30645), [#30659](https://github.com/servo/servo/pull/30659), [#30685](https://github.com/servo/servo/pull/30685)).

But the biggest impact on our ability to keep our dependencies up to date comes from our **Rust version**.
Many pre-version-1 libraries, even in our transitive dependencies, bump their <abbr title="minimum supported Rust version">MSRV</abbr> quite aggressively, sometimes even requiring a nightly compiler.
First, we migrated from Rust nightly-2023-02-01 to nightly-03-18 ([@mrobinson](https://github.com/mrobinson), [#30630](https://github.com/servo/servo/pull/30630)), which in turn allowed us to upgrade our network stack ([@mrobinson](https://github.com/mrobinson), [#30612](https://github.com/servo/servo/pull/30612), [#30660](https://github.com/servo/servo/pull/30660)).
Since then, we’ve started eliminating our usage of unstable Rust features ([@mrobinson](https://github.com/mrobinson), [#30745](https://github.com/servo/servo/pull/30745), [#30742](https://github.com/servo/servo/pull/30742)), which should make future Rust upgrades easier.

## Pull requests

<figure class="_figr"><a href="{{ '/img/blog/try-job-labels.png' | url }}"><img src="{{ '/img/blog/try-job-labels.png' | url }}"
    alt="GitHub pull request label menu, with the new try job labels (T-full, T-linux-wpt-2013, T-linux-wpt-2020, T-macos, T-windows)"></a></figure>

<span class="_floatmin"></span>You can now **run try jobs by adding labels** to your pull requests ([@mrobinson](https://github.com/mrobinson), [#30383](https://github.com/servo/servo/pull/30383), [#30647](https://github.com/servo/servo/pull/30647), [#30650](https://github.com/servo/servo/pull/30650), [#30756](https://github.com/servo/servo/pull/30756)).
You can even add multiple labels!
The old method, where you mention [@bors-servo](https://github.com/bors-servo) in a comment, has been removed ([@mrobinson](https://github.com/mrobinson), [#30712](https://github.com/servo/servo/pull/30712)), making your pull requests less likely to get spammed with job failures when you post comments on them.
For more details, see [CONTRIBUTING.md](https://github.com/servo/servo/blob/master/CONTRIBUTING.md).

## Stability

We’ve fixed a panic when no font is found for a run of text, printing a warning instead ([@mrobinson](https://github.com/mrobinson), [#30581](https://github.com/servo/servo/pull/30581)), as well as a panic when creating stacking contexts with zero scale ([@mrobinson](https://github.com/mrobinson), [#30713](https://github.com/servo/servo/pull/30713)).
In general, Servo should never panic outside of debug assertions.

We’ve also fixed a bug where paint worklets may access thread-local storage after a script thread gets destroyed ([@mrobinson](https://github.com/mrobinson), [#30671](https://github.com/servo/servo/pull/30671)), which caused intermittent panics in 74 tests.

<style>
    /* guaranteed minimum width for first paragraph after a float */
    ._floatmin {
        display: block;
        width: 13em;
        overflow: hidden;
    }
    ._none {
        display: none;
    }
    ._fig:not(#specificity) {
        width: 33em;
        max-width: 100%;
        margin: 1em auto;
    }
    ._fig > ._flex {
        display: flex;
    }
    ._fig._min {
        width: min-content;
    }
    ._fig table {
        text-align: initial;
    }
    ._fig figcaption._notes {
        text-align: left;
        width: max-content;
        max-width: 100%;
    }
    ._figl:not(#specificity),
    ._figr:not(#specificity) {
        margin: 0 1em 1em;
    }
    ._figl {
        float: left;
    }
    ._figr {
        float: right;
    }
    .figl > iframe,
    .figr > iframe,
    .figl > a > img,
    .figr > a > img {
        width: 17em;
        max-width: max-content;
    }
    ._runin {
        margin-bottom: 1em;
    }
    ._runin > p,
    ._runin > h2 {
        display: inline;
    }
    #_color_mix_demo {
        margin: 0 auto;
        display: block;
        height: min(calc(100vh - 9em), 400px);
        width: min(100%, 33em);
    }
    ._correction {
        max-width: 33em;
        margin: 1em auto;
        border-bottom: 1px solid;
        padding-bottom: 1em;
    }
</style>
