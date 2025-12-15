---
layout:     post
tags:       blog
title:      "November in Servo: ???"
date:       2025-12-12
summary:    ao!! wrrrrao!!
categories:
---

Landing in [**Servo 0.0.3**](https://github.com/servo/servo/releases/tag/v0.0.3) and our November nightly builds, we now have **context menus** for links, images, and other web content (@atbrakhi, @mrobinson, #40434, #40501), **vsync on Android** (@mrobinson, #40306), **light mode** for the **new tab page** (@arihant2math, #40272), plus several web platform features:

- **&lt;video controls>** (@rayguo17, #40578)
- **&lt;use>** in SVG (@WaterWhisperer, #40684)
- ☢️ **‘font-optical-sizing’** (@simonwuelker, #40829, #40861, #40884)
- **‘brotli’** in **CompressionStream** and **DecompressionStream** (@Taym95, #40842)
- **‘display-p3-linear’** in CSS **color()** and **color-mix()** (@Loirooriol, #40525)
- **calc()** now works in **grid layout** (@nicoburns, #34846)
- **ResizeObserver** is now enabled by default (@jdm, #40378)

<figure>
    <img src="{{ '/img/blog/2025-12-diffie.png' | url }}" alt="Servo 0.0.3 showing new support for <use> in SVG, <details name>, and context menus">
</figure>

**Font variations** are now applied in **‘font-weight’** and **‘font-stretch’** (@simonwuelker, #40867), fixing a rendering issue in the [Web Engines Hackfest website](https://webengineshackfest.org).

@kkoyung has landed some huge improvements in the [**SubtleCrypto API**](https://w3c.github.io/webcrypto/), including some of the more [modern algorithms in this WICG draft](https://wicg.github.io/webcrypto-modern-algos/), and a fix for constant-time base64 (#40334).
We now have full support for **SHA3-256**, **SHA3-384**, **SHA3-512** (@kkoyung, #40765), **cSHAKE128**, **cSHAKE256** (@kkoyung, #40832), **Argon2d**, **Argon2i**, **Argon2id**, **ChaCha20-Poly1305**, **ECDH**, **ECDSA**, and **X25519**:

<figure style="overflow-x: scroll;">

| Algorithm | deriveBits | exportKey | generateKey | importKey | sign | verify |
|---|---|---|---|---|---|---|
| Argon2d | #40936 | n/a | n/a | #40932 | n/a | n/a |
| Argon2i | #40936 | n/a | n/a | #40932 | n/a | n/a |
| Argon2id | #40936 | n/a | n/a | #40932 | n/a | n/a |
| ChaCha20-Poly1305 | n/a | #40948 | n/a | #40948 | n/a | n/a |
| ECDH | #40333 | #40298 | #40305 | #40253 | n/a | n/a |
| ECDSA | n/a | #40536 | #40553 | #40523 | #40591 | #40557 |
| X25519 | #40497 | #40421 | #40480 | #40398 | n/a | n/a |
</figure>

**&lt;details>** now fires **‘toggle’** events (@lukewarlow, #40271), and **&lt;details name>** is now exclusive, like radio buttons (@simonwuelker, #40314).
**InputEvent**, which represents **‘input’** and **‘beforeinput’** events, now has **composed**, **data**, **isComposing**, and **inputType** properties (@excitablesnowball, #39989).

## Embedding API

**Each webview** can now now have its **own rendering context** (@mrobinson, @mukilan, #40794, #40738, #40721, #40594, #40923).
This effectively enables full support for **multiple windows**, and we’ve started incorporating that into servoshell (@mrobinson, @mukilan, #40883).

Our previously unused **context menu API** has been replaced with a new, more effective API that includes actions for links, images, and other web content (@mrobinson, @atbrakhi, #40402, #40501, #40607).
For more details, see the docs for **[ContextMenu](https://doc.servo.org/servo/struct.ContextMenu.html)**, [EmbedderControl::<wbr>ContextMenu](https://doc.servo.org/servo/enum.EmbedderControl.html#variant.ContextMenu), and [WebViewDelegate::<wbr>show_<wbr>embedder_<wbr>control()](https://doc.servo.org/servo/trait.WebViewDelegate.html#method.show_embedder_control).

[**WebView**](https://doc.servo.org/servo/struct.WebView.html) now has [**can_go_back()**](https://doc.servo.org/servo/struct.WebView.html#method.can_go_back) and [**can_go_forward()**](https://doc.servo.org/servo/struct.WebView.html#method.can_go_forward) methods, and servoshell now uses those to disable the back and forward buttons (@mrobinson, #40598).

Having introduced our new [**RefreshDriver**](https://doc.servo.org/servo/trait.RefreshDriver.html) API in October, we’ve now **removed [Servo](https://doc.servo.org/servo/struct.Servo.html)::<wbr>animating()** (@mrobinson, #40799) and **[ServoDelegate](https://doc.servo.org/servo/trait.ServoDelegate.html)::<wbr>notify_<wbr>animating_<wbr>changed()** (@mrobinson, #40886), and similarly cleaned up the obsolete and inefficient “animating” state in servoshell (@mrobinson, #40715).

We’ve moved virtually all of the useful items in the Servo API to the root of the `servo` library crate (@mrobinson, #40951).
This is a **breaking change**, but we expect that it will greatly simplify embedding Servo, and it means you can even write `use servo::*;` in a pinch.

When running Servo without a custom [**ClipboardDelegate**](https://doc.servo.org/servo/clipboard_delegate/trait.ClipboardDelegate.html), we normally use the system clipboard by default.
But if there’s no system clipboard, we now have a built-in **fallback clipboard** (@mrobinson, #40408), rather than having no clipboard at all.
Note that the fallback clipboard is very limited, as it can only store text and does not work across processes.

## Performance and stability

Servo now **parses CSS in parallel** with script and layout (@mrobinson, @vimpunk, #40639, #40556), and can now measure [**Largest Contentful Paint**](https://web.dev/articles/lcp) in PerformanceObserver as well as in our internal profiling tools (@shubhamg13, @boluochoufeng, #39714, #39384).

**Just-in-time compilation** (JIT) is now **optional** (@jschwe, #37972), which can be useful in situations where generating native code is forbidden by policy or unwanted for other reasons.

We’ve improved the performance of incremental layout (@Loirooriol, @mrobinson, #40795, #40797), touch input (@kongbai1996, #40637), animated GIF rendering (@mrobinson, #40158), the prefs subsystem (@webbeef, #40775), and parseFromString() on DOMParser (@webbeef, #40742).
We also use fewer IPC resources when internal profiling features are disabled (@lumiscosity, #40823).

We’ve fixed a bug causing **nytimes.com** to hang (@jdm, #40811), as well as fixing crashes in **[Speedometer 3.0](https://www.browserbench.org/Speedometer3.0/)** and **[3.1](https://www.browserbench.org/Speedometer3.1/)** (@Narfinger, #40459), grid layout (@nicoburns, #40821), the fonts subsystem (@simonwuelker, #40913), XPath (@simonwuelker, #40411), ReadableStream (@Taym95, #40911), AudioContext (@Taym95, #40729), and when exiting Servo (@mrobinson, #40933).

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
