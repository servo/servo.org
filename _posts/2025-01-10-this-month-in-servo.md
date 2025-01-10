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

Servo now supports **dark mode** (@arthmis, @lazypassion, #34532), respecting the platform dark mode in servoshell and **‘prefers-color-scheme’** (#34423, stylo#93, @nicoburns) on Windows and macOS.
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

**CSS transitions** can now be triggered properly by script (@mrobinson, #34486), and we now support **‘min-height’** and **‘max-height’** on column flex containers (@Loirooriol, @mrobinson, #34450), **‘min-content’**, **‘max-content’**, **‘fit-content’**, and **‘stretch’** in block layout (@Loirooriol, #34641, #34568, #34695), **‘stretch’** on replaced positioned elements (@Loirooriol, #34430), as well as **‘align-self: self-start’**, **‘self-end’**, **‘left’**, and **‘right’** on positioned elements (@taniishkaaa, @Loirooriol, #34365).
</div>
</div>

<div class="_paired_figure">
<div class="_text_before">

Servo can now run [**Discord**](https://discord.com) well enough to [**log in**](https://discord.com/login) and **read messages**, though you can’t send messages yet.
To get this working, we landed some bare-bones AbortController support (@jdm, @syvb, #34519) and a WebSocket fix (@jdm, #34634).
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

We now support **console.trace()** (@simonwuelker, #34629), **PointerEvent** (@wusyong, #34437), and the **clonable** property on **ShadowRoot** (@simonwuelker, #34514).
Shadow DOM support continues to improve (@jdm, #34503), including very basic **Shadow DOM layout** (@mrobinson, #34701) when enabled via `--pref dom.shadowdom.enabled`.

We’ve also regained support for **ReadableStream** with the default reader and controller (@gterzian, @wusyong, @Taym95, #34064, #34675).

`script` underwent (and continues to undergo) major rework towards being **more reliable** and **faster to build**.
We’ve landed better **synchronisation for DOM tree mutations** (@jdm, #34505) and continued work on **splitting up the `script` crate** (@jdm, #34366).

The web platform guarantees that same-origin frames and their parents can **synchronously observe resizes** and their effects.
Many tests rely on this, and not doing this correctly made Servo’s test results much flakier than they could otherwise be.
We’ve made very good progress towards fixing this (@mrobinson, #34643, #34656, #34702, #34609), with correct resizing in all cases except when a same-origin frame is in another script thread, which is rare.
</div>
</div>

<div class="_paired_figure">
<div class="_text_before">

We now support enough of **XPath** to get [htmx](https://htmx.org) working (@vlindhol, #34463), when enabled via `--pref dom.xpath.enabled`.
</div>
<figure>
    <a href="{{ '/img/blog/htmx-december-2024.png' | url }}"><img src="{{ '/img/blog/htmx-december-2024.png' | url }}"
        alt="htmx home page in Servo, with the hero banner thing now working (it relies on XPath)"></a>
</figure>
<div class="_text_after">

Servo’s performance continues to improve, with **layout caching for flex columns** delivering up to 12x speedup (@Loirooriol, @mrobinson, #34461), many **unnecessary reflows now eliminated** (@mrobinson, #34558, #34599, #34576, #34645), **reduced memory usage** (@mrobinson, @Loirooriol, #34563, #34666), faster rendering for pages with animations (@mrobinson, #34489), and timers now operating without IPC (@mrobinson, #34581).

**servoshell nightlies are up to 20% smaller** (@atbrakhi, #34340), **WebGPU is now optional** at build time (@atbrakhi, #34444), and `--features tracing` no longer enables `--features layout-2013` (@jschwe, #34515) for further binary size savings.
You can also **limit the size of** several of Servo’s **thread pools** with `--pref threadpools.fallback_worker_num` and others (@jschwe, #34478), which is especially useful on machines with many CPU cores.

We’ve started laying the groundwork for full **incremental layout** in our new layout engine, starting with a general layout caching mechanism (@mrobinson, @Loirooriol, #34507, #34513, #34530, #34586).
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
With this money, we’ve been able to cover our web hosting and [self-hosted CI runners](https://ci0.servo.org) for Windows, Linux, and now macOS builds (@delan, #34868), **halving `mach try` build times** from over an hour to under 30 minutes!
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

<!--
- DONE donations
    - DONE 2160.66/month opencollective
    - DONE 2169.00/month github
    - DONE 16 donors on thanks.dev
- engine
    - DONE 73    ‘prefers-color-scheme’ (dark mode)
    - DONE 54    CSS transitions can be triggered by script
    - 53    prompt user for credentials
    - DONE 65 69     ReadableStream with default reader and controller
    - DONE 43    console.trace()
    - DONE 39 42 59  ‘min-content’, ‘max-content’, ‘fit-content’ and ‘stretch’ for block layout
    - DONE 77    ‘self-start’, ‘self-end’, ‘left’, and ‘right’ for abspos elements
    - DONE 76 shadow dom impl
        - DONE 27    clonable property on ShadowRoot
        - DONE 68    initial shadow dom layout (--pref dom.shadowdom.enabled)
    - 48    referrerpolicy attribute
    - 30    referrerPolicy property on HTMLIFrameElement
    - DONE 14    xpath --pref dom.xpath.enabled; htmx
    - DONE 34    stub AbortController --pref dom.abort_controller.enabled; discord
    - DONE 72    fixed WebSocket connection error; discord
    - DONE 15    PointerEvent
    - DONE 11 12 13 36  synchronous iframe resizing
    - DONE 16    sync script execution with dom tree mutations
    - DONE 20    ‘min-’ and ‘max-height’ on column flex containers
    - 21    improved layout of flex container with reverse direction
    - DONE 23    ‘stretch’ on replaced abspos
    - DONE 26    --pref threadpools.fallback_worker_num etc
    - DONE 28 31 32 33  initial layout caching for incremental layout
    - 29    fixed `new Request({referrerPolicy: ""})`
    - 38    fixed case insensitivity of CSS ‘attr()’ in HTML
    - 46    fixed navigation from initial about:blank in iframes
    - 57 58     fixed intrinsic contributions of tables and anonymous blocks
    - 71    fixed WebSocket constructor with http or https url
- upgrades
    - 24    stylo 2024-12-04
    - 37 49 50  wgpu 24?
    - 45    SpiderMonkey 128.6
- crashes
    - 70    multiprocess mode
    - 51 52     shutting down
    - 19    unconnected shadow root
- ohos
    - 1     swipe back
- perf
    - DONE 17    flex column caching; 12x improvement
    - DONE 40 41 55 56   fixed reflows so they only happen when needed by HTML event loop
    - DONE 78    faster “update the rendering” with animations
    - DONE 18    reduced memory usage by 260 bytes per InlineItem
    - DONE 61    reduced memory usage in ContainingBlockPaddingAndBorder
    - DONE 2     optimise production-stripped
    - DONE 3     webgpu feature flag
    - DONE 4     tracing no longer enables layout-2013
    - 5     linux-perf job in ci
    - DONE 44    timers without IPC
    - 47    more gl bindings unification
    - DONE 75    more splitting up script crate
- dev
    - 35    fixed devtools with firefox 133
    - 6 7 8 62 63 64    now uses uv
    - 25 66 67  mach python compat
    - 9 10      rust 1.82
    - 22    mach cargo-clippy is now mach clippy
    - 60    dump_js_stack(*mut RawJSContext)
    - 74    preparing to support wpt testdriver.js
    - ci reliability?

>>> 2024-12-01T06:04:14Z
21  https://github.com/servo/servo/pull/34426	(@Loirooriol, #34426)	Fix alignment of abspos child of flexbox with flipped direction (#34426)
https://github.com/servo/servo/pull/34435	(@jdm, #34435)	script: Dirty video element when clearing video frame data. (#34435)
    https://github.com/servo/servo/pull/34432	(@shanehandley, #34432)	Retain the referrer policy when loading an about:blank iframe. (#34432)
>>> 2024-12-02T06:02:17Z
    https://github.com/servo/servo/pull/34427	(@dependabot[bot], @dependabot[bot], #34427)	build(deps): bump tracing-subscriber from 0.3.18 to 0.3.19 (#34427)
1   https://github.com/servo/servo/pull/34433	(@jschwe, #34433)	ohos: Support swiping to go back (#34433)
>>> 2024-12-03T06:05:34Z
20  https://github.com/servo/servo/pull/34450	(@Loirooriol, @mrobinson, #34450)	Obey min and max properties when computing main size of column flex (#34450)
    https://github.com/servo/servo/pull/34459	(@dependabot[bot], @dependabot[bot], #34459)	build(deps): bump libloading from 0.8.5 to 0.8.6 (#34459)
    https://github.com/servo/servo/pull/34457	(@dependabot[bot], @dependabot[bot], #34457)	build(deps): bump mio from 1.0.2 to 1.0.3 (#34457)
    https://github.com/servo/servo/pull/34456	(@dependabot[bot], @dependabot[bot], #34456)	build(deps): bump syn from 2.0.89 to 2.0.90 (#34456)
    https://github.com/servo/servo/pull/34454	(@dependabot[bot], @dependabot[bot], #34454)	build(deps): bump web-sys from 0.3.72 to 0.3.74 (#34454)
    https://github.com/servo/servo/pull/34453	(@dependabot[bot], @dependabot[bot], #34453)	build(deps): bump allocator-api2 from 0.2.20 to 0.2.21 (#34453)
    https://github.com/servo/servo/pull/34452	(@dependabot[bot], @dependabot[bot], #34452)	build(deps): bump js-sys from 0.3.72 to 0.3.74 (#34452)
    https://github.com/servo/servo/pull/34451	(@dependabot[bot], @dependabot[bot], #34451)	build(deps): bump ttf-parser from 0.25.0 to 0.25.1 (#34451)
19  https://github.com/servo/servo/pull/34361	(@simonwuelker, #34361)	Don't register unconnected shadow roots with their owner document (#34361)
    https://github.com/servo/servo/pull/34443	(@Loirooriol, #34443)	Refactor AbsoluteAxisSolver (#34443)
15  https://github.com/servo/servo/pull/34437	(@wusyong, #34437)	script: add PointerEvent (#34437)
2   https://github.com/servo/servo/pull/34340	(@atbrakhi, #34340)	Optimize `production-stripped` (#34340)
    https://github.com/servo/servo/pull/34422	(@jschwe, #34422)	ohos: Improve argument filtering (#34422)
>>> 2024-12-04T06:07:52Z
    https://github.com/servo/servo/pull/34471	(@dependabot[bot], @dependabot[bot], #34471)	build(deps): bump tokio from 1.41.1 to 1.42.0 (#34471)
    https://github.com/servo/servo/pull/34470	(@dependabot[bot], @dependabot[bot], #34470)	build(deps): bump wasm-bindgen-futures from 0.4.45 to 0.4.47 (#34470)
    https://github.com/servo/servo/pull/34469	(@dependabot[bot], @dependabot[bot], #34469)	build(deps): bump xml-rs from 0.8.23 to 0.8.24 (#34469)
17  https://github.com/servo/servo/pull/34461	(@Loirooriol, @mrobinson, #34461)	Improve performance of flex column layouts by caching (#34461)
>>> 2024-12-05T06:02:26Z
    https://github.com/servo/servo/pull/34480	(@nicoburns, #34480)	Move stylo thread pool mutex to servo layout thread crates (#34480)
22  https://github.com/servo/servo/pull/34481	(@nicoburns, #34481)	Rename 'cargo-clippy' mach command to just 'clippy' (#34481)
    https://github.com/servo/servo/pull/34477	(@dependabot[bot], @dependabot[bot], #34477)	build(deps): bump anyhow from 1.0.93 to 1.0.94 (#34477)
    https://github.com/servo/servo/pull/34476	(@dependabot[bot], @dependabot[bot], #34476)	build(deps): bump clap from 4.5.21 to 4.5.22 (#34476)
    https://github.com/servo/servo/pull/34475	(@dependabot[bot], @dependabot[bot], #34475)	build(deps): bump tokio-util from 0.7.12 to 0.7.13 (#34475)
    https://github.com/servo/servo/pull/34467	(@mukilan, #34467)	mach: fix logic to override paths for legacy layout (#34467)
>>> 2024-12-06T06:05:40Z
24  https://github.com/servo/servo/pull/34501	(@Loirooriol, #34501)	Upgrade Stylo to 2024-12-04 (#34501)
25  https://github.com/servo/servo/pull/34490	(@MichaelMcDonnell, #34490)	Check maximum Python version in mach (#34490)
23  https://github.com/servo/servo/pull/34430	(@Loirooriol, #34430)	Fix `stretch` sizes on replaced abspos (#34430)
78  https://github.com/servo/servo/pull/34489	(@mrobinson, #34489)	script: Update animations once per-Document during `update_the_rendering()` (#34489)
3   https://github.com/servo/servo/pull/34444	(@atbrakhi, #34444)	Add `webgpu` feature flag (#34444)
77  https://github.com/servo/servo/pull/34365	(@taniishkaaa, @Loirooriol, #34365)	layout: Add missing support for some alignment keywords on absolutely positioned elements (#34365)
https://github.com/servo/servo/pull/34484	(@jschwe, #34484)	Bump MACOSX_DEPLOYMENT_TARGET to 13.0 (#34484)
    https://github.com/servo/servo/pull/34483	(@servo-wpt-sync, #34483)	Update web-platform-tests to revision b'bf49dde84c5f05613115d6146d109f0ec3900694' (#34483)
>>> 2024-12-07T06:04:53Z
76  https://github.com/servo/servo/pull/34503	(@jdm, #34503)	Make traverse_preorder follow shadow roots (#34503)
4   https://github.com/servo/servo/pull/34515	(@jschwe, #34515)	Fix tracing enabling layout-2013 feature (#34515)
    https://github.com/servo/servo/pull/34512	(@dependabot[bot], @dependabot[bot], #34512)	build(deps): bump tokio-stream from 0.1.16 to 0.1.17 (#34512)
    https://github.com/servo/servo/pull/34511	(@dependabot[bot], @dependabot[bot], #34511)	build(deps): bump clap from 4.5.22 to 4.5.23 (#34511)
    https://github.com/servo/servo/pull/34510	(@dependabot[bot], @dependabot[bot], #34510)	build(deps): bump clap_lex from 0.7.3 to 0.7.4 (#34510)
    https://github.com/servo/servo/pull/34508	(@jschwe, #34508)	Don't trace SystemFontService loop (#34508)
    https://github.com/servo/servo/pull/34485	(@Mikopet, #34485)	tweak mach files a little bit (#34485)
75  https://github.com/servo/servo/pull/34366	(@jdm, #34366)	Create two-phase initialization for generated JS engine bindings (#34366)
5   https://github.com/servo/servo/pull/33261	(@sagudev, @dklassic, #33261)	Add linux-pref job (#33261)
>>> 2024-12-08T06:07:13Z
14  https://github.com/servo/servo/pull/34463	(@vlindhol, #34463)	Add XPath parser/evaluator (#34463)
28  https://github.com/servo/servo/pull/34507	(@mrobinson, #34507)	layout: Add `LayoutBoxBase` and use it for `IndependentFormattingContext` (#34507)
27  https://github.com/servo/servo/pull/34514	(@simonwuelker, #34514)	Implement `ShadowRoot.clonable` attribute (#34514)
    https://github.com/servo/servo/pull/34509	(@dependabot[bot], @dependabot[bot], #34509)	build(deps): bump fdeflate from 0.3.6 to 0.3.7 (#34509)
29  https://github.com/servo/servo/pull/34518	(@shanehandley, #34518)	net: correct handling of the empty string referrer policy when provided in requestInit (#34518)
26  https://github.com/servo/servo/pull/34478	(@jschwe, #34478)	Add prefs to limit threadpool sizes (#34478)
>>> 2024-12-09T06:05:58Z
    https://github.com/servo/servo/pull/34529	(@vlindhol, #34529)	traverse Shadow DOM boundaries when determining element lang (#34529)
30  https://github.com/servo/servo/pull/34526	(@shanehandley, #34526)	Add ReferrerPolicy IDL attribute to iframes (#34526)
    https://github.com/servo/servo/pull/34525	(@servo-wpt-sync, #34525)	Update web-platform-tests to revision b'7b6f075f0ec3c52d92c61fb9f35ce0ec927b17b2' (#34525)
    https://github.com/servo/servo/pull/34524	(@iamlockon, #34524)	script: add `initialize_ui_event` method (#34524)
31  https://github.com/servo/servo/pull/34513	(@mrobinson, #34513)	layout: Add `LayoutBox` to `TableSlotCell` (#34513)
>>> 2024-12-10T06:10:59Z
5   https://github.com/servo/servo/pull/34548	(@mukilan, #34548)	Revert "mach: switch to `uv` for managing python venv (#34504)" (#34548)
    https://github.com/servo/servo/pull/34546	(@dependabot[bot], @dependabot[bot], #34546)	build(deps): bump png from 0.17.14 to 0.17.15 (#34546)
    https://github.com/servo/servo/pull/34545	(@dependabot[bot], @dependabot[bot], #34545)	build(deps): bump chrono from 0.4.38 to 0.4.39 (#34545)
    https://github.com/servo/servo/pull/34543	(@dependabot[bot], @dependabot[bot], #34543)	build(deps): bump cc from 1.2.2 to 1.2.3 (#34543)
    https://github.com/servo/servo/pull/34542	(@dependabot[bot], @dependabot[bot], #34542)	build(deps): bump libc from 0.2.167 to 0.2.168 (#34542)
    https://github.com/servo/servo/pull/34541	(@dependabot[bot], @dependabot[bot], #34541)	build(deps): bump fastrand from 2.2.0 to 2.3.0 (#34541)
    https://github.com/servo/servo/pull/34540	(@dependabot[bot], @dependabot[bot], #34540)	build(deps): bump taffy from 0.6.2 to 0.6.3 (#34540)
    https://github.com/servo/servo/pull/34536	(@jschwe, #34536)	tracing: Trace Constellation blocked duration (#34536)
    https://github.com/servo/servo/pull/34538	(@iamlockon, @wusyong, #34538)	retire deprecated MouseEvent::InitMouseEvent (#34538)
4   https://github.com/servo/servo/pull/34504	(@mukilan, #34504)	mach: switch to `uv` for managing python venv (#34504)
54  https://github.com/servo/servo/pull/34486	(@mrobinson, #34486)	script: Update the rendering when receiving IPC messages instead of just reflowing (#34486)
    https://github.com/servo/servo/pull/34506	(@atbrakhi, #34506)	Reword assert message (#34506)
32  https://github.com/servo/servo/pull/34530	(@mrobinson, #34530)	layout: Have `SameFormattingContextBlock` be a `LayoutBoxBase` (#34530)
>>> 2024-12-12T06:06:01Z
https://github.com/servo/servo/pull/34587	(@nicoburns, #34587)	Deduplicate taffy layout pbm computation (#34587)
33  https://github.com/servo/servo/pull/34586	(@Loirooriol, #34586)	Make sure to cache `inline_content_sizes()` (#34586)
74  https://github.com/servo/servo/pull/34550	(@jdm, #34550)	Allow running testharness/testdriver/reftests in servodriver (#34550)
55  https://github.com/servo/servo/pull/34576	(@mrobinson, #34576)	script: Do not do explicit reflows when handing rAFs (#34576)
    https://github.com/servo/servo/pull/34583	(@dependabot[bot], @dependabot[bot], #34583)	build(deps): bump serde from 1.0.215 to 1.0.216 (#34583)
18  https://github.com/servo/servo/pull/34563	(@mrobinson, @Loirooriol, #34563)	layout: Clean up inline layout data types a bit (#34563)
    https://github.com/servo/servo/pull/34565	(@mrobinson, @Loirooriol, #34565)	layout: Make a new `ContainingBlockSize` type (#34565)
    https://github.com/servo/servo/pull/34552	(@jdm, #34552)	tidy: Update pattern for checking for missing specification links. (#34552)
    https://github.com/servo/servo/pull/34570	(@shanehandley, #34570)	Update response handling in main_fetch (#34570)
40  https://github.com/servo/servo/pull/34558	(@mrobinson, #34558)	script: Remove 'pending reflow' concept and some explicit reflows (#34558)
    https://github.com/servo/servo/pull/34567	(@jdm, #34567)	Iterate PR commits in reverse (oldest->newest) when preparing WPT export. (#34567)
    https://github.com/servo/servo/pull/34577	(@mukilan, #34577)	ci: disable caches on Android CI for testing (#34577)
    https://github.com/servo/servo/pull/34554	(@jdm, #34554)	Rewrite From/TryFrom conversions on generated types to avoid future orphan rule violations (#34554)
https://github.com/servo/servo/pull/34557	(@Loirooriol, #34557)	Don't transfer indefinite `height: stretch` to inline axis (#34557)
https://github.com/servo/servo/pull/34539	(@mrobinson, #34539)	script: Do not prioritize *update-the-rendering* in `ScriptThread` message loop (#34539)
34  https://github.com/servo/servo/pull/34519	(@jdm, @syvb, #34519)	script: Add stub interface for AbortController. (#34519)
>>> 2024-12-13T06:06:41Z
35  https://github.com/servo/servo/pull/34602	(@parasyte, #34602)	Fix devtools timeout with Firefox 133 (#34602)
    https://github.com/servo/servo/pull/34595	(@Loirooriol, #34595)	Distinguish cached `inline_content_sizes()` from uncached ones (#34595)
    https://github.com/servo/servo/pull/34596	(@Loirooriol, #34596)	Fix block size of containing block established by table rows (#34596)
https://github.com/servo/servo/pull/34572	(@d-desiatkin, @Loirooriol, #34572)	layout: Fix ordering of padding, border, and margin in inline BiDi (#34572)
    https://github.com/servo/servo/pull/34585	(@Loirooriol, #34585)	Share more code for non-replaced float-avoiding blocks (#34585)
    https://github.com/servo/servo/pull/34544	(@dependabot[bot], @dependabot[bot], #34544)	build(deps): bump rustix from 0.38.41 to 0.38.42 (#34544)
10  https://github.com/servo/servo/pull/34592	(@jschwe, #34592)	Upgrade Rust to 1.82.0 (#34592)
    https://github.com/servo/servo/pull/34589	(@nicoburns, #34589)	Remove taffy-specific layout caching (#34589)
    https://github.com/servo/servo/pull/34556	(@sagudev, #34556)	Run bencher in try-full (#34556)
https://github.com/servo/servo/pull/34575	(@mrobinson, #34575)	script: Remove `note_rendering_opportunity` and `rendering_opportunity` (#34575)
9   https://github.com/servo/servo/pull/34270	(@mukilan, #34270)	build: upgrade rustc to 1.81.0 (#34270)
73  https://github.com/servo/servo/pull/34532	(@arthmis, @lazypassion, #34532)	Add embedder event for preferred color scheme and respond to it in the LayoutThread (#34532)
https://github.com/servo/servo/pull/34584	(@jschwe, #34584)	android: Fix flinging downwards  (#34584)
>>> 2024-12-14T06:04:56Z
    https://github.com/servo/servo/pull/34617	(@webbeef, #34617)	Allow a null principal to subsumes others when appropriate (#34617)
    https://github.com/servo/servo/pull/34588	(@jdm, #34588)	Replace unsafe uses of HandleValueArray. (#34588)
36  https://github.com/servo/servo/pull/34609	(@mrobinson, #34609)	layout: Send back layout results directly and remove channels (#34609)
37  https://github.com/servo/servo/pull/34607	(@sagudev, #34607)	Update wgpu to trunk (#34607)
    https://github.com/servo/servo/pull/34611	(@dependabot[bot], @dependabot[bot], #34611)	build(deps): bump cc from 1.2.3 to 1.2.4 (#34611)
    https://github.com/servo/servo/pull/34610	(@dependabot[bot], @dependabot[bot], #34610)	build(deps): bump semver from 1.0.23 to 1.0.24 (#34610)
38  https://github.com/servo/servo/pull/34574	(@stevennovaryo, #34574)	layout: Fix CSS `attr()` function case sensitivity matching (#34574)
https://github.com/servo/servo/pull/34608	(@Loirooriol, #34608)	Use inline-start/inline-end instead of left/right terminology for floats (#34608)
https://github.com/servo/servo/pull/34606	(@willypuzzle, #34606)	Add CanGc argument to reflect_dom_object  (#34606)
41  https://github.com/servo/servo/pull/34599	(@mrobinson, #34599)	script: No longer do explicit reflows for display (#34599)
    https://github.com/servo/servo/pull/34447	(@mrobinson, #34447)	tidy: Use more `cargo-deny` features (#34447)
>>> 2024-12-15T06:06:42Z
    https://github.com/servo/servo/pull/34622	(@servo-wpt-sync, #34622)	Update web-platform-tests to revision b'38623a53d6598cb7aab4be8a810102b352a652df' (#34622)
    https://github.com/servo/servo/pull/34619	(@mukilan, #34619)	ci: add retries and caching for `gradle` installation (#34619)
    https://github.com/servo/servo/pull/34618	(@webbeef, #34618)	Set a Rust edition for blurmac (#34618)
>>> 2024-12-16T06:06:45Z
>>> 2024-12-17T06:05:35Z
    https://github.com/servo/servo/pull/34659	(@Narfinger, #34659)	Update deprecated use of PanicInfo to PanicHookInfo (#34659)
    https://github.com/servo/servo/pull/34650	(@dependabot[bot], @dependabot[bot], #34650)	build(deps): bump colored from 2.1.0 to 2.2.0 (#34650)
49  https://github.com/servo/servo/pull/34646	(@sagudev, #34646)	Update wgpu to better handle optional attachment load/store ops (#34646)
39  https://github.com/servo/servo/pull/34641	(@Loirooriol, #34641)	Complete implementation of keyword sizes for block layout (#34641)
    https://github.com/servo/servo/pull/34654	(@dependabot[bot], @dependabot[bot], #34654)	build(deps): bump cc from 1.2.3 to 1.2.4 (#34654)
    https://github.com/servo/servo/pull/34653	(@dependabot[bot], @dependabot[bot], #34653)	build(deps): bump crossbeam-deque from 0.8.5 to 0.8.6 (#34653)
    https://github.com/servo/servo/pull/34652	(@dependabot[bot], @dependabot[bot], #34652)	build(deps): bump semver from 1.0.23 to 1.0.24 (#34652)
    https://github.com/servo/servo/pull/34649	(@dependabot[bot], @dependabot[bot], #34649)	build(deps): bump crossbeam-utils from 0.8.20 to 0.8.21 (#34649)
    https://github.com/servo/servo/pull/34648	(@dependabot[bot], @dependabot[bot], #34648)	build(deps): bump crossbeam-channel from 0.5.13 to 0.5.14 (#34648)
    https://github.com/servo/servo/pull/34626	(@mrobinson, #34626)	wpt: Fix flakiness in `vh_not_refreshing_on_chrome.html` (#34626)
11  https://github.com/servo/servo/pull/34643	(@mrobinson, #34643)	script: Manage `<iframe>` sizes in `Window` (#34643)
42  https://github.com/servo/servo/pull/34568	(@Loirooriol, #34568)	Partial implementation of keyword sizes for block layout (#34568)
    https://github.com/servo/servo/pull/34640	(@mukilan, #34640)	ci: fix wpt export job (#34640)
6   https://github.com/servo/servo/pull/34632	(@mukilan, #34632)	mach: adopt `uv` and avoid system python (#34632)
    https://github.com/servo/servo/pull/34562	(@jschwe, #34562)	Bump bindgen to 0.71.1 (#34562)
72  https://github.com/servo/servo/pull/34634	(@jdm, #34634)	websocket: Revert use of h2 in websocket ALPN. (#34634)
>>> 2024-12-20T13:15:33Z
warning: not reachable from default branch: 61bfd2f8b3f17fa988830447f169b97fd87c624c
    https://github.com/servo/servo/pull/ci: explictly install Clang 14 on Linux runners	(#ci: explictly install Clang 14 on Linux runners, @mukilan)	ci: explictly install Clang 14 on Linux runners
67  https://github.com/servo/servo/pull/34712	(@mukilan, #34712)	mach: recreate .venv when .python-version changes (#34712)
68  https://github.com/servo/servo/pull/34701	(@mrobinson, #34701)	layout: Lay out Shadow DOM elements (#34701)
66  https://github.com/servo/servo/pull/34707	(@sagudev, #34707)	Set python version to 3.11 (#34707)
    https://github.com/servo/servo/pull/34704	(@dependabot[bot], @dependabot[bot], #34704)	build(deps): bump libc from 0.2.168 to 0.2.169 (#34704)
    https://github.com/servo/servo/pull/34705	(@dependabot[bot], @dependabot[bot], #34705)	build(deps): bump truetype from 0.47.6 to 0.47.7 (#34705)
    https://github.com/servo/servo/pull/34703	(@dependabot[bot], @dependabot[bot], #34703)	build(deps): bump cc from 1.2.4 to 1.2.5 (#34703)
69  https://github.com/servo/servo/pull/34675	(@gterzian, #34675)	Remove the need for crow allow unrooted lints in the queuing and de-queuing of values from default stream controllers (#34675)
    https://github.com/servo/servo/pull/34638	(@wusyong, #34638)	chore: remove deprecated winit method (#34638)
64  https://github.com/servo/servo/pull/34693	(@Loirooriol, #34693)	Reapply "Fix mozjs build on Windows (#34680)" (#34693)
    https://github.com/servo/servo/pull/34671	(@Loirooriol, #34671)	Refactor box size computation (#34671)
43  https://github.com/servo/servo/pull/34629	(@simonwuelker, #34629)	Implement `console.trace` (#34629)
    https://github.com/servo/servo/pull/34694	(@simonwuelker, #34694)	Save http response reason instead of inferring it from status code (#34694)
    https://github.com/servo/servo/pull/34687	(@dependabot[bot], @dependabot[bot], #34687)	build(deps): bump miniz_oxide from 0.8.0 to 0.8.2 (#34687)
https://github.com/servo/servo/pull/34672	(@Loirooriol, #34672)	layout: Never stretch indefinite intrinsic keywords other than `auto` (#34672)
    https://github.com/servo/servo/pull/34692	(@jschwe, #34692)	Disable sccache in CI (#34692)
63  https://github.com/servo/servo/pull/34680	(@Loirooriol, #34680)	Revert "Fix mozjs build on Windows (#34680)"
62  https://github.com/servo/servo/pull/34680	(@delan, #34680)	Fix mozjs build on Windows (#34680)
    https://github.com/servo/servo/pull/34681	(@shanehandley, #34681)	Replace HistoryEntryReplacement with NavigationHistoryBehavior from the navigation API (#34681)
    https://github.com/servo/servo/pull/34682	(@jschwe, #34682)	CI: simplify self-hosted check (#34682)
    https://github.com/servo/servo/pull/34678	(@jschwe, #34678)	Fix compilation with --no-default-features (#34678)
    https://github.com/servo/servo/pull/34684	(@mukilan, #34684)	ci: purge MacOS specific caches (#34684)
    https://github.com/servo/servo/pull/34667	(@mrobinson, #34667)	script: Expose a constructor on `HTMLCollection` that takes a static function (#34667)
    https://github.com/servo/servo/pull/34673	(@mukilan, #34673)	ci: increment SCCACHE_GHA_VERSION to purge caches (#34673)
    https://github.com/servo/servo/pull/34658	(@willypuzzle, #34658)	modified Promise::new_resolved/new_rejected signature (#34658)
65  https://github.com/servo/servo/pull/34064	(@gterzian, @wusyong, @Taym95, #34064)	Dom: Re-implement `ReadableStream` Part 1 : Default `Reader` and `Controller` (#34064)
61  https://github.com/servo/servo/pull/34666	(@Loirooriol, #34666)	Shrink ContainingBlockPaddingAndBorder (#34666)
    https://github.com/servo/servo/pull/34670	(@sagudev, #34670)	Set CCACHE only for github hosted runner (#34670)
    https://github.com/servo/servo/pull/34668	(@dependabot[bot], @dependabot[bot], #34668)	build(deps): bump unicode-bidi from 0.3.17 to 0.3.18 (#34668)
    https://github.com/servo/servo/pull/34647	(@dependabot[bot], @dependabot[bot], @mukilan, #34647)	build(deps): bump the egui-related group with 6 updates (#34647)
    https://github.com/servo/servo/pull/34663	(@mrobinson, #34663)	tidy: Make the tidy tests pass tidy (#34663)
12  https://github.com/servo/servo/pull/34656	(@mrobinson, #34656)	layout: Allow same `ScriptThread` `<iframe>`s to be resized synchronously (#34656)
70  https://github.com/servo/servo/pull/34661	(@mukilan, #34661)	libservo: update stylo preferences in multiprocess mode. (#34661)
56  https://github.com/servo/servo/pull/34645	(@mrobinson, #34645)	script: Fix assertion verifying that reflow isn't necessary after reflow (#34645)
    https://github.com/servo/servo/pull/34631	(@sagudev, #34631)	webgpu: Fix HTML event loop integration (#34631)
>>> 2024-12-21T06:10:08Z
    https://github.com/servo/servo/pull/34723	(@dependabot[bot], @dependabot[bot], @jdm, #34723)	build(deps): bump content-security-policy from 0.5.2 to 0.5.3 (#34723)
    https://github.com/servo/servo/pull/34718	(@mukilan, #34718)	ci: explictly install Clang 14 on Linux runners (#34718)
    https://github.com/servo/servo/pull/34724	(@dependabot[bot], @dependabot[bot], #34724)	build(deps): bump png from 0.17.15 to 0.17.16 (#34724)
    https://github.com/servo/servo/pull/34722	(@dependabot[bot], @dependabot[bot], #34722)	build(deps): bump env_filter from 0.1.2 to 0.1.3 (#34722)
47  https://github.com/servo/servo/pull/34716	(@jschwe, #34716)	servoshell: Remove duplicate egl bindings on android/ohos (#34716)
57  https://github.com/servo/servo/pull/34696	(@Loirooriol, #34696)	layout: Fix intrinsic contributions of tables (#34696)
    https://github.com/servo/servo/pull/34715	(@jdm, #34715)	compositing: Invert check for webxr when determining animation status. (#34715)
13  https://github.com/servo/servo/pull/34702	(@mrobinson, #34702)	script: Cache the `<iframe>` list per-Document (#34702)
>>> 2024-12-22T06:04:12Z
    https://github.com/servo/servo/pull/34733	(@servo-wpt-sync, #34733)	Update web-platform-tests to revision b'979291d49c1a8e3d811df117d9e6b5d399a6deb2' (#34733)
    https://github.com/servo/servo/pull/34732	(@sagudev, #34732)	ci: Do not run bencher in MQ (#34732)
    https://github.com/servo/servo/pull/34729	(@sagudev, #34729)	chore: Update mozjs to version without streams (#34729)
    https://github.com/servo/servo/pull/34706	(@dependabot[bot], @dependabot[bot], @jdm, #34706)	build(deps): bump gpu-descriptor from 0.3.0 to 0.3.1 (#34706)
50  https://github.com/servo/servo/pull/34721	(@sagudev, #34721)	Update wgpu for supporting TextureView.usage (#34721)
>>> 2024-12-23T06:03:24Z
    https://github.com/servo/servo/pull/34737	(@wulanseruniati, #34737)	Optimize mutex usage in fetch by locking once and using scoped MutexGuard (#34737)
71  https://github.com/servo/servo/pull/34735	(@longvatrong111, #34735)	Convert http&https to ws&wss in websocket constructor (#34735)
48  https://github.com/servo/servo/pull/34736	(@shanehandley, #34736)	Implement referrerpolicy attribute on remaining elements (#34736)
58  https://github.com/servo/servo/pull/34719	(@Loirooriol, #34719)	layout: Fix intrinsic contributions of anonymous blocks (#34719)
>>> 2024-12-24T06:04:56Z
    https://github.com/servo/servo/pull/34760	(@dependabot[bot], @dependabot[bot], #34760)	build(deps): bump base64 from 0.21.7 to 0.22.1 (#34760)
    https://github.com/servo/servo/pull/34759	(@dependabot[bot], @dependabot[bot], #34759)	build(deps): bump truetype from 0.47.7 to 0.47.8 (#34759)
    https://github.com/servo/servo/pull/34761	(@dependabot[bot], @dependabot[bot], #34761)	build(deps): bump anyhow from 1.0.94 to 1.0.95 (#34761)
    https://github.com/servo/servo/pull/34758	(@dependabot[bot], @dependabot[bot], #34758)	build(deps): bump serde_json from 1.0.133 to 1.0.134 (#34758)
    https://github.com/servo/servo/pull/34757	(@dependabot[bot], @dependabot[bot], #34757)	build(deps): bump object from 0.36.5 to 0.36.7 (#34757)
    https://github.com/servo/servo/pull/34756	(@dependabot[bot], @dependabot[bot], #34756)	build(deps): bump syn from 2.0.90 to 2.0.91 (#34756)
    https://github.com/servo/servo/pull/34753	(@dependabot[bot], @dependabot[bot], #34753)	build(deps): bump winit from 0.30.5 to 0.30.7 (#34753)
    https://github.com/servo/servo/pull/34755	(@dependabot[bot], @dependabot[bot], #34755)	build(deps): bump bytemuck_derive from 1.8.0 to 1.8.1 (#34755)
    https://github.com/servo/servo/pull/34754	(@dependabot[bot], @dependabot[bot], #34754)	build(deps): bump typeface from 0.4.2 to 0.4.3 (#34754)
    https://github.com/servo/servo/pull/34725	(@Loirooriol, #34725)	layout: Pass the right containing block to `find_block_margin_collapsing_with_parent_from_slice()` (#34725)
    https://github.com/servo/servo/pull/34765	(@jschwe, #34765)	Whitelist RUSTSEC-2024-0429 to fix CI (#34765)
59  https://github.com/servo/servo/pull/34695	(@Loirooriol, #34695)	layout: Implement keyword sizes for block layout heuristics (#34695)
>>> 2024-12-25T06:04:47Z
    https://github.com/servo/servo/pull/34775	(@dependabot[bot], @dependabot[bot], #34775)	build(deps): bump unicase from 2.8.0 to 2.8.1 (#34775)
    https://github.com/servo/servo/pull/34774	(@dependabot[bot], @dependabot[bot], #34774)	build(deps): bump taffy from 0.7.0 to 0.7.1 (#34774)
    https://github.com/servo/servo/pull/34742	(@willypuzzle, #34742)	Clone node on a shadow root should always throw an error (#34742)
45  https://github.com/servo/servo/pull/34772	(@sagudev, #34772)	Update mozjs to include SM 128.6 (#34772)
44  https://github.com/servo/servo/pull/34581	(@mrobinson, #34581)	script: Make timers per-process (#34581)
51  https://github.com/servo/servo/pull/34752	(@wusyong, #34752)	fix(wayland): segfault because of double free surfaces (#34752)
    https://github.com/servo/servo/pull/34749	(@stevennovaryo, #34749)	Add check for valid custom element name in element::attach_shadow (#34749)
    https://github.com/servo/servo/pull/34762	(@dependabot[bot], @dependabot[bot], #34762)	build(deps): bump bytemuck from 1.20.0 to 1.21.0 (#34762)
>>> 2024-12-26T06:00:09Z
    https://github.com/servo/servo/pull/34776	(@mrobinson, #34776)	script: Refactor channels in `ScriptThread` into receivers and senders (#34776)
>>> 2024-12-27T06:00:05Z
46  https://github.com/servo/servo/pull/34747	(@shanehandley, #34747)	Use spec-aligned process for resolving history handling during navigation (#34747)
    https://github.com/servo/servo/pull/34779	(@dependabot[bot], @dependabot[bot], #34779)	build(deps): bump quote from 1.0.37 to 1.0.38 (#34779)
52  https://github.com/servo/servo/pull/34769	(@jdm, @sagudev, #34769)	script: Handle null contexts better during JS runtime shutdown. (#34769)
16  https://github.com/servo/servo/pull/34505	(@jdm, #34505)	Don't run scripts while DOM tree is undergoing mutations (#34505)
    https://github.com/servo/servo/pull/34194	(@jdm, #34194)	Ensure ConsumeBodyPromiseHandler values are always rooted (#34194)
>>> 2024-12-28T05:59:19Z
    https://github.com/servo/servo/pull/34783	(@dependabot[bot], @dependabot[bot], #34783)	build(deps): bump rustversion from 1.0.18 to 1.0.19 (#34783)
    https://github.com/servo/servo/pull/34782	(@dependabot[bot], @dependabot[bot], #34782)	build(deps): bump cc from 1.2.5 to 1.2.6 (#34782)
    https://github.com/servo/servo/pull/34781	(@dependabot[bot], @dependabot[bot], #34781)	build(deps): bump syn from 2.0.91 to 2.0.92 (#34781)
>>> 2024-12-29T05:59:37Z
53  https://github.com/servo/servo/pull/34620	(@arthmis, @lazypassion, #34620)	Prompt user for credentials when http request needs it (#34620)
>>> 2024-12-30T06:04:39Z
https://github.com/servo/servo/pull/34792	(@webbeef, #34792)	Split StructuredCloneHolder into Reader and Writer structs (#34792)
60  https://github.com/servo/servo/pull/34791	(@jdm, #34791)	script: Add gdb/lldb helper to see the current JS stack. (#34791)
    https://github.com/servo/servo/pull/34786	(@mrobinson, #34786)	Correct a variety of documentation issues (#34786)
    https://github.com/servo/servo/pull/34789	(@servo-wpt-sync, @sagudev, #34789)	Sync WPT with upstream (29-12-2024) (#34789)
>>> 2024-12-31T06:04:42Z
    https://github.com/servo/servo/pull/34802	(@dependabot[bot], @dependabot[bot], #34802)	build(deps): bump glob from 0.3.1 to 0.3.2 (#34802)
    https://github.com/servo/servo/pull/34799	(@dependabot[bot], @dependabot[bot], #34799)	build(deps): bump serde from 1.0.216 to 1.0.217 (#34799)
>>> 2025-01-01T06:06:19Z
-->

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
