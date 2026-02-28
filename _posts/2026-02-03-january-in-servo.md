---
layout:     post
tags:       blog
title:      "January in Servo: text input, preloads, details styling, and more!"
date:       2026-02-03
summary:    The web works hard, but Servo contributors work harder.
categories:
---

[**Servo 0.0.5**](https://github.com/servo/servo/releases/tag/v0.0.5) is here, bringing with it lots of improvements in web platform features.
Some highlights:

- **&lt;link rel=preload>** ([@TimvdLippe](https://github.com/TimvdLippe), [@jdm](https://github.com/jdm), [#40059](https://github.com/servo/servo/pull/40059))
- **&lt;style blocking>** and **&lt;link blocking>** ([@TimvdLippe](https://github.com/TimvdLippe), [#42096](https://github.com/servo/servo/pull/42096))
- **&lt;img align>** ([@mrobinson](https://github.com/mrobinson), [#42220](https://github.com/servo/servo/pull/42220))
- **&lt;select disabled>** ([@simonwuelker](https://github.com/simonwuelker), [#42036](https://github.com/servo/servo/pull/42036))
- **OGG files** can now be played in **&lt;audio>** ([@jdm](https://github.com/jdm), [#41789](https://github.com/servo/servo/pull/41789))
- **‘cursor-color’** ([@mrobinson](https://github.com/mrobinson), [#41976](https://github.com/servo/servo/pull/41976))
- **‘content: &lt;image>’** works on all elements ([@andreubotella](https://github.com/andreubotella), [#41480](https://github.com/servo/servo/pull/41480))
- **‘::details-content’** on &lt;details> ([@lukewarlow](https://github.com/lukewarlow), [#42107](https://github.com/servo/servo/pull/42107))
- **‘:open’** on &lt;details> ([@lukewarlow](https://github.com/lukewarlow), [#42195](https://github.com/servo/servo/pull/42195))
- **‘:active’** on &lt;input type=button> ([@mrobinson](https://github.com/mrobinson), [#42095](https://github.com/servo/servo/pull/42095))
- **[Origin](https://html.spec.whatwg.org/multipage/#the-origin-interface) API** ([@WaterWhisperer](https://github.com/WaterWhisperer), [#41712](https://github.com/servo/servo/pull/41712))
- **[MouseEvent.detail](https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail)** ([@mrobinson](https://github.com/mrobinson), [#41833](https://github.com/servo/servo/pull/41833))
- **[Request.keepalive](https://developer.mozilla.org/en-US/docs/Web/API/Request/keepalive)** ([@TimvdLippe](https://github.com/TimvdLippe), [@WaterWhisperer](https://github.com/WaterWhisperer), [#41457](https://github.com/servo/servo/pull/41457), [#41811](https://github.com/servo/servo/pull/41811))
- **Cyclic imports**, **import attributes**, and **JSON modules** ([@Gae24](https://github.com/Gae24), [#41779](https://github.com/servo/servo/pull/41779))
- **navigator.sendBeacon()** is enabled by default ([@TimvdLippe](https://github.com/TimvdLippe), [#41694](https://github.com/servo/servo/pull/41694))
- `https_proxy`, `HTTPS_PROXY`, and `NO_PROXY` ([@Narfinger](https://github.com/Narfinger), [#41689](https://github.com/servo/servo/pull/41689))
- **ML-KEM**, **ML-DSA**, and **AES-OCB** in **[Crypto](https://w3c.github.io/webcrypto/)** ([@kkoyung](https://github.com/kkoyung), [#41604](https://github.com/servo/servo/pull/41604), [#41617](https://github.com/servo/servo/pull/41617), [#41615](https://github.com/servo/servo/pull/41615), [#41627](https://github.com/servo/servo/pull/41627), [#41628](https://github.com/servo/servo/pull/41628), [#41647](https://github.com/servo/servo/pull/41647), [#41659](https://github.com/servo/servo/pull/41659), [#41676](https://github.com/servo/servo/pull/41676), [#41791](https://github.com/servo/servo/pull/41791), [#41822](https://github.com/servo/servo/pull/41822), [#41813](https://github.com/servo/servo/pull/41813), [#41829](https://github.com/servo/servo/pull/41829))

<figure>
    <img src="{{ '/img/blog/2026-02-diffie.png' | url }}" alt="Servo 0.0.5 showing improved appearance of buttons, text inputs, radio buttons, and checkboxes, plus new support for ‘::details-content’ and ‘:open’ selectors">
</figure>

## Web APIs

Servo now **plays OGG media** inside &lt;audio> elements ([@jdm](https://github.com/jdm), [#41789](https://github.com/servo/servo/pull/41789))!
We disabled this feature many years ago due to bugs in [GStreamer](https://gstreamer.freedesktop.org/), our media playback engine, but those bugs have since been fixed.

We now support non-`px` sizes for width and height attributes in &lt;svg> elements ([@rodio](https://github.com/rodio), [#40761](https://github.com/servo/servo/pull/40761)).

Inactive documents will now correctly reject fullscreen mode changes ([@stevennovaryo](https://github.com/stevennovaryo), [#42068](https://github.com/servo/servo/pull/42068)).

We've enabled support for the **navigator.sendBeacon()** by default ([@TimvdLippe](https://github.com/TimvdLippe), [#41694](https://github.com/servo/servo/pull/41694)); the `dom_navigator_sendbeacon_enabled` preference has been removed.
As part of this work, we implemented the [`keepalive`](https://developer.mozilla.org/en-US/docs/Web/API/Request/keepalive) feature of the Request API ([@TimvdLippe](https://github.com/TimvdLippe), [@WaterWhisperer](https://github.com/WaterWhisperer), [#41457](https://github.com/servo/servo/pull/41457), [#41811](https://github.com/servo/servo/pull/41811)).

That's not all for network-related improvements!
Quota errors from the **[fetchLater()](https://developer.mozilla.org/en-US/docs/Web/API/Window/fetchLater) API** provide more details ([@TimvdLippe](https://github.com/TimvdLippe), [#41665](https://github.com/servo/servo/pull/41665)), and fetch response body promises now reject when **invalid gzip content** is encountered ([@arayaryoma](https://github.com/arayaryoma), [#39438](https://github.com/servo/servo/pull/39438)).
Meanwhile, **[EventSource](https://developer.mozilla.org/en-US/docs/Web/API/EventSource)** connections will no longer endlessly reconnect for permanent failures ([@WaterWhisperer](https://github.com/WaterWhisperer), [#41651](https://github.com/servo/servo/pull/41651), [#42137](https://github.com/servo/servo/pull/42137)), and now use the correct **‘Last-Event-Id’ header** when reconnecting ([@WaterWhisperer](https://github.com/WaterWhisperer), [#42103](https://github.com/servo/servo/pull/42103)).
Finally, Servo will create **[PerformanceResourceTiming](https://developer.mozilla.org/en-US/docs/Web/API/PerformanceResourceTiming)** entries for requests that returned unsuccessful responses ([@bellau](https://github.com/bellau), [#41804](https://github.com/servo/servo/pull/41804)).

There has been lots of work related to **navigating pages** and **loading iframes**.
We process **URL fragments** more consistently when navigating via **window.location** ([@TimvdLippe](https://github.com/TimvdLippe), [#41805](https://github.com/servo/servo/pull/41805), [#41834](https://github.com/servo/servo/pull/41834)), and allow evaluating **javascript: URLs** when a document's domain has been modified ([@jdm](https://github.com/jdm), [#41969](https://github.com/servo/servo/pull/41969)).
XML documents loaded in an &lt;iframe> no longer inherit their encoding from the parent document ([@simonwuelker](https://github.com/simonwuelker), [#41637](https://github.com/servo/servo/pull/41637)).

We're also made it possible to use **blob: URLs** from inside **‘about:blank’** and **‘about:srcdoc’** documents ([@jdm](https://github.com/jdm), [#41966](https://github.com/servo/servo/pull/41966), [#42104](https://github.com/servo/servo/pull/42104)).
Finally, constructed documents (e.g. `new Document()`) now inherit the origin and domain of the document that created them ([@TimvdLippe](https://github.com/TimvdLippe), [#41780](https://github.com/servo/servo/pull/41780)), and we implemented the new **[Origin](https://html.spec.whatwg.org/multipage/#the-origin-interface) API** ([@WaterWhisperer](https://github.com/WaterWhisperer), [#41712](https://github.com/servo/servo/pull/41712)).

Servo's **mixed content protections** are steadily increasing.
Insecure requests (e.g. HTTP) originating from &lt;iframe> elements can now be upgraded to secure protocols ([@WaterWhisperer](https://github.com/WaterWhisperer), [#41661](https://github.com/servo/servo/pull/41661)), and redirected requests now check the most recent URL when determining if the protocol is secure ([@WaterWhisperer](https://github.com/WaterWhisperer), [#41832](https://github.com/servo/servo/pull/41832)).

**&lt;style blocking>** and **&lt;link blocking>** can now be used to block rendering while loading stylesheets that are added dynamically ([@TimvdLippe](https://github.com/TimvdLippe), [#42096](https://github.com/servo/servo/pull/42096)), and stylesheets loaded when parsing the document will **block the document ‘load’ event** more consistently ([@TimvdLippe](https://github.com/TimvdLippe), [@mrobinson](https://github.com/mrobinson), [#41986](https://github.com/servo/servo/pull/41986), [#41987](https://github.com/servo/servo/pull/41987), [#41988](https://github.com/servo/servo/pull/41988), [#41973](https://github.com/servo/servo/pull/41973)).
We also **fire the ‘error’ event** if a fetched stylesheet response is invalid ([@TimvdLippe](https://github.com/TimvdLippe), [@mrobinson](https://github.com/mrobinson), [#42037](https://github.com/servo/servo/pull/42037)).

Servo now **[leads other browsers](https://wpt.fyi/results/WebCryptoAPI?run_id=5925299129942016&run_id=5929752339939328&run_id=5468032483983360&run_id=5132831023169536)** in support for new **[Web](https://w3c.github.io/webcrypto/) [Cryptography](https://wicg.github.io/webcrypto-modern-algos/)** algorithms!
This includes full support for **ML-KEM** ([@kkoyung](https://github.com/kkoyung), [#41604](https://github.com/servo/servo/pull/41604), [#41617](https://github.com/servo/servo/pull/41617), [#41615](https://github.com/servo/servo/pull/41615), [#41627](https://github.com/servo/servo/pull/41627)), **ML-DSA** ([@kkoyung](https://github.com/kkoyung), [#41628](https://github.com/servo/servo/pull/41628), [#41647](https://github.com/servo/servo/pull/41647), [#41659](https://github.com/servo/servo/pull/41659), [#41676](https://github.com/servo/servo/pull/41676)), and **AES-OCB** ([@kkoyung](https://github.com/kkoyung), [#41791](https://github.com/servo/servo/pull/41791), [#41822](https://github.com/servo/servo/pull/41822), [#41813](https://github.com/servo/servo/pull/41813), [#41829](https://github.com/servo/servo/pull/41829)), plus improvements to **AES-GCM** ([@kkoyung](https://github.com/kkoyung), [#41950](https://github.com/servo/servo/pull/41950)).
Additionally, the error messages returned by many Crypto APIs are now more detailed ([@PaulTreitel](https://github.com/PaulTreitel), [@danilopedraza](https://github.com/danilopedraza), [#41964](https://github.com/servo/servo/pull/41964), [#41468](https://github.com/servo/servo/pull/41468), [#41902](https://github.com/servo/servo/pull/41902)).

**[JS module](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules) loading** received a lot of attention – we've improved support for **cyclic imports** ([@Gae24](https://github.com/Gae24), [#41779](https://github.com/servo/servo/pull/41779)), **import attributes** ([@Gae24](https://github.com/Gae24), [#42185](https://github.com/servo/servo/pull/42185)), and **JSON modules** ([@Gae24](https://github.com/Gae24), [@jdm](https://github.com/jdm), [#42138](https://github.com/servo/servo/pull/42138)).

Additionally, the **[&lt;link rel=preload>](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Attributes/rel/preload)** attribute now triggers **preload fetch operations** that can improve page load speeds ([@TimvdLippe](https://github.com/TimvdLippe), [@jdm](https://github.com/jdm), [#40059](https://github.com/servo/servo/pull/40059)).

**IndexedDB** support continues to make progress, though for now the feature is disabled by default (`--pref dom_indexeddb_enabled`).
This month we gained improvements to **connection queues** ([@gterzian](https://github.com/gterzian), [#41500](https://github.com/servo/servo/pull/41500), [#42053](https://github.com/servo/servo/pull/42053)) and **request granularity** ([@gterzian](https://github.com/gterzian), [#41933](https://github.com/servo/servo/pull/41933)).

We were accidentally persisting **SessionStorage** data beyond the current session, but this has been corrected ([@arihant2math](https://github.com/arihant2math), [#41326](https://github.com/servo/servo/pull/41326)).

**Text input fields** have received a lot of love this month.
Clicking in an input field will position the cursor accordingly ([@mrobinson](https://github.com/mrobinson), [@jdm](https://github.com/jdm), [@Loirooriol](https://github.com/Loirooriol), [#41906](https://github.com/servo/servo/pull/41906), [#41974](https://github.com/servo/servo/pull/41974), [#41931](https://github.com/servo/servo/pull/41931)), as will clicking past the end of a multiline input ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#41909](https://github.com/servo/servo/pull/41909)).
Selecting text with the mouse in input fields works ([@mrobinson](https://github.com/mrobinson), [#42049](https://github.com/servo/servo/pull/42049)), and double and triple clicks now toggle selections ([@mrobinson](https://github.com/mrobinson), [#41926](https://github.com/servo/servo/pull/41926)).
Finally, we fixed a bug causing the input caret to be hidden in &lt;input> elements inside of Shadow DOM content ([@stevennovaryo](https://github.com/stevennovaryo), [#42233](https://github.com/servo/servo/pull/42233)).

**‘cursor-color’** is respected when rendering the input cursor ([@mrobinson](https://github.com/mrobinson), [#41976](https://github.com/servo/servo/pull/41976)), and newlines can no longer be pasted into single line inputs ([@mrobinson](https://github.com/mrobinson), [#41934](https://github.com/servo/servo/pull/41934)).
Finally, we fixed a panic when focusing a text field that is disabled ([@mrobinson](https://github.com/mrobinson), [#42078](https://github.com/servo/servo/pull/42078)), as well as panics in APIs like **HTMLInputElement.setRangeText()** that confused bytes and UTF-8 character indices ([@mrobinson](https://github.com/mrobinson), [#41588](https://github.com/servo/servo/pull/41588)).

We also made time to **improve form controls**!
The default styling of many controls received some care ([@mrobinson](https://github.com/mrobinson), [#42085](https://github.com/servo/servo/pull/42085)), while **&lt;input type=button>** can now be styled with the **‘:active’ pseudo-class** ([@mrobinson](https://github.com/mrobinson), [#42095](https://github.com/servo/servo/pull/42095)).
Conversely, disabled **&lt;select>** elements can no longer be activated ([@simonwuelker](https://github.com/simonwuelker), [#42036](https://github.com/servo/servo/pull/42036)).

Mouse events triggered by the embedder are more complete; [**MouseEvent.detail**](https://developer.mozilla.org/en-US/docs/Web/API/UIEvent/detail) correctly reports the click count for **‘mouseup’** and **‘mousedown’** events ([@mrobinson](https://github.com/mrobinson), [#41833](https://github.com/servo/servo/pull/41833)), and many other members are now consistent with other mouse events ([@mrobinson](https://github.com/mrobinson), [#42013](https://github.com/servo/servo/pull/42013)).

Performing a pinch zoom on mobile is now reflected in the **[VisualViewport](https://developer.mozilla.org/en-US/docs/Web/API/VisualViewport) API** ([@stevennovaryo](https://github.com/stevennovaryo), [#41754](https://github.com/servo/servo/pull/41754)), though for now the feature is disabled by default (`--pref dom_visual_viewport_enabled`).

We've changed the behaviour of Web APIs that use the [`[Clamp]` annotation](https://webidl.spec.whatwg.org/#Clamp) (such as **Blob.slice()**).
The previous implementation would cast floating point values to their integer equivalents, but the standard requires [more specific rounding logic](https://webidl.spec.whatwg.org/#abstract-opdef-converttoint) ([@Taym95](https://github.com/Taym95), [#41640](https://github.com/servo/servo/pull/41640)).

The `RGBA8` constant is now available in WebGL 1 rendering contexts; it was previously only available in WebGL 2 contexts ([@simonwuelker](https://github.com/simonwuelker), [#42048](https://github.com/servo/servo/pull/42048)).

**Fonts** were another area of focus this month.
Loading web fonts from **file: URLs** works as expected ([@TimvdLippe](https://github.com/TimvdLippe), [#41714](https://github.com/servo/servo/pull/41714)), as does using web fonts within Shadow DOM content ([@minghuaw](https://github.com/minghuaw), [#42151](https://github.com/servo/servo/pull/42151)).
Each web font request now creates a [**PerformanceResourceTiming**](https://developer.mozilla.org/en-US/docs/Web/API/PerformanceResourceTiming) entry ([@lumi-me-not](https://github.com/lumi-me-not), [#41784](https://github.com/servo/servo/pull/41784)).
Servo supports font variations as of November 2025, so as of this month, the **[FontFace](https://developer.mozilla.org/en-US/docs/Web/API/FontFace)** constructor no longer ignores the **‘font-variation-settings’ property** ([@muse254](https://github.com/muse254), [#41968](https://github.com/servo/servo/pull/41968)).

**Cursive scripts** now ignore the **‘letter-spacing’** CSS property ([@mrobinson](https://github.com/mrobinson), [#42165](https://github.com/servo/servo/pull/42165)), and we significantly reduced the time and memory required when **rendering non-ASCII text** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#42105](https://github.com/servo/servo/pull/42105), [#42162](https://github.com/servo/servo/pull/42162)) and when text nodes share the same font ([@mrobinson](https://github.com/mrobinson), [#41876](https://github.com/servo/servo/pull/41876)).

## CSS

There were lots of improvements to **block layout** algorithms ([@Loirooriol](https://github.com/Loirooriol), [#41492](https://github.com/servo/servo/pull/41492), [#41624](https://github.com/servo/servo/pull/41624), [#41632](https://github.com/servo/servo/pull/41632), [#41655](https://github.com/servo/servo/pull/41655), [#41652](https://github.com/servo/servo/pull/41652), [#41683](https://github.com/servo/servo/pull/41683)).
These often affect pages where a block element (such as a &lt;div>) exists within some other layout mode (such as an inline &lt;span>, or a flexbox context), and fixes like these ensure Servo matches the output of other browsers.

Elements with **scrollable overflow** can be scrolled more consistently, even with CSS transforms applied to them ([@stevennovaryo](https://github.com/stevennovaryo), [#41707](https://github.com/servo/servo/pull/41707), [#42005](https://github.com/servo/servo/pull/42005)).

You can now use **‘content: &lt;image>’ on any element** ([@andreubotella](https://github.com/andreubotella), [#41480](https://github.com/servo/servo/pull/41480)).
Generated image content used to only work with pseudo-elements, but that restriction no longer applies.

**&lt;details> elements** can now be styled with the **‘::details-content’ pseudo-element** ([@lukewarlow](https://github.com/lukewarlow), [#42107](https://github.com/servo/servo/pull/42107)), as well as the ‘:open’ pseudo-class ([@lukewarlow](https://github.com/lukewarlow), [#42195](https://github.com/servo/servo/pull/42195)).

CSS styles now inherit correctly through **‘display: contents’** as well as **&lt;slot> elements** in Shadow DOM content ([@longvatrong111](https://github.com/longvatrong111), [@Loirooriol](https://github.com/Loirooriol), [@mrobinson](https://github.com/mrobinson), [#41855](https://github.com/servo/servo/pull/41855)).

**‘overflow-clip-margin’** now works correctly when **‘border-radius’** is present ([@Loirooriol](https://github.com/Loirooriol), [#41967](https://github.com/servo/servo/pull/41967)).

We fixed bugs involving text inside flexbox elements: they now use consistent baselines for alignment ([@lukewarlow](https://github.com/lukewarlow), [@mrobinson](https://github.com/mrobinson), [#42038](https://github.com/servo/servo/pull/42038)), and style updates are propagated to the text correctly ([@mrobinson](https://github.com/mrobinson), [#41951](https://github.com/servo/servo/pull/41951)).

**&lt;img align>** now aligns the image as expected ([@mrobinson](https://github.com/mrobinson), [#42220](https://github.com/servo/servo/pull/42220)).

**‘word-break: keep-all’** now prevents line breaks in **[CJK](https://en.wikipedia.org/wiki/CJK_characters) text** ([@RichardTjokroutomo](https://github.com/RichardTjokroutomo), [#42088](https://github.com/servo/servo/pull/42088)).

We also fixed some bugs involving **floats**, **[collapsing margins](https://developer.mozilla.org/en-US/docs/Web/CSS/Guides/Box_model/Margin_collapsing)**, and **[phantom line boxes](https://drafts.csswg.org/css-inline-3/#invisible-line-boxes)** ([@Loirooriol](https://github.com/Loirooriol), [#41812](https://github.com/servo/servo/pull/41812)), which sound much cooler than they actually are.

Finally, we upgraded our [Stylo](https://crates.io/crates/stylo) dependency to the latest changes as of January 1 2026 ([@Loirooriol](https://github.com/Loirooriol), [#41916](https://github.com/servo/servo/pull/41916), [#41696](https://github.com/servo/servo/pull/41696)).
Stylo powers our CSS parsing and [style resolution engine](https://hacks.mozilla.org/2017/08/inside-a-super-fast-css-engine-quantum-css-aka-stylo/), and this upgrade improves support for **parsing color functions** like **‘color-mix()’**, and improves our **CSS animations and transitions** for borders and overflow clipping.

## Automation and introspection

Last month Servo gained support for HTTP proxies.
We now support **HTTPS proxies** as well ([@Narfinger](https://github.com/Narfinger), [#41689](https://github.com/servo/servo/pull/41689)), which can be configured with the `https_proxy` or `HTTPS_PROXY` environment variables, or the [`network_https_proxy_uri` preference](https://doc.servo.org/servo/prefs/struct.Preferences.html#structfield.network_https_proxy_uri).
In addition, the `NO_PROXY` environment variable or the [`network_http_no_proxy` preference](https://doc.servo.org/servo/prefs/struct.Preferences.html#structfield.network_http_no_proxy) can **disable any proxy** for particular domains.

Our **developer tools** integration continues to improve.
Worker globals are now categorized correctly in the UI ([@atbrakhi](https://github.com/atbrakhi), [#41929](https://github.com/servo/servo/pull/41929)), and the Sources panel is populated for very short documents ([@atbrakhi](https://github.com/atbrakhi), [#41983](https://github.com/servo/servo/pull/41983)).
Servo will report console messages that were logged before the developer tools are opened ([@eerii](https://github.com/eerii), [@mrobinson](https://github.com/mrobinson), [#41895](https://github.com/servo/servo/pull/41895)).
Finally, we fixed a panic when selecting nodes in the layout inspector that have no style information ([@eerii](https://github.com/eerii), [#41800](https://github.com/servo/servo/pull/41800)).

We're working towards supporting pausing in the JS debugger ([@eerii](https://github.com/eerii), [@atbrakhi](https://github.com/atbrakhi), [@jdm](https://github.com/jdm), [#42007](https://github.com/servo/servo/pull/42007)), and breakpoints can be toggled through the UI ([@eerii](https://github.com/eerii), [@atbrakhi](https://github.com/atbrakhi), [#41925](https://github.com/servo/servo/pull/41925), [#42154](https://github.com/servo/servo/pull/42154)).
While the debugger is paused, hovering over JS objects will report the object's properties for builtin JS classes ([@eerii](https://github.com/eerii), [@atbrakhi](https://github.com/atbrakhi), [#42186](https://github.com/servo/servo/pull/42186)).
Stay tuned for more JS debugging updates in next month's blog post!

Servo’s [**WebDriver server**]({{ '/blog/2025/07/17/this-month-in-servo/#webdriver' | url }}) is also maturing.
Evaluating a synchronous script that returns a Promise will wait until that promise settles ([@yezhizhen](https://github.com/yezhizhen), [#41823](https://github.com/servo/servo/pull/41823)).
**‘touchmove’ events** are fired for pointer actions when a button is pressed ([@yezhizhen](https://github.com/yezhizhen), [#41801](https://github.com/servo/servo/pull/41801)), and **‘touchcancel’ events** are fired for canceled pointer action items ([@yezhizhen](https://github.com/yezhizhen), [#41937](https://github.com/servo/servo/pull/41937)).
Finally, any pointer actions that would trigger **duplicate ‘mousemove’ events** are silently discarded ([@mrobinson](https://github.com/mrobinson), [#42034](https://github.com/servo/servo/pull/42034)).

**[Element Clear](https://w3c.github.io/webdriver/#element-clear) commands** now test whether the element is interactable ([@yezhizhen](https://github.com/yezhizhen), [#42124](https://github.com/servo/servo/pull/42124)).
Now a null [script execution timeout](https://w3c.github.io/webdriver/#dfn-script-timeout) value will never trigger a timeout ([@yezhizhen](https://github.com/yezhizhen), [#42184](https://github.com/servo/servo/pull/42184)), and synthesized **‘pointermove’ events** have a consistent `pointerId` value ([@yezhizhen](https://github.com/yezhizhen), [#41726](https://github.com/servo/servo/pull/41726)).

## Embedding

You can now **cross-compile Servo** using Windows as the host ([@yezhizhen](https://github.com/yezhizhen), [#41748](https://github.com/servo/servo/pull/41748)).

We’ve **pinned all git dependencies** to specific revisions, to reduce the risk of build failures ([@Narfinger](https://github.com/Narfinger), [#42029](https://github.com/servo/servo/pull/42029)).
We intend to eventually [forbid git dependencies](https://github.com/servo/servo/issues/25650) in Servo libraries, which will help unblock releasing Servo on [crates.io](https://crates.io).

**[SiteDataManager](https://doc.servo.org/servo/struct.SiteDataManager.html)** now has a new **[clear_site_data()](https://doc.servo.org/servo/struct.SiteDataManager.html#method.clear_site_data)** method to clear all stored data for a particular host ([@janvarga](https://github.com/janvarga), [#41618](https://github.com/servo/servo/pull/41618), [#41709](https://github.com/servo/servo/pull/41709), [#41852](https://github.com/servo/servo/pull/41852)).

Our nightly testing UI, **servoshell**, now respects any customized installation path on Windows ([@yezhizhen](https://github.com/yezhizhen), [#41653](https://github.com/servo/servo/pull/41653)).
We fixed a crash in the Android app when pausing the application ([@NiklasMerz](https://github.com/NiklasMerz), [#41827](https://github.com/servo/servo/pull/41827)).
Additionally, clicking inside a webview in the desktop app will remove focus from any browser UI ([@mrobinson](https://github.com/mrobinson), [#42080](https://github.com/servo/servo/pull/42080)).

We've laid more groundwork towards exposing **accessibility tree** information from webviews ([@delan](https://github.com/delan), [@lukewarlow](https://github.com/lukewarlow), [@alice](https://github.com/alice), [#41924](https://github.com/servo/servo/pull/41924)).
There's nothing to test yet, but keep an eye on our [tracking issue](https://github.com/servo/servo/issues/4344) if you want to be notified when nightly builds are ready for testing!

## Stability & performance

We’ve converted many uses of **IPC channels** in the engine to channels that are **more efficient** when multiprocess mode is disabled ([@Narfinger](https://github.com/Narfinger), [@jdm](https://github.com/jdm), [@sagudev](https://github.com/sagudev), [@mrobinson](https://github.com/mrobinson), [#41178](https://github.com/servo/servo/pull/41178), [#41071](https://github.com/servo/servo/pull/41071), [#41733](https://github.com/servo/servo/pull/41733), [#41806](https://github.com/servo/servo/pull/41806), [#41380](https://github.com/servo/servo/pull/41380), [#41809](https://github.com/servo/servo/pull/41809), [#41774](https://github.com/servo/servo/pull/41774), [#42032](https://github.com/servo/servo/pull/42032), [#42033](https://github.com/servo/servo/pull/42033), [#41412](https://github.com/servo/servo/pull/41412)).
Since multiprocess mode is not yet enabled by default (`--multiprocess`), this is a significant boost to Servo’s everyday performance.

Servo now sets a **socket timeout for HTTP connections** ([@Narfinger](https://github.com/Narfinger), [@mrobinson](https://github.com/mrobinson), [#41710](https://github.com/servo/servo/pull/41710)).
This is controlled by the [`network_connection_timeout` preference](https://doc.servo.org/servo/prefs/struct.Preferences.html#structfield.network_connection_timeout), and defaults to **15 seconds**.

Each instance of Servo now starts **four fewer threads** ([@Narfinger](https://github.com/Narfinger), [#41740](https://github.com/servo/servo/pull/41740)).
Any network operations that trigger a synchronous UI operation (such as an HTTP authentication prompt) no longer blocks other network tasks from completing ([@Narfinger](https://github.com/Narfinger), [@jdm](https://github.com/jdm), [#41965](https://github.com/servo/servo/pull/41965), [#41857](https://github.com/servo/servo/pull/41857)).

It's said that one of the hardest problems in computer science is **cache invalidation**.
We improved the memory usage of **dynamic inline SVG content** by evicting stale SVG tree data from a cache ([@TomRCummings](https://github.com/TomRCummings), [#41675](https://github.com/servo/servo/pull/41675)).
Meanwhile, we added a new cache to reduce memory usage and improve rendering performance for pages with animating images ([@Narfinger](https://github.com/Narfinger), [#41956](https://github.com/servo/servo/pull/41956)).

Servo's JS engine now accounts for 2D and 3D canvas-related memory usage when deciding how often to perform garbage collection ([@sagudev](https://github.com/sagudev), [#42180](https://github.com/servo/servo/pull/42180)).
This can reduce the risk of out-of-memory (OOM) errors on pages that create large numbers of short-lived WebGL or WebGPU objects.

To reduce the risk of panics involving the JS engine integration, we’re continuing to use the **Rust type system** to make certain kinds of dynamic borrow failures impossible ([@sagudev](https://github.com/sagudev), [#41692](https://github.com/servo/servo/pull/41692), [#41782](https://github.com/servo/servo/pull/41782), [#41756](https://github.com/servo/servo/pull/41756), [#41808](https://github.com/servo/servo/pull/41808), [#41879](https://github.com/servo/servo/pull/41879), [#41878](https://github.com/servo/servo/pull/41878), [#41955](https://github.com/servo/servo/pull/41955), [#41971](https://github.com/servo/servo/pull/41971), [#42123](https://github.com/servo/servo/pull/42123)).
We also continue to identify and **forbid code patterns** that can trigger rare crashes when garbage collection happens while destroying webviews ([@willypuzzle](https://github.com/willypuzzle), [#41717](https://github.com/servo/servo/pull/41717), [#41783](https://github.com/servo/servo/pull/41783), [#41911](https://github.com/servo/servo/pull/41911), [#41911](https://github.com/servo/servo/pull/41911), [#41977](https://github.com/servo/servo/pull/41977), [#41984](https://github.com/servo/servo/pull/41984), [#42243](https://github.com/servo/servo/pull/42243)).

This month also brought fixes for panics in parallel layout ([@mrobinson](https://github.com/mrobinson), [#42026](https://github.com/servo/servo/pull/42026)), WebGPU ([@WaterWhisperer](https://github.com/WaterWhisperer), [#42050](https://github.com/servo/servo/pull/42050)), &lt;link> fetching ([@jdm](https://github.com/jdm), [#42208](https://github.com/servo/servo/pull/42208)), Element.attachShadow() ([@mrobinson](https://github.com/mrobinson), [#42237](https://github.com/servo/servo/pull/42237)), text input methods ([@mrobinson](https://github.com/mrobinson), [#42240](https://github.com/servo/servo/pull/42240)), Web Workers when the developer tools are active ([@mrobinson](https://github.com/mrobinson), [#42159](https://github.com/servo/servo/pull/42159)), IndexedDB ([@gterzian](https://github.com/gterzian), [#41960](https://github.com/servo/servo/pull/41960)), and asynchronous [session history](https://developer.mozilla.org/en-US/docs/Web/API/History_API/Working_with_the_History_API) updates ([@mrobinson](https://github.com/mrobinson), [#42238](https://github.com/servo/servo/pull/42238)).

**Node.compareDocumentPosition()** is now more efficient ([@webbeef](https://github.com/webbeef), [#42260](https://github.com/servo/servo/pull/42260)), and selections in text inputs no longer require a full page layout ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#41963](https://github.com/servo/servo/pull/41963)).

## Donations

Thanks again for your generous support!
We are now receiving **7007 USD/month** (−1.4% over December) in recurring donations.
This helps us cover the cost of our **[speedy](https://ci0.servo.org) [CI](https://ci1.servo.org) [and](https://ci2.servo.org) [benchmarking](https://ci3.servo.org) [servers](https://ci4.servo.org)**, one of our latest **[Outreachy interns](https://www.outreachy.org/alums/2025-06/#:~:text=Servo)**, and funding **[maintainer work]({{ '/blog/2025/09/17/your-donations-at-work-funding-jdm/' | url }})** that helps more people contribute to Servo.

Servo is also on [thanks.dev](https://thanks.dev), and already **33 GitHub users** (+3 over December) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

We now have [**sponsorship tiers**]({{ '/blog/2025/11/21/sponsorship-tiers/' | url }}) that allow you or your organisation to donate to the Servo project with public acknowlegement of your support.
A big thanks from Servo to our newest Bronze Sponsor: **str4d**!
If you’re interested in this kind of sponsorship, please contact us at [join@servo.org](mailto:join@servo.org).

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; right: calc(100% - 100% * 7007 / 10000); padding-right: 0.5em;"><strong>7007</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 7007 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="7007" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

Use of donations is decided transparently via the Technical Steering Committee’s public **[funding request process](https://github.com/servo/project/blob/main/FUNDING_REQUEST.md)**, and active proposals are tracked in [servo/project#187](https://github.com/servo/project/issues/187).
For more details, head to our [Sponsorship page]({{ '/sponsorship/' | url }}).

## Conference talks and blogs

There were two talks about Servo at FOSDEM 2026 (videos and slides [here]({{ '/about/#presentations' | url }})):

* [**Implementing Streams Spec in Servo**](https://fosdem.org/2026/schedule/event/3J8GUD-servo-streams-reimplementation/) – Taym Haddadi ([@taym95](https://github.com/taym95)) described the challenges of implementing the [Streams Standard](https://streams.spec.whatwg.org/).

* [**The Servo project and its impact on the web platform**](https://fosdem.org/2026/schedule/event/LXFKS9-servo-project-impact/) – Manuel Rego ([@rego](https://github.com/rego)) highlighted the ways that Servo has shaped the web platform and contributed to web standards since it started in 2012.

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
