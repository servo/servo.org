---
layout:     post
tags:       blog
title:      "This month in Servo: tables, WOFF2, Outreachy, and more!"
date:       2024-03-30
summary:    Beginning of the end of legacy layout, runtime filtering of event logs, plus console, canvas, WebGPU, DOM, and CSS improvements.
categories:
---

<figure class="_figr" style="max-width: 100%;"><a href="{{ '/img/blog/new-in-march-2023.png' | url }}"><img src="{{ '/img/blog/new-in-march-2023.png' | url }}"
    alt="Servo nightly showing a table with ‘box-shadow’ and WOFF2 web fonts, containing demos of several other new features"
    style="width: calc(626px * 0.75);"></a>
<figcaption style="width: calc(626px * 0.75);">Servo now supports tables, box and text shadows, setting fonts on 2D canvases, synthetic small caps, conic and repeating conic gradients, and WOFF2 web fonts.</figcaption></figure>

<span class=_floatmin></span>This month, after surpassing our legacy layout engine in the CSS test suites, we’re proud to share that Servo has **surpassed legacy in the whole suite of Web Platform Tests** as well!

Servo now supports **WOFF2 web fonts** ([@mrobinson](https://github.com/mrobinson), [#31879](https://github.com/servo/servo/pull/31879)), **‘box-shadow’** ([@mrobinson](https://github.com/mrobinson), [#31453](https://github.com/servo/servo/pull/31453)), **‘text-shadow’** ([@mrobinson](https://github.com/mrobinson), [#31734](https://github.com/servo/servo/pull/31734)), **‘conic-gradient()’** and **‘repeating-conic-gradient()’** ([@mrobinson](https://github.com/mrobinson), [#31597](https://github.com/servo/servo/pull/31597)), and **[synthetic](https://developer.mozilla.org/en-US/docs/Web/CSS/font-synthesis-small-caps) small caps** ([@mrobinson](https://github.com/mrobinson), [#31435](https://github.com/servo/servo/pull/31435)).
**‘text-decoration: line-through’** is also supported on macOS now ([@mrobinson](https://github.com/mrobinson), [#31756](https://github.com/servo/servo/pull/31756)).

In other layout news, **tables are now enabled by default** ([@Loirooriol](https://github.com/Loirooriol), [#31470](https://github.com/servo/servo/pull/31470)), you can now **transform &lt;iframe> and &lt;img>** (and other inline replaced elements) without wrapping them in a container ([@mrobinson](https://github.com/mrobinson), [#31833](https://github.com/servo/servo/pull/31833)), we now have full support for **&lt;div align> and &lt;center>** ([@Loirooriol](https://github.com/Loirooriol), [#31423](https://github.com/servo/servo/pull/31423)), and **‘text-align: justify’** now takes **‘text-indent’** into account ([@mrobinson](https://github.com/mrobinson), [#31777](https://github.com/servo/servo/pull/31777)).

You can now **set the `font` on 2D canvases** ([@syvb](https://github.com/syvb), [#31436](https://github.com/servo/servo/pull/31436)), and use several other APIs:

- as of 2024-03-02, **&lt;meta http-equiv=&quot;Refresh&quot;>** ([@syvb](https://github.com/syvb), [#31468](https://github.com/servo/servo/pull/31468))
- as of 2024-03-15, **&lt;style disabled>** ([@Loirooriol](https://github.com/Loirooriol), [#31682](https://github.com/servo/servo/pull/31682))
- as of 2024-03-16, basic support for **getClientRects()** ([@mrobinson](https://github.com/mrobinson), [#31696](https://github.com/servo/servo/pull/31696))
- as of 2024-03-18, **console.count()** and **console.countReset()** ([@syvb](https://github.com/syvb), [#31635](https://github.com/servo/servo/pull/31635))
- as of 2024-03-20, **createComputePipelineAsync()** and **createRenderPipelineAsync()** ([@sagudev](https://github.com/sagudev), [#31695](https://github.com/servo/servo/pull/31695))
- as of 2024-03-23, **StaticRange** and **AbstractRange** ([@nipunG314](https://github.com/nipunG314), [@cathiechen](https://github.com/cathiechen), [#25466](https://github.com/servo/servo/pull/25466), [#31809](https://github.com/servo/servo/pull/31809))
- as of 2024-03-27, the obsolete **&lt;pre width>** attribute ([@bplaat](https://github.com/bplaat), [#31792](https://github.com/servo/servo/pull/31792))

Our dependency upgrades have also surged forward:

- [**WebRender**](https://github.com/servo/webrender) is now fully caught up with upstream ([@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#31486](https://github.com/servo/servo/pull/31486))
- [**Stylo**](https://github.com/servo/stylo) has been updated to September 2023 ([@Loirooriol](https://github.com/Loirooriol), [#31437](https://github.com/servo/servo/pull/31437), [#31609](https://github.com/servo/servo/pull/31609))
- [**SpiderMonkey**](https://github.com/servo/mozjs) has been bumped to 115.9 ([@sagudev](https://github.com/sagudev), [#31757](https://github.com/servo/servo/pull/31757))
- **GStreamer** is now at 0.22 ([@sagudev](https://github.com/sagudev), [#31465](https://github.com/servo/servo/pull/31465))

Servo now stops loading videos and other media after encountering decode errors ([@frereit](https://github.com/frereit), [#31748](https://github.com/servo/servo/pull/31748)), and our docs and dev tooling have been updated to ensure **support for WebM and AV1** ([@delan](https://github.com/delan), [#31687](https://github.com/servo/servo/pull/31687)).

Servo no longer crashes when **&lt;video poster> fails to load** ([@sebsebmc](https://github.com/sebsebmc), [#31447](https://github.com/servo/servo/pull/31447)), when interacting with **CSS layers** in the CSSOM ([@Loirooriol](https://github.com/Loirooriol), [#31481](https://github.com/servo/servo/pull/31481)).

We’ve also landed improvements to style invalidation ([@mrobinson](https://github.com/mrobinson), [#31857](https://github.com/servo/servo/pull/31857)), inline layout ([@mrobinson](https://github.com/mrobinson), [@atbrakhi](https://github.com/atbrakhi), [@Loirooriol](https://github.com/Loirooriol), [#31519](https://github.com/servo/servo/pull/31519), [#31636](https://github.com/servo/servo/pull/31636), [#31641](https://github.com/servo/servo/pull/31641), [#31681](https://github.com/servo/servo/pull/31681), [#31660](https://github.com/servo/servo/pull/31660), [#31896](https://github.com/servo/servo/pull/31896)), and table layout ([@Loirooriol](https://github.com/Loirooriol), [@mrobinson](https://github.com/mrobinson), [#31430](https://github.com/servo/servo/pull/31430), [#31421](https://github.com/servo/servo/pull/31421), [#31455](https://github.com/servo/servo/pull/31455), [#31487](https://github.com/servo/servo/pull/31487), [#31480](https://github.com/servo/servo/pull/31480), [#31484](https://github.com/servo/servo/pull/31484), [#31506](https://github.com/servo/servo/pull/31506), [#31535](https://github.com/servo/servo/pull/31535), [#31536](https://github.com/servo/servo/pull/31536), [#31578](https://github.com/servo/servo/pull/31578), [#31596](https://github.com/servo/servo/pull/31596), [#31586](https://github.com/servo/servo/pull/31586), [#31613](https://github.com/servo/servo/pull/31613), [#31606](https://github.com/servo/servo/pull/31606), [#31661](https://github.com/servo/servo/pull/31661), [#31619](https://github.com/servo/servo/pull/31619), [#31650](https://github.com/servo/servo/pull/31650), [#31704](https://github.com/servo/servo/pull/31704), [#31803](https://github.com/servo/servo/pull/31803), [#31862](https://github.com/servo/servo/pull/31862), [#31705](https://github.com/servo/servo/pull/31705), [#31831](https://github.com/servo/servo/pull/31831)).

As a result of the work done on Servo this month, we’ve made some big strides in [our pass rates](https://wpt.servo.org) for **CSS tables** (+30.4pp to 62.9%), **CSS2 margin-padding-clear** (+13.2pp to 93.6%), and **CSS2 box-display** (+10.0pp to 84.4%).

## servoshell and debug logging

servoshell has had a good amount of love this month, with a new **loading spinner** ([@frereit](https://github.com/frereit), [#31713](https://github.com/servo/servo/pull/31713)) and a **rendering glitch under the location bar now fixed** ([@delan](https://github.com/delan), [#31774](https://github.com/servo/servo/pull/31774)).
**Logging in servoshell is no longer mixed with libservo** ([@delan](https://github.com/delan), [#31439](https://github.com/servo/servo/pull/31439)), with the RUST_LOG prefix now being `servoshell::` instead of `servo::`.

Speaking of RUST_LOG, you can now **filter event logging in servoshell and the constellation at runtime** ([@delan](https://github.com/delan), [#31657](https://github.com/servo/servo/pull/31657), [#31659](https://github.com/servo/servo/pull/31659)), with the new RUST_LOG prefixes `servoshell<winit@`, `servoshell<servo@`, `servoshell>servo@`, `constellation<compositor@`, `constellation<script@`, and `constellation<layout@`.
For example:

- to trace all events in the constellation from layout, plus all events from the compositor other than ReadyToPresent:<br>
  <code style="word-wrap: break-word;">RUST_LOG='constellation<layout@,constellation<compositor@,constellation<compositor@ReadyToPresent=off'</code>
- to trace only winit window moved events in servoshell, plus all ordinary servoshell logs at trace level:<br>
  <code style="word-wrap: break-word;">RUST_LOG='servoshell,servoshell<=off,servoshell>=off,servoshell<winit@WindowEvent(Moved)'</code>

To learn more about the RUST_LOG syntax, see the [env_logger docs](https://docs.rs/env_logger/0.10.2/env_logger/#enabling-logging), and for the full list of event log targets, see [ports/servoshell/tracing.rs](https://github.com/servo/servo/blob/2d5a1cd02ee0c3196875dc52ca55a150a63cc29f/ports/servoshell/tracing.rs) and [components/constellation/tracing.rs](https://github.com/servo/servo/blob/2d5a1cd02ee0c3196875dc52ca55a150a63cc29f/components/constellation/tracing.rs).

<figure class="_fig" style="width: 100%;"><div style="display: flex; flex-flow: row nowrap; justify-content: center;">
    <video autoplay loop src="{{ '/img/blog/runtime-event-tracing-before.webm' | url }}" style="max-width: 50%;"></video>
    <video autoplay loop src="{{ '/img/blog/runtime-event-tracing-after.webm' | url }}" style="max-width: 50%;"></video>
</div><figcaption>Comparison of event tracing with and without runtime filtering</figcaption></figure>

<aside class="_note">

To keep things from getting too noisy, [@delan](https://github.com/delan) likes to use the event logging config below:

<code style="word-wrap: break-word;">RUST_LOG='warn,servoshell<,servoshell>,constellation<,servoshell<winit@DeviceEvent=off,servoshell<winit@MainEventsCleared=off,servoshell<winit@NewEvents(Poll)=off,servoshell<winit@NewEvents(WaitCancelled)=off,servoshell<winit@RedrawEventsCleared=off,servoshell<winit@RedrawRequested=off,servoshell<winit@UserEvent=off,servoshell<winit@WindowEvent(CursorMoved)=off,servoshell<winit@WindowEvent(AxisMotion)=off,servoshell<servo@EventDelivered=off,servoshell<servo@ReadyToPresent=off,servoshell>servo@Idle=off,servoshell>servo@MouseWindowMoveEventClass=off,constellation<compositor@LogEntry=off,constellation<compositor@ForwardEvent(MouseMoveEvent)=off,constellation<compositor@ReadyToPresent=off,constellation<compositor@TickAnimation=off,constellation<script@LogEntry=off,servoshell<winit@WindowEvent(Moved)=off'</code>
</aside>

## Embedding and dev changes

We’ve now defined a simple policy for reporting security vulnerabilities ([@mrego](https://github.com/mrego), [#31622](https://github.com/servo/servo/pull/31622)), though this is subject to change once Servo is no longer purely experimental.

Servo had a pervasive but confusing concept of webviews or pipelines being “visible”, which actually controls whether script runs timers at a heavily limited rate and the compositor pauses animations.
We’ve replaced this with the more concrete (but inverted) concept of a webview being “throttled” ([@delan](https://github.com/delan), [#31816](https://github.com/servo/servo/pull/31816)), including in our embedding API, where `WebViewVisibilityChanged` has been replaced with `SetWebViewThrottled` ([@delan](https://github.com/delan), [#31815](https://github.com/servo/servo/pull/31815)).

We’ve fixed broken rendering when running Servo in **Android emulators** ([@mukilan](https://github.com/mukilan), [#31727](https://github.com/servo/servo/pull/31727)), fixed linking problems with fontsan on Linux ([@jschwe](https://github.com/jschwe), [#31810](https://github.com/servo/servo/pull/31810), [#31821](https://github.com/servo/servo/pull/31821), [fontsan#33](https://github.com/servo/fontsan/pull/33), [fontsan#34](https://github.com/servo/fontsan/pull/34), [fontsan#35](https://github.com/servo/fontsan/pull/35)), and fixed a mozjs build issue ([@sagudev](https://github.com/sagudev), [#31889](https://github.com/servo/servo/pull/31889), [mozjs#460](https://github.com/servo/mozjs/pull/460)).

**mach fmt** now uses **stable Rust** ([@mrobinson](https://github.com/mrobinson), [#31441](https://github.com/servo/servo/pull/31441)) and should now be **much faster on macOS** ([@mrobinson](https://github.com/mrobinson), [#31440](https://github.com/servo/servo/pull/31440)).
**mach doc** is now working again, and the spurious **“crown” warnings have been fixed** ([@mrobinson](https://github.com/mrobinson), [#31804](https://github.com/servo/servo/pull/31804)).

As for **try jobs on CI**, builds now **immediately fail when Cargo.lock is out of date** ([@Loirooriol](https://github.com/Loirooriol), [#31720](https://github.com/servo/servo/pull/31720)), the **test result comments no longer ping random users** ([@sagudev](https://github.com/sagudev), [#31691](https://github.com/servo/servo/pull/31691)), and build artifacts now include the more compact **“wptreport” logs** ([@sagudev](https://github.com/sagudev), [#31616](https://github.com/servo/servo/pull/31616)).

We’ve also landed changes to reduce **test flakiness in requestAnimationFrame()** ([@mrobinson](https://github.com/mrobinson), [#31561](https://github.com/servo/servo/pull/31561)), as well as when the compositor waits for frames ([@mrobinson](https://github.com/mrobinson), [#31523](https://github.com/servo/servo/pull/31523)), when the compositor is shutting down ([@mrobinson](https://github.com/mrobinson), [#31733](https://github.com/servo/servo/pull/31733)), and when loading fonts on macOS ([@mrobinson](https://github.com/mrobinson), [#31658](https://github.com/servo/servo/pull/31658)).

Last but not least, NixOS users can rejoice, as **nix-shell will no longer break when Cargo.lock changes** ([@mukilan](https://github.com/mukilan), [#31825](https://github.com/servo/servo/pull/31825)).

## Outreachy

Servo is also **participating in Outreachy** this year!
Outreachy is a three-month paid (7000 USD) remote internship program that runs twice a year, with a special focus on open source software.
To select interns for Outreachy, there was a *contribution period* that is now coming to a close, during which contributors have landed a wide range of improvements.

The biggest area of improvement was in code health ([@eerii](https://github.com/eerii), [@MunishMummadi](https://github.com/MunishMummadi), [@sandeepB3](https://github.com/sandeepB3), [#31521](https://github.com/servo/servo/pull/31521), [#31537](https://github.com/servo/servo/pull/31537), [#31608](https://github.com/servo/servo/pull/31608), [#31685](https://github.com/servo/servo/pull/31685), [#31670](https://github.com/servo/servo/pull/31670), [#31822](https://github.com/servo/servo/pull/31822)), where we have now fixed almost all of our rustdoc ([@Aaryakhandelwal](https://github.com/Aaryakhandelwal), [@sandeepB3](https://github.com/sandeepB3), [@maureenblack](https://github.com/maureenblack), [@mnaibei](https://github.com/mnaibei), [@oluwatobiss](https://github.com/oluwatobiss), [@azharcodeit](https://github.com/azharcodeit), [@jahielkomu](https://github.com/jahielkomu), [@Rhea-Eve](https://github.com/Rhea-Eve), [@ektuu](https://github.com/ektuu), [#31582](https://github.com/servo/servo/pull/31582), [#31587](https://github.com/servo/servo/pull/31587), [#31592](https://github.com/servo/servo/pull/31592), [#31617](https://github.com/servo/servo/pull/31617), [#31625](https://github.com/servo/servo/pull/31625), [#31632](https://github.com/servo/servo/pull/31632), [#31640](https://github.com/servo/servo/pull/31640), [#31643](https://github.com/servo/servo/pull/31643), [#31647](https://github.com/servo/servo/pull/31647), [#31654](https://github.com/servo/servo/pull/31654), [#31712](https://github.com/servo/servo/pull/31712), [#31644](https://github.com/servo/servo/pull/31644), [#31708](https://github.com/servo/servo/pull/31708), [#31755](https://github.com/servo/servo/pull/31755), [#31745](https://github.com/servo/servo/pull/31745), [#31738](https://github.com/servo/servo/pull/31738)) and clippy errors ([@mnaibei](https://github.com/mnaibei), [@sandeepB3](https://github.com/sandeepB3), [@eerii](https://github.com/eerii), [@zawwz](https://github.com/zawwz), [@richarddushime](https://github.com/richarddushime), [@RustAndMetal](https://github.com/RustAndMetal), [@six-shot](https://github.com/six-shot), [@oluwatobiss](https://github.com/oluwatobiss), [@jahielkomu](https://github.com/jahielkomu), [@Aaryakhandelwal](https://github.com/Aaryakhandelwal), [@ektuu](https://github.com/ektuu), [@azharcodeit](https://github.com/azharcodeit), [#31508](https://github.com/servo/servo/pull/31508), [#31512](https://github.com/servo/servo/pull/31512), [#31549](https://github.com/servo/servo/pull/31549), [#31566](https://github.com/servo/servo/pull/31566), [#31567](https://github.com/servo/servo/pull/31567), [#31560](https://github.com/servo/servo/pull/31560), [#31562](https://github.com/servo/servo/pull/31562), [#31563](https://github.com/servo/servo/pull/31563), [#31551](https://github.com/servo/servo/pull/31551), [#31568](https://github.com/servo/servo/pull/31568), [#31565](https://github.com/servo/servo/pull/31565), [#31564](https://github.com/servo/servo/pull/31564), [#31548](https://github.com/servo/servo/pull/31548), [#31612](https://github.com/servo/servo/pull/31612), [#31610](https://github.com/servo/servo/pull/31610), [#31611](https://github.com/servo/servo/pull/31611), [#31627](https://github.com/servo/servo/pull/31627), [#31623](https://github.com/servo/servo/pull/31623), [#31628](https://github.com/servo/servo/pull/31628), [#31626](https://github.com/servo/servo/pull/31626), [#31700](https://github.com/servo/servo/pull/31700), [#31710](https://github.com/servo/servo/pull/31710), [#31719](https://github.com/servo/servo/pull/31719), [#31735](https://github.com/servo/servo/pull/31735), [#31758](https://github.com/servo/servo/pull/31758), [#31717](https://github.com/servo/servo/pull/31717), [#31759](https://github.com/servo/servo/pull/31759), [#31769](https://github.com/servo/servo/pull/31769), [#31770](https://github.com/servo/servo/pull/31770), [#31776](https://github.com/servo/servo/pull/31776), [#31778](https://github.com/servo/servo/pull/31778), [#31793](https://github.com/servo/servo/pull/31793), [#31801](https://github.com/servo/servo/pull/31801), [#31800](https://github.com/servo/servo/pull/31800), [#31799](https://github.com/servo/servo/pull/31799), [#31791](https://github.com/servo/servo/pull/31791), [#31811](https://github.com/servo/servo/pull/31811), [#31813](https://github.com/servo/servo/pull/31813), [#31819](https://github.com/servo/servo/pull/31819), [#31784](https://github.com/servo/servo/pull/31784), [#31823](https://github.com/servo/servo/pull/31823), [#31837](https://github.com/servo/servo/pull/31837), [#31818](https://github.com/servo/servo/pull/31818), [#31842](https://github.com/servo/servo/pull/31842), [#31827](https://github.com/servo/servo/pull/31827), [#31849](https://github.com/servo/servo/pull/31849), [#31850](https://github.com/servo/servo/pull/31850), [#31843](https://github.com/servo/servo/pull/31843), [#31852](https://github.com/servo/servo/pull/31852), [#31864](https://github.com/servo/servo/pull/31864), [#31863](https://github.com/servo/servo/pull/31863), [#31853](https://github.com/servo/servo/pull/31853), [#31865](https://github.com/servo/servo/pull/31865), [#31834](https://github.com/servo/servo/pull/31834), [#31876](https://github.com/servo/servo/pull/31876), [#31877](https://github.com/servo/servo/pull/31877), [#31888](https://github.com/servo/servo/pull/31888), [#31878](https://github.com/servo/servo/pull/31878), [#31890](https://github.com/servo/servo/pull/31890), [#31867](https://github.com/servo/servo/pull/31867), [#31893](https://github.com/servo/servo/pull/31893), [#31898](https://github.com/servo/servo/pull/31898), [#31900](https://github.com/servo/servo/pull/31900), [#31891](https://github.com/servo/servo/pull/31891), [#31906](https://github.com/servo/servo/pull/31906), [#31908](https://github.com/servo/servo/pull/31908), [#31907](https://github.com/servo/servo/pull/31907)).

One contributor went further, cleaning up the codegen for our DOM bindings ([@eerii](https://github.com/eerii), [#31721](https://github.com/servo/servo/pull/31721), [#31711](https://github.com/servo/servo/pull/31711), [#31844](https://github.com/servo/servo/pull/31844)), improving our dev tooling ([@eerii](https://github.com/eerii), [#31694](https://github.com/servo/servo/pull/31694)), and even improving our image decoding by replacing per-image threads with a thread pool ([@eerii](https://github.com/eerii), [#31517](https://github.com/servo/servo/pull/31517), [#31585](https://github.com/servo/servo/pull/31585))!
Two contributors worked together to support language-specific behaviour in ‘text-transform’ ([@MunishMummadi](https://github.com/MunishMummadi), [@Rhea-Eve](https://github.com/Rhea-Eve), [stylo#24](https://github.com/servo/stylo/pull/24), [#31737](https://github.com/servo/servo/pull/31737)), and other contributors also landed improvements to our docs ([@six-shot](https://github.com/six-shot), [@jahielkomu](https://github.com/jahielkomu), [#31583](https://github.com/servo/servo/pull/31583), [#31718](https://github.com/servo/servo/pull/31718)), CJK font fallback ([@richarddushime](https://github.com/richarddushime), [@sandeepB3](https://github.com/sandeepB3), [#31668](https://github.com/servo/servo/pull/31668), [#31670](https://github.com/servo/servo/pull/31670)), and the Web Platform Tests ([@azharcodeit](https://github.com/azharcodeit), [@richarddushime](https://github.com/richarddushime), [#31534](https://github.com/servo/servo/pull/31534), [#31802](https://github.com/servo/servo/pull/31802)).

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
    ._note {
        margin: 1em 1em;
        border-left: 1px solid;
        padding-left: 1em;
        opacity: 0.75;
    }
</style>
