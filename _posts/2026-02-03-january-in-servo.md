---
layout:     post
tags:       blog
title:      "January in Servo: who knows?"
date:       2026-02-03
summary:    hurr durr
categories:
---

<figure>
    <img src="{{ '/img/blog/2026-02-diffie.png' | url }}" alt="Servo 0.0.5 showing improved appearance of buttons, text inputs, radio buttons, and checkboxes, plus new support for ‘::details-content’ and ‘:open’ selectors">
</figure>

## Web APIs

We were accidentally persisting `SessionStorage` data beyond the current session, but this has been corrected (@arihant2math, #41326).

Servo now plays OGG media inside `<audio>` elements (@jdm, #41789)!
We disabled this feature many years ago due to bugs in [GStreamer](https://gstreamer.freedesktop.org/), our media playback engine, but those bugs have since been fixed.

IndexedDB support continues to make progress.
This month we gained improvements to connection queues (@gterzian, #41500, #42053) and request granularity (@gterzian, #41933).
This work remains disabled behind the `dom_indexeddb_enabled` preference until more of the IndexedDB API is implemented.

We now support non-`px` sizes for width and height attributes in `<svg>` elements (@rodio, #40761).

Inactive documents will now correct reject fullscreen mode changes (@stevennovaryo, #42068).

We've enabled support for the **navigator.sendBeacon** by default (@TimvdLippe, #41694); the `dom_navigator_sendbeacon_enabled` preference has been removed.
As part of this work, we implemented the [`keepalive`](https://developer.mozilla.org/en-US/docs/Web/API/Request/keepalive) feature of the Request API (@TimvdLippe, #41457, @WaterWhisperer, #41811).

That's not all for network-related improvements!
Quota errors from the [`fetchLater`](https://developer.mozilla.org/en-US/docs/Web/API/Window/fetchLater) API provide more details (@TimvdLippe, #41665), and fetch response body promises now reject when invalid gzip content is encountered (@arayaryoma, #39438).
Meanwhile, [`EventSource`](https://developer.mozilla.org/en-US/docs/Web/API/EventSource) connections will no longer endlessly reconnect for permanent failures (@WaterWhisperer, #41651, #42137), and now use the correct `Last-Event-Id` header when reconnecting (@WaterWhisperer, #42103).
Finally, Servo will create `PerformanceResourceTiming` entries for requests that returned unsuccessful responses (@bellau, #41804).

There has been lots of work related to **navigating pages and loading iframes**.
We process URL fragments more consistently when navigating via the `location` property (@TimvdLippe, #41805, #41834), and allow evaluating `javascript:` URLs when a document's domain has been modified (@jdm, #41969).
XML documents loaded in an `<iframe>` will no longer inherit an encoding from the parent document (@simonwuelker, #41637).

We're also made it possible to use `blob:` URLs from inside `about:blank` and `about:srcdoc` documents (@jdm, #41966, #42104).
Finally, constructed documents (e.g. `new Document()`) now inherit the origin and domain of the document that created them (@TimvdLippe, #41780), and we implemented the new [`Origin`](https://html.spec.whatwg.org/multipage/#the-origin-interface) interface.

Servo's mixed content protections are steadily increasing.
Insecure requests (e.g. HTTP) originating from `<iframe>` elements can be upgraded to secure protocols (@WaterWhisperer, #41661), and redirected requests now check the most recent URL when determining if the protocol is secure (@WaterWhisperer, #41832).

Stylesheets loaded when parsing the document will block the document `load` event more consistently (@TimvdLippe, @mrobinson, #41986, #41987, #41988, #41973), and the `blocking` attribute can be used for stylesheets that are added dynamically @TimvdLippe, #42096).
We also fire the `error` event if a fetched stylesheet response is invalid (@TimvdLippe, @mrobinson, #42037).

Servo now **[leads other browsers](https://wpt.fyi/results/WebCryptoAPI?label=master&product=chrome%5Bexperimental%5D&product=firefox%5Bexperimental%5D&product=safari&product=servo&aligned)** in support for new WebCrypto algorithms!
This includes work on ML-KEM (@kkoyung, #41604, #41617, #41615, #41627), ML-DSA (@kkoyung, #41628, #41647, #41659, #41676), AES-OCB (@kkoyung, #41791, #41822, #41813, #41829), and AES-GCM (@kkoyung, #41950).
Additionally, the error messages returned by many WebCrypto APIs are now more detailed (@PaulTreitel, @danilopedraza, #41964, #41468, #41902).

JS module loading received a lot of attention—we've improved support for **cyclic imports** (@Gae24, #41779), **import attributes** (@Gae24, #42185), and **JSON modules** (@Gae24, @jdm, #42138).

Additionally, the [`preload`](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/rel/preload) attribute now triggers **preload fetch operations** that can improve page load speeds (@TimvdLippe, @jdm, #40059).

**Text input fields** have received a lot of love this month.
Clicking in an input field will position the cursor accordingly (@mrobinson, @jdm, @Loirooriol, #41906, #41974, #41931), as will clicking past the end of a multiline input (@mrobinson, @Loirooriol, #41909).
Selecting text with the mouse in input fields works (@mrobinson, #42049), and double and triple clicks now toggle selections (@mrobinson, #41926).
Finally, we fixed a bug causing the input caret to be hidden in `<input>` elements inside of Shadow DOM content (@stevennovaryo, #42233).

The `cursor-color` CSS property is respected when rendering the input cursor (@mrobinson, #41976), and newlines can no longer be pasted into single line inputs (@mrobinson, #41934)
Finally, we fixed a panic that occurred when focusing a text field that is disabled (@mrobinson, #42078), as well as panics from APIs like `setRangeText` that confused bytes and UTF-8 character indices (@mrobinson, #41588).

We also made time to **improve form controls**!
The default styling of many controls received some care (@mrobinson, #42085), while `<input type=button>` can now be styled with the `:active` pseudo-class (@mrobinson, #42095).
Conversely, disabled `<select>` elements can no longer be activated (@simonwuelker, #42036).

Mouse events triggered by the embedder are more complete; `MouseEvent.detail` correctly reports the click count for `mouseup` and `mousedown` events (@mrobinson, #41833), and many other members are now consistent with other mouse events (@mrobinson, #42013).

Performing a pinch zoom on mobile is now reflected in the [`VisualViewport`](https://developer.mozilla.org/en-US/docs/Web/API/VisualViewport) API (@stevennovaryo, #41754).
This work remains hidden behind the `dom_visual_viewport_enabled` preference until more of the API is supported.

We've changed the behaviour of Web APIs that use the [`[Clamp]` annotation](https://webidl.spec.whatwg.org/#Clamp) (such as `Blob.slice`).
The previous implementation would cast floating point values to their integer equivalents, but the standard requires [more specific rounding logic](https://webidl.spec.whatwg.org/#abstract-opdef-converttoint) (#41640).

The `RGBA8` constant is now available in WebGL 1 rendering contexts; it was previously only available in WebGL 2 contexts (@simonwuelker, #42048).

**Fonts** were another area of focus this month.
Loading web fonts from `file://` origins works as expected (@TimvdLippe, #41714), as does using web fonts within Shadow DOM content (@minghuaw, #42151).
Each web font request now creates a [PerformanceResourceTiming](https://developer.mozilla.org/en-US/docs/Web/API/PerformanceResourceTiming) entry (@lumi-me-not, #41784).
Servo supports font variations as of November 2025, so the [`FontFace`](https://developer.mozilla.org/en-US/docs/Web/API/FontFace) constructor no longer ignores the `font-variation-settings` property (@muse254, #41968).

Cursive scripts now ignore the `letter-spacing` CSS property (@mrobinson, #42165),
and we significantly reduced the time and memory required when **rendering non-ASCII text** (@mrobinson, @Loirooriol, #42105, #42162) as well as for text nodes that share the same font (@mrobinson, #41876).

## CSS

There were lots of improvements to block layout algorithms (@Loirooriol, #41492, #41624, #41632, #41655, #41652, #41683).
These often affect pages where some block element (such as a `<div>`) exists within other layout mode (such as an inline `<span>`, or a flexbox context), and fixes like these ensure Servo matches the output of other browsers.

Elements with overflow that is scrollable can be scrolled more consistently, even with CSS transforms applied to them (@stevennovaryo, #41707, #42005).

Generated image content used to only work with pseudo-elements, but that restriction no longer applies (@andreubotella, #41480).
Similarly, `<details>` elements can now be styled with the `::details-content` pseudo-elemement (@lukewarlow, #42107), as well as the `:open` pseudo-class (@lukewarlow, #42195).

CSS styles now inherit correctly through `display: contents` as well as `<slot>` elements in Shadow DOM content (@longvatrong111, @Loirooriol, @mrobinson, #41855).

The `overflow-clip-margin` property now works correctly when `border-radius` is present (@Loirooriol, #41967).

We fixed bugs involving text inside flexbox elements: they now use consistent baselines for alignment (@lukewarlow, @mrobinson, #42038) and updated styles are propagated to the text correctly (@mrobinson, #41951).

The `align` attribute on `<img>` elements now aligns the image as expected (@mrobinson, #42220).

`word-break: keep-all` now prevents line breaks in [CJK text](https://en.wikipedia.org/wiki/CJK_characters) (@RichardTjokroutomo, #42088).

We also fixed some bugs involving [collapsing margins](https://developer.mozilla.org/en-US/docs/Web/CSS/Guides/Box_model/Margin_collapsing), floats, and [phantom line boxes](https://drafts.csswg.org/css-inline-3/#invisible-line-boxes) (@Loirooriol, #41812), which sound much cooler than they actually are.

Finally, we upgraded our [Stylo](https://crates.io/crates/stylo) dependency to the latest changes as of January 1 2026 (@Loirooriol, #41916, #41696).
Stylo powers our CSS parsing and [style resolution engine](https://hacks.mozilla.org/2017/08/inside-a-super-fast-css-engine-quantum-css-aka-stylo/), and this upgrade improves our **CSS animations and transitions** for borders and overflow clipping and **parsing color functions** like `color-mix`.

## Automation and introspection

Last month Servo gained support for HTTP proxies.
We now support **HTTPS proxies** as well (@Narfinger, #41689), which can be configured with the `https_proxy`/`HTTPS_PROXY` environment variables or the `network_https_proxy_uri` preference.
In addition, the `NO_PROXY` variable or `network_http_no_proxy` preference can **disable any proxy** for particular domains.
See [the preference documentation](https://doc.servo.org/servo/struct.Preferences.html#structfield.network_http_no_proxy) for more details.

Our **developer tools** integration continues to improve.
Worker globals are now categorized correctly in the UI (@atbrakhi, #41929), and the Sources panel is populated for very short documents (@atbrakhi, #41983).
Servo will report console messages that were logged before the developer tools are opened (@eerii, @mrobinson, #41895).
Finally, we fixed a panic when selecting nodes in the layout inspector that have no style information (@eerii, #41800).

We're working towards supporting pausing in the JS debugger (@eerii, @atbrakhi, @jdm, #42007), and breakpoints can be toggled through the UI (@eerii, @atbrakhi, #41925, #42154).
While the debugger is paused, hovering over JS objects will report the object's properties for builtin JS classes (@eerii, @atbrakhi, #42186).
Sadly, pausing does not actually pause Servo yet; stay tuned for updates in next month's blog post!

Similarly, our **WebDriver server** is also maturing.
Evaluating a synchronous script that returns a Promise will wait until that promise settles (@yezhizhen, #41823).
`touchmove` events are sent for pointer actions when a button is pressed (@yezhizhen, #41801), and `touchcancel` events for canceled pointer action items (@yezhizhen, #41937).
Finally, any pointer actions that would trigger duplicate `mousemove` events are silently discarded (@mrobinson, #42034).

The [`Element Clear`](https://w3c.github.io/webdriver/#element-clear) API now tests whether the element is interactable (@yezhizhen, #42124).
A null script execution timeout value will never trigger a timeout (@yezhizhen, #42184), and synthesized `pointermove` events have a consistent `pointerId` value (@yezhizhen, #41726).

## Embedding

It is now possible to **cross-compile Servo** using Windows as the host (@yezhizhen, #41748).
In addition, we have **pinned all git dependencies** to specific revisions to reduce the risk of build failures (@Narfinger, #42029).
In future, we intend to [forbid git dependencies entirely](https://github.com/servo/servo/issues/25650).

The [`SiteDataManager`](https://doc.servo.org/servo/struct.SiteDataManager.html) interface has a new **clear_site_data** method to clear all stored data for a particular host (@janvarga, #41618, #41709, #41852).

Our nightly testing UI, **servoshell**, now respects any customized installation path on Windows (@yezhizhen, #41653).
We fixed a crash in the Android app when pausing the application (@NiklasMerz, #41827).
Additionally, clicking inside a webview in the desktop app will remove focus from any browser UI (@mrobinson, #42080).

We've laid more groundwork to expose accessibility tree information from WebViews (@delan, @lukewarlow, @alice, #41924).
There's nothing to test yet, but keep an eye on our [tracking issue](https://github.com/servo/servo/issues/4344) if you want to be notified when nightly builds are ready for testing!

## Stability & performance

We converted many uses of IPC channels in the engine to channels that are **more efficient** when multiprocess mode is disabled (@Narfinger, @jdm, @sagudev, @mrobinson, #41178, #41071, #41733, #41806, #41380, #41809, #41774, #42032, #42033, #41412).

Servo now sets a **socket timeout for HTTP conections** (@Narfinger, @mrobinson, #41710).
This is controlled by the `network_connection_timeout` preference and defaults to **15 seconds**.

Each instance of Servo now starts four fewer threads (@Narfinger, #41740).
Any network operations that trigger a synchronous UI operation (such as an HTTP authentication prompt) no longer blocks other network tasks from completing (@Narfinger, @jdm, #41965, #41857).

It's said that one of the hardest problems in computer science is cache invalidation.
We improved the memory usage of **dynamic inline SVG content** by evicting stale SVG tree data from a cache (@TomRCummings, #41675).
Meanwhile, we added a new cache to reduce memory usage and improve rendering performance for pages with animating images (@Narfinger, #41956).

Servo's JS engine now accounts for 2d and 3d canvas-related memory usage when deciding whether to perform a garbage collection operation.
This can reduce the risk of out of memory (OOM) errors on pages that create large numbers of short-lived WebGL or WebGPU objects.

To reduce the risk of panics involving the JS engine integration, we are using **the Rust type system** to make certain kinds of dynamic borrow failures impossible (@sagudev, #41692, #41782, #41756, #41808, #41879, #41878, #41955, #41971, #42123).
We also continue to identify and **forbid code patterns** that can trigger rare crashes during garbage collection when destroying a WebView (@willypuzzle, #41717, #41783, #41911, #41911, #41977, #41984, #42243).

This month also featured various fixes panics in parallel layout (@mrobinson, #42026), WebGPU (@WaterWhisperer, #42050), `<link>` fetching (@jdm, #42208), `Element.attachShadow` (@mrobinson, #42237), text input methods (@mrobinson, #42240), Web Workers when the developer tools are active,(@mrobinson, #42159), IndexedDB (@gterzian, #41960), and asynchronous [session history](https://developer.mozilla.org/en-US/docs/Web/API/History_API/Working_with_the_History_API) updates (@mrobinson, #42238).

The `Node.compareDocumentPosition` method is now more efficient (@webbeef, #42260), and selections in text inputs no longer require a full page layout (@mrobinson, @Loirooriol, #41963).

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
