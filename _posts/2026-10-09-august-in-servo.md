---
layout:     post
tags:       blog
title:      "August in Servo: CSS Grid, text selection, and more!"
date:       2026-10-09
summary:    Plus accessibility and navigation improvements.
categories:
---

<style>
code {
  white-space: nowrap;
}
</style>

[**Servo 0.6.0**](https://github.com/servo/servo/releases/tag/v0.6.0) contains all of the changes we landed in August, which came out to **417 commits**!

The big news is that we've turned on support for **CSS Grid** by default ([@nicoburns](https://github.com/nicoburns), [#45621](https://github.com/servo/servo/pull/45621)).
This has had a huge positive impact on the visual appearance of many websites!

<figure>
    <a href="{{ '/img/blog/2026-10-gary.png' | url }}"><img src="{{ '/img/blog/2026-10-gary.png' | url }}" alt="a black and white cat named Gary showing off new visual web platform features"></a>
</figure>

We’ve shipped several new web platform features:

- **touch-action** ([@yezhizhen](https://github.com/yezhizhen), [#47043](https://github.com/servo/servo/pull/47043))
- **animation-composition** ([@nicoburns](https://github.com/nicoburns), [#47405](https://github.com/servo/servo/pull/47405))
- **color-scheme** ([@TimvdLippe](https://github.com/TimvdLippe), [#47042](https://github.com/servo/servo/pull/47042))
- **full-width**, **math-auto**, **full-size-kana** values for **text-transform** ([@SimonSapin](https://github.com/SimonSapin), [#47160](https://github.com/servo/servo/pull/47160), [#47160](https://github.com/servo/servo/pull/47160), [#47225](https://github.com/servo/servo/pull/47225))

Plus a bunch of new DOM APIs:

- **requestAnimationFrame()** on **DedicatedWorkerGlobalScope** ([@Taym95](https://github.com/Taym95), [#46232](https://github.com/servo/servo/pull/46232))
- **ancestorOrigins** on **Location** ([@TimvdLippe](https://github.com/TimvdLippe), [@mrobinson](https://github.com/mrobinson), [#46056](https://github.com/servo/servo/pull/46056))
- **imagesrcset** and **imagesizes** on `<link rel=preload as=image>` ([@lumiscosity](https://github.com/lumiscosity), [@TimvdLippe](https://github.com/TimvdLippe), [#47103](https://github.com/servo/servo/pull/47103))
- **style** on **CSSFontFaceRule** ([@simonwuelker](https://github.com/simonwuelker), [#47388](https://github.com/servo/servo/pull/47388))
- **isReloadNavigation** and **isHistoryNavigation** on **Request** ([@Taym95](https://github.com/Taym95), [@yezhizhen](https://github.com/yezhizhen), [#46917](https://github.com/servo/servo/pull/46917))
- **name=color-scheme** on `<meta>` ([@TimvdLippe](https://github.com/TimvdLippe), [@jdm](https://github.com/jdm), [#46993](https://github.com/servo/servo/pull/46993))
- **focusin** and **focusout** events ([@RichardTjokroutomo](https://github.com/RichardTjokroutomo), [@yezhizhen](https://github.com/yezhizhen), [#46980](https://github.com/servo/servo/pull/46980))
- **new TextEvent()** ([@moamenhesham0](https://github.com/moamenhesham0), [@mrobinson](https://github.com/mrobinson), [#47391](https://github.com/servo/servo/pull/47391))
- **PeriodicWave** and **createPeriodicWave** on **BaseAudioContext** ([@kevlu93](https://github.com/kevlu93), [#47492](https://github.com/servo/servo/pull/47492))

This release also contains significant improvements to **navigation**, **document loading**, and **session history**, which are some of the [gnarliest](https://html.spec.whatwg.org/multipage/browsing-the-web.html#navigation-and-session-history) parts of the HTML specification. Who knew that loading `about:blank` was [so complicated](https://hsivonen.fi/about-blank/)? The upshot to all this work is that pages that open additional windows or include iframes work much more reliably.

This is another big update, so here’s an outline:

- [**Security**](#security)

- [**Real world compat**](#real-world-compat)

- [**Work in progress**](#work-in-progress)

- [**Embedding API**](#embedding-api)

- [**For users and developers**](#for-users-and-developers)

- [**More on the web platform**](#more-on-the-web-platform)

- [**Performance and stability**](#performance-and-stability)

- [**New contributors**](#new-contributors)

## Security

We upgraded to **SpiderMonkey v153**, which brings many new security and crash fixes to Servo's JavaScript engine integration ([@sagudev](https://github.com/sagudev), [@Gae24](https://github.com/Gae24), [#47489](https://github.com/servo/servo/pull/47489)).

Navigating away from a document that **activated fullscreen mode** now exits fullscreen mode ([@shubhamg13](https://github.com/shubhamg13), [@jdm](https://github.com/jdm), [#47123](https://github.com/servo/servo/pull/47123)).

## Real world compat

CSS Grid enabled by default means that many websites with traditional grid layouts now look correct, like [rustweek.org](https://rustweek.org/).

<figure class="_spaced">
    <div class="_peel" style="--default-position: 22%;">
        <div class="_line">
            <div class="_left"><div>v0.5.0</div></div>
            <div class="_right"><div>v0.6.0</div></div>
        </div>
        <img src="{{ '/img/blog/2026-10-grid2-before.png' | url }}">
        <img src="{{ '/img/blog/2026-10-grid2-after.png' | url }}">
    </div>
    <figcaption><a href="https://2026.rustweek.org/">2026.rustweek.org</a></figcaption>
</figure>

It also makes a lot of websites look better that you wouldn't assume rely on CSS Grid:

<figure class="_spaced">
    <div class="_peel" style="--default-position: 22%;">
        <div class="_line">
            <div class="_left"><div>v0.5.0</div></div>
            <div class="_right"><div>v0.6.0</div></div>
        </div>
        <img src="{{ '/img/blog/2026-10-grid-before.png' | url }}">
        <img src="{{ '/img/blog/2026-10-grid-after.png' | url }}">
    </div>
    <figcaption><a href="https://labs.jensimmons.com/">labs.jensimmons.com</a></figcaption>
</figure>

<style>
    ._spaced {
        margin: 1em 0;
    }
    ._halves {
        display: flex;
        flex-flow: row wrap;
    }
    ._halves > * {
        width: 50%;
    }
    ._peel {
        --default-position: 50%;
        position: relative;
        overflow: hidden;
        background: white;
        * {
            /* ensure ‘pointermove’ events always target the root */
            pointer-events: none;
            user-select: none;
        }
        img {
            background: white;
        }
        :not(:last-child) {
            position: absolute;
            inset: 0 auto 0 auto;
            width: var(--position, var(--default-position));
            height: 100%;
            object-fit: cover;
            object-position: top left;
        }
        ._line {
            z-index: 1;
            border-right: thin solid #1192e8;
            div {
                position: absolute;
                right: 0;
                width: 0;
            }
            div div {
                position: absolute;
                width: max-content;
                padding: 0 0.25em;
                background: #ffffff80;
            }
            ._left div {
                /* extend left of the line */
                right: 0;
            }
            ._right div {
                /* extend right of the line */
                left: 0;
            }
        }
    }
</style>

<script>
    for (const peel of document.querySelectorAll("._peel")) {
        peel.addEventListener("pointermove", event => {
            const position = Math.max(0, Math.min(1, event.offsetX / peel.offsetWidth));
            peel.style.setProperty("--position", `${position * 100}%`);
        }, true);
    }
</script>

Panning gestures initiated by touch inputs now lock to the dominant axis ([@yezhizhen](https://github.com/yezhizhen), [#46983](https://github.com/servo/servo/pull/46983)).
This results in more predictable panning when interacting with pages in Servo.

We fixed a crash affecting [gumroad.com.au](https://gumroad.com.au) ([@lumiscosity](https://github.com/lumiscosity), [#47266](https://github.com/servo/servo/pull/47266)).

We’re interested to hear how well your favourite websites run in Servo! Report successes in [this Zulip thread](https://servo.zulipchat.com/#narrow/channel/263398-general/topic/Servo.20web.20compat.20success.20stories/with/612898341) or [this Github discussion](https://github.com/servo/servo/discussions/49037), and failures [in our GitHub issues](https://github.com/servo/servo/issues).

## Work in progress

**Accessibility support** in Servo continues to make great strides; it can be enabled with the `--pref accessibility_enabled` command line argument.
Servo now reports **positions and sizes** for items in the content accessibility tree ([@philocalyst](https://github.com/philocalyst), [@alice](https://github.com/alice), [@mrobinson](https://github.com/mrobinson), [#46996](https://github.com/servo/servo/pull/46996)), allowing macOS VoiceOver to work more reliably.
We also report many [**ARIA roles**](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles) for web content elements to accessibility toolkits ([@mukilan](https://github.com/mukilan), [#47318](https://github.com/servo/servo/pull/47318)).
<details>
<summary>Full list of supported roles</summary>

- alert
- banner
- blockquote
- caption
- code
- complementary
- contentinfo
- definition
- deletion
- directory
- document
- emphasis
- feed
- figure
- generic
- insertion
- list
- log
- main
- math
- navigation
- none
- note
- paragraph
- presentation
- rowgroup
- search
- status
- strong
- term
- time
- timer

</details><br>


Servo's support for **Document.execCommand()** is rapidly improving, and can be enabled with `--pref dom_exec_command_enabled`.
We fixed issues with the **inserttext** command ([@Psychpsyo](https://github.com/Psychpsyo), [#47224](https://github.com/servo/servo/pull/47224), [#47306](https://github.com/servo/servo/pull/47306)), editing uneditable content ([@Psychpsyo](https://github.com/Psychpsyo), [#47362](https://github.com/servo/servo/pull/47362)), computing contained nodes ([@TimvdLippe](https://github.com/TimvdLippe), [#47429](https://github.com/servo/servo/pull/47429)), adjusting selections in **contenteditable** ([@mrobinson](https://github.com/mrobinson), [#47393](https://github.com/servo/servo/pull/47393), [#47581](https://github.com/servo/servo/pull/47581), [#47581](https://github.com/servo/servo/pull/47581)), and implemented the **indent** and **insertLineBreak** commands ([@Psychpsyo](https://github.com/Psychpsyo), [#47416](https://github.com/servo/servo/pull/47416), [#47445](https://github.com/servo/servo/pull/47445)).

We made a lot of progress on the **LargestContentfulPaint** performance metric, implemented behind the `--pref largest_contentful_paint_enabled` argument.
Servo now supports the **element** and **loadTime** attributes, ([@shubhamg13](https://github.com/shubhamg13), [#46553](https://github.com/servo/servo/pull/46553), [#47475](https://github.com/servo/servo/pull/47475)), URLs for video element posters ([@shubhamg13](https://github.com/shubhamg13), [#43376](https://github.com/servo/servo/pull/43376)), accurate size information ([@shubhamg13](https://github.com/shubhamg13), [#43378](https://github.com/servo/servo/pull/43378)), and painting text nodes ([@shubhamg13](https://github.com/shubhamg13), [#47212](https://github.com/servo/servo/pull/47212)).

There was preparatory work for a future [**AudioWorklet**](https://developer.mozilla.org/en-US/docs/Web/API/AudioWorklet) implementation ([@niyabits](https://github.com/niyabits), [#46856](https://github.com/servo/servo/pull/46856), [#47016](https://github.com/servo/servo/pull/47016), [#47199](https://github.com/servo/servo/pull/47199)).
See Niya's [blog post](https://text.tchncs.de/niya/wrapping-up-my-work-on-servos-audioworklet) about her Outreachy project for more details!

We're continuing work on the **ServiceWorker** feature, which can be enabled with `--pref dom_serviceworker_enabled`.
This month we implemented the **CookieStore** interface behind the `--pref dom_cookiestore_enabled` command line argument ([@Taym95](https://github.com/Taym95), [#47044](https://github.com/servo/servo/pull/47044)) as well as the **Cache** interface ([@gterzian](https://github.com/gterzian), [#47220](https://github.com/servo/servo/pull/47220)).

Servo now supports a **disk-backed HTTP cache** that can be enabled with `--pref network_http_disk_cache` ([@Narfinger](https://github.com/Narfinger), [#43819](https://github.com/servo/servo/pull/43819)).
This cache persists between runs, but there is not yet any way to clear it.

## Embedding API

**Breaking change:** [`WebView`](https://doc.servo.org/servo/struct.WebView.html)::`toggle_sampling_profiler` has been removed ([@lumiscosity](https://github.com/lumiscosity), [#47014](https://github.com/servo/servo/pull/47014)).
To perform sampling profiling on Servo, follow the instructions in [the book](https://book.servo.org/contributing/profiling.html).

**Breaking change:** The variants of [`MouseButton`](https://doc.servo.org/servo/enum.MouseButton.html) have been renamed to `Primary`, `Secondary`, and `Auxiliary` ([@mrobinson](https://github.com/mrobinson), [@SimonSapin](https://github.com/SimonSapin), [#47327](https://github.com/servo/servo/pull/47327)).

We've added several new Cargo features reflecting common usage patterns:
* `default_web_features`, to include optional web platform features in the build (e.g. WebXR and WebGPU) ([@jschwe](https://github.com/jschwe), [#44032](https://github.com/servo/servo/pull/44032))
* `bundled`, to include required resources in the binary ([@jschwe](https://github.com/jschwe), [#44032](https://github.com/servo/servo/pull/44032))
* `brotli-compression-stream`, enabling support for `brotli` content in the `CompressionStream`/`DecompressionStream` web APIs ([@Narfinger](https://github.com/Narfinger), [@jdm](https://github.com/jdm), [#47197](https://github.com/servo/servo/pull/47197))
* `webcrypto`, to enable support for the Crypto and WebCrypto web APIs ([@Narfinger](https://github.com/Narfinger), [#47198](https://github.com/servo/servo/pull/47198))
* `webgl`, to enable support for WebGL ([@janeoa](https://github.com/janeoa), [#47200](https://github.com/servo/servo/pull/47200))

## For users and developers

One visible change is that interactive **text selection** now works!
This is the result of lots of work across our script and layout code to ensure it respects the actual geometry of the page content ([@mrobinson](https://github.com/mrobinson), [@SimonSapin](https://github.com/SimonSapin), [#47022](https://github.com/servo/servo/pull/47022), [#47025](https://github.com/servo/servo/pull/47025), [#47329](https://github.com/servo/servo/pull/47329), [#47358](https://github.com/servo/servo/pull/47358), [#46982](https://github.com/servo/servo/pull/46982), [#47425](https://github.com/servo/servo/pull/47425), [#47438](https://github.com/servo/servo/pull/47438), [#47437](https://github.com/servo/servo/pull/47437), [#47581](https://github.com/servo/servo/pull/47581), [#47070](https://github.com/servo/servo/pull/47070), [#47048](https://github.com/servo/servo/pull/47048), [#46963](https://github.com/servo/servo/pull/46963)).

<figure>
    <a href="{{ '/img/blog/2026-10-select.png' | url }}"><img src="{{ '/img/blog/2026-10-select.png' | url }}" alt="servoshell 0.6.0 showing text selection on an element using CSS perspective"></a>
</figure>

Building Servo now requires at least **Clang 19** on all platforms ([@jschwe](https://github.com/jschwe), [#47421](https://github.com/servo/servo/pull/47421)).
Additionally, the `cargo-ohos` tool is now required for building for OpenHarmony ([@jschwe](https://github.com/jschwe), [#47334](https://github.com/servo/servo/pull/47334)).

Debug builds on Windows can now complete successfully ([@jschwe](https://github.com/jschwe), [#47372](https://github.com/servo/servo/pull/47372)).

Linux arm64 builds have been customized to work on **Raspberry Pi 5** ([@mukilan](https://github.com/mukilan), [#47113](https://github.com/servo/servo/pull/47113)).
Any libservo embedders targeting the same platform will require a similar change if they are using jemalloc.

### servoshell

Under **Wayland** and **OpenHarmony**, we now integrate with the system clipboard ([@TheZoq2](https://github.com/TheZoq2), [@yezhizhen](https://github.com/yezhizhen), [@jschwe](https://github.com/jschwe), [#46938](https://github.com/servo/servo/pull/46938), [#47177](https://github.com/servo/servo/pull/47177)).

The macOS command key and Windows logo key is now reported as `Meta` instead of `Super` ([@eachra-bawn](https://github.com/eachra-bawn), [#47330](https://github.com/servo/servo/pull/47330)).

The **Android** port has had many rough edges filed off as part of modernizing it for the **Compose UI** ([@veyndan](https://github.com/veyndan), [#47656](https://github.com/servo/servo/pull/47656), [#47491](https://github.com/servo/servo/pull/47491), [#47494](https://github.com/servo/servo/pull/47494), [#47697](https://github.com/servo/servo/pull/47697), [#46955](https://github.com/servo/servo/pull/46955), [#47644](https://github.com/servo/servo/pull/47644), [#47652](https://github.com/servo/servo/pull/47652), [#47276](https://github.com/servo/servo/pull/47276), [#47277](https://github.com/servo/servo/pull/47277), [#47299](https://github.com/servo/servo/pull/47299), [#47439](https://github.com/servo/servo/pull/47439)) and converting its implementation to Kotlin ([@veyndan](https://github.com/veyndan), [#46926](https://github.com/servo/servo/pull/46926), [#46925](https://github.com/servo/servo/pull/46925), [#46951](https://github.com/servo/servo/pull/46951), [#46965](https://github.com/servo/servo/pull/46965)).
Library consumers are no longer responsible for implementing **pause and resume** support ([@veyndan](https://github.com/veyndan), [#47555](https://github.com/servo/servo/pull/47555)).

Meanwhile, the **OpenHarmony** port now supports external keyboards with US keyboard layouts ([@jschwe](https://github.com/jschwe), [#47359](https://github.com/servo/servo/pull/47359)).
Additionally, there are now better fallback font selections for CJK characters ([@RichardTjokroutomo](https://github.com/RichardTjokroutomo), [#47116](https://github.com/servo/servo/pull/47116), [#47664](https://github.com/servo/servo/pull/47664)).

Setting the `device_pixel_ratio_override` preference is no longer ignored on Android and OpenHarmony ([@jschwe](https://github.com/jschwe), [#47081](https://github.com/servo/servo/pull/47081)).

## Performance and stability

There were many small changes this month that **removed unnecessary allocations** ([@Narfinger](https://github.com/Narfinger), [@jschwe](https://github.com/jschwe), [@yezhizhen](https://github.com/yezhizhen), [#47264](https://github.com/servo/servo/pull/47264), [#47147](https://github.com/servo/servo/pull/47147), [#47066](https://github.com/servo/servo/pull/47066), [#47249](https://github.com/servo/servo/pull/47249), [#47249](https://github.com/servo/servo/pull/47249), [#47285](https://github.com/servo/servo/pull/47285), [#47307](https://github.com/servo/servo/pull/47307), [#47343](https://github.com/servo/servo/pull/47343), [#47361](https://github.com/servo/servo/pull/47361), [#47395](https://github.com/servo/servo/pull/47395), [#47427](https://github.com/servo/servo/pull/47427), [#47454](https://github.com/servo/servo/pull/47454), [#47474](https://github.com/servo/servo/pull/47474), [#47506](https://github.com/servo/servo/pull/47506), [#47479](https://github.com/servo/servo/pull/47479), [#47530](https://github.com/servo/servo/pull/47530), [#47541](https://github.com/servo/servo/pull/47541), [#47566](https://github.com/servo/servo/pull/47566), [#47509](https://github.com/servo/servo/pull/47509), [#47622](https://github.com/servo/servo/pull/47622)).

We also **reduced GC interactions** leading to better JS performance ([@jdm](https://github.com/jdm), [@Narfinger](https://github.com/Narfinger), [@webbeef](https://github.com/webbeef), [@TimvdLippe](https://github.com/TimvdLippe), [@mrobinson](https://github.com/mrobinson), [#47513](https://github.com/servo/servo/pull/47513), [#47250](https://github.com/servo/servo/pull/47250), [#47158](https://github.com/servo/servo/pull/47158), [#47165](https://github.com/servo/servo/pull/47165), [#47049](https://github.com/servo/servo/pull/47049), [#47251](https://github.com/servo/servo/pull/47251), [#47510](https://github.com/servo/servo/pull/47510), [#46981](https://github.com/servo/servo/pull/46981)).

On platforms that memory map font data (such as OpenHarmony and macOS), we can now save time that would otherwise be spent loading font files from disk ([@jschwe](https://github.com/jschwe), [#47029](https://github.com/servo/servo/pull/47029)).
Similarly, reading system fonts is no longer in the critical path of starting up the engine ([@Narfinger](https://github.com/Narfinger), [@jdm](https://github.com/jdm), [#46476](https://github.com/servo/servo/pull/46476)).

There were were also a number of savings in the final binary size ([@jschwe](https://github.com/jschwe), [@kkoyung](https://github.com/kkoyung), [@Narfinger](https://github.com/Narfinger), [@jschwe](https://github.com/jschwe), [#47211](https://github.com/servo/servo/pull/47211), [#47214](https://github.com/servo/servo/pull/47214), [#47210](https://github.com/servo/servo/pull/47210), [#46950](https://github.com/servo/servo/pull/46950)).

We **fixed crashes** related to media playback ([@calvaris](https://github.com/calvaris), [#46891](https://github.com/servo/servo/pull/46891)), the 2d canvas renderer ([@yezhizhen](https://github.com/yezhizhen), [#46915](https://github.com/servo/servo/pull/46915)), fonts with negative line gaps ([@jschwe](https://github.com/jschwe), [#47374](https://github.com/servo/servo/pull/47374)), and resolving fonts variants ([@simonwuelker](https://github.com/simonwuelker), [#47356](https://github.com/servo/servo/pull/47356)).

Canvas renderer worker threads can now be adjusted by the `thread_pool_canvas_workers` preference, allowing more performance granularity according to embedder needs. ([@jschwe](https://github.com/jschwe), [#46691](https://github.com/servo/servo/pull/46691), [#47018](https://github.com/servo/servo/pull/47018))

We've continued our long-running effort to use the Rust type system to make Servo's integration with SpiderMonkey **safer and more reliable** ([@jdm](https://github.com/jdm), [@treetmitterglad](https://github.com/treetmitterglad), [@Narfinger](https://github.com/Narfinger), [@Gae24](https://github.com/Gae24), [#47398](https://github.com/servo/servo/pull/47398), [#47296](https://github.com/servo/servo/pull/47296), [#47051](https://github.com/servo/servo/pull/47051), [#47005](https://github.com/servo/servo/pull/47005), [#47323](https://github.com/servo/servo/pull/47323), [#47297](https://github.com/servo/servo/pull/47297), [#47322](https://github.com/servo/servo/pull/47322), [#47368](https://github.com/servo/servo/pull/47368), [#47446](https://github.com/servo/servo/pull/47446), [#47317](https://github.com/servo/servo/pull/47317)). We're also working on statically preventing [a footgun](https://github.com/servo/servo/issues/39139) that can lead to uncollectible GC cycles and leaking memory ([@Gae24](https://github.com/Gae24), [#47355](https://github.com/servo/servo/pull/47355), [#47650](https://github.com/servo/servo/pull/47650)).

Historically, **about:memory** has reported all memory usage by Rust implementations of JS APIs as one undifferentiated `js/malloc-heap` number.
We now break it down by memory usage of nodes in document trees ([@pylbrecht](https://github.com/pylbrecht), [#46931](https://github.com/servo/servo/pull/46931)) and interfaces that are not part of the DOM ([@jdm](https://github.com/jdm), [#47531](https://github.com/servo/servo/pull/47531)). We also report memory usage for the network stack's cookie database ([@Narfinger](https://github.com/Narfinger), [#47248](https://github.com/servo/servo/pull/47248)) and the canvas renderer backend ([@janeoa](https://github.com/janeoa), [@jdm](https://github.com/jdm), [#46958](https://github.com/servo/servo/pull/46958)).

We've added an **experimental threadboost** mechanism ([@jschwe](https://github.com/jschwe), [@mrobinson](https://github.com/mrobinson), [#46843](https://github.com/servo/servo/pull/46843), [#47027](https://github.com/servo/servo/pull/47027)) that has been observed to improve Speedometer results by **50%** and allow canvas rendering to reach 60 FPS.
This is initially enabled for OpenHarmony, but future expansion to other Linux-based platforms is expected.

## More on the web platform

We upgraded to [resvg 0.48](https://github.com/linebender/resvg/blob/main/CHANGELOG.md#0480-2026-07-31), fixing **many issues with SVG images** with missing width/height attributes that specified a `viewBox` ([@nicoburns](https://github.com/nicoburns), [#46937](https://github.com/servo/servo/pull/46937)).

Upgrading to [Taffy 0.14](https://github.com/DioxusLabs/taffy/blob/main/CHANGELOG.md#0130) fixed a number of **CSS grid-related crashes**, support for grid names, better intrinsic sizing, and improved performance ([@nicoburns](https://github.com/nicoburns), [#47031](https://github.com/servo/servo/pull/47031), [#47493](https://github.com/servo/servo/pull/47493)).
We also fixed some issues in the Taffy grid integration for more accurate baselines ([@nicoburns](https://github.com/nicoburns), [#47518](https://github.com/servo/servo/pull/47518)).

Session history traversals (i.e. navigating backwards or forwards in history) now wait for any outstanding traversal to complete ([@mrobinson](https://github.com/mrobinson), [#47293](https://github.com/servo/servo/pull/47293), [#47485](https://github.com/servo/servo/pull/47485)).
Meanwhile, navigations to `about:blank` are skipped if the initial about:blank document is present ([@jdm](https://github.com/jdm), [#47074](https://github.com/servo/servo/pull/47074)).

`about:blank` documents no longer use the asynchronous HTML parser ([@jdm](https://github.com/jdm), [#47050](https://github.com/servo/servo/pull/47050)), and no longer report a `readyState` of `LOADING` ([@mrobinson](https://github.com/mrobinson), [#47450](https://github.com/servo/servo/pull/47450)).
Opening auxiliary windows will wait to dispatch the load event until the initial `about:blank` document has [been replaced](https://html.spec.whatwg.org/multipage/document-sequences.html#windows%3Awindow) ([@jdm](https://github.com/jdm), [@mrobinson](https://github.com/mrobinson), [#47442](https://github.com/servo/servo/pull/47442), [#46975](https://github.com/servo/servo/pull/46975)).

For non-about:blank content, we also made the document loading phases more reliable ([@TimvdLippe](https://github.com/TimvdLippe), [@mrobinson](https://github.com/mrobinson), [#47426](https://github.com/servo/servo/pull/47426)), improved conformance of `javascript:` URL evaluation and navigation target selection ([@mrobinson](https://github.com/mrobinson), [#47486](https://github.com/servo/servo/pull/47486), [#47516](https://github.com/servo/servo/pull/47516)), and addressed longstanding compatibility issues with cross-origin `Window` and `Location` objects ([@mrobinson](https://github.com/mrobinson), [#47549](https://github.com/servo/servo/pull/47549)).

Our media playback has improved; we fixed several issues around **canPlayType()** on **HTMLMediaElement** that allow Servo to report that **MP4 content is playable** ([@jdm](https://github.com/jdm), [#47612](https://github.com/servo/servo/pull/47612), [#47641](https://github.com/servo/servo/pull/47641), [#47670](https://github.com/servo/servo/pull/47670)).

Input elements with the `autofocus` property inside of a `<dialog>` now receive focus when that dialog is opened ([@skyz1](https://github.com/skyz1), [@mrobinson](https://github.com/mrobinson), [#45826](https://github.com/servo/servo/pull/45826)).

We improved the exception error text for numerous web APIs ([@jdm](https://github.com/jdm), [@eachra-bawn](https://github.com/eachra-bawn), [#46960](https://github.com/servo/servo/pull/46960), [#47124](https://github.com/servo/servo/pull/47124), [#47168](https://github.com/servo/servo/pull/47168), [#47580](https://github.com/servo/servo/pull/47580), [#47430](https://github.com/servo/servo/pull/47430), [#47127](https://github.com/servo/servo/pull/47127)).

We also fixed issues related to many other APIs, including:
* matching other browsers' treatment of **Access-Control-Allow-Headers** ([@yezhizhen](https://github.com/yezhizhen), [#47600](https://github.com/servo/servo/pull/47600))
* WebCrypto **CryptoKey** usage checks ([@kkoyung](https://github.com/kkoyung), [#47112](https://github.com/servo/servo/pull/47112), [#47141](https://github.com/servo/servo/pull/47141), [#47178](https://github.com/servo/servo/pull/47178)) and key lengths ([@kkoyung](https://github.com/kkoyung), [#47452](https://github.com/servo/servo/pull/47452), [#47453](https://github.com/servo/servo/pull/47453))
* determining referrers when navigating ([@mrobinson](https://github.com/mrobinson), [#47487](https://github.com/servo/servo/pull/47487))
* reading **name** on **Window** inside of iframes ([@TimvdLippe](https://github.com/TimvdLippe), [@jdm](https://github.com/jdm), [#47270](https://github.com/servo/servo/pull/47270))
* many edge cases around determining dirty roots for incremental layout ([@mrobinson](https://github.com/mrobinson), [#46906](https://github.com/servo/servo/pull/46906))
* edge cases around **compareDocumentPosition** on **Node** ([@SimonSapin](https://github.com/SimonSapin), [#46886](https://github.com/servo/servo/pull/46886))
* resolving ties in web font matching ([@simonwuelker](https://github.com/simonwuelker), [#47449](https://github.com/servo/servo/pull/47449))
* Range.**getClientBoundingRect()**/**getClientRects**() for empty ranges ([@yezhizhen](https://github.com/yezhizhen), [#47143](https://github.com/servo/servo/pull/47143))
* JS module fetching failures can now be retried ([@Gae24](https://github.com/Gae24), [#46919](https://github.com/servo/servo/pull/46919))
* `KeyEvent.keyCode` values for many **nonprintable keys** now match other browsers ([@eachra-bawn](https://github.com/eachra-bawn), [#47461](https://github.com/servo/servo/pull/47461))
* making **timing** on **Performance** return a `PerformanceTiming` object ([@jdm](https://github.com/jdm), [@aniebietafia](https://github.com/aniebietafia), [#46990](https://github.com/servo/servo/pull/46990))
* synthesizing font variations from `font-style` ([@simonwuelker](https://github.com/simonwuelker), [@mrobinson](https://github.com/mrobinson), [#46918](https://github.com/servo/servo/pull/46918), [#47364](https://github.com/servo/servo/pull/47364))
* the **Get Element Tag Name** WebDriver command ([@yezhizhen](https://github.com/yezhizhen), [#47216](https://github.com/servo/servo/pull/47216))
* removed nonstandard WebDriver-related properties on the global object ([@mrobinson](https://github.com/mrobinson), [#47542](https://github.com/servo/servo/pull/47542))
* sniffing RAR responses correctly ([@wood-ghost](https://github.com/wood-ghost), [#47366](https://github.com/servo/servo/pull/47366))
* `Attribute` nodes created during parsing now have the expected namespace prefix ([@Ms2ger](https://github.com/Ms2ger), [#47030](https://github.com/servo/servo/pull/47030))
* improving **text-transform: capitalize** ([@mrobinson](https://github.com/mrobinson), [#46910](https://github.com/servo/servo/pull/46910))
* zero-sized margins inside of inline boxes ([@Loirooriol](https://github.com/Loirooriol), [#47020](https://github.com/servo/servo/pull/47020))
* incorrect `buttons` values in pointer capture transitions ([@steigeo](https://github.com/steigeo), [#45628](https://github.com/servo/servo/pull/45628))
* empty lists returned by **load()** on **FontFaceSet** ([@simonwuelker](https://github.com/simonwuelker), [#47564](https://github.com/servo/servo/pull/47564))
* cancelling more ongoing network requests when performing a navigation ([@mrobinson](https://github.com/mrobinson), [#47576](https://github.com/servo/servo/pull/47576))
* shaping text across inline boxes ([@mrobinson](https://github.com/mrobinson), [#46829](https://github.com/servo/servo/pull/46829))
* scrollable overflow for `position: sticky` ([@rayguo17](https://github.com/rayguo17), [#43766](https://github.com/servo/servo/pull/43766))
* fixing hyperlinks for blob: URLs ([@TimvdLippe](https://github.com/TimvdLippe), [#47226](https://github.com/servo/servo/pull/47226))
* firing the error callback for **decodeAudioData** on **BaseAudioContext** ([@amittenak47](https://github.com/amittenak47), [@jdm](https://github.com/jdm), [#46870](https://github.com/servo/servo/pull/46870))

## New contributors

A special thanks to the following people for landing their first patch in Servo:

* Frans Skarman ([@TheZoq2](https://github.com/TheZoq2), [#46938](https://github.com/servo/servo/pull/46938))
* Moamen Hesham ([@moamenhesham0](https://github.com/moamenhesham0), [#47391](https://github.com/servo/servo/pull/47391))
* Miles Wirht ([@philocalyst](https://github.com/philocalyst), [#46996](https://github.com/servo/servo/pull/46996))
* Vaibhav Srivastava ([@vaibhav8a](https://github.com/vaibhav8a), [#47626](https://github.com/servo/servo/pull/47626))
* wood-ghost ([@wood-ghost](https://github.com/wood-ghost), [#47366](https://github.com/servo/servo/pull/47366))
* 禾可 ([@Lfan-ke](https://github.com/Lfan-ke), [#47514](https://github.com/servo/servo/pull/47514))

Interested in helping build a web browser?
Take a look at our [curated list](https://starters.servo.org) of issues that are good for new contributors!

## Donations

Thanks again for your generous support!
We are now receiving **8128 USD/month** (+3% from July) in recurring donations.
This helps us cover the cost of our **[speedy](https://ci0.servo.org) [CI](https://ci1.servo.org) [and](https://ci2.servo.org) [benchmarking](https://ci3.servo.org) [servers](https://ci4.servo.org)**, one of our latest **[Outreachy interns](https://www.outreachy.org/alums/2026-05/#:~:text=Servo)**, and funding **[maintainer work]({{ '/blog/2026/09/15/one-year-of-sponsorship/' | url }})** that helps more people contribute to Servo.

Servo is also on [thanks.dev](https://thanks.dev), and already **36 GitHub users** (+1 from July) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

We now have [**sponsorship tiers**]({{ '/blog/2025/11/21/sponsorship-tiers/' | url }}) that allow you or your organisation to donate to the Servo project with public acknowlegement of your support.
If you’re interested in this kind of sponsorship, please contact us at [join@servo.org](mailto:join@servo.org).

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; right: calc(100% - 100% * 8124 / 10000); padding-right: 0.5em;"><strong>8128</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 8124 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="7824" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

Use of donations is decided transparently via the Technical Steering Committee’s public **[funding request process](https://github.com/servo/project/blob/main/FUNDING_REQUEST.md)**, and active proposals are tracked in [servo/project#187](https://github.com/servo/project/issues/187).
For more details, head to our [Sponsorship page]({{ '/sponsorship/' | url }}).

<style>
    kbd {
        background: #00000020;
        margin: 0 0.125rem;
        padding: 0.125rem;
        border-radius: 0.25rem;
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

<script>
    (function makeVideoPlayersClickable() {
        addEventListener("toggle", event => {
            const details = event.target.closest("details");
            if (!details?.open) {
                return;
            }
            const video = details.querySelector("video");
            if (!video) {
                return;
            }
            if (video.fastSeek) {
                video.fastSeek(0);
            } else {
                video.currentTime = 0;
            }
            video.play();
        }, true);
    })();
</script>
