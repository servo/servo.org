---
layout:     post
tags:       blog
title:      "This month in Servo: text fields, better emoji, devtools, and more!"
date:       2024-06-28
summary:    Plus font rendering performance, OpenHarmony and AddressSanitizer builds, and a new AI policy.
categories:
---

<figure class="_figr"><a href="{{ '/img/blog/june-2024.png' | url }}"><img src="{{ '/img/blog/june-2024.png' | url }}"
    alt="servoshell showing three demos: spaces at the end of each line take up space under ‘white-space-collapse: break-spaces’, measuring the size of the viewport with a ResizeObserver, and a focused text field with a visible value, where the space after the emoji now has normal width"></a></figure>

<span class=_floatmin></span>Servo has had some exciting changes land in our nightly builds over the last month:

- as of 2024-05-31, we now support **‘white-space-collapse: break-spaces’** ([@mrobinson](https://github.com/mrobinson), [@atbrakhi](https://github.com/atbrakhi), [#32388](https://github.com/servo/servo/pull/32388))
- as of 2024-06-11, we now support **&lt;col span> in &lt;colgroup>** ([@Loirooriol](https://github.com/Loirooriol), [#32467](https://github.com/servo/servo/pull/32467))
- as of 2024-06-14, we now support the **decode method on HTMLImageElement** ([@Taym95](https://github.com/Taym95), [#31269](https://github.com/servo/servo/pull/31269))
- as of 2024-06-18, we now have initial support for **ResizeObserver** ([@gterzian](https://github.com/gterzian), [#31108](https://github.com/servo/servo/pull/31108))
    - to enable this experimental feature, run servoshell with `--pref dom.resize_observer.enabled`
- as of 2024-06-21, we now **render text in input fields** ([@mrobinson](https://github.com/mrobinson), [#32365](https://github.com/servo/servo/pull/32365))
    - note that editing is still very limited, and the caret and selection are not yet rendered

<figure class="_figl"><a href="{{ '/img/blog/emoji-presentation.png' | url }}"><img src="{{ '/img/blog/emoji-presentation.png' | url }}"
    alt="Table rendered by Servo with three columns (default, with VS15, and with VS16), comparing the behaviour of three emoji with Emoji_Presentation=Yes (🐕, 🐶, 🐾) and three emoji with Emoji_Presentation=No (☺, ™, ↔)"></a>
<figcaption>On platforms with color emoji support, we now correctly follow Unicode’s rules for when to use color emoji. This table also uses &lt;col&#xA0;span> in a &lt;colgroup>.</figcaption></figure>

<span class=_floatmin></span>WebGPU can now run on **OpenGL ES on Windows and Linux** ([@hieudo-dev](https://github.com/hieudo-dev), [#32452](https://github.com/servo/servo/pull/32452)), **no longer records errors after losing a device** ([@sagudev](https://github.com/sagudev), [#32347](https://github.com/servo/servo/pull/32347)), and you can now **select a WebGPU backend with `--pref dom.webgpu.wgpu_backend=`**.

servoshell can now go **fullscreen without showing the location bar** ([@Nylme](https://github.com/Nylme), [#32425](https://github.com/servo/servo/pull/32425)), and no longer **leaves the status bar behind when navigating** ([@webbeef](https://github.com/webbeef), [#32518](https://github.com/servo/servo/pull/32518)).
We’ve also started building **servoshell on OpenHarmony** in CI ([@jschwe](https://github.com/jschwe), [#32507](https://github.com/servo/servo/pull/32507)), started merging our Android build into servoshell ([@jschwe](https://github.com/jschwe), [#32533](https://github.com/servo/servo/pull/32533)), and refactored servoshell’s desktop-only code ([@jschwe](https://github.com/jschwe), [#32457](https://github.com/servo/servo/pull/32457)).

## Fonts and emoji

Unicode emoji often come in two variants: an **emoji presentation** (color or graphic) and a **text presentation** (monochrome).
You can select one or the other by appending the **variation selectors** [U+FE0F](https://charming.daz.cat/#FE0F) or [U+FE0E](https://charming.daz.cat/#FE0E) respectively, and the default presentation is controlled by the [**Emoji_Presentation**](https://www.unicode.org/reports/tr51/tr51-25.html#Emoji_Properties_and_Data_Files) property.
Most emoji default to emoji presentation, but not all of them, and bugs in handling that property are often why characters like [<span style=font-size:150%;line-height:1rem>™</span>](https://charming.daz.cat/#2122) and [<span style=font-size:150%;line-height:1rem>↔</span>](https://charming.daz.cat/#2194) get displayed as emoji when they shouldn’t.

We’ve reworked our font fallback algorithm to enable **emoji in text presentation on Windows** ([@mrobinson](https://github.com/mrobinson), [#32286](https://github.com/servo/servo/pull/32286)) and correctly handle **emoji variation selectors** and **Emoji_Presentation** ([@mrobinson](https://github.com/mrobinson), [@atbrakhi](https://github.com/atbrakhi), [@mukilan](https://github.com/mukilan), [#32493](https://github.com/servo/servo/pull/32493)).

Webfont performance is improving, with Servo no longer starting a **layout reflow every time a webfont loads** ([@mrobinson](https://github.com/mrobinson), [#32455](https://github.com/servo/servo/pull/32455)) and no longer **leaking resources in WebRender** ([@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#32545](https://github.com/servo/servo/pull/32545)).
We’ve also fixed a bug where spaces near emoji are too wide ([@mrobinson](https://github.com/mrobinson), [@atbrakhi](https://github.com/atbrakhi), [#32442](https://github.com/servo/servo/pull/32442)), fixed a shaping bug on Windows ([@mrobinson](https://github.com/mrobinson), [#32499](https://github.com/servo/servo/pull/32499)), and improved our fallback font lists ([@mrobinson](https://github.com/mrobinson), [@jschwe](https://github.com/jschwe), [#32463](https://github.com/servo/servo/pull/32463), [#32555](https://github.com/servo/servo/pull/32555)).

## Embedding and dev changes

<figure class="_figr"><a href="{{ '/img/blog/devtools-june-2024.png' | url }}"><img src="{{ '/img/blog/devtools-june-2024.png' | url }}"
    alt="Firefox devtools connected to Servo, with a hello world printed by a document.write() call in the Console tab"></a>
<figcaption>You can now use Firefox devtools to evaluate JavaScript in Servo, but messages from the Console API are not yet visible.</figcaption></figure>

<span class=_floatmin></span>Servo now has an [**AI contributions policy**](https://github.com/servo/servo/blob/FIXME/CONTRIBUTING.md) ([@mrobinson](https://github.com/mrobinson), [@delan](https://github.com/delan), [#32287](https://github.com/servo/servo/pull/32287)).
In short, for the time being, anything you contribute to the Servo project **must not contain content generated by large language models** or other probabilistic tools.

Servo now builds with **Rust 1.78** ([@sagudev](https://github.com/sagudev), [#32217](https://github.com/servo/servo/pull/32217)) and we’ve migrated to **Rust 2021** ([@mrobinson](https://github.com/mrobinson), [#32544](https://github.com/servo/servo/pull/32544)), **SpiderMonkey 115.13** ([@sagudev](https://github.com/sagudev), [#32510](https://github.com/servo/servo/pull/32510)), and **Stylo 2024-05-15** ([@Loirooriol](https://github.com/Loirooriol), [#32334](https://github.com/servo/servo/pull/32334)).
Thanks to the compiler upgrade, **`mach doc` no longer hangs** ([@delan](https://github.com/delan), [#32413](https://github.com/servo/servo/pull/32413)), **[our API docs](https://doc.servo.org) are now live again**, and **[libservo API docs](https://doc.servo.org/servo/) are now available too** ([@wusyong](https://github.com/wusyong), [#32429](https://github.com/servo/servo/pull/32429)), having previously been shadowed by an empty docs page for the servoshell bin crate.

You can now **build Servo with AddressSanitizer** via `mach build --with-asan` ([@sagudev](https://github.com/sagudev), [#31429](https://github.com/servo/servo/pull/31429)), which will help us find and fix memory safety violations.

Outreachy intern [@eerii](https://github.com/eerii) is showing our [**Firefox-compatible devtools**](https://book.servo.org/running-servoshell.html) some much needed love, landing support for **listing tabs and processes** ([@eerii](https://github.com/eerii), [@fabricedesre](https://github.com/fabricedesre), [#32475](https://github.com/servo/servo/pull/32475)) and **running code in the Console tab** ([@eerii](https://github.com/eerii), [#32509](https://github.com/servo/servo/pull/32509)).

We’ve fixed a panic in multiprocess mode ([@mukilan](https://github.com/mukilan), [#32571](https://github.com/servo/servo/pull/32571)) and several busted builds, including **cross-compiling on macOS** ([@jschwe](https://github.com/jschwe), [#32504](https://github.com/servo/servo/pull/32504)), **building on NixOS** ([@mukilan](https://github.com/mukilan), [#32567](https://github.com/servo/servo/pull/32567)), and **building for Android on Fedora** ([@jschwe](https://github.com/jschwe), [#32532](https://github.com/servo/servo/pull/32532)).

## Donations

Thanks again for your generous support!
We are now receiving **2229 USD/month** (+36.7% over May) in recurring donations.
We are still receiving donations from **15 people** on LFX, and we’re working on transferring the balance to our new fund, but we will stop accepting donations there soon — **please move your recurring donations to [GitHub](https://github.com/sponsors/servo) or [Open Collective](https://opencollective.com/servo)**.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 2229 / 10000); padding-left: 0.5em;"><strong>2229</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 2229 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="2229" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

As always, use of these funds will be decided transparently in the Technical Steering Committee.
For more details, head to our [Sponsorship page]({{ '/sponsorship/' | url }}).

## Conferences and blogs

- [**Fixing Servo’s Event Loop**](https://medium.com/@polyglot_factotum/fixing-servos-event-loop-490c0fd74f8d) — Gregory Terzian blogged about using [TLA+](https://en.wikipedia.org/wiki/TLA%2B) to guide and verify our work on implementing the HTML event loop in Servo
- [**Blitz: a truly modular, hackable web renderer**](https://www.youtube.com/watch?v=QRuYyG_CmMU) ([slides](https://webengineshackfest.org/2024/slides/blitz_a_truly_modular_hackable_web_renderer_by_nico_burns.pdf)) — Nico Burns spoke at the [Web Engines Hackfest 2024](https://webengineshackfest.org/2024/) about building a new kind of Servo-based web renderer for [Dioxus](https://dioxuslabs.com), without any JavaScript runtime
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
