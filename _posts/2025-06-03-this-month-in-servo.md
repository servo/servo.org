---
layout:     post
tags:       blog
title:      "This month in Servo: ??????"
date:       2025-06-03
summary:    Who even knows?
categories:
---


Two big pieces of news for images in Servo this month:

1. We now **display animated GIFs** in all their animated glory (@rayguo17, #36286)!
This work required careful architecting to integrate with existing animation mechanisms in the engine without incurring unnecessary CPU usage.

<figure><a href="{{ '/img/blog/2025-06-servo-gif.gif' | url }}"><img alt="Animated GIFs rendering in Servo" src="{{ '/img/blog/2025-06-servo-gif.gif' | url }}"></a></figure>

2. We support **loading SVG images** as `<img>` element sources (@mukilan, @mrobinson, #36721).

<figure><a href="{{ '/img/blog/2025-06-servo-svg.png' | url }}"><img alt="SVG image rendering in Servo" src="{{ '/img/blog/2025-06-servo-svg.png' | url }}"></a></figure>

Servo's layout implementation has historically been all-or-nothing—any change in the page, no matter how isolated, requires laying out the entire page from scratch. Fixing this is called "incremental layout", and it's a key performance optimization in all browser engines. This month we made a number of changes to **support incremental layout** that make various classes of CSS changes much more efficient than a full layout (@mrobinson, @Loirooriol, #36896, #36978, #37004, #37047, #37069, #37048, #37088, #37099).

We have also made **significant progress on the [Trusted Types API](https://developer.mozilla.org/en-US/docs/Web/API/Trusted_Types_API)**, going from 47% of tests passing to 58% over the course of May (@TimvdLippe, #36710, #36668, #36811, #36824, #36941, #36960).

Supporting this work on Trusted Types, our [Content Security Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/CSP) implementation has been steadily improving, now passing 59% of automated tests (@TimvdLippe, @jdm, @simonwuelker, #36709, #36710, #36776, #36832, #36860, #36887, #36923, #36963, #36962, #36961, #36965, #37020).

We've begun preparatory work to **integrate [Vello](https://github.com/linebender/vello)** as the backend for 2D canvases (@sagudev, #36783, #36790, #36999). We've also merged some preparatory work to support `::placeholder` pseudo-elements and fix rendering issues with text inputs (@stevennovaryo, #37065).

We've **enabled support for `URLPattern`** (@simonwuelker, #36826, #37004, #37116), as well as **&lt;input type="color">** (@simonwuelker, #36992).
Additionally, Servo now supports:
* `ShadowRoot.setHTMLUnsafe` (@TG199, #36240)
* `document.scrollingElement` (@JimmyDdotEXE, #35994)
* `ReadableStream.pipeThrough` (@Taym95, #36977)
* `TransformStream` (@Taym95, @gterzian, #36739, #36905)
* `asyncClipboard.readText` (@Gae24, #36689)
* `Stylesheet.type` (@simonwuelker, #37126)

Additionally, HTMLVideoElement can be used as an image source for 2D canvas APIs (@tharkum, #37135), ImageBitmap objects can be serialized and transferred via `postMessage` (@tharkum, #37101), media elements redraw properly whenever their size changes (@tharkum, #37056), polygon image map areas are clickable (@arihant2math, #37064), `&lt;select>` elements are redrawn when their contents change (@simonwuelker, #36958), and `GPU.preferredCanvasFormat` returns platform-appropriate values (@arihant2math, #37073).

We fixed a number of bugs where Servo's behaviour did not match relevant specifications:
* `input` events are now fired following `keydown` events (@yezhizhen, #37078)
* unscopable objects are now writable and readable, and don't have a prototype (@simonwuelker, #37119, #37122)
* `Request` headers reject more erroneous headers (@sebsebmc, #36943)
* External stylesheets in documents with quirks mode are more lenient about the stylesheet's `Content-Type` (@ghostd, @mrobinson, #28321)
* the `ImageData` constructor throws better errors for unsupported arguments (@Taym95, #31398)
* Attribute nodes are serialized as the empty string (@simonwuelker, #36875)
* custom element `is` values are serialized as attributes (@simonwuelker, #36888)
* `EventSource` ignores invalid field values and treats non-200 responses codes as failures (@KiChjang, #36853, #36854)
* the `premultipliedAlpha` flag for WebGL canvases premultiplies correctly (@tharkum, #36895)

### Embedding

#### The engine

Embedders can now **evaluate JavaScript inside a given WebView** and receive results asynchronously (@Narfinger, @mrobinson, #35720).

All embedders will receive default styling and interactivity for elements like inputs and media elements (@webbeef, #36803), which reduces the amount of configuration required when embedding the engine.

Any provided system light/dark theme will be propagated to any document loaded inside of a WebView (@mrobinson, #37132).

Servo's developer tools integration now highlights elements in the layout inspector (@simonwuelker, #35822), as well as displays `DocumentType` nodes correctly (@simonwuelker, #36787).

We have **removed the `dom_shadowdom_enabled` preference**, since the feature has been enabled by default since March 2025.

#### Servoshell

The `--user-agent`/`-u` flag now correctly sets the User-Agent header for network requests (@PartiallyUntyped, @mrobinson, #36859).

Service Workers have been removed from the list of features enabled by `--enable-experimental-web-platform-features` until they provide more value (@jdm, #36867).

The current system light/dark theme is now queried on startup (@Legend-Master, #37128).


### Stability

Servo is now better at evicting image data from GPU caches (@webbeef, #36956).
We also reduced the memory used to store [HSTS data](https://developer.mozilla.org/en-US/docs/Glossary/HSTS), saving **more than 60mb** by doing so (@sebsebmc, #37000, #37015).

We fixed a number of crashes involving animated images (@simonwuelker, #37058), media elements with an unknown duration (@tharkum, [servo-media#437](https://github.com/servo/media/pull/437)), canvas elements during shutdown (@mrobinson, #37182), adding a Path2D to itself (@Taym95, #36847), using `Node.childNodes` (@jdm, #36889), resizing OffscreenCanvas (@simonwuelker, #36855), querying WebGL extensions (@mrobinson, #36911), and slicing a sliced Blob (@simonwuelker, #36866).
We also addressed a deadlock involving streams with very large chunks (@wusyong, #36914), and a source of intermittent crashes when closing tabs or removing iframes (@jdm, #37120).
Finally, we rewrote the implementation of `HTMLOptionElement.text` to avoid crashes with deeply-nested elements (@kkoyung, #37167).

We now measure the memory usage of sessionStorage and localStorage data (@jdm, #37053), the [Public Suffix List](https://en.wikipedia.org/wiki/Public_Suffix_List) (@sebsebmc, #37049), and the system font storage (@jdm, #36834).
In addition, we **reduced the size of the final Servo binary** by 2mb by stripping out DOM code that should never be used outside of automated tests (@jdm, #37034).

### Upgrades

We upgraded our fork of WebRender to an upstream revision from late April (@mrobinson, #36770), and we upgraded our Stylo dependency to a version from the start of May (@Loirooriol, #36835).
These changes ensure that Servo is up to date with ongoing work in Firefox, which shares these dependencies.

<!--
- devex
    - https://github.com/servo/servo/pull/32836	(@jschwe, #32836)	bootstrap: Add `winget` fallback (#32836)
      devex
- layout
    - https://github.com/servo/servo/pull/36703	(@mrobinson, #36703)	script: Clamp table spans according to the HTML specification      (#36703)
      layout
    - https://github.com/servo/servo/pull/36795	(@mrobinson, #36795)	layout: Simplify `PositioningContext` by having it hold a single `Vec` (#36795)
      layout
    - https://github.com/servo/servo/pull/36749	(@Loirooriol, #36749)	layout: Let individual transform properties establish a stacking context (#36749)
      layout
    - https://github.com/servo/servo/pull/36876	(@mrobinson, @Loirooriol, #36876)	layout: Use `ServoLayoutNode` directly instead of a generic `impl` (#36876)
      layout
    - https://github.com/servo/servo/pull/36917	(@mrobinson, @Loirooriol, #36917)	layout: Resolve canvas background properties during painting (#36917)
      layout
    - https://github.com/servo/servo/pull/36993	(@stevennovaryo, @Loirooriol, #36993)	layout: Propagate specified info for flex item (#36993)
      layout
    - https://github.com/servo/servo/pull/36980	(@Loirooriol, #36980)	layout: Inform child layout about final block size (#36980)
      layout
    - https://github.com/servo/servo/pull/37024	(@Loirooriol, #37024)	layout: Fix `align-content` on stretched row flex containers (#37024)
      layout
    - https://github.com/servo/servo/pull/37029	(@mrobinson, #37029)	fonts: Fix calculation of font underline thickness on macOS (#37029)
      layout
    - https://github.com/servo/servo/pull/37011	(@Loirooriol, #37011)	layout: Fix min-content inline size of multi-line row flex container (#37011)
      layout
    - https://github.com/servo/servo/pull/37079	(@mrobinson, #37079)	layout: Support `wavy` and `double` for `text-decoration-line` (#37079)
      layout
    - https://github.com/servo/servo/pull/37097	(@mrobinson, #37097)	layout: Use the viewport size as the `background-attachment: fixed` positioning area (#37097)
      layout
    - https://github.com/servo/servo/pull/37147	(@Loirooriol, #37147)	layout: Fix logic for transforms with non-invertible matrix (#37147)
      layout
- ohos
    - https://github.com/servo/servo/pull/36915	(@PartiallyUntyped, @jschwe, #36915)	[OH] Provide correct geometry offset and fix available screen dimensions (#36915)
      ohos
- stability
    - https://github.com/servo/servo/pull/36808	(@mrobinson, #36808)	script: Unconditionally send exit message during pipeline shutdown (#36808)
      stability
    - https://github.com/servo/servo/pull/36955	(@webbeef, #36955)	Prevent overflow in intersection observer area evaluation (#36955)
      stability
    - https://github.com/servo/servo/pull/36873	(@jschwe, #36873)	Extend --with-asan to support C/C++ code (#36873)
      stability
    - https://github.com/servo/servo/pull/36957	(@yezhizhen, #36957)	Remove duplicate click event in `simulate_mouse_click` (#36957)
      stability
    - https://github.com/servo/servo/pull/36974	(@mrobinson, #36974)	compositor: Batch all pending scroll event updates into a single transaction (#36974)
      stability
    - https://github.com/servo/servo/pull/37136	(@willypuzzle, #37136)	[#26488] Moved Droppable code into a separate struct for CanvasRenderingContext2D (#37136)
      stability
- testing
    - https://github.com/servo/servo/pull/36791	(@mrobinson, #36791)	libservo: Add a basic `WebView` API test (#36791)
      testing
    - https://github.com/servo/servo/pull/36878	(@Narfinger, #36878)	Added a new workflow that benchmarks simple startup and loading of servo.org on HarmonyOS. (#36878)
      testing
- webdriver
    - https://github.com/servo/servo/pull/36871	(@longvatrong111, #36871)	Set proper button value in WebDriver - ElementClick command (#36871)
      webdriver
    - https://github.com/servo/servo/pull/36744	(@kenzieradityatirtarahardja18@gmail.com, @kenzieradityatirtarahardja.18@gmail.com, #36744)	Implement wheel action in webdriver (#36744)
      webdriver
    - https://github.com/servo/servo/pull/36673	(@jdm, #36673)	Improve some webdriver conformance tests results (#36673)
      webdriver
    - https://github.com/servo/servo/pull/36908	(@yezhizhen, #36908)	rework webdriver deserialization to avoid false-positive cycle error (#36908)
      webdriver
    - https://github.com/servo/servo/pull/36985	(@kenzieradityatirtarahardja18@gmail.com, @kenzieradityatirtarahardja.18@gmail.com, #36985)	Fix origin relative coordinate for wheel scroll and refactoring (#36985)
      webdriver
    - https://github.com/servo/servo/pull/37010	(@yezhizhen, #37010)	Fix `WebDriverSession::input_cancel_list` related logic (#37010)
      webdriver
    - https://github.com/servo/servo/pull/36932	(@longvatrong111, @mrobinson, #36932)	Synchronize `dispatch_actions` in WebDriver (#36932)
      webdriver
    - https://github.com/servo/servo/pull/37081	(@yezhizhen, #37081)	Remove accidentally re-added logic to `WebDriverSession::input_cancel_list` (#37081)
      webdriver
-->

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