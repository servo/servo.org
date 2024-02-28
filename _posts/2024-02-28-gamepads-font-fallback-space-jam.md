---
layout:     post
tags:       blog
title:      "This month in Servo: gamepad support, font fallback, Space Jam, and more!"
date:       2024-02-28
summary:    Big strides in tables and layout architecture, a new CSS2 milestone, dev changes in WebRender and Stylo, plus console, canvas, and CSSOM improvements.
categories:
---

<figure class="_figr"><a href="{{ '/img/blog/font-fallback.png' | url }}"><img src="{{ '/img/blog/font-fallback.png' | url }}"
    alt="Servo nightly showing Chinese, Japanese, and Korean Wikipedia with working font fallback"></a>
<figcaption>Font fallback now works for Chinese, Japanese, and Korean.</figcaption></figure>

[A couple of weeks ago](https://wpt.servo.org), Servo surpassed its legacy layout engine in a core set of CSS2 test suites (84.2% vs 82.8% in legacy), but now we’ve **surpassed legacy in the whole CSS test suite** (63.6% vs 63.5%) as well!
More on how we got there in a bit, but first let’s talk about new API support:

- as of 2024-02-07, you can safely **console.log() symbols and large arrays** ([@syvb](https://github.com/syvb), [#31241](https://github.com/servo/servo/pull/31241), [#31267](https://github.com/servo/servo/pull/31267))
- as of 2024-02-07, we support **CanvasRenderingContext2D.reset()** ([@syvb](https://github.com/syvb), [#31258](https://github.com/servo/servo/pull/31258))
- as of 2024-02-08, we support **navigator.hardwareConcurrency** ([@syvb](https://github.com/syvb), [#31268](https://github.com/servo/servo/pull/31268))
- as of 2024-02-11, you can look up **shorthands like ‘margin’ in getComputedStyle()** ([@sebsebmc](https://github.com/sebsebmc), [#31277](https://github.com/servo/servo/pull/31277))
- as of 2024-02-15, we accept SVG with the **image/svg+xml mime type** ([@KiChjang](https://github.com/KiChjang), [#31318](https://github.com/servo/servo/pull/31318))
- as of 2024-02-20, we support non-XR **game controllers with the Gamepad API** ([@msub2](https://github.com/msub2), [#31200](https://github.com/servo/servo/pull/31200))
- as of 2024-02-23, we have basic support for **‘text-transform’** ([@mrobinson](https://github.com/mrobinson), [@atbrakhi](https://github.com/atbrakhi), [#31396](https://github.com/servo/servo/pull/31396))
  <br>— except ‘full-width’, ‘full-size-kana’, grapheme clusters, and language-specific transforms

As of 2024-02-12, we have basic support for **font fallback** ([@mrobinson](https://github.com/mrobinson), [#31254](https://github.com/servo/servo/pull/31254))!
This is especially important for pages that mix text from different languages.
More work is needed to support shaping across element boundaries and shaping complex scripts like Arabic, but the current version should be enough for Chinese, Japanese, and Korean.
If you encounter text that still fails to display, be sure to check your installed fonts against the page styles and Servo’s default font lists ([Windows](https://github.com/servo/servo/blob/304ab9b09c0beace5ac08c073c957060621d4056/components/gfx/platform/windows/font_list.rs), [macOS](https://github.com/servo/servo/blob/304ab9b09c0beace5ac08c073c957060621d4056/components/gfx/platform/macos/font_list.rs), [Linux](https://github.com/servo/servo/blob/304ab9b09c0beace5ac08c073c957060621d4056/components/gfx/platform/freetype/font_list.rs)).

<figure class="_figl"><a href="{{ '/img/blog/space-jam.png' | url }}"><img src="{{ '/img/blog/space-jam.png' | url }}"
    alt="Servo nightly showing the Space Jam (1996) website with its table-based menu correctly laid out"></a>
<figcaption>

[Space Jam (1996)](https://www.spacejam.com/1996/) now has correct layout with `--pref layout.tables.enabled`.</figcaption></figure>

As of 2024-02-24, **layout now runs in the script thread**, rather than in a dedicated layout thread ([@mrobinson](https://github.com/mrobinson), [@jdm](https://github.com/jdm), [#31346](https://github.com/servo/servo/pull/31346)), though it can still spawn worker threads to parallelise layout work.
Since the web platform almost always requires layout to run synchronously with script, this should allow us to make layout simpler and more reliable without regressing performance.

Our experimental **tables support** (`--pref layout.tables.enabled`) has vastly improved:

- as of 2024-01-26, we compute **table column widths** ([@mrobinson](https://github.com/mrobinson), [@Loiroriol](https://github.com/Loiroriol), [#31165](https://github.com/servo/servo/pull/31165))
- as of 2024-01-30, we support the **&lt;table cellpadding> attribute** ([@Loirooriol](https://github.com/Loirooriol), [#31201](https://github.com/servo/servo/pull/31201))
- as of 2024-02-11, we support **‘vertical-align’ in table cells** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#31246](https://github.com/servo/servo/pull/31246))
- as of <!-- 2024-01-27 --> 2024-02-14, we support **‘border-spacing’ on tables** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#31166](https://github.com/servo/servo/pull/31166), [#31337](https://github.com/servo/servo/pull/31337))
- as of 2024-02-21, we support **rows, columns, and row/column groups** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#31341](https://github.com/servo/servo/pull/31341))

Together with inline layout for **&lt;div align> and &lt;center>** ([@Loirooriol](https://github.com/Loirooriol), [#31388](https://github.com/servo/servo/pull/31388)) landing in 2024-02-24, we now render the classic **[Space Jam](https://www.spacejam.com/1996/)** website correctly when tables are enabled!

As of 2024-02-24, we support **videos with autoplay** ([@jdm](https://github.com/jdm), [#31412](https://github.com/servo/servo/pull/31412)), and windows containing **videos no longer crash** when closed ([@jdm](https://github.com/jdm), [#31413](https://github.com/servo/servo/pull/31413)).

Many layout and CSS bugs have also been fixed:

- as of 2024-01-28, correct **rounding of clientLeft, clientTop, clientWidth, and clientHeight** ([@mrobinson](https://github.com/mrobinson), [#31187](https://github.com/servo/servo/pull/31187))
- as of 2024-01-30, correct **cache invalidation of client{Left,Top,Width,Height} after reflow** ([@Loirooriol](https://github.com/Loirooriol), [#31210](https://github.com/servo/servo/pull/31210), [#31219](https://github.com/servo/servo/pull/31219))
- as of 2024-02-03, correct **width and height for preloaded Image objects** ([@syvb](https://github.com/syvb), [#31253](https://github.com/servo/servo/pull/31253))
- as of 2024-02-07, correct **\[\.\.\.spreading] and indexing\[0] of style objects** ([@Loirooriol](https://github.com/Loirooriol), [#31299](https://github.com/servo/servo/pull/31299))
- as of 2024-02-09, correct **border widths in fragmented inlines** ([@mrobinson](https://github.com/mrobinson), [#31292](https://github.com/servo/servo/pull/31292))
- as of 2024-02-11, correct **UA styles for &lt;hr>** ([@sebsebmc](https://github.com/sebsebmc), [#31297](https://github.com/servo/servo/pull/31297))
- as of 2024-02-24, correct **positioning of absolutes with ‘inset: auto’** ([@mrobinson](https://github.com/mrobinson), [#31418](https://github.com/servo/servo/pull/31418))

## Embedding, code health, and dev changes

We’ve landed a few embedding improvements:

- we’ve removed several mandatory `WindowMethods` relating to OpenGL video playback ([@mrobinson](https://github.com/mrobinson), [#31209](https://github.com/servo/servo/pull/31209))
- we’ve removed `webrender_surfman`, and `WebrenderSurfman` is now in `gfx` as `RenderingContext` ([@mrobinson](https://github.com/mrobinson), [#31184](https://github.com/servo/servo/pull/31184))

We’ve finished migrating our DOM bindings to use typed arrays where possible ([@Taym95](https://github.com/Taym95), [#31145](https://github.com/servo/servo/pull/31145), [#31164](https://github.com/servo/servo/pull/31164), [#31167](https://github.com/servo/servo/pull/31167), [#31189](https://github.com/servo/servo/pull/31189), [#31202](https://github.com/servo/servo/pull/31202), [#31317](https://github.com/servo/servo/pull/31317), [#31325](https://github.com/servo/servo/pull/31325)), as part of an effort to **reduce our unsafe code surface** ([#30889](https://github.com/servo/servo/issues/30889), [#30862](https://github.com/servo/servo/issues/30862)).

[WebRender](https://github.com/servo/webrender) and [Stylo](https://github.com/servo/stylo) are two major components of Servo that have been adopted by Firefox, making Servo’s versions of them a downstream fork.
To make these forks easier to update, we’ve **split WebRender and Stylo out of [our main repo](https://github.com/servo/servo)** ([@mrobinson](https://github.com/mrobinson), [@delan](https://github.com/delan), [#31212](https://github.com/servo/servo/pull/31212), [#31351](https://github.com/servo/servo/pull/31351), [#31349](https://github.com/servo/servo/pull/31349), [#31358](https://github.com/servo/servo/pull/31358), [#31363](https://github.com/servo/servo/pull/31363), [#31365](https://github.com/servo/servo/pull/31365), [#31408](https://github.com/servo/servo/pull/31408), [#31387](https://github.com/servo/servo/pull/31387), [#31411](https://github.com/servo/servo/pull/31411), [#31350](https://github.com/servo/servo/pull/31350)).

We’ve fixed one of the blockers for building Servo with clang 16 ([@mrobinson](https://github.com/mrobinson), [#31306](https://github.com/servo/servo/pull/31306)), but a blocker for clang 15 still remains.
See [#31059](https://github.com/servo/servo/issues/31059) for more details, including how to build Servo against clang 14.

We’ve also made some other dev changes:

- we’ve removed the unmaintained **libsimpleservo C API** ([@mrobinson](https://github.com/mrobinson), [#31172](https://github.com/servo/servo/pull/31172)), though we’re open to adding a new C API someday
- we’ve upgraded **surfman** such that it **no longer depends on winit** ([@mrobinson](https://github.com/mrobinson), [#31224](https://github.com/servo/servo/pull/31224))
- we’ve added support for building Servo on **Asahi Linux** ([@arrynfr](https://github.com/arrynfr), [#31207](https://github.com/servo/servo/pull/31207))
- we’ve fixed problems building Servo on **Debian** ([@mrobinson](https://github.com/mrobinson), [@atbrakhi](https://github.com/atbrakhi), [#31281](https://github.com/servo/servo/pull/31281), [#31276](https://github.com/servo/servo/pull/31276)) and **NixOS** ([@syvb](https://github.com/syvb), [#31231](https://github.com/servo/servo/pull/31231))
- we’ve fixed failures when **starting multiple CI try jobs** at once ([@mrobinson](https://github.com/mrobinson), [#31347](https://github.com/servo/servo/pull/31347))
- we’ve made several improvements to **mach try** for starting CI try jobs ([@sagudev](https://github.com/sagudev), [@mrobinson](https://github.com/mrobinson), [#31141](https://github.com/servo/servo/pull/31141), [#31290](https://github.com/servo/servo/pull/31290))

## Conference talks

Rakhi Sharma will [**speak about Servo’s achievements**](https://ossna2024.sched.com/event/1aBNF/a-year-of-servo-reboot-where-are-we-now-rakhi-sharma-igalia) at [Open Source Summit North America](https://events.linuxfoundation.org/open-source-summit-north-america/) on **16 April 2024** at **14:15 local time** (21:15 UTC).
In the meantime, check out Rakhi’s recent talk [*Embedding Servo in Rust projects*](https://fosdem.org/2024/schedule/event/fosdem-2024-2321-embedding-servo-in-rust-projects/), which she gave at [FOSDEM 2024](https://fosdem.org/2024/) on 3 February 2024:

<figure class="_fig">
    <video controls>
        <source src="https://video.fosdem.org/2024/h1308/fosdem-2024-2321-embedding-servo-in-rust-projects.av1.webm" type='video/webm; codecs="av01.0.08M.08.0.110.01.01.01.0"' />
        <source src="https://video.fosdem.org/2024/h1308/fosdem-2024-2321-embedding-servo-in-rust-projects.mp4" type='video/mp4' />
        <p><a href="https://fosdem.org/2024/schedule/event/fosdem-2024-2321-embedding-servo-in-rust-projects/">Embedding Servo in Rust projects</a> by Rakhi Sharma at FOSDEM 2024</p>
    </video>
</figure>

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
</style>
