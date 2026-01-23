---
layout:     post
tags:       blog
title:      "December in Servo: multiple windows, proxy support, better caching, and more!"
date:       2026-01-23
summary:    Come along and meet us at FOSDEM 2026 – we’re speaking there too!
categories:
---

**Servo 0.0.4** and our December nightly builds now support **multiple windows** ([@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#40927](https://github.com/servo/servo/pull/40927), [#41235](https://github.com/servo/servo/pull/41235), [#41144](https://github.com/servo/servo/pull/41144))!
This builds on features that landed in Servo’s embedding API [last month]({{ '/blog/2025/12/15/november-in-servo/' | url }}).
We’ve also landed support for several web platform features, both old and new:

- **‘contrast-color()’** in CSS color values ([@webbeef](https://github.com/webbeef), [#41542](https://github.com/servo/servo/pull/41542))
- partial support for **&lt;meta charset>** ([@simonwuelker](https://github.com/simonwuelker), [#41376](https://github.com/servo/servo/pull/41376))
- partial support for [**encoding sniffing**](https://html.spec.whatwg.org/multipage/#encoding-sniffing-algorithm) ([@simonwuelker](https://github.com/simonwuelker), [#41435](https://github.com/servo/servo/pull/41435))
- **‘background’** and **‘bgcolor’** attributes on &lt;table>, &lt;thead>, &lt;tbody>, &lt;tfoot>, &lt;tr>, &lt;td>, &lt;th> ([@simonwuelker](https://github.com/simonwuelker), [#41272](https://github.com/servo/servo/pull/41272))
- **tee()** on **readable byte streams** ([@Taym95](https://github.com/Taym95), [#35991](https://github.com/servo/servo/pull/35991))

<aside class="_note">

**Note:** due to [a known issue](https://github.com/servo/servo/issues/42069), servoshell on macOS may not be able to directly open new windows, depending on your system settings.
</aside>

<figure>
    <img src="{{ '/img/blog/2026-01-diffie.png' | url }}" alt="Servo 0.0.4 showing new support for multiple windows">
</figure>

For better compatibility with older web content, we now support **vendor-prefixed** CSS properties like ‘-moz-transform’ ([@mrobinson](https://github.com/mrobinson), [#41350](https://github.com/servo/servo/pull/41350)), as well as window.**clientInformation** ([@Taym95](https://github.com/Taym95), [#41111](https://github.com/servo/servo/pull/41111)).

We’ve continued shipping the **[SubtleCrypto](https://w3c.github.io/webcrypto/) [API](https://wicg.github.io/webcrypto-modern-algos/)**, with full support for **ChaCha20-Poly1305**, **RSA-OAEP**, **RSA-PSS**, and **RSASSA-PKCS1-v1_5** (see below), plus **importKey() for ML-KEM** ([@kkoyung](https://github.com/kkoyung), [#41585](https://github.com/servo/servo/pull/41585)) and several other improvements ([@kkoyung](https://github.com/kkoyung), [@PaulTreitel](https://github.com/PaulTreitel), [@danilopedraza](https://github.com/danilopedraza), [#41180](https://github.com/servo/servo/pull/41180), [#41395](https://github.com/servo/servo/pull/41395), [#41428](https://github.com/servo/servo/pull/41428), [#41442](https://github.com/servo/servo/pull/41442), [#41472](https://github.com/servo/servo/pull/41472), [#41544](https://github.com/servo/servo/pull/41544), [#41563](https://github.com/servo/servo/pull/41563), [#41587](https://github.com/servo/servo/pull/41587), [#41039](https://github.com/servo/servo/pull/41039), [#41292](https://github.com/servo/servo/pull/41292)):

<figure style="overflow-x: scroll;">

| Algorithm | |
|---|---|
| <span style=white-space:nowrap>ChaCha20-Poly1305</span> | ([@kkoyung](https://github.com/kkoyung), [#40978](https://github.com/servo/servo/pull/40978), [#41003](https://github.com/servo/servo/pull/41003), [#41030](https://github.com/servo/servo/pull/41030)) |
| <span style=white-space:nowrap>RSA-OAEP</span> | ([@kkoyung](https://github.com/kkoyung), [@TimvdLippe](https://github.com/TimvdLippe), [@jdm](https://github.com/jdm), [#41225](https://github.com/servo/servo/pull/41225), [#41217](https://github.com/servo/servo/pull/41217), [#41240](https://github.com/servo/servo/pull/41240), [#41316](https://github.com/servo/servo/pull/41316)) |
| <span style=white-space:nowrap>RSA-PSS</span> | ([@kkoyung](https://github.com/kkoyung), [@jdm](https://github.com/jdm), [#41157](https://github.com/servo/servo/pull/41157), [#41225](https://github.com/servo/servo/pull/41225), [#41240](https://github.com/servo/servo/pull/41240), [#41287](https://github.com/servo/servo/pull/41287)) |
| <span style=white-space:nowrap>RSASSA-PKCS1-v1_5</span> | ([@kkoyung](https://github.com/kkoyung), [@jdm](https://github.com/jdm), [#41172](https://github.com/servo/servo/pull/41172), [#41225](https://github.com/servo/servo/pull/41225), [#41240](https://github.com/servo/servo/pull/41240), [#41267](https://github.com/servo/servo/pull/41267)) |
</figure>

When using **servoshell** on Windows, you can now see `--help` and log output, as long as servoshell was started in a console.

Servo diagnostics options are now accessible in servoshell via the `SERVO_DIAGNOSTICS` environment variable ([@atbrakhi](https://github.com/atbrakhi), [#41013](https://github.com/servo/servo/pull/41013)), in addition to the usual `-Z` / `--debug=` arguments.

[**Servo’s devtools**](https://book.servo.org/contributing/devtools.html) now partially support the **Network** > **Security** tab ([@jiang1997](https://github.com/jiang1997), [#40567](https://github.com/servo/servo/pull/40567)), allowing you to inspect some of the TLS details of your requests.
We’ve also made it **compatible with Firefox 145** ([@eerii](https://github.com/eerii), [#41087](https://github.com/servo/servo/pull/41087)), and use fewer IPC resources ([@mrobinson](https://github.com/mrobinson), [#41161](https://github.com/servo/servo/pull/41161)).

<figure>
    <img src="{{ '/img/blog/2026-01-devtools-security.png' | url }}" alt="this website in Servo’s devtools, showing that the main request used TLS 1.3, TLS13_AES_256_GCM_SHA384 cipher suite, and X25519MLKEM768 key exchange, with HSTS enabled and HPKP disabled">
</figure>

We’ve fixed rendering bugs related to **‘float’**, **‘order’**, **‘max-width’**, **‘max-height’**, **‘:link’ selectors**, **&lt;audio> layout**, and **getClientRects()**, affecting intrinsic sizing ([@Loirooriol](https://github.com/Loirooriol), [#41513](https://github.com/servo/servo/pull/41513)), anonymous blocks ([@Loirooriol](https://github.com/Loirooriol), [#41510](https://github.com/servo/servo/pull/41510)), incremental layout ([@Loirooriol](https://github.com/Loirooriol), [#40994](https://github.com/servo/servo/pull/40994)), flex item sizing ([@Loirooriol](https://github.com/Loirooriol), [#41291](https://github.com/servo/servo/pull/41291)), selector matching ([@andreubotella](https://github.com/andreubotella), [#41478](https://github.com/servo/servo/pull/41478)), replaced element layout ([@Loirooriol](https://github.com/Loirooriol), [#41262](https://github.com/servo/servo/pull/41262)), and empty fragments ([@Loirooriol](https://github.com/Loirooriol), [#41477](https://github.com/servo/servo/pull/41477)).

Servo now fires **‘toggle’** events on **&lt;dialog>** ([@lukewarlow](https://github.com/lukewarlow), [#40412](https://github.com/servo/servo/pull/40412)).
We’ve also improved the conformance of ‘wheel’ events ([@mrobinson](https://github.com/mrobinson), [#41182](https://github.com/servo/servo/pull/41182)), ‘hashchange’ events ([@Taym95](https://github.com/Taym95), [#41325](https://github.com/servo/servo/pull/41325)), ‘dblclick’ events on &lt;input> ([@Taym95](https://github.com/Taym95), [#41319](https://github.com/servo/servo/pull/41319)), ‘resize’ events on &lt;video> ([@tharkum](https://github.com/tharkum), [#40940](https://github.com/servo/servo/pull/40940)), ‘seeked’ events on &lt;video> and &lt;audio> ([@tharkum](https://github.com/tharkum), [#40981](https://github.com/servo/servo/pull/40981)), and the ‘transform’ property in getComputedStyle() ([@mrobinson](https://github.com/mrobinson), [#41187](https://github.com/servo/servo/pull/41187)).

## Embedding API

Servo now has basic support for **HTTP proxies** ([@Narfinger](https://github.com/Narfinger), [#40941](https://github.com/servo/servo/pull/40941)).
You can set the proxy URL in the `http_proxy` ([@Narfinger](https://github.com/Narfinger), [#41209](https://github.com/servo/servo/pull/41209)) or `HTTP_PROXY` ([@treeshateorcs](https://github.com/treeshateorcs), [@yezhizhen](https://github.com/yezhizhen), [#41268](https://github.com/servo/servo/pull/41268)) environment variables, or via `--pref network_http_proxy_uri`.

We now use the **system root certificates** by default ([@Narfinger](https://github.com/Narfinger), [@mrobinson](https://github.com/mrobinson), [#40935](https://github.com/servo/servo/pull/40935), [#41179](https://github.com/servo/servo/pull/41179)), on most platforms.
If you don’t want to trust the system root certificates, you can instead continue to use Mozilla’s root certificates with `--pref network_use_webpki_roots`.
As always, you can also add your own root certificates via [`Opts`](https://doc.servo.org/servo/opts/struct.Opts.html)::[`certificate_path`](https://doc.servo.org/servo/opts/struct.Opts.html#structfield.certificate_path) (`--certificate-path=`).

We have a new [`SiteDataManager`](https://doc.servo.org/servo/struct.SiteDataManager.html) API for managing **localStorage**, **sessionStorage**, and **cookies** ([@janvarga](https://github.com/janvarga), [#41236](https://github.com/servo/servo/pull/41236), [#41255](https://github.com/servo/servo/pull/41255), [#41378](https://github.com/servo/servo/pull/41378), [#41523](https://github.com/servo/servo/pull/41523), [#41528](https://github.com/servo/servo/pull/41528)), and a new [`NetworkManager`](https://doc.servo.org/servo/struct.NetworkManager.html) API for managing the **cache** ([@janvarga](https://github.com/janvarga), [@mrobinson](https://github.com/mrobinson), [#41255](https://github.com/servo/servo/pull/41255), [#41474](https://github.com/servo/servo/pull/41474), [#41386](https://github.com/servo/servo/pull/41386)).
To clear the cache, call [`NetworkManager`](https://doc.servo.org/servo/struct.NetworkManager.html)::[`clear_cache`](https://doc.servo.org/servo/struct.NetworkManager.html#method.clear_cache), and to list cache entries, call [`NetworkManager`](https://doc.servo.org/servo/struct.NetworkManager.html)::[`cache_entries`](https://doc.servo.org/servo/struct.NetworkManager.html#method.cache_entries).

[**Simple dialogs**](https://html.spec.whatwg.org/multipage/#simple-dialogs) – that is alert(), confirm(), and prompt() – are now exposed to embedders via a new [`SimpleDialog`](https://doc.servo.org/servo/enum.SimpleDialog.html) type in [`EmbedderControl`](https://doc.servo.org/servo/webview_delegate/enum.EmbedderControl.html) ([@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#40982](https://github.com/servo/servo/pull/40982)).
This new interface is harder to misuse, and no longer requires boilerplate for embedders that wish to [ignore simple dialogs](https://html.spec.whatwg.org/multipage/#cannot-show-simple-dialogs).

**Web console messages**, including messages from the [Console API](https://developer.mozilla.org/en-US/docs/Web/API/Console_API), are now accessible via [`ServoDelegate`](https://doc.servo.org/servo/trait.ServoDelegate.html)::[`show_console_message`](https://doc.servo.org/servo/trait.ServoDelegate.html#method.show_console_message) and [`WebViewDelegate`](https://doc.servo.org/servo/trait.WebViewDelegate.html)::[`show_console_message`](https://doc.servo.org/servo/trait.WebViewDelegate.html#method.show_console_message) ([@atbrakhi](https://github.com/atbrakhi), [#41351](https://github.com/servo/servo/pull/41351)).

[`Servo`](https://doc.servo.org/servo/struct.Servo.html), the main handle for controlling Servo, is now cloneable for sharing within the same thread ([@mukilan](https://github.com/mukilan), [@mrobinson](https://github.com/mrobinson), [#41010](https://github.com/servo/servo/pull/41010)).
To shut down Servo, simply [drop](https://doc.rust-lang.org/std/mem/fn.drop.html) the last `Servo` handle or let it go out of scope.
`Servo`::`start_shutting_down` and `Servo`::`deinit` have been removed ([@mukilan](https://github.com/mukilan), [@mrobinson](https://github.com/mrobinson), [#41012](https://github.com/servo/servo/pull/41012)).

Several interfaces have also been renamed:

- [`Servo`](https://doc.servo.org/servo/struct.Servo.html)::`clear_cookies` is now [`SiteDataManager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::[`clear_cookies`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.clear_cookies) ([@janvarga](https://github.com/janvarga), [#41236](https://github.com/servo/servo/pull/41236), [#41255](https://github.com/servo/servo/pull/41255))
- `DebugOpts`::`disable_share_style_cache` is now [`Preferences`](https://doc.servo.org/servo/prefs/struct.Preferences.html)::[`layout_style_sharing_cache_enabled`](https://doc.servo.org/servo/prefs/struct.Preferences.html#structfield.layout_style_sharing_cache_enabled) ([@atbrakhi](https://github.com/atbrakhi), [#40959](https://github.com/servo/servo/pull/40959))
- The rest of `DebugOpts` has been moved to [`DiagnosticsLogging`](https://doc.servo.org/servo/opts/struct.DiagnosticsLogging.html), and the options have been renamed ([@atbrakhi](https://github.com/atbrakhi), [#40960](https://github.com/servo/servo/pull/40960))

## Perf and stability

We can now **evict entries** from our **HTTP cache** ([@Narfinger](https://github.com/Narfinger), [@gterzian](https://github.com/gterzian), [@Taym95](https://github.com/Taym95), [#40613](https://github.com/servo/servo/pull/40613)), rather than having it grow forever (or get cleared by an embedder).
**about:memory** now tracks **SVG-related memory usage** ([@d-kraus](https://github.com/d-kraus), [#41481](https://github.com/servo/servo/pull/41481)), and we’ve fixed memory leaks in &lt;video> and &lt;audio> ([@tharkum](https://github.com/tharkum), [#41131](https://github.com/servo/servo/pull/41131)).

Servo now does less work when **matching selectors** ([@webbeef](https://github.com/webbeef), [#41368](https://github.com/servo/servo/pull/41368)), when **focus changes** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#40984](https://github.com/servo/servo/pull/40984)), and when **reflowing boxes** whose size did not change ([@Loirooriol](https://github.com/Loirooriol), [@mrobinson](https://github.com/mrobinson), [#41160](https://github.com/servo/servo/pull/41160)).

To allow for smaller binaries, **gamepad support** is now **optional at build time** ([@WaterWhisperer](https://github.com/WaterWhisperer), [#41451](https://github.com/servo/servo/pull/41451)).

We’ve fixed some **undefined behaviour** around garbage collection ([@sagudev](https://github.com/sagudev), [@jdm](https://github.com/jdm), [@gmorenz](https://github.com/gmorenz), [#41546](https://github.com/servo/servo/pull/41546), [mozjs#688](https://github.com/servo/mozjs/pull/688), [mozjs#689](https://github.com/servo/mozjs/pull/689), [mozjs#692](https://github.com/servo/mozjs/pull/692)).
To better avoid other garbage-collection-related bugs ([@sagudev](https://github.com/sagudev), [mozjs#647](https://github.com/servo/mozjs/issues/647), [mozjs#638](https://github.com/servo/mozjs/pull/638)), we’ve continued our work on defining (and migrating to) safer interfaces between Servo and the SpiderMonkey GC ([@sagudev](https://github.com/sagudev), [#41519](https://github.com/servo/servo/pull/41519), [#41536](https://github.com/servo/servo/pull/41536), [#41537](https://github.com/servo/servo/pull/41537), [#41520](https://github.com/servo/servo/pull/41520), [#41564](https://github.com/servo/servo/pull/41564)).

We’ve fixed a crash that occurs when **&lt;link rel="shortcut icon">** has an **empty ‘href’ attribute**, which affected chiptune<!---->.com ([@webbeef](https://github.com/webbeef), [#41056](https://github.com/servo/servo/pull/41056)), and we’ve also fixed crashes in:

- ‘background-repeat’ ([@mrobinson](https://github.com/mrobinson), [#41158](https://github.com/servo/servo/pull/41158))
- &lt;audio> layout ([@Loirooriol](https://github.com/Loirooriol), [#41262](https://github.com/servo/servo/pull/41262))
- custom elements ([@mrobinson](https://github.com/mrobinson), [#40743](https://github.com/servo/servo/pull/40743))
- AudioBuffer ([@WaterWhisperer](https://github.com/WaterWhisperer), [#41253](https://github.com/servo/servo/pull/41253))
- AudioNode ([@Taym95](https://github.com/Taym95), [#40954](https://github.com/servo/servo/pull/40954))
- ReportingObserver ([@Taym95](https://github.com/Taym95), [#41261](https://github.com/servo/servo/pull/41261))
- Uint8Array ([@jdm](https://github.com/jdm), [#41228](https://github.com/servo/servo/pull/41228))
- the fonts system, on FreeType platforms ([@simonwuelker](https://github.com/simonwuelker), [#40945](https://github.com/servo/servo/pull/40945))
- IME usage, on OpenHarmony ([@jschwe](https://github.com/jschwe), [#41570](https://github.com/servo/servo/pull/41570))

## Donations

Thanks again for your generous support!
We are now receiving **7110 USD/month** (+10.5% over November) in recurring donations.
This helps us cover the cost of our **[speedy](https://ci0.servo.org) [CI](https://ci1.servo.org) [and](https://ci2.servo.org) [benchmarking](https://ci3.servo.org) [servers](https://ci4.servo.org)**, one of our latest **[Outreachy interns](https://www.outreachy.org/alums/2025-06/#:~:text=Servo)**, and funding **[maintainer work]({{ '/blog/2025/09/17/your-donations-at-work-funding-jdm/' | url }})** that helps more people contribute to Servo.

Servo is also on [thanks.dev](https://thanks.dev), and already **30 GitHub users** (+2 over November) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

We now have [**sponsorship tiers**]({{ '/blog/2025/11/21/sponsorship-tiers/' | url }}) that allow you or your organisation to donate to the Servo project with public acknowlegement of your support.
A big thanks from Servo to our newest Bronze Sponsors: **Anthropy**, **Niclas Overby**, and **RxDB**!
If you’re interested in this kind of sponsorship, please contact us at [join@servo.org](mailto:join@servo.org).

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; right: calc(100% - 100% * 7110 / 10000); padding-right: 0.5em;"><strong>7110</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 7110 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="7110" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

Use of donations is decided transparently via the Technical Steering Committee’s public **[funding request process](https://github.com/servo/project/blob/main/FUNDING_REQUEST.md)**, and active proposals are tracked in [servo/project#187](https://github.com/servo/project/issues/187).
For more details, head to our [Sponsorship page]({{ '/sponsorship/' | url }}).

## Conference talks and blogs

We’ve recently published one talk and one blog post:

- [**Web engine CI on a shoestring budget**](https://www.youtube.com/watch?v=-W1mSXdlRqA) ([slides](https://www.azabani.com/talks/2025-12-18-shoestring-web-engine-ci/); [transcript](https://blogs.igalia.com/mrego/servo-a-new-web-engine-written-in-rust/)) – Delan Azabani ([@delan](https://github.com/delan)) spoke about the CI system that keeps our builds and tryjobs moving fast, running nearly two million tests in under half an hour.

- [**Servo 2025 Stats**](https://blogs.igalia.com/mrego/servo-2025-stats/) – Manuel Rego ([@mrego](https://github.com/mrego)) wrote about the growth of the Servo project, and how our many new contributors have enabled that.

We also have two **upcoming** talks at [**FOSDEM 2026**](https://fosdem.org/2026/) in **Brussels** later this month:

- [**The Servo project and its impact on the web platform ecosystem**](https://fosdem.org/2026/schedule/event/LXFKS9-servo-project-impact/) – Manuel Rego ([@mrego](https://github.com/mrego)) is speaking on **Saturday 31 January** at [**14:00 local time**](https://everytimezone.com/?t=697d4600,8ac) (13:00 UTC), about Servo’s impact on spec issues, interop bugs, test cases, and the broader web platform ecosystem.

- [**Implementing Streams Spec in Servo web engine**](https://fosdem.org/2026/schedule/event/3J8GUD-servo-streams-reimplementation/) – Taym Haddadi ([@Taym95](https://github.com/Taym95)) is speaking on **Saturday 31 January** at [**17:45 local time**](https://everytimezone.com/?t=697d4600,98d) (16:45 UTC), about our experiences writing a new implementation of the [Streams API](https://developer.mozilla.org/en-US/docs/Web/API/Streams_API) that is independent of the one in SpiderMonkey.

Servo developers Martin Robinson ([@mrobinson](https://github.com/mrobinson)) and Delan Azabani ([@delan](https://github.com/delan)) will also be attending FOSDEM 2026, so it would be a great time to come along and chat about Servo!

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
