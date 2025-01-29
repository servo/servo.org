---
layout:     post
tags:       blog
title:      "This month in Servo: Android nightlies, right-to-left, WebGPU, and more!"
date:       2024-10-03
summary:    Servo builds faster, runs faster, and gamepads are now enabled by default.
categories:
---

Servo has had several new features land in our nightly builds over the last month:

- as of 2024-09-10, we now support **&lt;ul type>** and **&lt;ul compact>** ([@simonwuelker](https://github.com/simonwuelker), [#33303](https://github.com/servo/servo/pull/33303))
- as of 2024-09-10, we now support **console.timeLog()** ([@simonwuelker](https://github.com/simonwuelker), [#33377](https://github.com/servo/servo/pull/33377))
- as of 2024-09-10, we now support the **encodeInto() method on TextEncoder** ([@webbeef](https://github.com/webbeef), [@mrobinson](https://github.com/mrobinson), [#33360](https://github.com/servo/servo/pull/33360))
- as of 2024-09-10, we now support **&lt;link rel=prefetch>** ([@simonwuelker](https://github.com/simonwuelker), [#33345](https://github.com/servo/servo/pull/33345))
- as of 2024-09-12, we now support **right-to-left languages**, except for floats ([@mrobinson](https://github.com/mrobinson), [@atbrakhi](https://github.com/atbrakhi), [#33375](https://github.com/servo/servo/pull/33375))
- as of 2024-09-14, we now support **‘table-layout: fixed’** ([@Loirooriol](https://github.com/Loirooriol), [@mrobinson](https://github.com/mrobinson), [#33384](https://github.com/servo/servo/pull/33384), [#33442](https://github.com/servo/servo/pull/33442))
- as of 2024-09-17, we now support the **‘reset’ event on XRReferenceSpace** properties ([@msub2](https://github.com/msub2), [#33460](https://github.com/servo/servo/pull/33460))
- as of 2024-09-19, we now support the **‘object-fit’** and **‘object-position’** properties ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#33479](https://github.com/servo/servo/pull/33479))
- as of 2024-09-19, **Crypto.getRandomValues()** can now take **BigInt64Array** or **BigUint64Array** ([@msub2](https://github.com/msub2), [#33485](https://github.com/servo/servo/pull/33485))
- as of 2024-09-25, we now support **‘innerText’** and **‘outerText’ on HTMLElement** ([@Melchizedek6809](https://github.com/Melchizedek6809), [@shanehandley](https://github.com/shanehandley), [#33312](https://github.com/servo/servo/pull/33312))


<figure><a href="{{ '/img/blog/september-2024.png' | url }}"><img src="{{ '/img/blog/september-2024.png' | url }}"
    alt="Servo nightly showing new support for <ul type>, right-to-left layout, ‘table-layout: fixed’, ‘object-fit’, ‘object-position’, crypto.getRandomValues(BigInt64Array) and (BigUint64Array), and innerText and outerText"></a></figure>


Servo’s flexbox support continues to mature, with support for **‘align-self: normal’** ([@Loirooriol](https://github.com/Loirooriol), [#33314](https://github.com/servo/servo/pull/33314)), plus corrections to **cross-axis percent units** in descendants ([@Loirooriol](https://github.com/Loirooriol), [@mrobinson](https://github.com/mrobinson), [#33242](https://github.com/servo/servo/pull/33242)), **automatic minimum sizes** ([@Loirooriol](https://github.com/Loirooriol), [@mrobinson](https://github.com/mrobinson), [#33248](https://github.com/servo/servo/pull/33248), [#33256](https://github.com/servo/servo/pull/33256)), **replaced flex items** ([@Loirooriol](https://github.com/Loirooriol), [@mrobinson](https://github.com/mrobinson), [#33263](https://github.com/servo/servo/pull/33263)), **baseline alignment** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#33347](https://github.com/servo/servo/pull/33347)), and **absolute descendants** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#33346](https://github.com/servo/servo/pull/33346)).

Our table layout has improved, with support for **width** and **height presentational attributes** ([@Loirooriol](https://github.com/Loirooriol), [@mrobinson](https://github.com/mrobinson), [#33405](https://github.com/servo/servo/pull/33405), [#33425](https://github.com/servo/servo/pull/33425)), as well as better handling of **‘border-collapse’** ([@Loirooriol](https://github.com/Loirooriol), [#33452](https://github.com/servo/servo/pull/33452)) and **extra &lt;col> and &lt;colgroup> columns** ([@Loirooriol](https://github.com/Loirooriol), [#33451](https://github.com/servo/servo/pull/33451)).

We’ve also started working on the intrinsic sizing keywords **‘min-content’**, **‘max-content’**, **‘fit-content’**, and **‘stretch’** ([@Loirooriol](https://github.com/Loirooriol), [@mrobinson](https://github.com/mrobinson), [#33492](https://github.com/servo/servo/pull/33492)).
Before we can support them, though, we needed to land patches to calculate intrinsic sizes, including for **percent units** ([@Loirooriol](https://github.com/Loirooriol), [@mrobinson](https://github.com/mrobinson), [#33204](https://github.com/servo/servo/pull/33204)), **aspect ratios** of replaced elements ([@Loirooriol](https://github.com/Loirooriol), [#33240](https://github.com/servo/servo/pull/33240)), **column flex containers** ([@Loirooriol](https://github.com/Loirooriol), [#33299](https://github.com/servo/servo/pull/33299)), and **‘white-space’** ([@Loirooriol](https://github.com/Loirooriol), [#33343](https://github.com/servo/servo/pull/33343)).

We’ve also worked on our **WebGPU support**, with support for **pipeline-overridable constants** ([@sagudev](https://github.com/sagudev), [#33291](https://github.com/servo/servo/pull/33291)), and major rework to **GPUBuffer** ([@sagudev](https://github.com/sagudev), [#33154](https://github.com/servo/servo/pull/33154)) and our **canvas presentation** ([@sagudev](https://github.com/sagudev), [#33387](https://github.com/servo/servo/pull/33387)).
As a result, **GPUCanvasContext** now properly supports (re)configuration and resize on **GPUCanvasContext** ([@sagudev](https://github.com/sagudev), [#33521](https://github.com/servo/servo/pull/33521)), presentation is now faster, and both are now more conformant with the spec.

## Performance and reliability

Servo now **sends font data over shared memory** ([@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#33530](https://github.com/servo/servo/pull/33530)), saving a huge amount of time over sending font data over IPC channels.

We now debounce resize events for **faster window resizing** ([@simonwuelker](https://github.com/simonwuelker), [#33297](https://github.com/servo/servo/pull/33297)), limit **document title updates** ([@simonwuelker](https://github.com/simonwuelker), [#33287](https://github.com/servo/servo/pull/33287)), and use DirectWrite kerning info for **faster text shaping on Windows** ([@crbrz](https://github.com/crbrz), [#33123](https://github.com/servo/servo/pull/33123)).

Servo has a new kind of **experimental profiling support** that can send profiling data to [Perfetto](https://ui.perfetto.dev) (on all platforms) and [HiTrace](https://github.com/openharmony/hiviewdfx_hitrace) (on OpenHarmony) via [`tracing`](https://tracing.rs) ([@atbrakhi](https://github.com/atbrakhi), [@delan](https://github.com/delan), [#33188](https://github.com/servo/servo/pull/33188), [#33301](https://github.com/servo/servo/pull/33301), [#33324](https://github.com/servo/servo/pull/33324)), and we’ve instrumented Servo with this in several places ([@atbrakhi](https://github.com/atbrakhi), [@delan](https://github.com/delan), [#33189](https://github.com/servo/servo/pull/33189), [#33417](https://github.com/servo/servo/pull/33417), [#33436](https://github.com/servo/servo/pull/33436)).
This is in addition to Servo’s existing [HTML-trace-based profiling support](https://book.servo.org/hacking/profiling.html#generating-timelines).

We’ve also added a new `profiling` Cargo profile that builds Servo with the recommended settings for profiling ([@delan](https://github.com/delan), [#33432](https://github.com/servo/servo/pull/33432)).
For more details on building Servo for profiling, benchmarking, and other perf-related use cases, check out our updated [Building Servo](https://book.servo.org/hacking/building-servo.html#build-profiles) chapter ([@delan](https://github.com/delan), [book#22](https://github.com/servo/book/pull/22)).

## Build times

The first patch towards [**splitting up our massive `script` crate**](https://github.com/servo/servo/issues/1799) has landed ([@sagudev](https://github.com/sagudev), [#33169](https://github.com/servo/servo/pull/33169)), over ten years since that issue was first opened.

`script` is the heart of the Servo rendering engine — it contains the HTML event loop plus all of our DOM APIs and their bindings to SpiderMonkey, and the script thread drives the page lifecycle from parsing to style to layout.
`script` is also a monolith, with over 170 000 lines of hand-written Rust plus another 520 000 lines of generated Rust, and it has long dominated Servo’s build times to the point of being unwieldy, so it’s very exciting to see that we may be able to change this.

Contributors to Servo can now enjoy faster **self-hosted CI runners** for our **Linux builds** ([@delan](https://github.com/delan), [@mrobinson](https://github.com/mrobinson), [#33321](https://github.com/servo/servo/pull/33321), [#33389](https://github.com/servo/servo/pull/33389)), cutting a typical **Linux-only build** from over half an hour to **under 8 minutes**, and a typical **[T-full](https://book.servo.org/contributing.html#running-tests-in-pull-requests) try job** from over an hour to **under 42 minutes**.

We’ve now started exploring self-hosted macOS runners ([@delan](https://github.com/delan), [ci-runners#3](https://github.com/servo/ci-runners/pull/3)), and in the meantime we’ve landed several fixes for self-hosted build failures ([@delan](https://github.com/delan), [@sagudev](https://github.com/sagudev), [#33283](https://github.com/servo/servo/pull/33283), [#33308](https://github.com/servo/servo/pull/33308), [#33315](https://github.com/servo/servo/pull/33315), [#33373](https://github.com/servo/servo/pull/33373), [#33471](https://github.com/servo/servo/pull/33471), [#33596](https://github.com/servo/servo/pull/33596)).

<figure class="_figl"><a href="{{ '/img/blog/servoshell-tabs-september-2024.png' | url }}"><img src="{{ '/img/blog/servoshell-tabs-september-2024.png' | url }}"
    alt="servoshell on desktop with improved tabbed browsing UI"></a></figure>

<figure class="_figl" style="clear: left;"><a href="{{ '/img/blog/servoshell-android-september-2024.png' | url }}"><img src="{{ '/img/blog/servoshell-android-september-2024.png' | url }}"
    alt="servoshell on Android with new navigation UI"></a></figure>

## <span class=_floatmin></span>Beyond the engine

You can now **download [the Servo browser](https://book.servo.org/running-servoshell.html) for Android** on [servo.org](https://servo.org) ([@mukilan](https://github.com/mukilan), [#33435](https://github.com/servo/servo/pull/33435))!
servoshell now **supports gamepads by default** ([@msub2](https://github.com/msub2), [#33466](https://github.com/servo/servo/pull/33466)), **builds for OpenHarmony** ([@mukilan](https://github.com/mukilan), [#33295](https://github.com/servo/servo/pull/33295)), and has **better navigation on Android** ([@msub2](https://github.com/msub2), [#33294](https://github.com/servo/servo/pull/33294)).

**Tabbed browsing** on desktop platforms has become a lot more polished, with visible **close and new tab buttons** ([@Melchizedek6809](https://github.com/Melchizedek6809), [#33244](https://github.com/servo/servo/pull/33244)), **key bindings for switching tabs** ([@Melchizedek6809](https://github.com/Melchizedek6809), [#33319](https://github.com/servo/servo/pull/33319)), as well as better handling of **empty tab titles** ([@Melchizedek6809](https://github.com/Melchizedek6809), [@mrobinson](https://github.com/mrobinson), [#33354](https://github.com/servo/servo/pull/33354), [#33391](https://github.com/servo/servo/pull/33391)) and the **location bar** ([@webbeef](https://github.com/webbeef), [#33316](https://github.com/servo/servo/pull/33316)).

We’ve also fixed **several HiDPI bugs** in servoshell ([@mukilan](https://github.com/mukilan), [#33529](https://github.com/servo/servo/pull/33529)), as well as **keyboard input** and scrolling on Windows ([@crbrz](https://github.com/crbrz), [@jdm](https://github.com/jdm), [#33225](https://github.com/servo/servo/pull/33225), [#33252](https://github.com/servo/servo/pull/33252)).

## Donations

Thanks again for your generous support!
We are now receiving **4147 USD/month** (+34.7% over August) in recurring donations.
This includes donations from **12 people** on LFX, but we will stop accepting donations there soon — **please move your recurring donations to [GitHub](https://github.com/sponsors/servo) or [Open Collective](https://opencollective.com/servo)**.

Servo is also on [thanks.dev](https://thanks.dev), and already **eleven GitHub users** that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 4147 / 10000); padding-left: 0.5em;"><strong>4147</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 4147 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="4147" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

With this money, we’ve been able to pay for our web hosting and self-hosted CI runners for Windows and Linux builds, and when the time comes, we’ll be able to afford macOS runners, perf bots, and maybe even an Outreachy intern or two!
As always, use of these funds will be decided transparently in the Technical Steering Committee.
For more details, head to our [Sponsorship page]({{ '/sponsorship/' | url }}).

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
