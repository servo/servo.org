---
layout:     post
tags:       blog
title:      "This month in Servo: dark mode, keyword sizes, XPath, and more!"
date:       2025-01-10
summary:    Servo nightlies are now faster, more reliable, 20% smaller, and more compatible with real web apps.
categories:
---

<div class="_paired_figure">
<div class="_text_before">

Servo now supports **dark mode** ([@arthmis](https://github.com/arthmis), [@lazypassion](https://github.com/lazypassion), [#34532](https://github.com/servo/servo/pull/34532)), respecting the platform dark mode in servoshell and **‘prefers-color-scheme’** ([@nicoburns](https://github.com/nicoburns), [#34423](https://github.com/servo/servo/pull/34423), [stylo#93](https://github.com/servo/stylo/pull/93)) on Windows and macOS.
</div>
<figure>
    <div style="display: flex;">
        <a href="{{ '/img/blog/dark-mode-december-2024.png' | url }}"><img src="{{ '/img/blog/dark-mode-december-2024.png' | url }}"
            alt="servoshell in dark mode, rendering the MDN article for ‘prefers-color-scheme’ in dark mode, when Windows is set to dark mode"></a>
        <a href="{{ '/img/blog/light-mode-december-2024.png' | url }}"><img src="{{ '/img/blog/light-mode-december-2024.png' | url }}"
            alt="servoshell in light mode, rendering the MDN article for ‘prefers-color-scheme’ in light mode, when Windows is set to light mode"></a>
    </div>
    <figcaption><a href="https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-color-scheme">MDN article for ‘prefers-color-scheme’</a> in dark mode (left) and light mode (right), with <code>--pref dom.resize_observer.enabled</code>.</figcaption>
</figure>
<div class="_text_after">

**CSS transitions** can now be triggered properly by script ([@mrobinson](https://github.com/mrobinson), [#34486](https://github.com/servo/servo/pull/34486)), and we now support **‘min-height’** and **‘max-height’** on column flex containers ([@Loirooriol](https://github.com/Loirooriol), [@mrobinson](https://github.com/mrobinson), [#34450](https://github.com/servo/servo/pull/34450)), **‘min-content’**, **‘max-content’**, **‘fit-content’**, and **‘stretch’** in block layout ([@Loirooriol](https://github.com/Loirooriol), [#34641](https://github.com/servo/servo/pull/34641), [#34568](https://github.com/servo/servo/pull/34568), [#34695](https://github.com/servo/servo/pull/34695)), **‘stretch’** on replaced positioned elements ([@Loirooriol](https://github.com/Loirooriol), [#34430](https://github.com/servo/servo/pull/34430)), as well as **‘align-self: self-start’**, **‘self-end’**, **‘left’**, and **‘right’** on positioned elements ([@taniishkaaa](https://github.com/taniishkaaa), [@Loirooriol](https://github.com/Loirooriol), [#34365](https://github.com/servo/servo/pull/34365)).
</div>
</div>

<div class="_paired_figure">
<div class="_text_before">

Servo can now run [**Discord**](https://discord.com) well enough to [**log in**](https://discord.com/login) and **read messages**, though you can’t send messages yet.
To get this working, we landed some bare-bones AbortController support ([@jdm](https://github.com/jdm), [@syvb](https://github.com/syvb), [#34519](https://github.com/servo/servo/pull/34519)) and a WebSocket fix ([@jdm](https://github.com/jdm), [#34634](https://github.com/servo/servo/pull/34634)).
Try it yourself with `--pref dom.svg.enabled --pref dom.intersection_observer.enabled --pref dom.abort_controller.enabled`!
</div>
<figure>
    <div style="display: flex;">
        <a href="{{ '/img/blog/discord-login-1-december-2024.png' | url }}"><img src="{{ '/img/blog/discord-login-1-december-2024.png' | url }}"
            alt="Discord login screen in Servo, showing form input and a QR code that never finishes loading"></a>
        <a href="{{ '/img/blog/discord-login-2-december-2024.png' | url }}"><img src="{{ '/img/blog/discord-login-2-december-2024.png' | url }}"
            alt="Discord loading screen in Servo, after logging in"></a>
    </div>
    <a href="{{ '/img/blog/discord-small-december-2024.png' | url }}"><img src="{{ '/img/blog/discord-small-december-2024.png' | url }}"
        alt="Discord channel screen in Servo, showing a few of Diffie’s messages and attachments"></a>
</figure>
<div class="_text_after">

We now support **console.trace()** ([@simonwuelker](https://github.com/simonwuelker), [#34629](https://github.com/servo/servo/pull/34629)), **PointerEvent** ([@wusyong](https://github.com/wusyong), [#34437](https://github.com/servo/servo/pull/34437)), and the **clonable** property on **ShadowRoot** ([@simonwuelker](https://github.com/simonwuelker), [#34514](https://github.com/servo/servo/pull/34514)).
Shadow DOM support continues to improve ([@jdm](https://github.com/jdm), [#34503](https://github.com/servo/servo/pull/34503)), including very basic **Shadow DOM layout** ([@mrobinson](https://github.com/mrobinson), [#34701](https://github.com/servo/servo/pull/34701)) when enabled via `--pref dom.shadowdom.enabled`.

`script` underwent (and continues to undergo) major rework towards being **more reliable** and **faster to build**.
We’ve landed better **synchronisation for DOM tree mutations** ([@jdm](https://github.com/jdm), [#34505](https://github.com/servo/servo/pull/34505)) and continued work on **splitting up the `script` crate** ([@jdm](https://github.com/jdm), [#34366](https://github.com/servo/servo/pull/34366)).
We’ve moved our **ReadableStream** support into Servo, eliminating the maintenance burden of a downstream SpiderMonkey patch ([@gterzian](https://github.com/gterzian), [@wusyong](https://github.com/wusyong), [@Taym95](https://github.com/Taym95), [#34064](https://github.com/servo/servo/pull/34064), [#34675](https://github.com/servo/servo/pull/34675)).

The web platform guarantees that same-origin frames and their parents can **synchronously observe resizes** and their effects.
Many tests rely on this, and not doing this correctly made Servo’s test results much flakier than they could otherwise be.
We’ve made very good progress towards fixing this ([@mrobinson](https://github.com/mrobinson), [#34643](https://github.com/servo/servo/pull/34643), [#34656](https://github.com/servo/servo/pull/34656), [#34702](https://github.com/servo/servo/pull/34702), [#34609](https://github.com/servo/servo/pull/34609)), with correct resizing in all cases except when a same-origin frame is in another script thread, which is rare.
</div>
</div>

<div class="_paired_figure">
<div class="_text_before">

We now support enough of **XPath** to get [htmx](https://htmx.org) working ([@vlindhol](https://github.com/vlindhol), [#34463](https://github.com/servo/servo/pull/34463)), when enabled via `--pref dom.xpath.enabled`.
</div>
<figure>
    <a href="{{ '/img/blog/htmx-december-2024.png' | url }}"><img src="{{ '/img/blog/htmx-december-2024.png' | url }}"
        alt="htmx home page in Servo, with the hero banner thing now working (it relies on XPath)"></a>
</figure>
<div class="_text_after">

Servo’s performance continues to improve, with **layout caching for flex columns** delivering up to 12x speedup ([@Loirooriol](https://github.com/Loirooriol), [@mrobinson](https://github.com/mrobinson), [#34461](https://github.com/servo/servo/pull/34461)), many **unnecessary reflows now eliminated** ([@mrobinson](https://github.com/mrobinson), [#34558](https://github.com/servo/servo/pull/34558), [#34599](https://github.com/servo/servo/pull/34599), [#34576](https://github.com/servo/servo/pull/34576), [#34645](https://github.com/servo/servo/pull/34645)), **reduced memory usage** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#34563](https://github.com/servo/servo/pull/34563), [#34666](https://github.com/servo/servo/pull/34666)), faster rendering for pages with animations ([@mrobinson](https://github.com/mrobinson), [#34489](https://github.com/servo/servo/pull/34489)), and timers now operating without IPC ([@mrobinson](https://github.com/mrobinson), [#34581](https://github.com/servo/servo/pull/34581)).

**servoshell nightlies are up to 20% smaller** ([@atbrakhi](https://github.com/atbrakhi), [#34340](https://github.com/servo/servo/pull/34340)), **WebGPU is now optional** at build time ([@atbrakhi](https://github.com/atbrakhi), [#34444](https://github.com/servo/servo/pull/34444)), and `--features tracing` no longer enables `--features layout-2013` ([@jschwe](https://github.com/jschwe), [#34515](https://github.com/servo/servo/pull/34515)) for further binary size savings.
You can also **limit the size of** several of Servo’s **thread pools** with `--pref threadpools.fallback_worker_num` and others ([@jschwe](https://github.com/jschwe), [#34478](https://github.com/servo/servo/pull/34478)), which is especially useful on machines with many CPU cores.

We’ve started laying the groundwork for full **incremental layout** in our new layout engine, starting with a general layout caching mechanism ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#34507](https://github.com/servo/servo/pull/34507), [#34513](https://github.com/servo/servo/pull/34513), [#34530](https://github.com/servo/servo/pull/34530), [#34586](https://github.com/servo/servo/pull/34586)).
This was lost in the switch to our new layout engine, and without it, every time a page changes, we have to rerun layout from scratch.
As you can imagine, this is very, very expensive, and incremental layout is critical for performance on today’s highly dynamic web.

<aside class=_note>

We’ve mentioned layout caching a few times, including in past monthly updates, but most of the caching we’ve landed so far has been to save time *within* a single reflow.
Incremental layout requires layout caching that *persists* across reflows, and algorithms to determine when to invalidate those cached results.
</aside>
</div>
</div>

## Donations

Thanks again for your generous support!
We are now receiving **4329 USD/month** (+0.8% over November) in recurring donations.
With this money, we’ve been able to cover our web hosting and [self-hosted CI runners](https://ci0.servo.org) for Windows, Linux, and now macOS builds ([@delan](https://github.com/delan), [#34868](https://github.com/servo/servo/pull/34868)), **halving `mach try` build times** from over an hour to under 30 minutes!
Next month, we’ll be [expanding our CI capacity further](https://github.com/servo/project/issues/123), all made possible thanks to your help.

Servo is also on [thanks.dev](https://thanks.dev), and already **sixteen GitHub users** that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 4329 / 10000); padding-left: 0.5em;"><strong>4329</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 4329 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="4329" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

As always, use of these funds will be decided transparently in the Technical Steering Committee.
For more details, head to our [Sponsorship page]({{ '/sponsorship/' | url }}).

<style>
    /* guaranteed minimum width for first paragraph after a float */
    ._floatmin {
        display: block;
        width: 13em;
        overflow: hidden;
    }
    ._clear {
        clear: both;
    }
    ._clearl {
        clear: left;
    }
    ._clearr {
        clear: right;
    }
    ._none {
        display: none;
    }
    ._fig:not(#specificity) {
        width: 33em;
        max-width: 100%;
        margin: 1em auto;
    }
    ._fig > ._flex,
    ._figl > ._flex,
    ._figr > ._flex {
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
    ._figr > a > img,
    ._figl > ._flex,
    ._figr > ._flex {
        width: 21em;
        max-width: 100%;
    }

    .content {
        container-type: inline-size;
    }
    ._paired_figure {
        margin: 1em 0;
    }
    @container (min-width: 55em) {
        ._paired_figure {
            display: grid;
            grid-template-columns: auto 33em;
            column-gap: 2em;
            row-gap: 1em;
        }
        ._paired_figure > ._text_before,
        ._paired_figure > ._text_after {
            flex: 1 1 20em;
            grid-column: 1 / 2;
        }
        ._paired_figure > figure:not(#specificity) {
            flex: 0 1 33em;
            grid-row: 1 / 3;
            grid-column: 2 / 3;
            margin: 0;
        }
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
