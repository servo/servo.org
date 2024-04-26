---
layout:     post
tags:       blog
title:      "This month in Servo: Acid2 redux, Servo book, Qt demo, and more!"
date:       2024-04-26
summary:    A new layout milestone, revamped docs, faster builds, plus embedding, video, fonts, WebGPU, and CSS improvements.
categories:
---

<figure class="_figr"><a href="{{ '/img/servo-acid2-202404.png' | url }}"><img src="{{ '/img/servo-acid2-202404.png' | url }}"
    style="width: auto;"
    alt="Servo nightly, now rendering Acid2 perfectly"></a>
<figcaption>Servo now renders Acid2 perfectly, but like all browsers, only at 1x dpi.</figcaption></figure>

<span class=_floatmin></span>[Back in November]({{ '/blog/2023/11/30/embedding-floats-color-mix/' | url }}), Servo’s new layout engine passed [Acid1](http://acid1.acidtests.org), and this month, thanks to a bug-squashing sprint by [@mrobinson](https://github.com/mrobinson) and [@Loirooriol](https://github.com/Loirooriol), we now pass [Acid2](https://acid2.acidtests.org)!

<aside class="_note">

Note that Acid2 is only designed to work at 1x dpi, so if you have a HiDPI monitor, be sure to run servoshell with `--device-pixel-ratio 1` to avoid a red pattern over the eyes.
</aside>

We would also like to thank you all for your generous support!
Since we moved to [Open Collective](https://opencollective.com/servo) and [GitHub Sponsors](https://github.com/sponsors/servo) in March, we have received **1578 USD** (after fees), including **1348 USD/month** (before fees) in recurring donations.
This smashed our first two goals, and is a respectable part of the way towards our next goal of 10000 USD/month.
For more details, see our [Sponsorship]({{ '/sponsorship/' | url }}) page and [announcement post]({{ '/blog/2024/03/12/sponsoring-servo/' | url }}).

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 1348 / 10000); padding-left: 0.5em;"><strong>1348</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 1348 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="1348" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

We are still receiving donations from **19 people** on LFX, and we’re working on transferring the balance to our new fund, but we will stop accepting donations there soon — **please move your recurring donations to [GitHub](https://github.com/sponsors/servo) or [Open Collective](https://opencollective.com/servo)**.
As always, use of these funds will be decided transparently in the Technical Steering Committee, starting with the TSC meeting [on 29 April](https://github.com/servo/project/issues/85).

<figure class="_figl"><a href="{{ '/img/blog/servo-book.png' | url }}"><img src="{{ '/img/blog/servo-book.png' | url }}"
    alt="The Servo book, a book much like the Rust book"></a>
</figure>

<span class=_floatmin></span>Servo’s docs are moving to [**the Servo book**](https://book.servo.org), and a very early version of this is now online ([@delan](https://github.com/delan), [servo/book](https://github.com/servo/book))!
The goal is to unify our many sources of documentation, including the [hacking quickstart guide](https://github.com/servo/servo/blob/81c4f2ae7a0b605befae652c0feeea03caba6292/docs/HACKING_QUICKSTART.md), [building Servo page](https://github.com/servo/servo/wiki/Building/e04d7a194b59fad65fbd3eefb7aab12ae3a60eba), [Servo design page](https://github.com/servo/servo/wiki/Design/0941531122361aac8c88d582aa640ec689cdcdd1), and [other in-tree docs and wiki pages](https://book.servo.org/hacking/older-versions.html), into a book that’s richer and easier to search and navigate.

Servo now supports several new features in its nightly builds:

- as of 2024-04-02, `files` setter on HTMLInputElement ([@shanehandley](https://github.com/shanehandley), [#31934](https://github.com/servo/servo/pull/31934))
- as of 2024-04-05, **‘ex’ units** in CSS ([@mrobinson](https://github.com/mrobinson), [#31966](https://github.com/servo/servo/pull/31966))
- as of 2024-04-05, `onSubmittedWorkDone` method on GPUQueue ([@sagudev](https://github.com/sagudev), [#31772](https://github.com/servo/servo/pull/31772))
- as of 2024-04-08, `deleteRow(-1)` on empty HTMLTableElement ([@shanehandley](https://github.com/shanehandley), [#32009](https://github.com/servo/servo/pull/32009))
- as of 2024-04-12, **ElementInternals** and **attachInternals** ([@pshaughn](https://github.com/pshaughn), [@cathiechen](https://github.com/cathiechen), [#25705](https://github.com/servo/servo/pull/25705), [#31980](https://github.com/servo/servo/pull/31980))
- as of 2024-04-16, **‘background-attachment: fixed’** ([@mrobinson](https://github.com/mrobinson), [#32068](https://github.com/servo/servo/pull/32068))
- as of 2024-04-16, **&lt;object>** with **image data URLs** ([@mrobinson](https://github.com/mrobinson), [#32069](https://github.com/servo/servo/pull/32069))
- as of 2024-04-18, **‘clear’** property on **&lt;br>** elements ([@mrobinson](https://github.com/mrobinson), [#32094](https://github.com/servo/servo/pull/32094))
- as of 2024-04-23, basic support for **‘list-style-position: outside’** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#32114](https://github.com/servo/servo/pull/32114))

As of 2024-04-05, we now support **non-autoplay &lt;video>** ([@eerii](https://github.com/eerii), [media#419](https://github.com/servo/media/pull/419), [#32001](https://github.com/servo/servo/pull/32001)), as long as the page provides its own controls, as well as the **‘baseline-source’** property ([@MunishMummadi](https://github.com/MunishMummadi), [#31904](https://github.com/servo/servo/pull/31904), [#31913](https://github.com/servo/servo/pull/31913)).
Both of these contributors started out as Outreachy participants, and we’re thrilled to see their continued work on improving Servo.

We’ve also landed several other rendering improvements:

- **Stylo** is now fully caught up with upstream ([@Loirooriol](https://github.com/Loirooriol), [#31932](https://github.com/servo/servo/pull/31932), [#31991](https://github.com/servo/servo/pull/31991), [#32032](https://github.com/servo/servo/pull/32032), [#32066](https://github.com/servo/servo/pull/32066), [#32089](https://github.com/servo/servo/pull/32089), [#32128](https://github.com/servo/servo/pull/32128))
- elements or frames **no longer scroll to top** when transforms change ([@mrobinson](https://github.com/mrobinson), [#31892](https://github.com/servo/servo/pull/31892))
- fixed **intrinsic sizing** of inline content containing **‘pre-wrap’** ([@Loirooriol](https://github.com/Loirooriol), [#31930](https://github.com/servo/servo/pull/31930))
- fixed **margin collapsing** with indefinite percentages or non-zero height ([@Loirooriol](https://github.com/Loirooriol), [#32059](https://github.com/servo/servo/pull/32059), [#32060](https://github.com/servo/servo/pull/32060))
- fixed some (but not all) **HTTP 400** errors when sending requests to nginx ([@philip-lamb](https://github.com/philip-lamb), [#32024](https://github.com/servo/servo/pull/32024), [#32093](https://github.com/servo/servo/pull/32093))
- fixed **‘min-height’** and **‘max-height’** on elements with **‘float’** ([@Loirooriol](https://github.com/Loirooriol), [#32057](https://github.com/servo/servo/pull/32057))

Our font rendering has improved, with support for selecting the correct weight and style in **indexed fonts (.ttc)** on Linux ([@mukilan](https://github.com/mukilan), [@mrobinson](https://github.com/mrobinson), [#32127](https://github.com/servo/servo/pull/32127)), as well as support for **emoji font fallback** on macOS ([@mrobinson](https://github.com/mrobinson), [#32122](https://github.com/servo/servo/pull/32122)).
Note that color emoji are not yet supported.

Other big changes are coming to Servo’s font loading and rendering, thanks to [@mrobinson](https://github.com/mrobinson)’s **font system redesign** RFC ([#32033](https://github.com/servo/servo/issues/32033)).
Work has already started on this ([@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#32034](https://github.com/servo/servo/pull/32034), [#32038](https://github.com/servo/servo/pull/32038), [#32100](https://github.com/servo/servo/pull/32100), [#32101](https://github.com/servo/servo/pull/32101), [#32115](https://github.com/servo/servo/pull/32115)), with the eventual goal of making font data **zero-copy readable from multiple threads**.
This in turn will fix several major issues with font caching, including cached font data leaking over time and between pages, unnecessary loading from disk, and unnecessary copying to layout.

We’ve also started simplifying the script–layout interface ([@mrobinson](https://github.com/mrobinson), [#31937](https://github.com/servo/servo/pull/31937), [#32081](https://github.com/servo/servo/pull/32081)), since [layout was merged into the script thread]({{ '/blog/2024/02/28/gamepads-font-fallback-space-jam/' | url }}), and script can now call into layout without IPC.

## Embedding and dev changes

<figure class="_figr"><a href="{{ '/img/blog/cxx-qt-servo-webview.png' | url }}"><img src="{{ '/img/blog/cxx-qt-servo-webview.png' | url }}"
    alt="Servo running in a Qt app via CXX-Qt"></a>
<figcaption>The prototype shows that Servo can be integrated with a Qt app via <a href="https://github.com/KDAB/cxx-qt">CXX-Qt</a>.</figcaption></figure>

<span class=_floatmin></span>A prototype for **integrating Servo with Qt** was built by [@ahayzen-kdab](https://github.com/ahayzen-kdab) and [@vimpostor](https://github.com/vimpostor) and [shown at Embedded World 2024](https://www.kdab.com/kdab-at-embedded-world-2024/).
We’re looking forward to incorporating their feedback from this to improve Servo’s embedding API.
For more details, check out [their GitHub repo](https://github.com/KDABLabs/cxx-qt-servo-webview) and [*Embedding the Servo Web Engine in Qt*](https://www.kdab.com/embedding-servo-in-qt/).

Servo now supports **multiple concurrent webviews** ([@wusyong](https://github.com/wusyong), [@delan](https://github.com/delan), [@atbrakhi](https://github.com/atbrakhi), [#31417](https://github.com/servo/servo/pull/31417), [#32067](https://github.com/servo/servo/pull/32067))!
This is a big step towards making Servo a viable embedded webview, and we will soon use it to implement tabbed browsing in servoshell ([@delan](https://github.com/delan), [#31545](https://github.com/servo/servo/pull/31545)).

Three of the slowest crates in the Servo build process are **mozjs_sys**, **mozangle**, and **script**.
The first two compile some very large C++ libraries in their build scripts — SpiderMonkey and ANGLE respectively — and the third blocks on the first two.
They can account for over two minutes of build time, even on a very fast machine (AMD 7950X), and a breaking change in newer versions of GNU Make ([mozjs#375](https://github.com/servo/mozjs/issues/375)) can make mozjs_sys take **over eight minutes** to build!

mozjs_sys now uses a **prebuilt version of SpiderMonkey** by default ([@wusyong](https://github.com/wusyong), [@sagudev](https://github.com/sagudev), [mozjs#450](https://github.com/servo/mozjs/pull/450), [#31824](https://github.com/servo/servo/pull/31824)), **cutting clean build times by over seven minutes** on a very fast machine (see above).
On Linux with Nix (the package manager), where we run an unaffected version of GNU Make, it can still save over 100 seconds on a quad-core CPU with SMT.
Further savings will be possible once we [do the same for mozangle](https://github.com/servo/mozangle/pull/71#issuecomment-1878567207).

If you use NixOS, or any Linux distro with Nix, you can now get a shell with all of the tools and dependencies needed to build and run Servo by typing `nix-shell` ([@delan](https://github.com/delan), [#32035](https://github.com/servo/servo/pull/32035)), without also needing to type `etc/shell.nix`.

As for CI, our experimental Android build now supports aarch64 ([@mukilan](https://github.com/mukilan), [#32137](https://github.com/servo/servo/pull/32137)), in addition to Android on armv7, x86_64, and i686, and we’ve improved flakiness in the WebGPU tests ([@sagudev](https://github.com/sagudev), [#31952](https://github.com/servo/servo/pull/31952)) and macOS builds ([@mrobinson](https://github.com/mrobinson), [#32005](https://github.com/servo/servo/pull/32005)).

## Conferences and events

Earlier this month, Rakhi Sharma gave her talk [**A year of Servo reboot: where are we now?**](https://servo.org/slides/2024-04-16-open-source-summit-NA/) at [Open Source Summit North America](https://events.linuxfoundation.org/open-source-summit-north-america/) ([slides](https://servo.org/slides/2024-04-16-open-source-summit-NA/); recording available soon) and at the [Seattle Rust User Group](https://www.meetup.com/Seattle-Rust-Meetup/) ([slides](https://servo.org/slides/2024-04-16-seattle-rust-user-group/)).

In the Netherlands, Gregory Terzian will be presenting **Modular Servo: Three Paths Forward** at the [GOSIM Conference 2024](https://europe2024.gosim.org/schedule#mobile-and-web-app), on **6 May** at **15:10 local time** (13:10 UTC).
That’s the **same venue as [RustNL 2024](https://2024.rustnl.org)**, just one day earlier, and you can also find Gregory, Rakhi, and Nico at RustNL afterwards.
See you there!

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
        max-width: 100%;
    }
    ._figr {
        float: right;
        max-width: 100%;
    }
    ._figl > figcaption,
    ._figr > figcaption,
    ._figl > iframe,
    ._figr > iframe,
    ._figl > video,
    ._figr > video,
    ._figl > a > img,
    ._figr > a > img {
        width: 21em;
        max-width: 100%;
    }
    ._runin {
        margin-bottom: 1em;
    }
    ._runin > p,
    ._runin > h2 {
        display: inline;
    }
    ._correction {
        max-width: 33em;
        margin: 1em auto;
        border-bottom: 1px solid;
        padding-bottom: 1em;
    }
    ._note {
        margin: 1em 1em;
        border-left: 1px solid;
        padding-left: 1em;
        opacity: 0.75;
    }
</style>
