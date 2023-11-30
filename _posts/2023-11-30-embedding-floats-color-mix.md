---
layout:     post
tags:       blog
title:      "This month in Servo: better floats, :has(), color-mix(), and more!"
date:       2023-11-28
summary:    Sneak peek of our embedding effort, changes to pull requests, plus nightly updates to browser UI, floats, inline layout, CSS, Rust, and crash fixes.
categories:
---

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
<!-- - 2023-11-03 2023-11-15 71-13 2022-08-26 2022-11-09 [#30646](https://github.com/servo/servo/pull/30646) + mrobinson -->
<!-- - 2023-11-04 2023-11-15 80-16 2022-11-09 2023-01-16 [#30681](https://github.com/servo/servo/pull/30681) -->
<!-- - 2023-11-06 2023-11-15 66-11 2023-01-18 2023-03-07 [#30692](https://github.com/servo/servo/pull/30692) -->
<!-- - 2023-11-21 2023-11-23 85-18 2023-03-07 2023-05-10 [#30748](https://github.com/servo/servo/pull/30748) -->
<!-- - 2023-11-24 2023-11-25 90-23 2023-05-10 2023-06-14 [#30770](https://github.com/servo/servo/pull/30770) -->

As a result, Servo now passes 60.5% of the CSSOM test suite (+3.3pp).
We also no longer incorrectly transition properties that are inherently “discrete” ([@Loirooriol](https://github.com/Loirooriol), [#30565](https://github.com/servo/servo/pull/30565)), passing a further (net) 294 test cases.

Thanks to the recent work on Stylo by Mozilla and others, Servo now supports the **:has() selector**, as well as the **color-mix()** and **new color spaces** from [CSS Color 4](https://drafts.csswg.org/css-color-4/) ([@Loirooriol](https://github.com/Loirooriol), [#30752](https://github.com/servo/servo/pull/30752))!
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

<!--
    - servoshell
    - layout
    - wpt
    - stylo
    - upgrade
    - ci
    - crash
    - refactor
-->

<!--
    based on
    - wpt dashboard
        - 2023-11-15 cssom 58 60.5
        - 2023-11-14 cssom 57.2 58
        - 2023-11-02 30628 floats 78.9 82.2
        - 2023-10-26 30608 normal-flow 77.0 78.1
        - 2023-10-21 30586 floats 77.9 78.9 floats-clear 72.8 73.3
        - 2023-10-19 30519 linebox 58.6 61.4
    - commits in nightlies 2023-10-19 through 2023-11-27
        >>> also 2023-10-19
        !!! 8a12b4c957b6ccf678d47eddd6336163b4b34112	[#30519](https://github.com/servo/servo/pull/30519)
            wpt layout      Improve line box block size calculation (#30519)
        >>> 2023-10-20T06:22:31Z
        !!! d7207122c0705021c3593b5ae854bce4a223b443	[#30581](https://github.com/servo/servo/pull/30581)
            crash layout    Don't panic when no font is found for a TextRun (#30581)
        +++ fd31da9102497cfaf5265bbab17df4424a8a1078	[#30579](https://github.com/servo/servo/pull/30579)
            layout          Anonymous boxes that wrap inlines should not inherit overflow (#30579)
        >>> 2023-10-21T06:35:31Z
        !!! 111716d458c0f9684b094bc835e84302182f7578	[#30565](https://github.com/servo/servo/pull/30565)
            style layout    Stop transitioning properties with a discrete animation type (#30565)
        !!! 9af3495d8aed9a7738824b3eed1e834ba77b6a47	[#30586](https://github.com/servo/servo/pull/30586)
            wpt layout      Consider trailing_whitespace_advance when calling place_line_among_floats() (#30586)
        >>> 2023-10-24T06:26:21Z
        !!! fdcbe613ac152aeac8ae82830b027f90abc1c780	[#30383](https://github.com/servo/servo/pull/30383)
            ci              Allow trigger try workfows using labels (#30383)
        >>> 2023-10-26T06:31:35Z
        !!! 95e32f83727bb56978ae5aca8ac1424afc75afce	[#30608](https://github.com/servo/servo/pull/30608)
            wpt layout      Make LineItems a token stream on the root (#30608)
        >>> 2023-10-29T06:28:14Z
        !!! 463c61f34de83d0e642eeaf792b92532ff5edb2c	[#30638](https://github.com/servo/servo/pull/30638)
            upgrade         Stop using distutils (#30638)
        +++ a6ceca6d9f7f4ce483d1fa7d76a96a921ddc0548	[#30637](https://github.com/servo/servo/pull/30637)
            refactor        Clean up a bit of the canvas backend abstractions (#30637)
        +++ 26a3dffd956b332361c75e5a3cef6dbf4d7584cc	[#30606](https://github.com/servo/servo/pull/30606)
            refactor        Clean up and merge some canvas-related WebIDLs (#30606)
        !!! a3d2f0c586e97e26906bd2327395186bf140f49b	[#30509](https://github.com/servo/servo/pull/30509)
            ci              Enable debug assertions for all builds other than official releases (#30509)
        >>> 2023-10-31T06:39:07Z
        !!! a354b5fc3df3d48baccf49339259ef30f189f3e1	[#30650](https://github.com/servo/servo/pull/30650)
            ci              One more fix for trying via a label (#30650)
        !!! 6b882579a5571a8f4776414c5ef501d1e8de6fb2	[#30647](https://github.com/servo/servo/pull/30647)
            ci              Fix try jobs triggered with labels (#30647)
        !!! 117cc1da6c3d47a7857471524bb4962bc9d885f0	[#30645](https://github.com/servo/servo/pull/30645)
            upgrade         mach: use `importlib` module instead of `imp` (#30645)
        >>> 2023-11-02T06:43:02Z
        !!! 27527142bdde26917d2f58a14551d0d6f3e12050	[#30630](https://github.com/servo/servo/pull/30630)
            upgrade         Update rust version to "nightly-2023-03-18" (#30630)
        !!! 6c4f098d41e951a76e0dd480933bfa503fcb2e01	[#30628](https://github.com/servo/servo/pull/30628)
            wpt layout      Add better support for line breaking across inline box boundaries (#30628)
        !!! 79cceab06442acc26ad1316d1e5fb9f9cfebddce	[#30660](https://github.com/servo/servo/pull/30660)
            upgrade         Update `ipc-channels` (#30660)
        !!! 9d9c5d3ca9b514f3021ae7edd476354faf194bca	[#30659](https://github.com/servo/servo/pull/30659)
            upgrade         Vendor `mozdebug` and stop using `distutils` (#30659)
        >>> 2023-11-03T06:06:01Z
        !!! a53271d31eaa0915d8f642d27c52ddf2bb54f71c	[#30612](https://github.com/servo/servo/pull/30612)
            upgrade         Update network stack dependencies (#30612)
        !!! 8fd370784e5fcabe0828c05463f7fc80a7093214	[#30685](https://github.com/servo/servo/pull/30685)
            upgrade         Update mozjs and setuptools (#30685)
        !!! f8ec3df49516a4ac3e2753af0fa71c50de72c715	[#30671](https://github.com/servo/servo/pull/30671)
            crash           Fix intermittent crashes in paint worklets (#30671)
        >>> 2023-11-15T05:59:22Z
        !!! 72cb34dc3def415b4c6e742d8897cb2425c1685a	[#30713](https://github.com/servo/servo/pull/30713)
            crash           Fix transform assertion failures in Layout 2013 and Layout 2020 (#30713)
        !!! 44d79269f48ddd7d0cbef1b933831066a2e19869	[#30598](https://github.com/servo/servo/pull/30598)
            servoshell      Fix servoshell can't respond when there's no minibrowser (#30598)
        !!! bbbdb77a7a64fe7aef5b3dc76076d3f2010daa04	[#30148](https://github.com/servo/servo/pull/30148)
            servoshell      Handle URL without scheme (#30148)
        !!! fe7bdb7e4b3594048682f4727163a3a98b161116	[#30712](https://github.com/servo/servo/pull/30712)
            ci              Remove support for triggering try from comments (#30712)
        +++ f4d3af296c05260dfbb3deea4f8fa400cb6887d3	[#30507](https://github.com/servo/servo/pull/30507)
            refactor        Move `*_traits` and other shared types to `shared`
        !!! b268936308177c5cbe4d58d26f7aa1a87b2841c8	[#30162](https://github.com/servo/servo/pull/30162)
            ci upgrade      ci: use ubuntu 22.04 on linux runners (#30162)
        >>> 2023-11-19T05:58:36Z
        !!! e83e7ded6e9d00a1079b00bd3b1c6c2d072b827f	[#30745](https://github.com/servo/servo/pull/30745)
            upgrade         Remove use of proc_macro_diagnostics feature (#30745)
        !!! 8de4629a3c769e78c47a163326f045ca53ed6298	[#30742](https://github.com/servo/servo/pull/30742)
            upgrade         Remove usage of `drain_filter` (#30742)
        >>> 2023-11-21T06:12:22Z
        !!! 61af8fb56d77f0023e8aeeb5641c680e7133c7f2	[#30752](https://github.com/servo/servo/pull/30752)
            style upgrade   Enable new color functions from CSS Color 4 (#30752)
        >>> 2023-11-23T05:54:09Z
        !!! 35b4641bf91ed932919d543bfb7deba599174adb	[#30756](https://github.com/servo/servo/pull/30756)
            ci              Add a concurrency group to try jobs (#30756)
        >>> 2023-11-25T05:58:07Z
        !!! 69fb7a9a9a9ea57bbb917fc67854963416c84b6e	[#30771](https://github.com/servo/servo/pull/30771)
            style upgrade   Update cssparser to 0.31.2 (#30771)
-->

<!--
>>> also 2023-10-19
+++ 8a12b4c957b6ccf678d47eddd6336163b4b34112	https://github.com/servo/servo/pull/30519	Improve line box block size calculation (#30519)

>>> 2023-10-20T06:22:31Z
    582943a19eeef23e3efd381ff35637edc32adb5c	https://github.com/servo/servo/pull/30478	Migrate scroll_root.html to WPT (#30478)
    486b743f134edf8d9d9fd0b5c124dfbfd152fde8	https://github.com/servo/servo/pull/30588	build(deps): bump tracing from 0.1.39 to 0.1.40 (#30588)
+++ d7207122c0705021c3593b5ae854bce4a223b443	https://github.com/servo/servo/pull/30581	Don't panic when no font is found for a TextRun (#30581)
+++ fd31da9102497cfaf5265bbab17df4424a8a1078	https://github.com/servo/servo/pull/30579	Anonymous boxes that wrap inlines should not inherit overflow (#30579)
>>> 2023-10-21T06:35:31Z
    66e169cc71741bb4c7a16651955e98cf6a261741	https://github.com/servo/servo/pull/30595	build(deps): bump thiserror from 1.0.49 to 1.0.50 (#30595)
    1d5cd6176066b2cbe767dc30b90128665271edc4	https://github.com/servo/servo/pull/30596	build(deps): bump cpufeatures from 0.2.9 to 0.2.10 (#30596)
    57c050fb6c5c3e22be405282b89959e83e720a07	https://github.com/servo/servo/pull/30597	build(deps): bump rustix from 0.38.19 to 0.38.20 (#30597)
+++ 111716d458c0f9684b094bc835e84302182f7578	https://github.com/servo/servo/pull/30565	Stop transitioning properties with a discrete animation type (#30565)
+++ 9af3495d8aed9a7738824b3eed1e834ba77b6a47	https://github.com/servo/servo/pull/30586	Consider trailing_whitespace_advance when calling place_line_among_floats() (#30586)
    e95de5d858e7f9a49dc3fe9e8818b46c3a3790e0	https://github.com/servo/servo/pull/30590	Temporarily convert more cfg(debug_assertions) crashes to warnings (#30590)
    aabae55407705aa96f04b89bd0b893c18be78cf4	https://github.com/servo/servo/pull/30591	Fix filtered test counts in WPT summaries (#30591)
>>> 2023-10-23T06:20:33Z
>>> 2023-10-24T06:26:21Z
    2d474a0697d45652aed5e96ff587c70b67a431f8	https://github.com/servo/servo/pull/30605	build(deps): bump socket2 from 0.4.9 to 0.4.10 (#30605)
    54c37497f5ee44752955cc540a115cd3edea06ed	https://github.com/servo/servo/pull/30602	build(deps): bump base64 from 0.21.4 to 0.21.5 (#30602)
+++ fdcbe613ac152aeac8ae82830b027f90abc1c780	https://github.com/servo/servo/pull/30383	Allow trigger try workfows using labels (#30383)
>>> 2023-10-25T06:18:35Z
    1f961b9d384dafb744f65a2e5da41312b003e64c	https://github.com/servo/servo/pull/30610	build(deps): bump ahash from 0.7.6 to 0.7.7 (#30610)
>>> 2023-10-26T06:31:35Z
    88234309b04057d7474e51131a806105032acc28	https://github.com/servo/servo/pull/30618	build(deps): bump tokio-util from 0.7.9 to 0.7.10 (#30618)
+++ 95e32f83727bb56978ae5aca8ac1424afc75afce	https://github.com/servo/servo/pull/30608	Make LineItems a token stream on the root (#30608)
    c9d25963a776014d75ccf1a6c7118875681263b3	https://github.com/servo/servo/pull/30616	docs: add table of contents to HACKING_QUICKSTART (#30616)
    65beca94cd748e4974f3aed9c21c3a233551760c	https://github.com/servo/servo/pull/30607	Sync WPT with upstream (24-10-2023) (#30607)
>>> 2023-10-27T13:33:38Z
fatal: Invalid revision range 88234309b04057d7474e51131a806105032acc28..6839f41e39da14bee3580c6b1a5924d04afa8492
>>> 2023-10-28T14:29:31Z
fatal: Invalid revision range 6839f41e39da14bee3580c6b1a5924d04afa8492..6dd359193f3f2b71c590000b3ea3d86a878ee8e4
>>> 2023-10-29T06:28:14Z
    66810f7318f6c540fa7b663951914bd6e48d8ddc	https://github.com/servo/servo/pull/30633	build(deps): bump futures-util from 0.3.28 to 0.3.29 (#30633)
+++ 463c61f34de83d0e642eeaf792b92532ff5edb2c	https://github.com/servo/servo/pull/30638	Stop using distutils (#30638)
    6dd359193f3f2b71c590000b3ea3d86a878ee8e4	https://github.com/servo/servo/pull/30632	Fix upload-nightly to use correct path (#30632)
+++ a6ceca6d9f7f4ce483d1fa7d76a96a921ddc0548	https://github.com/servo/servo/pull/30637	Clean up a bit of the canvas backend abstractions (#30637)
    faf928f3a86a704b213dc6bb821fcb2f3f352285	https://github.com/servo/servo/pull/30626	build(deps): bump cpufeatures from 0.2.10 to 0.2.11 (#30626)
    3fb8a04c184c8f0b36f24e981a9aec1a8001accc	https://github.com/servo/servo/pull/30625	build(deps): bump serde from 1.0.189 to 1.0.190 (#30625)
    e897fcc3a531f128b83f00d6bdff9e91a52e0dcd	https://github.com/servo/servo/pull/30622	build(deps): bump futures-io from 0.3.28 to 0.3.29 (#30622)
    de5d79dd3709a8c194a183e507785a5c476a18f0	https://github.com/servo/servo/pull/30621	build(deps): bump futures-task from 0.3.28 to 0.3.29 (#30621)
    7c1ad5f41d09f4102b415f9b0e1b99e7c6b65b9d	https://github.com/servo/servo/pull/30620	build(deps): bump futures-channel from 0.3.28 to 0.3.29 (#30620)
    e4fc4fa3f512bd64c45dd7035e5fd26ab36cbf7d	https://github.com/servo/servo/pull/30613	Replace the time crate with std::time in components/compositing (#30613)
+++ 26a3dffd956b332361c75e5a3cef6dbf4d7584cc	https://github.com/servo/servo/pull/30606	Clean up and merge some canvas-related WebIDLs (#30606)
+++ a3d2f0c586e97e26906bd2327395186bf140f49b	https://github.com/servo/servo/pull/30509	Enable debug assertions for all builds other than official releases (#30509)
>>> 2023-10-30T07:04:55Z
    3fde61f2e51ca3653b86eaac6ca1f3f2bed3a2f2	https://github.com/servo/servo/pull/30642	Fix the try build (#30642)
    854863f73e495516818f431c29ed07ffaa5d98aa	https://github.com/servo/servo/pull/30635	build(deps): bump tempfile from 3.8.0 to 3.8.1 (#30635)
>>> 2023-10-31T06:39:07Z
    61f7e433225ad4208bc5ddc989165d4cd43e3147	https://github.com/servo/servo/pull/30655	build(deps): bump futures-executor from 0.3.28 to 0.3.29 (#30655)
    e5710220589bb2ba70d35eb858df58b9d2cd35a7	https://github.com/servo/servo/pull/30653	build(deps): bump serde_json from 1.0.107 to 1.0.108 (#30653)
    64e42c8de2a6f27a33e3e84d43a95090a5df4c49	https://github.com/servo/servo/pull/30652	build(deps): bump brotli-decompressor from 2.5.0 to 2.5.1 (#30652)
+++ a354b5fc3df3d48baccf49339259ef30f189f3e1	https://github.com/servo/servo/pull/30650	One more fix for trying via a label (#30650)
    afe299fd1d9dc988d4b54fba14326d9107edbd92	https://github.com/servo/servo/pull/30644	fix typo in debugging.md from servo to Servo (#30644)
+++ 6b882579a5571a8f4776414c5ef501d1e8de6fb2	https://github.com/servo/servo/pull/30647	Fix try jobs triggered with labels (#30647)
+++ 117cc1da6c3d47a7857471524bb4962bc9d885f0	https://github.com/servo/servo/pull/30645	mach: use `importlib` module instead of `imp` (#30645)
>>> 2023-11-02T06:43:02Z
    af68769007abcfdd498740093aee1976599f1fee	https://github.com/servo/servo/pull/30662	Remove an unused file (#30662)
    01b30e1552e738e56ebb172cd7092cd514b25fba	https://github.com/servo/servo/pull/30663	Cleanup: rename to top_level_browsing_context_id for consistency (#30663)
    9227069076b9f2d4055e9b93eb2ab0738f2ac062	https://github.com/servo/servo/pull/30677	build(deps): bump mio from 0.8.8 to 0.8.9 (#30677)
    f2bd0394c390b73e22c79054f9709d7df6695fbe	https://github.com/servo/servo/pull/30676	build(deps): bump wasm-bindgen from 0.2.87 to 0.2.88 (#30676)
    4fd96e2905b6ec694de4e7108e1fee4aa960b299	https://github.com/servo/servo/pull/30675	build(deps): bump fdeflate from 0.3.0 to 0.3.1 (#30675)
+++ 27527142bdde26917d2f58a14551d0d6f3e12050	https://github.com/servo/servo/pull/30630	Update rust version to "nightly-2023-03-18" (#30630)
    364d11f15f6025b1bfb8bccb548b70a35239331d	https://github.com/servo/servo/pull/30643	Update textinput.rs (#30643)
+++ 6c4f098d41e951a76e0dd480933bfa503fcb2e01	https://github.com/servo/servo/pull/30628	Add better support for line breaking across inline box boundaries (#30628)
    4d573dffa31182f26f10d3a65c42c6125bfd38ca	https://github.com/servo/servo/pull/30670	Use py3.11 on mac runners (#30670)
+++ 79cceab06442acc26ad1316d1e5fb9f9cfebddce	https://github.com/servo/servo/pull/30660	Update `ipc-channels` (#30660)
    7064be31926e4f2b6f31bf72565d0ab413318af4	https://github.com/servo/servo/pull/30654	build(deps): bump ab_glyph from 0.2.22 to 0.2.23 (#30654)
+++ 9d9c5d3ca9b514f3021ae7edd476354faf194bca	https://github.com/servo/servo/pull/30659	Vendor `mozdebug` and stop using `distutils` (#30659)
    4ea042cb1473d22b7b2e804da5fb5b68fee6432d	https://github.com/servo/servo/pull/30641	Sync WPT with upstream (29-10-2023) (#30641)
>>> 2023-11-03T06:06:01Z
+++ a53271d31eaa0915d8f642d27c52ddf2bb54f71c	https://github.com/servo/servo/pull/30612	Update network stack dependencies (#30612)
+++ 8fd370784e5fcabe0828c05463f7fc80a7093214	https://github.com/servo/servo/pull/30685	Update mozjs and setuptools (#30685)
+++ f8ec3df49516a4ac3e2753af0fa71c50de72c715	https://github.com/servo/servo/pull/30671	Fix intermittent crashes in paint worklets (#30671)
    c2af95d2fc982023caaac07bb8d9f027673d8d7d	https://github.com/servo/servo/pull/30682	Unit tests are becoming more flaky, so retry them (#30682)
    f5627ce4cc9e280fa942eaf3810816a398ad5fd5	https://github.com/servo/servo/pull/30661	Remove `__future__` imports that are no longer necessary (#30661)
    7e643f46d7ab08bd59421ef8f137936c61f76ea2	https://github.com/servo/servo/pull/30673	build(deps): bump web-sys from 0.3.64 to 0.3.65 (#30673)
    ac852f6c38343c9b4bee51f21e35cd553069bf4b	https://github.com/servo/servo/pull/30674	build(deps): bump js-sys from 0.3.64 to 0.3.65 (#30674)
    31ca45e589cfde9dfb17942d3967db612e41321f	https://github.com/servo/servo/pull/30658	Replace environmental cargo_profile___ with ${{}} (#30658)
>>> 2023-11-13T13:32:55Z
fatal: Invalid revision range a53271d31eaa0915d8f642d27c52ddf2bb54f71c..fea71cda427cb7f4cfaa0ff80fa656e1439cde40
>>> 2023-11-14T06:11:40Z
fatal: Invalid revision range fea71cda427cb7f4cfaa0ff80fa656e1439cde40..e6203817363d5cc209002539ad0d629a8b951f2e
>>> 2023-11-15T05:59:22Z
    354d1d8d11925f1b4c4d46e1fc02ae67533fce3e	https://github.com/servo/servo/pull/30615	docs: add try job labels to CONTRIBUTING (#30615)
    0cc093548ea80099ecaf6efdfa0a1c27c8a9f0f2	https://github.com/servo/servo/pull/30730	build(deps): bump http from 0.2.10 to 0.2.11 (#30730)
    1e5db618d04ef5636bdcf887ca8dffb480c1a222	https://github.com/servo/servo/pull/30726	Fix Servo taking a long time to start on MacOS after a recompile (#30726)
    098e6a158039fe1b01cc69f1e52a5e375c4c423f	https://github.com/servo/servo/pull/30657	constellation: clean up logging of pipelines and browsing contexts (#30657)
    e6203817363d5cc209002539ad0d629a8b951f2e	https://github.com/servo/servo/pull/30728	Pin pyopenssl (#30728)
    e44ea6290aeab13221b9f5f389e271cf351e0763	https://github.com/servo/servo/pull/30727	bootstrap: Alphabetize and add 'm4' Ubuntu dependency (#30727)
+++ 72cb34dc3def415b4c6e742d8897cb2425c1685a	https://github.com/servo/servo/pull/30713	Fix transform assertion failures in Layout 2013 and Layout 2020 (#30713)
    1915032f66a83c25b1134264c08cd1d500cc8271	https://github.com/servo/servo/pull/30720	build(deps): bump tokio from 1.33.0 to 1.34.0 (#30720)
+++ 44d79269f48ddd7d0cbef1b933831066a2e19869	https://github.com/servo/servo/pull/30598	Fix servoshell can't respond when there's no minibrowser (#30598)
    d8e93fa4087efd1a72adbb3511405b127a8023d3	https://github.com/servo/servo/pull/30721	build(deps): bump http from 0.2.8 to 0.2.10 (#30721)
    6068fe211006d3978d4425679fb44d16dd004ca6	https://github.com/servo/servo/pull/30719	build(deps): bump smallvec from 1.11.1 to 1.11.2 (#30719)
    d67fc424e0c5c402d9e21d5d93996df8bb3dc2e7	https://github.com/servo/servo/pull/30718	build(deps): bump rustls-pemfile from 1.0.3 to 1.0.4 (#30718)
    96d37d3785ceadb33d0d0e9c81a967bf3179343a	https://github.com/servo/servo/pull/30707	Add `--production` option to mach (#30707)
    c78b98252a7a6de2df8628adef9515d454c9c3ac	https://github.com/servo/servo/pull/30715	README.md: update reference to rust-toolchain(.toml) (#30715)
+++ bbbdb77a7a64fe7aef5b3dc76076d3f2010daa04	https://github.com/servo/servo/pull/30148	Handle URL without scheme (#30148)
+++ fe7bdb7e4b3594048682f4727163a3a98b161116	https://github.com/servo/servo/pull/30712	Remove support for triggering try from comments (#30712)
    c529bfa49e7fa9e3004dacf278b3e90b0be373b4	https://github.com/servo/servo/pull/30710	Remove some stray references to OpenSSL (#30710)
    149c322639fcc2cd04300c9ec5166fac1edc11fc	https://github.com/servo/servo/pull/30711	build(deps): bump getrandom from 0.2.10 to 0.2.11 (#30711)
    c467528dec5dea435d59e79163750f23cff9800e	https://github.com/servo/servo/pull/30709	build(deps): bump linux-raw-sys from 0.4.10 to 0.4.11 (#30709)
    e0c0b65e2a80ac7d67b87dc10322716ffd8e7b4d	https://github.com/servo/servo/pull/30708	Inherit secrets in the main workflow (#30708)
    3c57f2cb4409224ad6139f7b8d9f691bddf8b8f2	https://github.com/servo/servo/pull/30704	Use `Au` instead of `Length` in flexbox code (#30704)
    e44f17c3df8e97ca5565ceceaa9e8a1d81908818	https://github.com/servo/servo/pull/30706	build(deps): bump serde from 1.0.190 to 1.0.192 (#30706)
    52fa105e8faa57c2fc028cf315e022e16323aeed	https://github.com/servo/servo/pull/30705	build(deps): bump errno from 0.3.5 to 0.3.6 (#30705)
    1db357456a0f577b21ab5d673b4b4bad69879290	https://github.com/servo/servo/pull/30698	build(deps): bump etagere from 0.2.8 to 0.2.9 (#30698)
    ecc1bdd797bf27a7650dcedf79ea47e5651fa2f7	https://github.com/servo/servo/pull/30702	build(deps): bump libc from 0.2.149 to 0.2.150 (#30702)
    81dba33cf69433b50ddccca4eb556c8931bfa4e2	https://github.com/servo/servo/pull/30699	build(deps): bump syn from 2.0.38 to 2.0.39 (#30699)
    1ab2c7b1278ad217f9b7758c094382d04178f2a0	https://github.com/servo/servo/pull/30697	build(deps): bump vergen from 8.2.5 to 8.2.6 (#30697)
    96892a2c96f3c89bb3dea7ad6ae19ab23a1a0196	https://github.com/servo/servo/pull/30700	build(deps): bump orbclient from 0.3.46 to 0.3.47 (#30700)
        1b20d5e67aa00266a3951d261dbee20a44d3d22b	Update test expectations
        ecc6ba79b0f4c1cf28b78b20ca6cc7aaff6c4e7b	Further changes required by Servo
        a8fef9d4f2bc971dab40f610e5ad5286aac31140	style: Serialize NaN and infinity angles as per spec
        7b285723095a6359523ddb653ee37b7ada0fde2b	Further changes required by Servo
        a41194a318830ddccbfb62bab85405df07dc14ae	style: Make <ray-size> optional and default to 'closest-side'
        860a6c2fe680bf65fc654a2eeda24cb05d7799f6	style: Move legacy -moz-box collapse to its own CSS property
        34eb94c71e3292c2fc244254bde5c440e7bac2e8	Further changes required by Servo
        21d1bdeb9b9a86963569df925390d2a0170ed2ea	style: Implement CSS exponential functions
        0b20b343e69f0543fc906af9889ae7659f96a828	style: Support offset-position in the style system
        1b40d30f883c245f6b4d8ca2d55f538c83de8203	style: Fix appearance-cssom-001.html
        9a37424dca3b3f63c885bc0888837ecc2540197a	style: Make -moz-box-layout: flex default, and clean-up CSS
        4da83f238a010bc4a58f6ad904922c7c7d6eb52d	Further changes required by Servo
        1c3aafd9d222048b8ba9c21c9962424f3aeef25c	style: Use abstract color parser
        6e128b65127084dec4f6433ec6088dc7119a84f6	style: Don't reject negative resolutions either
        d68bd45cc3301178b0b2b810b30d44777ce09af0	style: Don't reject negative values at parse time in media features
        4ed0f518fb9b16096506f31f6a542c2b6571e5c6	style: Fix parsing nested image-set funcs as valid
        75b3bf184216cf9ab7041cd48fec9ee83a30555b	style: Layer should be an invalid media type
        fa9fa0097770f9f288dd277fb76e3f2e7c30856d	style: Remove -moz-image-region support from layout
        e0e5a226148e18b6d16e543b719f93ff7e6a2373	Further changes required by Servo
        1a3b32a2482a7f09dba4c7076d7800b1cc0e004f	style: Expose scrollbar-inline-size as a chrome-only environment variable
        89e01f1df6d885706bb63fcb7cc41e9124c788e7	style: Expose chrome-only environment variables to all chrome:// documents, not just chrome-docshells
        017ab0cb241a58a5cf28205c18949f3748b587b3	style: `linear()` easing function should not consider less than 2 linear stop arguments valid
        d76fe816000d89e0667d34443380dc2dafd10ed3	Further changes required by Servo
        9d41dd1ad9c0dafd9378d3b2cb387021cca207b9	style: Add forced-color-adjust property
        93326b2d2ba5f8c8512d077496428363c7ce7ec2	style: Part 3 - Color mixing is done with new color spaces
        954c38cccb6ff3b5feed8f4c2c74922e90544fce	style: Part 2 - Use new color space for color mixing
        e963abe2e9f29563ffce21a74db95fd53216f640	style: Part 1 - Move color mixing code to color module
        c4ae5c93a8ae2edefaf0b1207a56a21fd5f07172	style: add subgrid to list of suggestions for grid-template-* properties
        53cddb188677b40edbaa0397cc94be5823960c1d	Further changes required by Servo
        8997888c6f359f6ad35c8f1defd28c7986d22bef	style: Expose line-height resolution to style, and use it from ToResolvedValue
        aa810f77ecc0c6e3ae8fcfb9c5b59d07781d2875	style: Use non-native menus in Windows for documents where we don't have a native theme
        a9998e899b41f4a8495e1b2df1f01aeb6cc1d8d1	style: Move AbsoluteColor to common color module
        169c2682d5407841fcc7b25b656d470d3c59078e	style: Add missing color conversions
        dc295dad310a3a081634dd3d00fda49a7606009c	style: Implement ipdl reads without needing default ctors
        a55ae0ee90278b9597acab91e1f9cf6886bdafaf	style: Hint directionality of label content for crop="start" labels
        647434532d4bf41be6dec391b4f298a686c64367	style: [devtools] Add `color` to DevTools autocomplete
        0bf39dc3d32b61cbf53830084363673654a79220	style: Resolve <number> to <length> in ToResolvedValue for line-height
        816a0f960bb87b84ad81a8c128d513a5fd593d62	style: Fixes for font-language-override parsing and tests
        2d441672be4f7e3566869ac1c267e21f53a05cbc	style: Ensure font-variant-alternates values are serialized in canonical order
        3de6f5a887e9da074c3d23d781f3e67cd7241c53	style: Avoid redundantly serializing the initial value of font-weight (400) as part of the font shorthand in computed style
        8a2cfc0b24994daead399faec9f0341199b6614c	style: Use write_char in place of write_str when serializing single-character literals
        05fb1b62b7566c9c1155a05680f2e9d9a670e874	style: Implement the font-synthesis-{weight,style,small-caps} longhand properties, and make font-synthesis into a shorthand
        dbd3eab9cd0f4c7808a2add2333300a0e9668ebf	Further changes required by Servo
        449fe2338e9ce4af5a68ec82ee7b8e54a11bfdcb	style: Create a pref to list icon font families that should be used even when use_document_fonts=0, overriding the browser's font prefs
        922914aa385084c068ff41f318e95e2e71d59169	style: Implement color() function from CSS specification
        896aac5e4a5f6a9f61a57b0e7a5e6e2a6a9b9a95	style: Basic implementation of Custom Highlight API
        29c6094c80a4b8b9ba7f25a97e1af9aec11ec897	style: [css-nesting] Parse parent selector
        b024f5b2e752d4d6f2b475dc0ff26c0d237beeca	style: Make scroll-timeline-{name|axis} be a coordinating list property group
        47a54ced2bf5f31dbb8842d1df75c95b4e1099d9	Further changes required by Servo
        d9a9ae4d7bee9fab5d87e54aa1ec58005ed06c58	style: Add `lab`, `lch`, `oklab` and `oklch` to DevTools autocomplete
        6542bb135e5649e6a58ca02aff9f8d9966d665c9	style: Update scroll-timeline shorthand syntax in WPT
        1bb98a9e16e866297d40ac9e5e9fc6286ac293f7	style: Accept auto for {scroll|view}-timeline-name
        39f57649da1b228e6d5a8de5204cea6f32c1e1c9	style: Support view-timeline shorthand
        835268aec2fcb02b58c53af83e9a8aca817a3d40	style: Support view-timeline-inset in style system
        b5b64af3f12155750a77e0c369d29a93c0f47f8f	style: Support view-timeline-name and view-timeline-axis in style system
        863716a0a15212f016beec98412b16053fee8662	style: Minor clean-up to transform interpolation code
        fffb3c0830513f112b81833bfb39c35c8903422c	style: Avoid infinite output progress after applying the easing function
        bb55e923bb2a8dd0d639316790ef947f3d804d1e	Further changes required by Servo
        4559546fbbc51de8ff06a8b5e95cb5b8007e60f3	style: Add lab(), lch(), oklab(), oklch() to specified colors
        6ce64abe7ecdf5b262c528617c47b1fdb4977c40	style: Clean up list interpolation code
        d54d9ec25a3100a22f0cae24f857de5c00fbe77f	style: De-dup items with the same tag in the computed value of font-feature-settings and font-variation-settings
        979637de7d23a975695f8558a6b8ee899d268f1e	style: Remove some duplicated code for coordinated properties
        fe8cdbe328a1697d8cc7c7f438f85b06bbfd66da	style: Use the same computed time representation between Servo and Gecko
        b96f8f748cd9db5500fed89ecd67fb86f3877fc5	style: Share computed animation-iteration-count representation between Servo and Gecko
        fa297196ef8a0743f929472d0ae2b7e902784612	style: Reuse list_matches_complex_selector() where possible
        93de6edbc99204b3e3efc05ca4b6d137d8350f6c	style: Apply slow selector flags before matching
    27f79b1d51018a5b8b737e7b161e7870674971e1	https://github.com/servo/servo/pull/30691	build(deps): bump webxr from `2735ed7` to `21d9e38` (#30691)
        9b56e9591249bfc893a3a1ce23b868f2ea30f866	Update test expectations
        dd372eb5c240db994ab52f67e78e7d2d18983c06	style: Style changes to support the 'page-orientation' property
        9e36918bf030001a17a73e3ef465d8ed37e8258e	Further changes required by Servo
        3076481c52eff296bd784a010cfdf2683107681a	style: Implement selector matching for :nth-child(An+B of selector list) and :nth-last-child(An+B of selector list)
        a973371cf27946fc18d31cd967c67b5308b91ac1	style: Remove non-standard values of caption-side for good
        e38d2369c5b8d8e04c07e677d0e345e38da85bd9	style: Serialization differences with "columns" with one or more `auto` value
        2edc1139b634c7cb83f60332ae916f43aa92f45c	style: [refactor] Migrate NS_STYLE_LIST_STYLE_POSITION_* defines
        39b056cf7098cdde286190d98affd9397623dc9d	style: Move nth-related logic to the NthSelectorData type for reuse
        1c8408e97e7254b3493666007e3e4299a849b36e	style: Implement parsing and serialization for nth-child(An+B of selector list) and :nth-last-child(An+B of selector list)
        b7d64ee6a4579ae38877abd0b2fc163ea09d76cc	style: Animate the 'normal' value of font-style as 'oblique 0deg'
        e51b9b8e1c5ec2157ab6cbd91bed3b8de8f92caa	style: Remove spurious mention of FontStyleAdjust from style/properties/data.py
        2f64ef0d8151663bdc26c98c44c35fbfbc05d70f	style: Compute font-size-adjust early, so that we get the correct used font size for font-dependent units
        425a92143d9fa9f83fb211f95aa6352d1561c6f5	style: Rename scroll-linked (animations) to scroll-driven (excluding WPT tests)
        bc438d725fdcd9ad9df8c47a43271791a2177ab5	style: Minor clean-ups and fixes on top of the previous patch
        211761ad883d579d8f582cde1499ca61ef2d3447	style: Represent FirstChild, FirstOfType, LastChild, LastOfType, OnlyChild, and OnlyOfType as functionless Nth variants
        dc225e0b2ffb2a2cc8d9df9a1c8975d11f11a099	style: [refactor] Migrate NS_STYLE_MASONRY_* defines
        281ae0748f29994e96590e26be53fac7c3db5997	style: Store values for :nth- selectors in dedicated struct NthSelectorData
        b373d9c1c4fbd3e0cb79e6c7cd02679f0982c5bf	Further changes required by Servo
        65e8b71b0ff284b03f9512208b4c03a4fd7cdb4a	style: Compute column-rule-width to 0 when column-rule-style is none
        7ce706f891ebcf17bf193d8eb87dea506b3bb73f	Further changes required by Servo
        18b9e1b615c583ccce13552102ab517a77005f39	style: Use used, rather than computed font-size for font-metric dependent units
        d30400d3ea6c057f112c6b502415e96bf55ce0ce	style: Fix container orientation evaluation
        2389650734c31c8cbe7294f0b4ebec11fecf4ddc	Further changes required by Servo
        92742f7f9098ac5bb2eb0408ca543c7bd69a71a2	style: Avoid generic soup and extra reference count bumps
        cceb538eb0b9dde301d78b43907dd41dd6a292ab	style: Update darling to 0.14.2
        58600c7854a5932ac05fcb2f3998099e65073fd2	Further changes required by Servo
        042864d34a69e4e30a3a492f5aa477cccaaa7340	style: Implement overflow: overlay as an alias on auto, and enable on Nightly
        40f5dbb1abe24afd852808b5cb84d0e25ff3ebff	style: Fix container units on ::backdrop
        a685297bf3696789cef09dc406de4d8bb0d6c526	style: Implement the color-gamut media feature
        65fbb16bb4857c2d25c6f560f32cce60fddebe58	style: Partial fix for container units in pseudo-elements
        16207872f991f119843f675df9dde8edcf42b13f	style: [refactor] Migrate NS_STYLE_TEXT_DECORATION_STYLE_* defines
        6751b84bab90c9fecb1eb318fd2df8e3132600fc	Further changes required by Servo
        9a862da88ff102ffb42f3835fb9c9276e77bb5b6	style: Properly handle ::backdrop
        b9e38017e75e0431e82fdbcf39b882b26dfc9b2f	Further changes required by Servo
        661e7d5c48df3a340de1ed48766445b66a09bbd7	style: Fix elements not being query containers for the pseudo-element they originate. r=emilio
        c511b9c3f991d157cef6a2016f7574cd7368a121	style: Unconditionally enable container properties in UA sheets
        c31db1c9372be4d0480371719b045fa0b97d2846	style: Lint container_rule.rs
        12903c51d50338bba3421d64b2a765300d1ff516	Further changes required by Servo
        c4b8e451ed25cba70a33e6f91406d5fd443959e1	style: Re-evaluate container queries when container gets display:contents
        cd50d30c31f24452c7edcda53c0d906e910c0a54	style: Fix outline-style: inherit behavior if you don't specify outline-width
        db4dd48d31bd811ddebab605af2dafd7d018a44a	style: Remove the about:config pref for subgrid, layout.css.grid-template-subgrid-value.enabled, since it's been default-enabled for years
        a478c1bf906b074ef2bb011f3fe5b376adfa55df	style: Don't share style for cousins that are using Container Queries
        6a6658801f7a77fb9bb41d785c5f7ed46e734cce	style: followup - revert the serialization change, and instead fix the test to expect lowercase
        e7dc4a47cb2ad52a9d3e40b9c47687f1f947b867	style: Serialize font-face src tech() keywords in mixed-case to match the spec; fix the associated WPT test to do case-insensitive comparisons
        6162f82c6b22948a9857e9788e253ea96a89e5a0	style: Remove 'font-palette' from the 'font' shorthand
        37c2d4d30a55a61c6f06cea4366e85a25fdbcead	style: [refactor] Migrate NS_STYLE_LIST_STYLE_* defines
        e19c955c1ce6cd3b45d67c8b124f8e36fa9ce1fd	Further changes required by Servo
        0c36795e204bb43d65e61faaab7a1d3bb65ce5e4	style: Evaluate size feature to unknown if the container lacks size containment
        1beb9880a9b2815b523a9ab6d35535a5d83b8cc9	Further changes required by Servo
        6ea75b064689c7967caff7161110efcafd4946e4	style: Parse errors in individual @font-face src components should cause only the bad component to be dropped, not the entire descriptor
        d2bb508272396ae97bac52b1b798d5a8070a52b8	Further changes required by Servo
        647d813c6b480b8f3f97d1447e20b2c844d0db83	style: @container(width:0) shouldn't match elements with no box
        6c02e9fdaa541084ff8056d8e20bf1819e449c28	style: Implement Kleene logic for query feature expressions
        134f6805038dbef14f241e8a48a57bc9abdbd304	Further changes required by Servo
        748dd1eae2c734f7b6d7f986a0106a979c0fd824	style: Make container queries check content-box size
        f11e232a538d6afca54a5d1a55fd327cd4f57d66	Further changes required by Servo
        7ec4c53266c53221e89644bf1d6ebef972701177	style: Fix style containment not triggered by 'contain'
        60bd00980dcf13f5762822d4d61748bf9f751cf1	style: Speed up dom iteration in querySelector
        b6d9b77a1581b8fb0a28f080766f560cff5dbc46	style: Speed up selector matching with already-lowercase local name selectors
        dbba87d73e05a306a10cca2e8e754cc6d0aaf502	style: Implement Buttonborder/mark/marktext
        1a04ce81a6ed3bc803d824ae537cc60540f6e8c7	style: Remove explicit rust target for bindgen in stylo
        11313368ac99de65bb357aa13ba5a124e690b252	style: Remove non-standard and unused system font values
        bf593a81ed95dd2afd1199ceb88e7ecc626f421a	style: Upgrade bindgen to 0.63.0
        020ba9e7494a78b815d364992f18649b7052cdfb	style: Follow-up clean-ups and tweaks
        bee44a52597d2b5ffee6248ab368ba86bb173258	style: Add parsing for <general-enclosed> in queries conditions
        a298c296e4291ce00bb536898e5f489dc99cd438	Further changes required by Servo
        e55c03c8ff2e4344913bb4b43e870cc9f913d3cf	style: Implement CSS mod() and rem() functions
        653b37f80aec196067e2cdf7108eee32221767fe	style: Green up and re-enable style system layout tests
        62dddfb2a69a23f17224c81db65d41404e574836	style: Alias -webkit-clip-path to clip-path for webcompat
        cc30a418a3d94894c95f685088ab1bab05c0af64	style: Remove unused -moz-window-frame appearance constants
        ea04827f05296959f0ad0fa2c0f89c2e4211b4ce	style: Use root element font size for rem calculation in Container queries
        4b9fc07522c20acd4c87e7983e2a34714664df0c	style: [refactor] Migrate NS_STYLE_UNICODE_BIDI_* defines
        f9c55a2971376b0c35c9ad7b6276d767ac12b2e4	style: Exclude 'size' from the 'all' shorthand
        63c3d36d2849731ad54e44ebb62ebc2329209594	style: Remove appearance: -moz-win-glass, which is unused
        d53696e45223ede8898def11757271b18d971674	Further changes required by Servo
        57da2712d063bd5967787c418e1e1f2649456d7c	style: Implement label[value] and start/end cropping with CSS rather than XUL layout
        aee17ed05c1788abcfbf4b57a8f84805e8cc91ba	style: container-queries: Stop restrict none/auto/normal from <custom-ident>
        717e4acefb507d5be595309a14462d0f99e0f8e2	style: [refactor] Migrate NS_STYLE_TEXT_COMBINE_UPRIGHT_* defines
        2a7055a8fff6ec5f16e960b803a414e5d83e9e0f	style: Remove unused std::ops::Rem implementations
        91626808e9740cdf74d63d895de4103baacb93d4	style: Remove display: -moz-popup
    fd5f04c18ee0c78ddaccf95caae2912329e8fab0	Use runner provided python
+++ f4d3af296c05260dfbb3deea4f8fa400cb6887d3	https://github.com/servo/servo/pull/30507	Move `*_traits` and other shared types to `shared`
    863529d9622c68f0a9535225237eb5e5c5b8c757	Mark two css-paint-api tests as a flaky PASS, TIMEOUT
        22f877c6ab1561e19ca26f4f1e1f2ee5312455f9	Update test expectations
        8193fb398534b6685d3e3d8ec7e0dda53b5e11a1	style: Check that we do not insert more than MAX_GRID_LINE subgrid line name lists while constructing the list
        e520c3796df6b6381b2e7d96477ed620d15f0a67	style: Make panel animations a LookAndFeel int
        a4d2beecd36054a2c9d6dfda3738e69e75ffce9e	Further changes required by Servo
        6a4a97ad7c9dd2a08169e91e6134d48740072984	style: Implement CSS round() function
        17d33183c26b89492ab59706eb14051d067006b9	style: Fix serialization of the font-variant shorthand when font-variant-emoji is preffed off
        8ffe78e5116e4f47294b1bfd2ed02e53f27246c7	style: Don't bother preserving authored colors for canvas
        81ae588ec94bd7112aebe623873448966a51ffd2	style: Fix container query evaluation on unsupported axis
        aba0a4bce07c455e38a143793a677d8164e0fafd	style: Only a single name allowed in @container rule
        2c1799a8dfc79f2bd2f74741004518d68d64644f	style: Rename page::PageOrientation to page::PageSizeOrientation
        b2ab136cd929f8eafefaf6129e2c0ad2b4674daa	style: Simplify container-type implementation
        8a5ba3fe161c1ec4eeadf0d209e8e8eab90c42cd	Further changes required by Servo
        efdf518acc5962f3c348bd9834ac650ae81ec882	style: Remove system font support for various font longhands
        3c4d198ad7e2fecd967a3e40331b542357c87316	style: Don't propagate bits for children invalidated under display:none/not in the flat tree
        8dcf5cddca211feb6cce5cb203dd351f18a9c90b	style: Change NS_STYLE_MATH_STYLE_* macros to enum StyleMathStyle
        8149cd4a0ca48879d755bdfbb4d3d5e95400168c	style: Add support for the CSS font-variant-emoji property to the style system
        14eece6f5aa7a33883384e2b739c4a6d2a51f90c	style: Container Relative Units: Set flag for `USES_VIEWPORT_UNITS` only when viewport fallback is actually used
        15cf28815e7b3778af48d122bd368b0f627fe275	style: Invalidate viewport units on container-queries properly
        b8c0a898adbaec9e0f1ef6bd9ac8e0b09aee9318	Further changes required by Servo
        5ded58a2b190f1295affc84ad1b8963be82c2efb	style: Allow propagating computed style bits from the selector-matching process
        bfa293c5c5c48e8792881441093dde722aae6496	style: Split in_media_query and in_container_query bits from computed::Context
        d21aa99252f69171595595cffe95c569065dda59	Further changes required by Servo
        a62f6c78b24df339e4a328fc00ddb78d825dc73d	style: Make a wrapper struct for extra matching data
        b89c2be4bd35003a67e2183c61fe6f9feca4b522	style: @container rules should support not without parentheses
        f14f1fa44062f2272437bb73860dce0d6e1e38e9	style: fix invalidation of sibling combinators in different slots
        6cb665df9543860b639b8bddcabad8c5f82a8c3e	style: Rematch all descendants when `container-type` changes
        27958b191a2084f1ff7962ffa66b22f8e7d215eb	style: Enable lookup and computation of container size queries
        5cbb81a0df8d6f24732fe5aa1c5c0f6a62fee412	style: Flag computed styles of elements with `container-type: *size` set & propagate them to their descendants
        3acb103324d68738b773f4e16a7fe96c4e93b0d5	style: Centralize construction of `computed::Context`
        d8785f3a220dd61bb9a578c8ba94591acd4dad48	style: Implement parsing of container relative lengths
        4dd841a0366cef8bb08a796df51045e8737af209	style: Make vertical writing mode (left/right) in text-emphasis-position optional
        d4742aefb9863a3e9dbe998ab38a6ed0bc86bb1d	style: disable lquote/rquote attributes on the <ms> element
        444dc23e00cfc2d3407d31a2d1a94d0c35062494	Further changes required by Servo
        fc10c6477930b874dc5d1965e3570eb5aaef4bb0	style: Connect CSS font-palette features to rendering via the presContext
        d5e3a4e3a6646c989ad5ecf3eb1313ac625c9383	Further changes required by Servo
        6a98b777e0f31f534d328181147ca4e4303ccb58	style: CSS support for the font-palette property
        38caec4f89c53d99e89b7356c0621f915058ed46	Further changes required by Servo
        a4ad5e19b0ec17d7e55e468cd9370fe7996b8bc9	style: Implement CSS parsing for the @font-palette-values rule
        ab4580e112ef2c4e2afb13296b73d17940b86004	style: More rename and clean up related to StyleClear
        fea3f9fbc18e2dbf9de2cf1b3b1099f0828b8abb	style: Move clear property out of gecko.mako.rs
        f4e10192ca79e9c81ac56719647f2d45d19ff4be	style: Remove StyleClear::Line
        3da52edffc2e28db2271826b0dce96e0a08c6847	style: Run "cargo +nightly fmt" for style components in servo
        1a9198a5ef59cbaf2417133076352cd2be0a801d	style: Convert text-emphasis-position #defines to enum classes
        6cfdd989d5c5d268d6e6c72df444075e2872b933	style: Implement <tabpanels> and <deck> without XUL layout
        6fa8160633b1453c1e7009de9f32ec6139fc700a	Further changes required by Servo
        de396d9766e5a22131646ac5f5dcc8168ea08a65	style: Drop @scroll-timeline rule entirely
        4b736595d72f7d62ee039be04f66985d86c08d24	style: Drop the usage of @scroll-timeline from animation builder
        8a63d9e059ae5ad3bde9dcb167fdd1567d52eb4a	style: Simplify our setup for font metric queries from style
        99d588a90ebc05618bd055fe2cb77de99ff45035	style: Honor currentColor in HCM
        f1bf68ef25d4419c8f515e2a6f9225d608a1a93f	style: Rename initial value of `container-type' from 'none' to 'normal'
        3fc54c24e2bb96514e72873f93b14ed2ece1cc15	style: Disallow 'not', 'and', and 'or' from <container-name>
        f9f5283a65ac22ef5099db264231701ba8216754	style: React to font-size changes on query containers
        00c9d9d0339f26c64b3baf137eceaee66365a4e9	style: Add CSSContainerRule.queryContainerFor(Element)
        ccad16b5601f044cba721f2139b0d964019232bc	style: Allow backplating if there's a background-image which is `none`
        3cad1db7f9fed022952cef238d9c88833a7cfce0	Further changes required by Servo
        b7773d02d2313fd955f5cb4ba9ab8a002042910a	style: Make anonymous box wrapping inside XUL boxes be similar to modern flex boxes
        319dca535123636e58edf4c8ae3077450241dbdb	style: Remove layout.css.webkit-line-clamp.enabled, and add a new pref to apply line-clamp to all BFCs
        6dafc18b67c5fc3b95099a18e5f54f7422902055	Further changes required by Servo
        0dfd45ba2153bda841a32a48938ecadfeb3f1999	style: Make -webkit-line-clamp create a block container in the appropriate situations
        069304c99c874d9843da1a1d004e8d769db8fc3b	style: Remove @supports selector pref. r=firefox-style-system-reviewers,layout-reviewers,boris
        98d10f954bf8558704b115e6e2c9ff11919d3e0e	Further changes required by Servo
        9f6341b83a088e7062f7915e113acd2bd512162e	style: Disallow forgiving selector-parsing in @supports
        ab36c8a39bba7e21e77d93da94ef5a21bfe3e122	style: Make maction/semantics elements behave as an mrow with the first child
        2edb1517822a5151c6a56061bae830bd2840e6b2	style: Do not reset font-weight/font-style when mathvariant is specified
        d130831877f9557699ee5116f2c695b60255e4f1	style: Fix typo to avoid devtools property-db failures
        a44db174320144f73a376a21e2ea18499fd558d7	style: Move line-clamp out of mako and do some adjacent clean-up
        3fa76ff2e8e251317fbbb76b7d1c2eafe12cfe24	style: Update font-tech feature-* keywords to features-*, as per editorial fix in the spec
        5c3e8cade4d47d02409f27f1d6df7883a8fe3009	Further changes required by Servo
        f196c1910622ee061adf70bc6e255c788d5cda20	style: Use ScriptPercentScaleDown and ScriptScriptPercentScaleDown constants
        12a2c886056f18d68ded2d10850a1eadd268a94d	style: 0% values are not skipped when parsing CSS transform
        aefbae5f96430249e468a164e4d52dfc222c9159	style: Improve CSS OM for CSSContainerRule
+++ b268936308177c5cbe4d58d26f7aa1a87b2841c8	https://github.com/servo/servo/pull/30162	ci: use ubuntu 22.04 on linux runners (#30162)
>>> 2023-11-16T06:06:41Z
    1d905e28f45cd2ff89f5812c26ab54f9aad5938c	https://github.com/servo/servo/pull/30736	build(deps): bump termcolor from 1.3.0 to 1.4.0 (#30736)
    b25c2ffd28bd0ef8057999c3b7bfa37eaccb310e	https://github.com/servo/servo/pull/30737	build(deps): bump rustix from 0.38.21 to 0.38.23 (#30737)
    3fc584d1a16f9abeeab4daa10ad98cf62069ad6b	https://github.com/servo/servo/pull/30724	Sync WPT with upstream (12-11-2023) (#30724)
>>> 2023-11-17T06:05:18Z
    378fdbe225344495052293f35cbc7d97d0a74fd8	https://github.com/servo/servo/pull/30744	build(deps): bump errno from 0.3.6 to 0.3.7 (#30744)
    b92c6238e6e1c918fdfdb4c3cd3b339e1902aa60	https://github.com/servo/servo/pull/30738	build(deps): bump rustix from 0.38.23 to 0.38.24 (#30738)
>>> 2023-11-19T05:58:36Z
    7086dd8f487c2a456456fd34a2815f25c8bcc480	https://github.com/servo/servo/pull/30747	build(deps): bump rustls from 0.21.8 to 0.21.9 (#30747)
    7c8ac54404cb5970d05f4c74cc522fb2ddac113d	https://github.com/servo/servo/pull/30746	build(deps): bump etagere from 0.2.9 to 0.2.10 (#30746)
+++ e83e7ded6e9d00a1079b00bd3b1c6c2d072b827f	https://github.com/servo/servo/pull/30745	Remove use of proc_macro_diagnostics feature (#30745)
+++ 8de4629a3c769e78c47a163326f045ca53ed6298	https://github.com/servo/servo/pull/30742	Remove usage of `drain_filter` (#30742)
    50732b49c5ad3937cf2b8f94e86a9efa1f2ce4de	https://github.com/servo/servo/pull/30743	Remove Servo `window.trap()` extension (#30743)
>>> 2023-11-20T05:57:48Z
    334c67a3cc27649a0e02b107ed19c99ed6b75c93	https://github.com/servo/servo/pull/30753	Update web-platform-tests to revision b'7aaad11d87d7a02515081e55609d31ab6ff173fc' (#30753)
>>> 2023-11-21T06:12:22Z
    ec4ff3b690150df8c69e40c7b4546d750305e1f6	https://github.com/servo/servo/pull/30761	build(deps): bump rustix from 0.38.24 to 0.38.25 (#30761)
+++ 61af8fb56d77f0023e8aeeb5641c680e7133c7f2	https://github.com/servo/servo/pull/30752	Enable new color functions from CSS Color 4 (#30752)
    868d84d8eebc83416e60acfc4b375ceeb5172a28	https://github.com/servo/servo/pull/30716	Retry smoketest on mac (#30716)
    3543a875923ce90bf218cda7b025702ca5200ffb	https://github.com/servo/servo/pull/30754	Allow currentColor in canvas context's shadowColor (#30754)
>>> 2023-11-23T05:54:09Z
    604d785bada14881766934eb328c6fbd4ddd5315	https://github.com/servo/servo/pull/30762	Update Servo::handle_events to take IntoIterator (#30762)
    7a5854693e39c7c3b4d22214e56bd545f5e3bb02	https://github.com/servo/servo/pull/30766	Retry packaged smoketest on mac (#30766)
    3be78096efc8eb9280f33d0b32e11ca8eac6ec98	https://github.com/servo/servo/pull/30764	build(deps): bump serde from 1.0.192 to 1.0.193 (#30764)
        2b0a64b087d837796eb0ba88abf12796ac640efa	Update test expectations
        d74a16d2ed128d02d6d8b795ebacbb7373bf5d55	Disable formatting for malloc_size_of, servo_arc, to_shmem
        e18675401ec236a634246a84d40a062c2a49fd4f	style: Remove HasFFI as well
        42cbb9d3cf291896b4a2cedf1b13ebad6ff4a8fb	style: Remove HasSimpleFFI
        19e037d9219d8aa1a6e1bed8a99ff413c63dc9e4	style: Remove HasBoxFFI
        1a49d8c79f50d5837e3af1e09cdd43f9bc829dd5	Further changes required by Servo
        9ac97dd8ad05f6f325152a0be22b5d62ec02d778	style: when iterating over a selector to find a bucket, choose the rightmost
        303ea410e20a029e55427af11d28f770d982f5ee	style: Support self keyword for scroll()
        f96c75c8d0aea0b6b04e87369cbfb5853b4ef89a	style: Update the syntax of scroll() to accept <scroller> and <axis> in any order
        a27f477c7d996a0123ffb24fefc9209f246b3801	style: Rework -x-text-zoom to allow disabling text zoom and min-font-size separately
        a6b97563c383e091264ccc650a894638c415eec5	style: Add negate node to use in place of mul_by in sum nodes
        9fd6f09a41c0d50da74ddf86e5278dec7c7963d5	style: Add animation-timeline: view() in style system
        115a45f8ebd99eef3a3fa4b3c2f99e476ab27c8e	Further changes required by Servo
        b1bcb22650e4de4973088e9587a534082ba10daa	style: Move animation-related values from box.rs/ui.rs to animation.rs
        1816d7750ff192e0fa7317dd57e8ca54c8f63f82	Further changes required by Servo
        a5b85ec83424dceb8e365769c6664a5cc9e06811	style: Refactor ImportLayer into enum
        2e713d436636ce8ef49937f61c00206153caefee	style: Serialize NaN and infinity percentages correctly
        d44f772dc37952c7e058851c942b66798493b5ed	Further changes required by Servo
        6f090b8a85a44d2e46d4bc60b3b3464d23a9cdc6	style: [css-nesting] Update cssparser to allow parsing qualified rules along with declaration
        93e07111944f78eaceeebae3b00077e9871f316b	style: [css-nesting] Process nested rules at cascade data rebuild
        f9a48e15aae7c1244b0db77d687eaa88f8324d79	Further changes required by Servo
        d4e12b9db662422f6f11c23b76e5e365eede2a63	style: [css-nesting] Add storage for nested rules
        1182296c4b1ce682f170bc5398a92a01f425b2e9	style: Enable all math functions on chrome code
        a523fffc9ea694632c0d4a747ae2cbba982c125c	Further changes required by Servo
        e91a0d8b96d8bcab6b1ee362c72e83a31343fb36	style: Share code to parse @import layer + supports()
        5671b9f0250a19e27b584bbcd48d8689d1685ead	style: Fix @import supports() parsing position
        0c246b0b7c76cd7acc273372ff535658dc2625fd	style: Fix @import serialization order
        5d59674c8a4821869444b122bda3e1432ddba2f0	style: Use more non-native rendering of menus
        9dfa7fb13633573d56343c71c9e7e6d725261714	style: Implement CSS and rendering (but not copy/paste) support for the (non-standard) -webkit-text-security property
        bedf5740927b9d5595daef61f92e9120c93fbddb	style: Avoid linear search to check for custom property presence
        9a97080dbb2c51583cb6b6f656be57cb2b0327d9	style: Replace popover's ':open' and ':closed' pseudo-classes with ':popover-open'
        bc82d005aed65631c1bc066ce776999a4c8bc2ef	style: Remove cascade layers pref
        9ce567d7fe140d11100d8a98763fb11ad66f0ab1	Further changes required by Servo
        1ac62a4ce8891d4c62af8dea326e61b000e7545d	style: Implement supports() syntax for @import rules
        b844a4e99247428fe3a164d63738a5ee51faffc7	Further changes required by Servo
        0709e13446ed186d6868e82887ebda4850c69365	style: Allow to use ThinVec/nsTArray in the style crate
        a2df8f7ea5e76e7753d9649b7dfb1b0329510078	style: Accept a comma-separated list of language codes in the :lang() pseudo
        13e2d104748b398776e16225024a0717e5c82627	style: Implement inverted-colors media feature
        dcfef6cdbb8b4ac099a8b7d66eac269d45e8881c	style: Remove MatchingContext mutability FIXME that no longer applies
        5dd35ac6cd4ff3d21b8eba55e3676a2dc3467ee7	style: Simplify NAC setup
        0917ee3f9b2fd777c1cafea75133dce422aca105	style: Fix some spec links
        38faddd687f8326ebc9229d97f0b60f1bc69eab0	style: Update bindgen to 0.64
        0748fd9582a6a8776a48b9acbfb81b411fe58b5c	style: Remove a bunch of now completely dead XUL layout code
        46a569ef4595609ed0324df458324054a66738d6	style: Implement scripting media feature
        d2217be803b16e28ff2a1573653fed87e79cc3a7	style: CSS comp funcs should handle NaN contagiously
        191c7cdb780a7a8870445a42dbfd54a66a48463d	style: Remove layout.css.d-property.enabled
        78c1c53ccd21380a977e62102802de7f55ca57ac	style: Restyle pseudo-elements as well on part attribute changes
        398df68d38b20572769388ef39eb710fd41d6f4c	style: Minor clean ups on top of the previous patch
        241e6e256fc4e048bcb1e8a972475541f60d9680	style: Refactor mul_by fn into map fn
        a5f696b90dbbdf0958057eff8d231c9fd5e73b97	style: Use auto as the initial value for view-timeline-inset
        6db3b1158c22a983b8171949c2753557a55e50c0	style: Update UA stylesheet for popover
        4d62fec376deaca98de182a11bc4ad8c948d7e7d	style: Reuse declaration block with SVG presentation attributes
        7d123316260cc6751880b7a925b26fbf0fb0e839	style: Optimize [id=foo] as #foo in querySelector/All
        536b3d603bd1efdf23b85aab32b19bca0f20d0b5	style: Check that the lowercase attribute is different before trying to track it
        4804e8dd94502833102cb7819ed6420476b843c1	Further changes required by Servo
        f3402e6144307bc9de78f7a6cd0cfe52a495bc76	style: Color interpolation takes none keyword into account
        11414d0c94e3c6ec8cb8da545881345b4ed6fc5e	Further changes required by Servo
        fb4501c5b48b12b57c5a431a1ba06c3b3f41604c	style: Allow 'none' keyword in color components
        3756e3b02718d70fd392abcdde9f947238681378	style: `:has` relative selector matching, with no caching/filtering
        a68766197fd9df4524ef2c31a0bdd4e005a8b168	style: Add (unused for now) parsing for support conditions in @import
        3914ff627e30ca7e4a72e816749d0f42a46bc983	Further changes required by Servo
        356e886d26b75611224bacb5c13cea23dd7f271e	style: Record attribute dependencies within the selector list of :nth-child(... of <selector list>)
        c7f884566514055ad79c4475955cff4f72306865	Further changes required by Servo
        744b21e72a00f9fdb27e6bb52a4a010155aa7067	style: Apply selector flags to the shadow root
        11a04d9d93635a0145c65e1eb81a3b61c9255bb3	style: Support rendering content: <gradient> images
        0e5eca1f005c59f8f6c5c427639ad2892e737f26	style: Implement prefers-reduced-transparency media query
        9509f84bc03e6951db8aab6d64e11b4ea45bd6ea	style: Simplify/remove a couple other length operations
        52f1a680d51f0dda74af5759c0e221eb68db0839	style: Fix a couple minor issues with the previous patch
        571f8a8dd556d2078506f14bd341e216950366ef	style: Serialize NaN and infinity lengths
        2dad1f0fd7bdca70acacb0c1e22e11ef2a54736c	style: Infinity angles should degenerate compute to 0
        23d6ecfc572a3c5ec742c7b7429fe510e744436b	style: Rustfmt recent changes to calc.rs
        2c986f00057afc2c74a66dba302e90c026e56a8e	style: Add resolution support to calc()
        76e8eeda72b6488b8958ba9431b12025d59f84a9	style: Make image-set without valid images render nothing
        29105eeb4910daacbf90ae0e4ec3c243f85022fa	style: Re-define CoordPair struct
        29a9f0da46af485768293d847f6feb699445f6a8	style: Add popover attribute and part of basic popover functionality
        3ded7ff273232c6a50f8680169395a0e30fdc294	style: Parse and serialize NaN and infinity times correctly
        9a6b46aebd5529a27467ed46b45abb429547d4df	Further changes required by Servo
        3390b77281bd7c65054b623ff4e4007918b1890a	style: Create timeline objects when mutating scroll-timeline property
        532d769e27db0b60dae3e1f4b5c9302e471309bf	Further changes required by Servo
        cfb7a9a108fbc24f53a74995789cdfe369f0fd48	style: Be consistent for which URIs we expose chrome rules
        664e44385e56bfecc72795f678f2161e49768b29	Further changes required by Servo
        f7b29ac4329d697c3aedc79428a1230fb7f9ee6b	style: Parsing for relative selectors in `:has()`
        b6db94bdf5fdb59550380a0b0b3f418afb01965f	Further changes required by Servo
        8c1c4073e250502822604c71fcaab9c183e4372a	style: Convert RGBA to AbsoluteColor for computed/animated/resolved CSS colors
        3763d9a6cc463b12ab86db41ca33ba76820430e2	style: Fix clippy warnings
+++ 35b4641bf91ed932919d543bfb7deba599174adb	https://github.com/servo/servo/pull/30756	Add a concurrency group to try jobs (#30756)
    76569daa620a2c449323273e0ea5b45467500543	https://github.com/servo/servo/pull/30759	build(deps): bump uuid from 1.5.0 to 1.6.1 (#30759)
>>> 2023-11-24T06:00:28Z
    f967d3c4fd68134c72e75dca2c2941ec402412d5	https://github.com/servo/servo/pull/30777	build(deps): bump percent-encoding from 2.3.0 to 2.3.1 (#30777)
    0d91f4d6167de567b52f43345fc1d8a9a5cfaa8d	https://github.com/servo/servo/pull/30776	build(deps): bump form_urlencoded from 1.2.0 to 1.2.1 (#30776)
    8e7beef83589099270fb1bc6a86aa91586eb0750	https://github.com/servo/servo/pull/30774	build(deps): bump webpki-roots from 0.25.2 to 0.25.3 (#30774)
    e3e1195329956c4d51630fc75f0036c6e7f918c6	https://github.com/servo/servo/pull/30769	build(deps): bump data-encoding from 2.4.0 to 2.5.0 (#30769)
    b5bd416f7cdd8d01b674d8838f3d52654332cf74	https://github.com/servo/servo/pull/30768	Make CSSConditionRule's conditionText readonly (#30768)
>>> 2023-11-25T05:58:07Z
    5d7ed76b79de359ef1de2bdee83b32bd497d7cd8	https://github.com/servo/servo/pull/30780	build(deps): bump gimli from 0.28.0 to 0.28.1 (#30780)
+++ 69fb7a9a9a9ea57bbb917fc67854963416c84b6e	https://github.com/servo/servo/pull/30771	Update cssparser to 0.31.2 (#30771)
    6dec39e95939699f1cfd11d34b47e5cfbfb9a219	https://github.com/servo/servo/pull/30779	Try to kill XProtect before running Mac CI (#30779)
        5b08febe88fe68e3ffd054100610c5b44b012336	Update test expectations
        27056eb93a3f83abbbc84e0b2f1df034d3e8f99e	Further changes required by Servo
        1ada5e9605600003a81e803eedda69c2b42b4c75	style: Add a query-selector fast path for attribute selectors in the rightmost compound
        de9fb7983aa72da9b531bbe3d004e0b859615d47	style: Speed up / specialize attribute selector-matching
        8c5a028955939e4716d9caa157d0eafa394f3973	Further changes required by Servo
        e59c71d8ef47e2840a474a479f3e0d66807b387a	style: Remove unused TElement::has_attr
        29f617056418eae88d396de82ddaf744766e1774	Further changes required by Servo
        3da2db1c53402cca97234712b8e69ccfc3495d58	style: Remove the never_matches field from attr selectors
        54a783db1746efe4e5c8775cc7cfb69e765c2fb5	style: Add a way to optimize the "attribute in no namespace exists" check
        c36a22a97fa0d28ef5ed787f03e2da9cb93f0bba	style: Don't recompute quirks mode -> case sensitivity over and over
        5b184f448b6da5b9ae00c0df6559f48849f6fa15	style: Fix style invalidation on layer rule insertion
        50d7f882dd92258745938745f23acbbf9a956a15	style: Container units should prevent us from sharing style by rule node
        07d6ec5d4b5226a5eb7725a90a7f94d9831da3eb	style: Remove obsolete comment to add use counter for developing CSS properties
        c1a622cf015fe5d24591195505edc8137831e0c5	Further changes required by Servo
        ae5e0d49d816b219d3817ceab8b994fbe946442f	style: Move `ANCHORS_RELATIVE_SELECTOR` out of nsINode flags
        9321265b38a9c69222d5a45d217e8b299ad6585a	style: Clean up Context::for_non_inherited_property
        1ad176f1bc2dc9d80a3193282a48022e804adc40	Further changes required by Servo
        3da0e44d9865f2b07ecbe2318b9e26d7611ef78a	style: Fix rebase conflict with bug 1837664
        77c541b38a8eb4b1e42dddebbb5507bdd9703219	style: Do not snap -webkit-text-stroke-width to dev pixels
        127e00e48a81a36776e921d39abe84ac252bd412	style: Improve border-image shorthand serialization, and annotate more passes
        733222fffe3c84ddcb62631e12eca24f3ca3193a	Further changes required by Servo
        78f8d575b7aa33dd7f74e79176be8e945c661069	style: Don't allow to share style by rule node for links
        c8ccb52c9e2e8d1d4691820eec57f74e991db92a	style: Improve border shorthand serialization
        cf3d31038c2d5535978fc30fe19926c33d78ec19	style: Minor clean-ups to border shorthand parsing
        7c8cf000333ad883b9b28a60fa6ccd1a251ca5dd	style: Avoid selecting zero-resolution images in image-set
        5842cfc1276b917867e188cbc76776fbe8f3f640	Further changes required by Servo
        42d9ec1106fdbf386ff73ea667ad840f0df44a96	style: Add method to parse CSS filters without context for workers
        a10df24ffbc80d88494ce3b5cd2d318e42a6fa4d	style: Serialize NaN and infinity numbers
        dcb61c095f55088768172b314bcb0bd6a4c5b72f	style: Forbid negative CSS resolutions at parse time
        019c14cf0b1ee73fa7b607bb5072f84227a2f317	style: Make flex-flow serialization interoperable
        abc0c86fef231acd17b268ecc95a7032b5815265	Further changes required by Servo
        d02c4e2fe996791d7e3872169114fec2409ba1b9	style: Remove viewport rule code
        0b75c1d9d1d3169a16a7894de5b5e4f3f55600ff	Further changes required by Servo
        23d60c21951af2211dd6c3dd4203c78b19add193	style: Unify parallel and sequential traversal scheduling
        7771cf25a867338b0e3adc1ef64ba8d2e69e4339	style: Remove :nth-child(... of) pref
        bcae33a43ff4658051715726bb2f50cf0c20af4f	style: Send offset-position to the compositor
        2fef5d1a17765b96951d2cdf1a4479ab0be74681	style: Add at <position> into ray() in style system
        8b60424e292218934cddd8d21cb8937e9bb792c9	style: Return Err() in to_animated_zero() for offset-path
        52e2cc5ff090ee1a9321de79acb9f9dca2e6deba	style: Change some references to raw pointers in some FFI functions
        e792eba7c76347694c717cc17dd4d7f9e4313ae6	Further changes required by Servo
        9e223342e77147abbd5c1150df4d6237cac20d45	style: Make content-visibility: auto forces contain-intrinsic-size to gain an auto value
        dcbeb2f1ab60a807bbf6a96f936feb9aff072040	Further changes required by Servo
        39bc94a4f732c384f26602da9d797f81912d4804	style: Update serde_with to 3.0.0
        e1b66323134bc4353881bf1f48f914943f856558	style: Update the syntax of offset-position
        0fd2f08da19e1e33e7850c1b2e7c484f9011fbe5	Further changes required by Servo
        7b4fb5dc22e1542be9d92ec0e88a266ad9b1da86	style: Simplify border snapping
        ad72081ac859e31302a21c86c7d688d6c8dfefdd	style: Rustfmt servo/. r=zrhoffman
        68cbe6833d1201ef43c679c5a42192593486a430	Further changes required by Servo
        672815818848a9687ad7320f97aa6b4787825e9a	style: Use non-locked rules for all rule types that can
        0aed54f63648f581193e7e6358afc9e671cb476d	style: [css-properties-values-api] Remove Locked<> from CssRule::Property arc
        cd67a09ac1c050f1cba1fda9adc310eef06ceb54	Further changes required by Servo
        ff8100d3963ac88fa0001bec40472134dbb4394b	style: Correct style sharing handling for any element that considered `:has()` in selector matching
        5c0897c8eb6ef789dd14918b9b427935a244a847	style: [css-properties-values-api] Share PropertyRule instance when cloning CssRule::Property
        48f2f475c60e5958655e223493a7eddf8500995c	style: Flush parent document layout if needed for viewport dependent media queries
        ad81122fcfe27d6d399080d44387743f3c25bd95	style: More gracefully deal with broken calls into selector matching
        b329d547bea5476aaba3af2211e45c1ce51c4a01	style: Properly increase the nesting level when matching :nth-child(of) selectors
        520f851d8c68b710f7d5e3c150cea4cf63c9d12b	style: Simplify some appearance code
        7d72d7c385f385e6fa4515342166d1acf884cf44	Further changes required by Servo
        d49b014c78e77de890e199541759cad0f12a1aa2	style: Make style parallel traversal more tunable at runtime
        ea3fcce25f933e139f786da516ef806d1ed0a109	Further changes required by Servo
        10f8eb423907cf6d19633d7883ed69952cab4bc7	style: Make stylo thread pool size configurable via pref rather than just env
        3a51e530d2698c17a942bb261b3ed17e726953e2	style: Remove overflow-block optional-paged
        8d2ae3f1c5b608e52f64e5a24c6b3933a1c5016f	Further changes required by Servo
        9c46eabe83c5e0de1d4d57f6ce60e29d5eb286bb	style: [css-properties-values-api] Implement parsing and serialization for @property at-rule
        87ce7045ef71a8dd483660438bb122140005c66a	style: [css-properties-values-api] Parsing and serialization for @property syntax descriptor
        8823b6351323cce9f85562b833b42c1a369d061f	style: Remove code that's flagged as to-be-removed once layout.css.always-repaint-on-unvisited is true
        b5deea844249948a1912279112fbec9054f42f54	style: Reject empty svg path string for basic shape path function
        d4aafad560121893920767c0c01f93bd3d35fbd3	Further changes required by Servo
        7c4ec6e9cc2970df7cf127c42e5aa3165d15902f	style: [css-nesting] Do a first pass at parsing nested rules mixed with declarations
        b92440ef7c38a453ef76dba53ecd9ef90c4676af	style: Disable NSCAP_FEATURE_USE_BASE
        7a2b444a6043bb82f83886b66be85d2255bba44e	style: Implement parsing for `baseline-source`
        571136562d7bc64a448e3b5da269f438a5d20ed1	style: Remove the layout.css.named-pages.enabled pref
        f1ae42678a987560f9025abfc3057454834ce0f4	Further changes required by Servo
        920a1c1f087854dfad786b821494e6a0d52d4a56	style: [css-nesting] Update cssparser again
        32f1989a5caa3c63c2bf4ffadc3f159c79bae173	Further changes required by Servo
        ae993e485a8a4cf07cafa95be06bad1816356180	style: Move a bit declaration_block and cascade modules
        9c58f0c635ed45f02098b17f2e49c1f86b699771	style: Disallow :has selector nesting
        9c7e0930c379096710c4707de8b7ccbae11c2b1d	Further changes required by Servo
        d1046739fc9b36f6a9ba3b7cc766716a420ab842	style: Remove some magic from the bindings
        e9bf9773693d132291dc741dc7b79823c9c7eb7e	style: Finish removing HasArcFFI
        3f03650c883c83965222b4a2bf5a89fd4ed68e20	style: Plumb android text scale via nsLookAndFeel
        c2a2113136bb5297bb14a8756d3ed7a143d65923	style: Container units should prevent us from using the rule cache
        af13e670d95b02a45cfc1f896e4cedfd30d4dc4b	style: Clean up length handling
        4b7260d846b7fc8bddea06ac995c0b52f563f153	style: Remove dead GTK menu styling code
        9370172552d2ad95b3c257e9a0e03612de43c453	style: Remove HasArcFFI for AnimationValue
        779aa9d30ec43c043910883dce5988c0b01534bd	style: Remove HasArcFFI for some types
        d9d865e8c9fad5eaaa15be7d3bfbf53df47135ca	style: Add an API to parse an absolute length without any other context
        a69578993aeca0790ffaed95a9fa08375887bfbe	style: display: inline list-item is also a line participant
        00945605417217c11ab8ce159083a07034118c90	Further changes required by Servo
        18c701e6b58a6a431cd808958d993e1a47e4b4b3	style: Hardening color checks
>>> 2023-11-26T05:58:01Z
>>> 2023-11-27T05:54:36Z
-->

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
</style>
