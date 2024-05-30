---
layout:     post
tags:       blog
title:      "This month in Servo: new CSS units, color emoji, servoshell, and more!"
date:       2024-05-30
summary:    Big changes to the font system and servoshell, plus improvements to flexbox, tables, DOM support, and the embedding API.
categories:
---

<figure class="_figr" style="clear: right;"><a href="{{ '/img/blog/ic-units.png' | url }}"><img src="{{ '/img/blog/ic-units.png' | url }}"
    alt="servoshell with three boxes arranged around a large water radical (水), each the same size as that character by being 1ic x 1ic."></a>
<figcaption>‘ic’ units are now supported.</figcaption></figure>

<span class=_floatmin></span>Servo now supports several CSS features in its nightly builds:

- as of 2024-04-29, **‘start’**, **‘end’**, and **‘space-evenly’** values in **‘align-content’** and **‘justify-content’** ([@nicoburns](https://github.com/nicoburns), [#31724](https://github.com/servo/servo/pull/31724)), in flexbox layouts when the experimental feature is enabled (`--pref layout.flexbox.enabled`)
- as of 2024-04-30, **‘white-space-collapse’**, **‘text-wrap-mode’**, and the new **‘white-space’** shorthand ([@Loirooriol](https://github.com/Loirooriol), [#32146](https://github.com/servo/servo/pull/32146))
- as of 2024-05-03, **‘ch’** and **‘ic’ font-relative units** ([@andreubotella](https://github.com/andreubotella), [#32171](https://github.com/servo/servo/pull/32171))
- as of 2024-05-19, basic support for **‘border-collapse’** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#32309](https://github.com/servo/servo/pull/32309))
- as of 2024-05-22, **‘empty-cells’** ([@Loirooriol](https://github.com/Loirooriol), [#32331](https://github.com/servo/servo/pull/32331))
- as of 2024-05-22, **‘visibility: collapse’** on table parts ([@Loirooriol](https://github.com/Loirooriol), [@mrobinson](https://github.com/mrobinson), [#32333](https://github.com/servo/servo/pull/32333))

<figure class="_figl"><a href="{{ '/img/blog/empty-cells.png' | url }}"><img src="{{ '/img/blog/empty-cells.png' | url }}"
    alt="Two pixel art smileys made from table cells, one with magenta eyes and background"></a>
<figcaption>Left: ‘empty-cells: show’.<br>Right: ‘empty-cells: hide’.</figcaption></figure>

<span class=_floatmin></span>Several DOM properties are now accessible, which should improve compatibility with scripts even though their effects are not yet implemented:

- `value`, `min`, `max`, `low`, `high`, and `optimum` on HTMLMeterElement ([@shanehandley](https://github.com/shanehandley), [#32230](https://github.com/servo/servo/pull/32230))
- `autofocus` on HTMLElement and SVGElement, via HTMLOrSVGElement ([@nolanlawson](https://github.com/nolanlawson), [#32170](https://github.com/servo/servo/pull/32170))
- `role` and 43 other ARIA string properties on Element ([@nolanlawson](https://github.com/nolanlawson), [#32080](https://github.com/servo/servo/pull/32080))

We’ve also landed the first patch towards making Servo’s **event loop comply with the HTML spec** ([@gterzian](https://github.com/gterzian), [#31505](https://github.com/servo/servo/pull/31505)).
This will hopefully address some complex timing issues between the renderer and other kinds of tasks like requestAnimationFrame and ResizeObserver callbacks.

Together with correct sizing for **floating tables** ([@Loirooriol](https://github.com/Loirooriol), [#32150](https://github.com/servo/servo/pull/32150)) and **empty list items** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#32152](https://github.com/servo/servo/pull/32152)), as well as correct **‘line-height’ based on the first font** ([@mrobinson](https://github.com/mrobinson), [#32165](https://github.com/servo/servo/pull/32165)), Servo has made some big strides in the Web Platform Tests this month:

- 90.8% (+1.6pp) in the **CSS2 floats** tests
- 68.7% (+5.7pp) in the **CSS2 and CSS tables** tests
- 53.3% (+4.0pp) in the **CSS text** tests
- 48.8% (+3.3pp) in the **CSS position** tests

## Font system changes

<figure class=_figr>

|   | `sbix` | `CBDT` | `COLR` |
|---|---|---|---|
| Windows | ❌︎ | ❌︎ | ❌︎ |
| macOS | ✅ | ❌︎ | ❌︎ |
| Linux | ❌︎ | ✅ | ❌︎ |

<figcaption>Overview of Servo’s current color emoji support by format and platform.</figcaption>
</figure>

<span class=_floatmin></span>Servo now supports the **‘font-weight’**, **‘font-style’**, **‘font-stretch’**, and **‘unicode-range’ descriptors** in [@font-face](https://github.com/font-face), correctly matching fonts split by ‘unicode-range’ ([@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#32164](https://github.com/servo/servo/pull/32164)) and correctly selecting the nearest weights and styles ([@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#32366](https://github.com/servo/servo/pull/32366)).

We also now support **font fallback on OpenHarmony** ([@jschwe](https://github.com/jschwe), [#32141](https://github.com/servo/servo/pull/32141)), and **bitmap color emoji** on Linux and macOS ([@mrobinson](https://github.com/mrobinson), [#32203](https://github.com/servo/servo/pull/32203), [#32278](https://github.com/servo/servo/pull/32278)).
Note that the layered `COLR` format is not yet supported, and that on macOS, we currently only support `sbix` (like in Apple Color Emoji), not `CBDT` (like in Noto Color Emoji).

Our [font system rework](https://github.com/servo/servo/issues/32033) continues, **saving up to 40 MB of memory** when loading servo.org by sharing font data and metadata across threads ([@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#32205](https://github.com/servo/servo/pull/32205)).
We’ve fixed a bug where web fonts in one document can **clobber fonts with the same name** in other documents ([@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#32303](https://github.com/servo/servo/pull/32303)), and a bug where the **font cache leaks unused web fonts** ([@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#32346](https://github.com/servo/servo/pull/32346)).

## servoshell changes

<figure class="_figr"><a href="{{ '/img/blog/servoshell-status-bar.png' | url }}"><img src="{{ '/img/blog/servoshell-status-bar.png' | url }}"
    alt="servoshell showing the URL of a hovered link at the bottom of the window."></a>
<figcaption>servoshell now shows the URL of hovered links near the bottom of the window.</figcaption></figure>

<span class=_floatmin></span>servoshell now **handles all known keycodes**, passing them to Servo where appropriate ([@Nopey](https://github.com/Nopey), [#32228](https://github.com/servo/servo/pull/32228)), goes back and forward when **pressing the mouse side buttons** ([@Nopey](https://github.com/Nopey), [#32283](https://github.com/servo/servo/pull/32283)), and shows the link URL in a **status tooltip when hovering over links** ([@iterminatorheart](https://github.com/iterminatorheart), [@atbrakhi](https://github.com/atbrakhi), [#32011](https://github.com/servo/servo/pull/32011)).

Adding support for the mouse side buttons required a winit upgrade, but we ultimately ended up embarking on a three-month overhaul to upgrade a bunch of other deps ([@Nopey](https://github.com/Nopey), [@mrobinson](https://github.com/mrobinson), [#31278](https://github.com/servo/servo/pull/31278)), including egui, glow, nix, raqote, font-kit, harfbuzz-sys, core-graphics, core-text, raw-window-handle, and jni ([@delan](https://github.com/delan), [@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#32216](https://github.com/servo/servo/pull/32216))!

This in turn involved upgrading those deps in surfman ([@Nopey](https://github.com/Nopey), [surfman#275](https://github.com/servo/surfman/pull/275), [surfman#280](https://github.com/servo/surfman/pull/280), [surfman#283](https://github.com/servo/surfman/pull/283)), font-kit ([@Nopey](https://github.com/Nopey), [font-kit#234](https://github.com/servo/font-kit/pull/234)), and webrender ([@Nopey](https://github.com/Nopey), [webrender#4838](https://github.com/servo/webrender/pull/4838)), as well as several improvements being contributed upstream:

- servoshell no longer throws **spurious GL_INVALID_ENUM errors on Windows** ([@Nopey](https://github.com/Nopey), [emilk/egui#3994](https://github.com/emilk/egui/pull/3994))
- harfbuzz now builds on Windows when using clang-cl ([@Nopey](https://github.com/Nopey), [harfbuzz/harfbuzz#4585](https://github.com/harfbuzz/harfbuzz/pull/4585), [rust-harfbuzz#248](https://github.com/servo/rust-harfbuzz/pull/248), [rust-harfbuzz#253](https://github.com/servo/rust-harfbuzz/pull/253))
- egui_glow no longer has to depend on an outdated version of raw-window-handle ([@Nopey](https://github.com/Nopey), [emilk/egui#4036](https://github.com/emilk/egui/pull/4036))
- raqote now depends on the latest version of font-kit ([@Nopey](https://github.com/Nopey), [jrmuizel/raqote#200](https://github.com/jrmuizel/raqote/pull/200))

## Other changes

Servo for Android **now builds on aarch64** ([@mukilan](https://github.com/mukilan), [#32137](https://github.com/servo/servo/pull/32137)), **no longer crashes on startup** ([@mukilan](https://github.com/mukilan), [#32273](https://github.com/servo/servo/pull/32273)), and now supports the **SpiderMonkey JIT on 64-bit builds** ([@mukilan](https://github.com/mukilan), [#31134](https://github.com/servo/servo/pull/31134)).

Servo should no longer cause intermittent errors and **panics when exiting** ([@mrobinson](https://github.com/mrobinson), [#32207](https://github.com/servo/servo/pull/32207)), and **ShowWebView** no longer fails if sent too quickly after a webview is created ([@wusyong](https://github.com/wusyong), [#32163](https://github.com/servo/servo/pull/32163)).

We’ve also landed several dev changes:

- You can now pass `--skip-platform` to `mach bootstrap` to **install taplo and crown only** ([@mrobinson](https://github.com/mrobinson), [#32176](https://github.com/servo/servo/pull/32176))
- `mach build` **no longer fails on Windows** due to `STATUS_DLL_NOT_FOUND` in crown ([@sagudev](https://github.com/sagudev), [#32301](https://github.com/servo/servo/pull/32301))
- `mach build` **no longer fails on Windows Server 2019** due to `UnsupportedPlatform` in notifypy ([@delan](https://github.com/delan), [#32352](https://github.com/servo/servo/pull/32352))

## Donations

Thanks again for your generous support!
We are now receiving **1630 USD/month** (+20.9% over April) in recurring donations.
We are still receiving donations from **15 people** on LFX, and we’re working on transferring the balance to our new fund, but we will stop accepting donations there soon — **please move your recurring donations to [GitHub](https://github.com/sponsors/servo) or [Open Collective](https://opencollective.com/servo)**.

As always, use of these funds will be decided transparently in the Technical Steering Committee.
[Our first proposal](https://github.com/servo/project/issues/88#issuecomment-2134485100) hopes to spend some of these funds on a **dedicated CI server**, which should make tryjobs and merge builds much faster!

We’ve also updated our [Sponsorship page]({{ '/sponsorship/' | url }}) with advice about how to make your donations most effective.
In short, donating via GitHub Sponsors is the best option, with 96% of the amount going to Servo in almost all cases.
Donations on Open Collective give Servo around 80% to 90%, depending on the amount and payment method.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 1630 / 10000); padding-left: 0.5em;"><strong>1630</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 1630 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="1630" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

## Conferences and events

Recordings are now available for three recent talks about Servo:

- [**A year of Servo reboot: where are we now?**](https://www.youtube.com/watch?v=RdtlD_7JAs8) ([slides](https://servo.org/slides/2024-04-16-open-source-summit-NA/), [transcript](https://www.atbrakhi.dev/blog/oss-north-america)) by Rakhi Sharma, at [Open Source Summit North America](https://events.linuxfoundation.org/open-source-summit-north-america/)
- [**Modular Servo: Three Paths Forward**](https://www.youtube.com/watch?v=EA_1jxzR85M) ([slides](/slides/2024-05-06-modular-servo.pdf)) by Gregory Terzian, at [GOSIM Conference 2024](https://europe2024.gosim.org/schedule#mobile-and-web-app)
- A talk that discusses [**porting Servo to OpenHarmony OS**](https://www.youtube.com/watch?v=MOhxXhUmgPM) ([slides](/slides/2024-05-06-openharmony-os-for-next-gen-mobile.pdf)) by Jonathan Schwender, at [GOSIM Conference 2024](https://europe2024.gosim.org/schedule#mobile-and-web-app)

We’ll also be running a [**Servo breakout session**](https://github.com/Igalia/webengineshackfest/issues/28) at the [Web Engines Hackfest 2024](https://webengineshackfest.org) in A Coruña on **4 June** at **15:00 local time** (09:00 UTC).
**Remote participation is welcome!**

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
