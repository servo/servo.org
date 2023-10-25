---
layout:     post
tags:       blog
title:      "This month in Servo: CSS filters, testing changes, Tauri, and more!"
date:       2023-10-25
summary:    Catch up on our recent conference talks, embedding news, and testing changes, plus nightly updates around media queries, the DOM, upgrades, CSS filters, and canvas performance.
categories:
---

Servo has had some exciting changes land in our nightly builds over the last month:

* as of 2023-09-23, **‘@media (resolution)’** queries are now supported ([@sagudev](https://github.com/sagudev), [#30406](https://github.com/servo/servo/pull/30406))
* as of 2023-09-28, the **‘dir’ attribute getter** now behaves correctly ([@EnnuiL](https://github.com/EnnuiL), [#30435](https://github.com/servo/servo/pull/30435))
    * this fixes **over 12000 subtests** in the HTML test suite!

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
</style>

Much of the recent work on Servo has been around upgrading the components we share with Firefox:

* **SpiderMonkey** — upgraded from 107 to 115 ([@sagudev](https://github.com/sagudev), [mozjs#408](https://github.com/servo/mozjs/pull/408), [#30379](https://github.com/servo/servo/pull/30379))
* **Stylo** — upgrade continues, with another 65 commits now landed in Servo ([@Loirooriol](https://github.com/Loirooriol), [#30421](https://github.com/servo/servo/pull/30421))
* **WebRender** — upgraded to [May 2021]([#30323](https://github.com/servo/servo/pull/30323)), now fixing regressions and preparing for more breaking changes:
    * <span class=_none>as of 2023-09-19,</span> we’ve fixed a scrolling regression in **Acid2** and other quirks mode pages ([@mrobinson](https://github.com/mrobinson), [#30375](https://github.com/servo/servo/pull/30375))
    * <span class=_none>as of 2023-09-21,</span> we’ve fixed a major **WebGL** regression related to tile cache invalidation ([@mukilan](https://github.com/mukilan), [#30390](https://github.com/servo/servo/pull/30390))
    * <span class=_none>as of 2023-10-04,</span> pinch zoom is now handled in Servo, preparing us for its removal from WebRender ([@mrobinson](https://github.com/mrobinson), [#30446](https://github.com/servo/servo/pull/30446), [#30459](https://github.com/servo/servo/pull/30459))

Sometimes the best source of ideas for improving Servo is to focus on a real-world app.
[Ennui @EnnuiL](https://github.com/EnnuiL) is doing exactly that with [Cookie Clicker](https://orteil.dashnet.org/cookieclicker/), a 2013 idle game that relies on CSS positioning, transitions, transforms, filters, and 2D canvases.

* as of 2023-10-05, the **CSS ‘drop-shadow()‘ filter** is now supported ([@EnnuiL](https://github.com/EnnuiL), [#30439](https://github.com/servo/servo/pull/30439))
* as of 2023-10-10, CSS filters are now correctly **clipped by ‘overflow: hidden’** ([@EnnuiL](https://github.com/EnnuiL), [#30517](https://github.com/servo/servo/pull/30517))
* as of 2023-10-19, **drawImage()** on a 2D canvas now uses shared memory for performance ([@EnnuiL](https://github.com/EnnuiL), [#30544](https://github.com/servo/servo/pull/30544))
* her work continues in [#30535](https://github.com/servo/servo/issues/30535), with an analysis of Servo’s performance issues under Cookie Clicker

<figure class="_fig">
    <div class="_flex">
        <a href="{{ '/img/blog/drop-shadow-filter-before.png' | url }}"><img src="{{ '/img/blog/drop-shadow-filter-before.png' | url }}"
            alt="Cookie Clicker on Servo 2023-10-04, without the drop-shadow() filter"></a>
        <a href="{{ '/img/blog/drop-shadow-filter-after.png' | url }}"><img src="{{ '/img/blog/drop-shadow-filter-after.png' | url }}"
            alt="Cookie Clicker on Servo 2023-10-05, now with the drop-shadow() filter"></a>
    </div>
    <figcaption>
        left: Cookie Clicker as of 2023-10-04
        <br>right: Cookie Clicker as of 2023-10-05
    </figcaption>
</figure>

<div class="_runin"><p><span class="_floatmin"></span>There have also been some changes to our internals that affect </p><h2>contributing to Servo</h2><p>.</p></div>

**Debug assertions** are now enabled everywhere except for official nightly releases ([@delan](https://github.com/delan), [#30509](https://github.com/servo/servo/pull/30509)).
This includes both debug (`-d --dev`) and release (`-r --release`) builds locally, as well as try jobs and most other builds on CI.
For more details, see [HACKING_QUICKSTART.md](https://github.com/servo/servo/blob/master/docs/HACKING_QUICKSTART.md).

With debug assertions enabled, you can use [debug_assert!()](https://doc.rust-lang.org/std/macro.debug_assert.html) to panic when an invariant is violated, much like you would use [DCHECK()](https://source.chromium.org/chromium/chromium/src/+/main:base/check.h;drc=95330f60656455a82d816e24907ed67b99cb8720) in Chromium, or for more complex checks, you can wrap code in `#[cfg(debug_assertions)]` or `if cfg!(debug_assertions) {}`.
Note that panicking in official releases — where `cfg!(debug_assertions)` is false — is still verboten in general, and those panics should almost always warn and/or gracefully recover instead.

<div class="_runin" style="clear: both;"><p>Servo has long aimed to become an </p><h2>embeddable web engine</h2><p>, and our next step on this journey will be supported by a grant from <a href="https://nlnet.nl/project/Tauri-Servo/">NLNet</a>!
Over the next few months, we will be collaborating with the developers of <a href="https://tauri.app">Tauri</a> to make Servo available as a webview backend.</p></div>

Tauri is a framework for building desktop apps that combine a web frontend with a Rust backend, and work is already ongoing to expand it to mobile apps and other backend languages.
But unlike say, Electron or React Native, Tauri is both frontend-agnostic and engine-agnostic, allowing you to use any frontend tooling you like and whichever web engine makes the most sense for your users.

At the moment, Tauri supports webkit2gtk (WebKit) on Linux, WebView2 (Chromium) on Windows, and WKWebView (WebKit) on macOS and iOS, in each case leveraging the system webview where possible.
With this project to add support for Servo in Tauri, we hope to make embedding Servo easier than ever.

For more details, subscribe to our tracking issue [#30593](https://github.com/servo/servo/issues/30593).

<div class="_runin"><p>This was a big month for Servo at </p><h2>conferences and events</h2><p> too! You can catch up on our recent talks here:</p></div>

* on 18 September, [**Servo project update**](https://www.youtube.com/watch?v=J4qedc-0pjs&t=2356s), by Manuel Rego at [LF Europe Member Summit](https://lfeuropems2023.sched.com/event/1PCHu)
* on 21 September, [**Servo Web Rendering Engine Reboot**](https://www.youtube.com/watch?v=9lkIX5ryZZ4), by Manuel Rego at [Open Source Summit Europe](https://osseu2023.sched.com/event/1OGkc)
* on 24 September, [**You can work on the web platform!**](https://www.bilibili.com/video/BV1Hw411r7Q6/), by Martin Robinson at [GOSIM workshop 2023](https://workshop2023.gosim.org/schedule#mobile)
* on 26 September, **Servo: a web view from somewhere else** (video pending), by Martin Robinson at [GOSIM conference 2023](https://conference2023.gosim.org/schedule#mobile)
* on 17 October, [**Servo**](https://servo.org/slides/2023-10-17-eclipsecon/), by Rakhi Sharma at [EclipseCon 2023](https://www.eclipsecon.org/2023/)
