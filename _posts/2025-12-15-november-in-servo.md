---
layout:     post
tags:       blog
title:      "November in Servo: monthly releases, context menus, parallel CSS parsing, and more!"
date:       2025-12-15
summary:    All of these updates are in Servo 0.0.3.
categories:
---

Landing in [**Servo 0.0.3**](https://github.com/servo/servo/releases/tag/v0.0.3) and our November nightly builds, we now have **context menus** for links, images, and other web content ([@atbrakhi](https://github.com/atbrakhi), [@mrobinson](https://github.com/mrobinson), [#40434](https://github.com/servo/servo/pull/40434), [#40501](https://github.com/servo/servo/pull/40501)), **vsync on Android** ([@mrobinson](https://github.com/mrobinson), [#40306](https://github.com/servo/servo/pull/40306)), **light mode** for the **new tab page** ([@arihant2math](https://github.com/arihant2math), [#40272](https://github.com/servo/servo/pull/40272)), plus several web platform features:

- **&lt;video controls>** ([@rayguo17](https://github.com/rayguo17), [#40578](https://github.com/servo/servo/pull/40578))
- **&lt;use>** in SVG ([@WaterWhisperer](https://github.com/WaterWhisperer), [#40684](https://github.com/servo/servo/pull/40684))
- ☢️ **‘font-optical-sizing’** ([@simonwuelker](https://github.com/simonwuelker), [#40829](https://github.com/servo/servo/pull/40829), [#40861](https://github.com/servo/servo/pull/40861), [#40884](https://github.com/servo/servo/pull/40884))
- **‘brotli’** in **CompressionStream** and **DecompressionStream** ([@Taym95](https://github.com/Taym95), [#40842](https://github.com/servo/servo/pull/40842))
- **‘display-p3-linear’** in CSS **color()** and **color-mix()** ([@Loirooriol](https://github.com/Loirooriol), [#40525](https://github.com/servo/servo/pull/40525))
- **calc()** now works in **grid layout** ([@nicoburns](https://github.com/nicoburns), [#34846](https://github.com/servo/servo/pull/34846))
- **ResizeObserver** is now enabled by default ([@jdm](https://github.com/jdm), [#40378](https://github.com/servo/servo/pull/40378))

<figure>
    <img src="{{ '/img/blog/2025-12-diffie.png' | url }}" alt="Servo 0.0.3 showing new support for <use> in SVG, <details name>, and context menus">
</figure>

**Font variations** are now applied in **‘font-weight’** and **‘font-stretch’** ([@simonwuelker](https://github.com/simonwuelker), [#40867](https://github.com/servo/servo/pull/40867)), fixing a rendering issue in the [Web Engines Hackfest website](https://webengineshackfest.org).

[@kkoyung](https://github.com/kkoyung) has landed some huge improvements in the [**SubtleCrypto API**](https://w3c.github.io/webcrypto/), including some of the more [modern algorithms in this WICG draft](https://wicg.github.io/webcrypto-modern-algos/), and a fix for constant-time base64 ([@kkoyung](https://github.com/kkoyung), [#40334](https://github.com/servo/servo/pull/40334)).
We now have full support for **SHA3-256**, **SHA3-384**, **SHA3-512** ([@kkoyung](https://github.com/kkoyung), [#40765](https://github.com/servo/servo/pull/40765)), **cSHAKE128**, **cSHAKE256** ([@kkoyung](https://github.com/kkoyung), [#40832](https://github.com/servo/servo/pull/40832)), **Argon2d**, **Argon2i**, **Argon2id**, **ChaCha20-Poly1305**, **ECDH**, **ECDSA**, and **X25519**:

<figure style="overflow-x: scroll;">

| Algorithm | deriveBits | exportKey | generateKey | importKey | sign | verify |
|---|---|---|---|---|---|---|
| Argon2d | [#40936](https://github.com/servo/servo/pull/40936) | n/a | n/a | [#40932](https://github.com/servo/servo/pull/40932) | n/a | n/a |
| Argon2i | [#40936](https://github.com/servo/servo/pull/40936) | n/a | n/a | [#40932](https://github.com/servo/servo/pull/40932) | n/a | n/a |
| Argon2id | [#40936](https://github.com/servo/servo/pull/40936) | n/a | n/a | [#40932](https://github.com/servo/servo/pull/40932) | n/a | n/a |
| ChaCha20-Poly1305 | n/a | [#40948](https://github.com/servo/servo/pull/40948) | n/a | [#40948](https://github.com/servo/servo/pull/40948) | n/a | n/a |
| ECDH | [#40333](https://github.com/servo/servo/pull/40333) | [#40298](https://github.com/servo/servo/pull/40298) | [#40305](https://github.com/servo/servo/pull/40305) | [#40253](https://github.com/servo/servo/pull/40253) | n/a | n/a |
| ECDSA | n/a | [#40536](https://github.com/servo/servo/pull/40536) | [#40553](https://github.com/servo/servo/pull/40553) | [#40523](https://github.com/servo/servo/pull/40523) | [#40591](https://github.com/servo/servo/pull/40591) | [#40557](https://github.com/servo/servo/pull/40557) |
| X25519 | [#40497](https://github.com/servo/servo/pull/40497) | [#40421](https://github.com/servo/servo/pull/40421) | [#40480](https://github.com/servo/servo/pull/40480) | [#40398](https://github.com/servo/servo/pull/40398) | n/a | n/a |
</figure>

**&lt;details>** now fires **‘toggle’** events ([@lukewarlow](https://github.com/lukewarlow), [#40271](https://github.com/servo/servo/pull/40271)), and **&lt;details name>** is now exclusive, like radio buttons ([@simonwuelker](https://github.com/simonwuelker), [#40314](https://github.com/servo/servo/pull/40314)).
**InputEvent**, which represents **‘input’** and **‘beforeinput’** events, now has **composed**, **data**, **isComposing**, and **inputType** properties ([@excitablesnowball](https://github.com/excitablesnowball), [#39989](https://github.com/servo/servo/pull/39989)).

## Embedding API

**Each webview** can now now have its **own rendering context** ([@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#40794](https://github.com/servo/servo/pull/40794), [#40738](https://github.com/servo/servo/pull/40738), [#40721](https://github.com/servo/servo/pull/40721), [#40594](https://github.com/servo/servo/pull/40594), [#40923](https://github.com/servo/servo/pull/40923)).
This effectively enables full support for **multiple windows**, and we’ve started incorporating that into servoshell ([@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#40883](https://github.com/servo/servo/pull/40883)).

Our previously unused **context menu API** has been replaced with a new, more effective API that includes actions for links, images, and other web content ([@mrobinson](https://github.com/mrobinson), [@atbrakhi](https://github.com/atbrakhi), [#40402](https://github.com/servo/servo/pull/40402), [#40501](https://github.com/servo/servo/pull/40501), [#40607](https://github.com/servo/servo/pull/40607)).
For more details, see the docs for **[ContextMenu](https://doc.servo.org/servo/struct.ContextMenu.html)**, [EmbedderControl::<wbr>ContextMenu](https://doc.servo.org/servo/enum.EmbedderControl.html#variant.ContextMenu), and [WebViewDelegate::<wbr>show_<wbr>embedder_<wbr>control()](https://doc.servo.org/servo/trait.WebViewDelegate.html#method.show_embedder_control).

[**WebView**](https://doc.servo.org/servo/struct.WebView.html) now has [**can_go_back()**](https://doc.servo.org/servo/struct.WebView.html#method.can_go_back) and [**can_go_forward()**](https://doc.servo.org/servo/struct.WebView.html#method.can_go_forward) methods, and servoshell now uses those to disable the back and forward buttons ([@mrobinson](https://github.com/mrobinson), [#40598](https://github.com/servo/servo/pull/40598)).

Having introduced our new [**RefreshDriver**](https://doc.servo.org/servo/trait.RefreshDriver.html) API in October, we’ve now **removed [Servo](https://doc.servo.org/servo/struct.Servo.html)::<wbr>animating()** ([@mrobinson](https://github.com/mrobinson), [#40799](https://github.com/servo/servo/pull/40799)) and **[ServoDelegate](https://doc.servo.org/servo/trait.ServoDelegate.html)::<wbr>notify_<wbr>animating_<wbr>changed()** ([@mrobinson](https://github.com/mrobinson), [#40886](https://github.com/servo/servo/pull/40886)), and similarly cleaned up the obsolete and inefficient “animating” state in servoshell ([@mrobinson](https://github.com/mrobinson), [#40715](https://github.com/servo/servo/pull/40715)).

We’ve moved virtually all of the useful items in the Servo API to the root of the `servo` library crate ([@mrobinson](https://github.com/mrobinson), [#40951](https://github.com/servo/servo/pull/40951)).
This is a **breaking change**, but we expect that it will greatly simplify embedding Servo, and it means you can even write `use servo::*;` in a pinch.

When running Servo without a custom [**ClipboardDelegate**](https://doc.servo.org/servo/clipboard_delegate/trait.ClipboardDelegate.html), we normally use the system clipboard by default.
But if there’s no system clipboard, we now have a built-in **fallback clipboard** ([@mrobinson](https://github.com/mrobinson), [#40408](https://github.com/servo/servo/pull/40408)), rather than having no clipboard at all.
Note that the fallback clipboard is very limited, as it can only store text and does not work across processes.

## Performance and stability

Servo now **parses CSS in parallel** with script and layout ([@mrobinson](https://github.com/mrobinson), [@vimpunk](https://github.com/vimpunk), [#40639](https://github.com/servo/servo/pull/40639), [#40556](https://github.com/servo/servo/pull/40556)), and can now measure [**Largest Contentful Paint**](https://web.dev/articles/lcp) in PerformanceObserver as well as in our internal profiling tools ([@shubhamg13](https://github.com/shubhamg13), [@boluochoufeng](https://github.com/boluochoufeng), [#39714](https://github.com/servo/servo/pull/39714), [#39384](https://github.com/servo/servo/pull/39384)).

**Just-in-time compilation** (JIT) is now **optional** ([@jschwe](https://github.com/jschwe), [#37972](https://github.com/servo/servo/pull/37972)), which can be useful in situations where generating native code is forbidden by policy or unwanted for other reasons.

We’ve improved the performance of incremental layout ([@Loirooriol](https://github.com/Loirooriol), [@mrobinson](https://github.com/mrobinson), [#40795](https://github.com/servo/servo/pull/40795), [#40797](https://github.com/servo/servo/pull/40797)), touch input ([@kongbai1996](https://github.com/kongbai1996), [#40637](https://github.com/servo/servo/pull/40637)), animated GIF rendering ([@mrobinson](https://github.com/mrobinson), [#40158](https://github.com/servo/servo/pull/40158)), the prefs subsystem ([@webbeef](https://github.com/webbeef), [#40775](https://github.com/servo/servo/pull/40775)), and parseFromString() on DOMParser ([@webbeef](https://github.com/webbeef), [#40742](https://github.com/servo/servo/pull/40742)).
We also use fewer IPC resources when internal profiling features are disabled ([@lumiscosity](https://github.com/lumiscosity), [#40823](https://github.com/servo/servo/pull/40823)).

We’ve fixed a bug causing **nytimes.com** to hang ([@jdm](https://github.com/jdm), [#40811](https://github.com/servo/servo/pull/40811)), as well as fixing crashes in **[Speedometer 3.0](https://www.browserbench.org/Speedometer3.0/)** and **[3.1](https://www.browserbench.org/Speedometer3.1/)** ([@Narfinger](https://github.com/Narfinger), [#40459](https://github.com/servo/servo/pull/40459)), grid layout ([@nicoburns](https://github.com/nicoburns), [#40821](https://github.com/servo/servo/pull/40821)), the fonts subsystem ([@simonwuelker](https://github.com/simonwuelker), [#40913](https://github.com/servo/servo/pull/40913)), XPath ([@simonwuelker](https://github.com/simonwuelker), [#40411](https://github.com/servo/servo/pull/40411)), ReadableStream ([@Taym95](https://github.com/Taym95), [#40911](https://github.com/servo/servo/pull/40911)), AudioContext ([@Taym95](https://github.com/Taym95), [#40729](https://github.com/servo/servo/pull/40729)), and when exiting Servo ([@mrobinson](https://github.com/mrobinson), [#40933](https://github.com/servo/servo/pull/40933)).

## Donations

Thanks again for your generous support!
We are now receiving **6433 USD/month** (+11.8% over October) in recurring donations.
This helps us cover the cost of our **[speedy](https://ci0.servo.org) [CI](https://ci1.servo.org) [and](https://ci2.servo.org) [benchmarking](https://ci3.servo.org) [servers](https://ci4.servo.org)**, one of our latest **[Outreachy interns](https://www.outreachy.org/alums/2025-06/#:~:text=Servo)**, and funding **[maintainer work]({{ '/blog/2025/09/17/your-donations-at-work-funding-jdm/' | url }})** that helps more people contribute to Servo.

Servo is also on [thanks.dev](https://thanks.dev), and already **28 GitHub users** (same as October) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

We now have [**sponsorship tiers**]({{ '/blog/2025/11/21/sponsorship-tiers/' | url }}) that allow you or your organisation to donate to the Servo project with public acknowlegement of your support.
If you’re interested in this kind of sponsorship, please contact us at [join@servo.org](mailto:join@servo.org).

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; right: calc(100% - 100% * 6433 / 10000); padding-right: 0.5em;"><strong>6433</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 6433 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="6433" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

Use of donations is decided transparently via the Technical Steering Committee’s public **[funding request process](https://github.com/servo/project/blob/main/FUNDING_REQUEST.md)**, and active proposals are tracked in [servo/project#187](https://github.com/servo/project/issues/187).
For more details, head to our [Sponsorship page]({{ '/sponsorship/' | url }}).

<style>
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
