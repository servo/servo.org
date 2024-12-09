---
layout:     post
tags:       blog
title:      "This month in Servo: :is() and :where(), grid layout, parallel flexbox, and more!"
date:       2024-12-09
summary:    Plus shadow DOM buffs, smaller binaries, and new SubtleCrypto algorithms (HMAC, AES-GCM, AES-KW, PBKDF2).
categories:
---

<figure class="_figr"><a href="{{ '/img/blog/november-2024.png' | url }}"><img src="{{ '/img/blog/november-2024.png' | url }}" style="width: 33em;"
    alt="Servo nightly showing new support for CSS grid layout"></a></figure>

Servo now supports **CSS grid layout** (@nicoburns, @taniishkaa, #32619, #34352, #34421), **parallel layout for flexbox** (@mrobinson, #34132), and **:is() and :where() selectors** (@mrobinson, #34066)!
We’ve also added support for two key Shadow DOM interfaces, the **shadowRoot property** on Element (@simonwuelker, #34306) and the **innerHTML property on ShadowRoot** (@simonwuelker, #34335).

Last month we also landed support for **‘justify-self’** on positioned elements (@chickenleaf, #34235), form submission with **&lt;input type=image>** (@shanehandley, #34203), **DataTransfer** (@Gae24, #34205), the **close()** method on ImageBitmap (@simonwuelker, #34124), plus several new **[SubtleCrypto](https://developer.mozilla.org/en-US/docs/Web/API/SubtleCrypto) API** features:

- crypto.subtle.**deriveKey()** (@simonwuelker, #34185)
- **wrapKey()** and **unwrapKey()** (@msub2, #34262)
- **“HMAC”** algorithm in **generateKey()** (@simonwuelker, #34278), **sign()**, **verify()** (@simonwuelker, #34223), and **deriveKey(`"get key length"`)** (@simonwuelker, #34230)
- **“AES-GCM”** algorithm in **encrypt()**, **decrypt()**, **generateKey()**, and **importKey()** (@simonwuelker, #34269)
- **“AES-KW”** algorithm in **generateKey()**, **importKey()**, **wrapKey()**, and **unwrapKey()** (@msub2, #34262)
- **“PBKDF2”** (@simonwuelker, #34164) and **“HKDF”** (@simonwuelker, #34200) algorithms in **deriveBits()**

On OpenHarmony, we’ve landed **keyboard input** and the IME (@jschwe, @jdm, @mukilan, #34188), **touch fling gestures** (@jschwe, @mrobinson, #33219), and additional **CJK fallback fonts** (@jschwe, #34410).
You can now build for OpenHarmony on a Windows machine (@jschwe, #34113), and build errors have been improved (@jschwe, #34267).

## More engine changes

You can now **scroll the viewport** and scrollable elements **with your pointer anywhere in the area**, not just when hovering over actual content (@mrobinson, @mukilan, #34347).
`--unminify-js`, a very useful feature for [diagnosing Servo bugs in real websites](https://book.servo.org/hacking/web-compat-bugs.html#diagnosing-js-errors), now supports module scripts (@jdm, #34206).

We’ve fixed the behaviour of **offsetLeft** and **offsetTop** relative to &lt;body> with ‘position: static’ (@nicoburns, @Loirooriol, #32761), which also required spec changes (@nicoburns, @Loirooriol, csswg-drafts#10549).
We’ve also fixed several layout bugs around:

- **‘object-fit’** when ‘aspect-ratio’ is set (@Loirooriol, #34413)
- **clientWidth** and friends on floats and replaced inlines (@Loirooriol, #34083)
- **‘align-items’** and **‘align-self: stretch’** (@mrobinson, @Loirooriol, #34162)
- **main axis free space** in flexbox (@mrobinson, #34150)
- **min-** and **max-content block sizes** of replaced elements (@Loirooriol, #34284)
- sizing of non-replaced positioned elements with **‘place-self’** (@taniishkaa, #34264)

The **getClientRects()** method on Element now correctly returns a DOMRectList (@chickenleaf, #34025).

**Stylo** has been updated to 2024-11-01 (@Loirooriol, #34322), and we’ve landed some changes to prepare our fork of Stylo for publishing releases on crates.io (@mrobinson, @nicoburns, #34332, #34353).
We’ve also made more progress towards **splitting up our massive `script` crate** (@jdm, @sagudev, #34357, #34356, #34163), which will eventually allow Servo to be built (and rebuilt) much faster.

## Performance improvements

In addition to parallel layout for flexbox (@mrobinson, #34132), we’ve landed several other performance improvements:

- faster layout for **‘column’ flex containers** (@Loirooriol, @mrobinson, #34346)
- faster caching of intrinsic sizes (@Loirooriol, #34384)
- caching of font template matches (@mukilan, @mrobinson, #34325)
- fixed warnings and memory leak when WebRender is running late (@mrobinson, @mukilan, #34305)

We’ve also landed some changes to reduce Servo’s binary size:

- legacy layout is no longer built by default (@jschwe, #34290)
- Servo no longer depends on `sparkle`, only `glow` and `gleam` (@sagudev, #33918, #34292)
- Servo can now be built without WebXR support (@wusyong, @augustkline, @jdm, @sagudev, #34241, #34348)
- servoshell can now be built without WebXR on OpenHarmony and Android (@jschwe, #34242), with more platforms to come
- plus some progress towards a build-time feature flag for WebGPU (@atbrakhi, #34415)

Servo’s **[tracing](https://docs.rs/tracing/0.1.40/tracing/)-based profiling support** (`--features tracing-perfetto` or `tracing-hitrace`) now supports **filtering events** via an environment variable (@delan, #34236, #34256), and no longer includes events from non-Servo crates by default (@delan, #34209).
Note that when the filter matches some span or event, it will also match all of its descendants for now, but this is a limitation we intend to fix.

Most of the events supported by the old interval profiler have been **ported to tracing** (@delan, #34238, #34337).
**ScriptParseHTML** and **ScriptParseXML** events no longer count the time spent doing layout and script while parsing, reducing them to more realistic times (@delan, #34273), while **ScriptEvaluate** events now count the time spent running scripts in timers, DOM event listeners, and many other situations (@delan, #34286), increasing them to more realistic times.

We’ve added new tracing events for **display list building** (@atbrakhi, #34392), **flex layout**, **inline layout**, and **font loading** (@delan, #34392).
This will help us diagnose performance issues around things like caching and relayout for ‘stretch’ in flex layout, shaping text runs, and font template creation.

## For developers

Hacking on Servo is now easier, with our **new `--profile medium` build mode** in Cargo (@jschwe, #34035).
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
