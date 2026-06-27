---
layout:     post
tags:       blog
title:      "May in Servo: and more!"
date:       2026-06-30
summary:    ao!! wrrrrao!!
categories:
---

[**Servo 0.3.0**](https://github.com/servo/servo/releases/tag/v0.3.0) contains all of the changes we landed in May, which came out to **391 commits** (March: 534).
For security fixes, see [**§ Security**](#security).

We’ve shipped several new web platform features:

- **‘font-kerning: none’** (@simonwuelker, #44634)
- **‘font-variant-east-asian’** (@simonwuelker, #44989)
- **‘font-variant-ligatures’** (@simonwuelker, #44903)
- **‘font-variant-numeric’** (@simonwuelker, #44950)
- **‘font-variant-position’** (@simonwuelker, #45142)
- **mp4** files **without fast start** in **&lt;video>** (@calvaris, #45084)
- **&lt;![CDATA[]]>** layout (@mrobinson, #44791)

Plus a bunch of new DOM APIs:

- **onslotchange** property on **Shadow­Root** (@jdm, #44688)
- **screen­Left** and **screen­Top** on **Window** (@TG199, #45128)
- **new Blob()** with `{endings: "native"}` (@yezhizhen, #44803)
- **new Performance­Mark()** (@shubhamg13, #44702)
- **parse­HTML()** on **Document** (@kkoyung, #44952)
- **read­As­Binary­String()** on **File­Reader** (@yezhizhen, #44858)
- **performance.measure()** with mark values **‘redirect­Start’**, **‘redirect­End’**, **‘secure­Connection­Start’**, and **‘response­End’** (@shubhamg13, #44673, #44624, #44850, #44739)

This is another big update, so here’s an outline:

- [**Security**](#security)

- [**Work in progress**](#work-in-progress)

- [**servoshell**](#servoshell)

- [**For developers**](#for-developers)

- [**Embedding API**](#embedding-api)

- [**More on the web platform**](#more-on-the-web-platform)

- [**Performance and stability**](#performance-and-stability)

## Work in progress

We’re continuing to implement **document.exec­Command()** for **rich text editing**, under `--pref dom­_exec­_command­_enabled`.
This release adds support for the **‘back­Color’**, **‘fore­Color’**, **‘create­Link’**, **‘unlink’**, **‘superscript’**, **‘subscript’**, and **‘remove­Format’** commands (@TimvdLippe, #44644, #44682, #44657, #44710, #44677).

We’re also working on the **Sanitizer** API, under `--pref dom­_sanitizer­_enabled`.
With the feature now enabled in servoshell’s experimental mode (@kkoyung, #44701), this release adds support for **set­Comments()**, **set­Data­Attributes()**, **allow­Processing­Instruction()**, **remove­Processing­Instruction()**, and **remove­Unsafe()** on **Sanitizer** (@kkoyung, #44734, #44983).

All of the features above are enabled in servoshell’s experimental mode.

We’re now working on **SharedWorker** and **ServiceWorker**, under `--pref dom­_sharedworker­_enabled` and `--pref dom­_serviceworker­_enabled` respectively.
This release adds support for **new Shared­Worker()** (@Taym95, #44761), and parts of the ServiceWorker API (@gterzian, @arihant2math, #45082, #44787).

## Embedding API

Servo now requires **Rust 1.88.0** or newer, up from the old MSRV of 1.86.0 (@sagudev, #44815).
We run compile tests with the MSRV, but most of our testing is now done with Rust 1.95.0 (@simonwuelker, #44632).

**Breaking changes** to the **cookies** methods in our [**SiteDataManager**](https://doc.servo.org/servo/struct.SiteDataManager.html) API (@longvatrong111, #44708):

- [`Site­Data­Manager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::[`clear­_cookies`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.clear_cookies) now takes an additional `callback` argument, allowing it to be called async – to continue calling it sync, pass `None` as the `callback`

- [`Site­Data­Manager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::[`clear­_session­_cookies`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.clear_session_cookies) now takes an additional `callback` argument, allowing it to be called async – to continue calling it sync, pass `None` as the `callback`

- [`Site­Data­Manager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::[`set­_cookie­_for­_url`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.set_cookie_for_url) now takes an additional `callback` argument, allowing it to be called async – to continue calling it sync, pass `None` as the `callback`

- [`Site­Data­Manager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::`set­_cookie­_for­_url­_async` has been removed in favour of [`set­_cookie­_for­_url`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.set_cookie_for_url) – to migrate, replace `set­_cookie­_for­_url­_async(​callback)` with `set­_cookie­_for­_url(​Some(​Box::new(​callback)))`

**Breaking changes** to our [**Preferences**](https://doc.servo.org/servo/struct.Preferences.html) API (@Narfinger, @mrobinson, #44307):

- `threadpools­_image­_cache­_workers­_max`, `threadpools­_indexeddb­_workers­_max`, and `threadpools­_webstorage­_workers­_max` have been **removed** in favour of a combined [`thread­_pool­_workers­_max`](https://doc.servo.org/servo/struct.Preferences.html#structfield.thread_pool_workers_max)

- `threadpools­_fallback­_worker­_num` has been **renamed** to [`thread­_pool­_fallback­_workers`](https://doc.servo.org/servo/struct.Preferences.html#structfield.thread_pool_fallback_workers)

- `threadpools­_async­_runtime­_workers­_max` has been **renamed** to [`thread­_pool­_async­_runtime­_workers­_max`](https://doc.servo.org/servo/struct.Preferences.html#structfield.thread_pool_async_runtime_workers_max)

- `threadpools­_webrender­_workers­_max` has been **renamed** to [`thread­_pool­_webrender­_workers­_max`](https://doc.servo.org/servo/struct.Preferences.html#structfield.thread_pool_webrender_workers_max)

We’ve also reworked our [**DiagnosticsLogging**](https://doc.servo.org/servo/struct.DiagnosticsLogging.html) API (@mukilan, #44703):

- You can now set options with [`DiagnosticsLogging`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html)::[`toggle­_option`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html#method.toggle_option), and check if they are enabled with [`DiagnosticsLogging`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html)::[`is­_enabled`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html#method.is_enabled)

- Each option is a variant of [`DiagnosticsLoggingOption`](https://doc.servo.org/servo/enum.DiagnosticsLoggingOption.html), a new type that also has useful methods for exposing these options in embedder UI

- **(Breaking change)** [`DiagnosticsLogging`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html) no longer has `pub` fields representing each option – to migrate, replace field writes and field reads with [`toggle­_option`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html#method.toggle_option) and [`is­_enabled`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html#method.is_enabled) respectively

- **(Breaking change)** [`DiagnosticsLogging`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html)::[`extend­_from­_string`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html#method.extend_from_string) no longer accepts a `help` option – this option only existed to support servoshell’s `-Z help` / `--debug=help` option, so the code implementing it has been moved to servoshell

## More on the web platform

**CryptoKey** is now **serializable**, allowing it to be used in structuredClone() and postMessage() (@kkoyung, #45163).

## Performance and stability

Several crashes have been fixed:

- in **‘content’** (@mrobinson, @Loirooriol, @SimonSapin, #45227, #44762)
- in **Media­Stream** (@jdm, #44781)
- in **item()** on **attributes** on **Element** (@webbeef, #44721)
- in **append­Rule()** on **CSS­Keyframes­Rule** (@mrobinson, #45173)
- in **init­Event()** on **Focus­Event** (@mrobinson, #44870)
- in **stop()** on **Window** (@TimvdLippe, #44804)
- in `document.exec­Command(​"delete")` (@TimvdLippe, #44748)
- in `--debug-mozjs` builds (@Gae24, @SharanRP, #44745, #45001)
- when shaping zero-width spaces (@mrobinson, #45176)
- when toggling servoshell’s experimental mode at runtime (@mrobinson, @Loirooriol, #45226)

We’ve continued our long-running effort to **use the Rust type system** to make certain kinds of dynamic borrow failures impossible (@Gae24, @MavenRain, @Narfinger, @SteveSharonSam, @TimvdLippe, @elomscansio, @jdm, @kkoyung, @yezhizhen, #44712, #44759, #44879, #45014, #45058, #45061, #45076, #45098, #45110, #45149, #45117, #45184, #45201, #44806, #44930, #44942, #44946, #45233, #45181, #44659, #44660, #44664, #44668, #44992, #45000, #45081, #45009, #45225, #45087, #45244, #45245, #45247, #44663, #44665, #44993, #45040, #45053, #44647, #44671, #44681, #44717, #44733, #44686, #44653).

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
