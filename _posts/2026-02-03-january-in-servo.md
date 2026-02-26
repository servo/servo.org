---
layout:     post
tags:       blog
title:      "January in Servo: who knows?"
date:       2026-02-03
summary:    hurr durr
categories:
---

## Web APIs

We've enabled support for the **navigator.sendBeacon** by default (@TimvdLippe, #41694); the `dom_navigator_sendbeacon_enabled` preference has been removed.
As part of this work, we implemented the [`keepalive`](https://developer.mozilla.org/en-US/docs/Web/API/Request/keepalive) feature of the Request API (@TimvdLippe, #41457, @WaterWhisperer, #41811).

That's not all for network-related improvements!
Quota errors from the [`fetchLater`](https://developer.mozilla.org/en-US/docs/Web/API/Window/fetchLater) API provide more details (@TimvdLippe, #41665), and fetch response body promises now reject when invalid gzip content is encountered (@arayaryoma, #39438).
Meanwhile, [`EventSource`](https://developer.mozilla.org/en-US/docs/Web/API/EventSource) connections will no longer endlessly reconnect for permanent failures (@WaterWhisperer, #41651, #42137), and now use the correct `Last-Event-Id` header when reconnecting (@WaterWhisperer, #42103).

There has been lots of work related to **navigating pages and loading iframes**.
We process URL fragments more consistently when navigating via the `location` property (@TimvdLippe, #41805, #41834), and allow evaluating `javascript:` URLs when a document's domain has been modified (@jdm, #41969).
We're also made it possible to use `blob:` URLs from inside `about:blank` and `about:srcdoc` documents (@jdm, #41966, #42104).
Finally, documents with opaque origins are no longer allowed to set `document.domain` (@TimvdLippe, #41780).

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

The `cursor-color` CSS property is respected when rendering the input cursor (@mrobinson, #41976), and newlines can no longer be pasted into single line inputs (@mrobinson, #41934)
Finally, we fixed a panic that occurred when focusing a text field that is disabled (@mrobinson, #42078), as well as panics from APIs like `setRangeText` that confused bytes and UTF-8 character indices (@mrobinson, #41588).

We also made time to **improve form controls**!
The default styling of many controls received some care (@mrobinson, #42085), while `<input type=button>` can now be styled with the `:active` pseudo-class (@mrobinson, #42095).
Conversely, disabled `<select>` elements can no longer be activated (@simonwuelker, #42036).

Mouse events triggered by the embedder are more complete; `MouseEvent.detail` correctly reports the click count for `mouseup` and `mousedown` events (@mrobinson, #41833), and many other members are now consistent with other mouse events (@mrobinson, #42013).

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
Similarly, `<details>` elements can now be styled with the `::details-cotent` pseudo-elemement (@lukewarlow, #42107), as well as the `:open` pseudo-class (@lukewarlow, #42195).

CSS styles now inherit correctly through `display: contents` as well as `<slot>` elements in Shadow DOM content (@longvatrong111, @Loirooriol, @mrobinson, #41855).

## Network & Fetch



## Automation and introspection

Last month Servo gained support for HTTP proxies.
We now support **HTTPS proxies** as well (@Narfinger, #41689), which can be configured with the `https_proxy`/`HTTPS_PROXY` environment variables or the `network_https_proxy_uri` preference.
In addition, the `NO_PROXY` variable or `network_http_no_proxy` preference can **disable any proxy** for particular domains.
See [the preference documentation](https://doc.servo.org/servo/struct.Preferences.html#structfield.network_http_no_proxy) for more details.

Our **developer tools** integration continues to improve.
Worker globals are now categorized correctly in the UI (@atbrakhi, #41929), and the Sources panel is populated for very short documents (@atbrakhi, #41983).
Servo will report console messages that were logged before the developer tools are opened (@eerii, @mrobinson, #41895).
Finally, we fixed a panic when selecting nodes in the layout inspector that have no style information (@eerii, #41800).

Pausing in the JS debugger now interrupts script execution (@eerii, @atbrakhi, @jdm, #42007), and breakpoints can be toggled through the UI (@eerii, @atbrakhi, #41925, #42154).
While the debugger is paused, hovering over JS objects will report the object's properties for builtin JS classes (@eerii, @atbrakhi, #42186).

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
