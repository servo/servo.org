---
layout:     post
tags:       blog
title:      "This month in Servo: :is(), :where(), grid layout, parallel flexbox, and more!"
date:       2024-12-09
summary:    Plus shadow DOM buffs, smaller binaries, and new SubtleCrypto algorithms (HMAC, AES-GCM, AES-KW, PBKDF2).
categories:
---

<figure class="_figr"><a href="{{ '/img/blog/november-2024.png' | url }}"><img src="{{ '/img/blog/november-2024.png' | url }}" style="width: 33em;"
    alt="Servo nightly showing new support for CSS grid layout, when enabled via `layout.grid.enabled`"></a></figure>

Servo now supports **:is() and :where() selectors** ([@mrobinson](https://github.com/mrobinson), [#34066](https://github.com/servo/servo/pull/34066)), **parallel layout for flexbox** ([@mrobinson](https://github.com/mrobinson), [#34132](https://github.com/servo/servo/pull/34132)), and experimentally, **CSS grid layout** ([@nicoburns](https://github.com/nicoburns), [@taniishkaa](https://github.com/taniishkaa), [#32619](https://github.com/servo/servo/pull/32619), [#34352](https://github.com/servo/servo/pull/34352), [#34421](https://github.com/servo/servo/pull/34421))!
To try our new grid layout support, [run Servo](https://book.servo.org/running-servoshell.html) with  `--pref layout.grid.enabled`.

We’ve added support for two key Shadow DOM interfaces, the **shadowRoot property** on Element ([@simonwuelker](https://github.com/simonwuelker), [#34306](https://github.com/servo/servo/pull/34306)) and the **innerHTML property on ShadowRoot** ([@simonwuelker](https://github.com/simonwuelker), [#34335](https://github.com/servo/servo/pull/34335)).

We’ve also landed **‘justify-self’** on positioned elements ([@chickenleaf](https://github.com/chickenleaf), [#34235](https://github.com/servo/servo/pull/34235)), form submission with **&lt;input type=image>** ([@shanehandley](https://github.com/shanehandley), [#34203](https://github.com/servo/servo/pull/34203)), **DataTransfer** ([@Gae24](https://github.com/Gae24), [#34205](https://github.com/servo/servo/pull/34205)), the **close()** method on ImageBitmap ([@simonwuelker](https://github.com/simonwuelker), [#34124](https://github.com/servo/servo/pull/34124)), plus several new **[SubtleCrypto](https://developer.mozilla.org/en-US/docs/Web/API/SubtleCrypto) API** features:

- crypto.subtle.**deriveKey()** ([@simonwuelker](https://github.com/simonwuelker), [#34185](https://github.com/servo/servo/pull/34185))
- **wrapKey()** and **unwrapKey()** ([@msub2](https://github.com/msub2), [#34262](https://github.com/servo/servo/pull/34262))
- **“HMAC”** algorithm in **generateKey()** ([@simonwuelker](https://github.com/simonwuelker), [#34278](https://github.com/servo/servo/pull/34278)), **sign()**, **verify()** ([@simonwuelker](https://github.com/simonwuelker), [#34223](https://github.com/servo/servo/pull/34223)), and **deriveKey(`"get key length"`)** ([@simonwuelker](https://github.com/simonwuelker), [#34230](https://github.com/servo/servo/pull/34230))
- **“AES-GCM”** algorithm in **encrypt()**, **decrypt()**, **generateKey()**, and **importKey()** ([@simonwuelker](https://github.com/simonwuelker), [#34269](https://github.com/servo/servo/pull/34269))
- **“AES-KW”** algorithm in **generateKey()**, **importKey()**, **wrapKey()**, and **unwrapKey()** ([@msub2](https://github.com/msub2), [#34262](https://github.com/servo/servo/pull/34262))
- **“PBKDF2”** ([@simonwuelker](https://github.com/simonwuelker), [#34164](https://github.com/servo/servo/pull/34164)) and **“HKDF”** ([@simonwuelker](https://github.com/simonwuelker), [#34200](https://github.com/servo/servo/pull/34200)) algorithms in **deriveBits()**

On OpenHarmony, we’ve landed **keyboard input** and the IME ([@jschwe](https://github.com/jschwe), [@jdm](https://github.com/jdm), [@mukilan](https://github.com/mukilan), [#34188](https://github.com/servo/servo/pull/34188)), **touch fling gestures** ([@jschwe](https://github.com/jschwe), [@mrobinson](https://github.com/mrobinson), [#33219](https://github.com/servo/servo/pull/33219)), and additional **CJK fallback fonts** ([@jschwe](https://github.com/jschwe), [#34410](https://github.com/servo/servo/pull/34410)).
You can now build for OpenHarmony on a Windows machine ([@jschwe](https://github.com/jschwe), [#34113](https://github.com/servo/servo/pull/34113)), and build errors have been improved ([@jschwe](https://github.com/jschwe), [#34267](https://github.com/servo/servo/pull/34267)).

## More engine changes

You can now **scroll the viewport** and scrollable elements **with your pointer anywhere in the area**, not just when hovering over actual content ([@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#34347](https://github.com/servo/servo/pull/34347)).
`--unminify-js`, a very useful feature for [diagnosing Servo bugs in real websites](https://book.servo.org/hacking/web-compat-bugs.html#diagnosing-js-errors), now supports module scripts ([@jdm](https://github.com/jdm), [#34206](https://github.com/servo/servo/pull/34206)).

We’ve fixed the behaviour of **offsetLeft** and **offsetTop** relative to &lt;body> with ‘position: static’ ([@nicoburns](https://github.com/nicoburns), [@Loirooriol](https://github.com/Loirooriol), [#32761](https://github.com/servo/servo/pull/32761)), which also required spec changes ([@nicoburns](https://github.com/nicoburns), [@Loirooriol](https://github.com/Loirooriol), [w3c/csswg-drafts#10549](https://github.com/w3c/csswg-drafts/pull/10549)).
We’ve also fixed several layout bugs around:

- **‘object-fit’** when ‘aspect-ratio’ is set ([@Loirooriol](https://github.com/Loirooriol), [#34413](https://github.com/servo/servo/pull/34413))
- **clientWidth** and friends on floats and replaced inlines ([@Loirooriol](https://github.com/Loirooriol), [#34083](https://github.com/servo/servo/pull/34083))
- **‘align-items’** and **‘align-self: stretch’** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#34162](https://github.com/servo/servo/pull/34162))
- **main axis free space** in flexbox ([@mrobinson](https://github.com/mrobinson), [#34150](https://github.com/servo/servo/pull/34150))
- **min-** and **max-content block sizes** of replaced elements ([@Loirooriol](https://github.com/Loirooriol), [#34284](https://github.com/servo/servo/pull/34284))
- sizing of non-replaced positioned elements with **‘place-self’** ([@taniishkaa](https://github.com/taniishkaa), [#34264](https://github.com/servo/servo/pull/34264))

The **getClientRects()** method on Element now correctly returns a DOMRectList ([@chickenleaf](https://github.com/chickenleaf), [#34025](https://github.com/servo/servo/pull/34025)).

**Stylo** has been updated to 2024-11-01 ([@Loirooriol](https://github.com/Loirooriol), [#34322](https://github.com/servo/servo/pull/34322)), and we’ve landed some changes to prepare our fork of Stylo for publishing releases on crates.io ([@mrobinson](https://github.com/mrobinson), [@nicoburns](https://github.com/nicoburns), [#34332](https://github.com/servo/servo/pull/34332), [#34353](https://github.com/servo/servo/pull/34353)).
We’ve also made more progress towards **splitting up our massive `script` crate** ([@jdm](https://github.com/jdm), [@sagudev](https://github.com/sagudev), [#34357](https://github.com/servo/servo/pull/34357), [#34356](https://github.com/servo/servo/pull/34356), [#34163](https://github.com/servo/servo/pull/34163)), which will eventually allow Servo to be built (and rebuilt) much faster.

## Performance improvements

In addition to parallel layout for flexbox ([@mrobinson](https://github.com/mrobinson), [#34132](https://github.com/servo/servo/pull/34132)), we’ve landed several other performance improvements:

- faster layout for **‘column’ flex containers** ([@Loirooriol](https://github.com/Loirooriol), [@mrobinson](https://github.com/mrobinson), [#34346](https://github.com/servo/servo/pull/34346))
- faster caching of intrinsic sizes ([@Loirooriol](https://github.com/Loirooriol), [#34384](https://github.com/servo/servo/pull/34384))
- caching of font template matches ([@mukilan](https://github.com/mukilan), [@mrobinson](https://github.com/mrobinson), [#34325](https://github.com/servo/servo/pull/34325))
- fixed warnings and memory leak when WebRender is running late ([@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#34305](https://github.com/servo/servo/pull/34305))

We’ve also landed some changes to reduce Servo’s binary size:

- legacy layout is no longer built by default ([@jschwe](https://github.com/jschwe), [#34290](https://github.com/servo/servo/pull/34290))
- Servo no longer depends on `sparkle`, only `glow` and `gleam` ([@sagudev](https://github.com/sagudev), [#33918](https://github.com/servo/servo/pull/33918), [#34292](https://github.com/servo/servo/pull/34292))
- Servo can now be built without WebXR support ([@wusyong](https://github.com/wusyong), [@augustkline](https://github.com/augustkline), [@jdm](https://github.com/jdm), [@sagudev](https://github.com/sagudev), [#34241](https://github.com/servo/servo/pull/34241), [#34348](https://github.com/servo/servo/pull/34348))
- servoshell can now be built without WebXR on OpenHarmony and Android ([@jschwe](https://github.com/jschwe), [#34242](https://github.com/servo/servo/pull/34242)), with more platforms to come
- plus some progress towards a build-time feature flag for WebGPU ([@atbrakhi](https://github.com/atbrakhi), [#34415](https://github.com/servo/servo/pull/34415))

Servo’s **[tracing](https://docs.rs/tracing/0.1.40/tracing/)-based profiling support** (`--features tracing-perfetto` or `tracing-hitrace`) now supports **filtering events** via an environment variable ([@delan](https://github.com/delan), [#34236](https://github.com/servo/servo/pull/34236), [#34256](https://github.com/servo/servo/pull/34256)), and no longer includes events from non-Servo crates by default ([@delan](https://github.com/delan), [#34209](https://github.com/servo/servo/pull/34209)).
Note that when the filter matches some span or event, it will also match all of its descendants for now, but this is a limitation we intend to fix.

Most of the events supported by the old interval profiler have been **ported to tracing** ([@delan](https://github.com/delan), [#34238](https://github.com/servo/servo/pull/34238), [#34337](https://github.com/servo/servo/pull/34337)).
**ScriptParseHTML** and **ScriptParseXML** events no longer count the time spent doing layout and script while parsing, reducing them to more realistic times ([@delan](https://github.com/delan), [#34273](https://github.com/servo/servo/pull/34273)), while **ScriptEvaluate** events now count the time spent running scripts in timers, DOM event listeners, and many other situations ([@delan](https://github.com/delan), [#34286](https://github.com/servo/servo/pull/34286)), increasing them to more realistic times.

We’ve added new tracing events for **display list building** ([@atbrakhi](https://github.com/atbrakhi), [#34392](https://github.com/servo/servo/pull/34392)), **flex layout**, **inline layout**, and **font loading** ([@delan](https://github.com/delan), [#34392](https://github.com/servo/servo/pull/34392)).
This will help us diagnose performance issues around things like caching and relayout for ‘stretch’ in flex layout, shaping text runs, and font template creation.

## For developers

Hacking on Servo is now easier, with our **new `--profile medium` build mode** in Cargo ([@jschwe](https://github.com/jschwe), [#34035](https://github.com/servo/servo/pull/34035)).
`medium` is more optimised than `debug`, but unlike `release`, it supports debuggers, line numbers in backtraces, and incremental builds.

Servo **now uses [CODEOWNERS](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)** to list reviewers that are experts in [parts of our main repo](https://github.com/servo/servo/blob/3515b83a95cb65da30c1e3988f7a47f79fd7b9bd/.github/CODEOWNERS).
This should make it much easier to find reviewers that know how to review your code, and helps us maximise the quality of our code reviews by allowing reviewers to specialise.

## Donations

Thanks again for your generous support!
We are now receiving **4291 USD/month** (+2.1% over October) in recurring donations.
**We are no longer accepting donations on LFX** — if you were donating there, please move your recurring donations to [GitHub](https://github.com/sponsors/servo) or [Open Collective](https://opencollective.com/servo).

Servo is also on [thanks.dev](https://thanks.dev), and already **fifteen GitHub users** that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 4291 / 10000); padding-left: 0.5em;"><strong>4291</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 4291 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="4291" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

With this money, we’ve been able to cover our web hosting and self-hosted CI runners for Windows and Linux builds.
When the time comes, we’ll also be able to afford macOS runners and perf bots, as well as additional Outreachy interns next year!
As always, use of these funds will be decided transparently in the Technical Steering Committee.
For more details, head to our [Sponsorship page]({{ '/sponsorship/' | url }}).

## Conferences and blogs

- [**Servo Revival: 2023-2024**](https://blogs.igalia.com/mrego/servo-revival-2023-2024/) — Manuel Rego wrote about Igalia’s role in getting Servo back to life, and now thriving, over the past two years
- [**Porting Servo to OpenHarmony**](https://www.youtube.com/watch?v=gpz088cxDcI) — Jonathan Schwender spoke at [GOSIM China 2024](https://lfeumembersummit24.sched.com/event/1hUAF) about the work we’ve done towards supporting OpenHarmony in Servo
- [**Taming concurrency with (in)-formal methods in Servo**](https://www.youtube.com/watch?v=1c9sHaEXQak) — Gregory Terzian spoke at [GOSIM China 2024](https://lfeumembersummit24.sched.com/event/1hUAF) about using [TLA+](https://en.wikipedia.org/wiki/TLA%2B) to help us correctly implement concurrent algorithms like the HTML event loop in Servo

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
