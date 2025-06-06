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

Our layout and CSS support continues to improve.
This month, we improved our page background sizing and style computation (@mrobinson, @Loirooriol, #36917, #37147) and added support for `wavy` and `double` for the `text-decoration-line` property (@mrobinson, #37079).
We also fixed bugs relating to transforms (both invertible and non-invertible) (@Loirooriol, #36749, #37147), and addressed sizing issues for tables and flex containers (@stevennovaryo, @Loirooriol, #36703, #36993, #36980, #37024, #37011), Finally, we fixed missing underlines on macOS (@mrobinson, #37029).

TODO: text-decoration-line screenshot

Additionally, HTMLVideoElement can be used as an image source for 2D canvas APIs (@tharkum, #37135), ImageBitmap objects can be serialized and transferred via `postMessage` (@tharkum, #37101), media elements redraw properly whenever their size changes (@tharkum, #37056), polygon image map areas are clickable (@arihant2math, #37064), `<select>` elements are redrawn when their contents change (@simonwuelker, #36958), and `GPU.preferredCanvasFormat` returns platform-appropriate values (@arihant2math, #37073).

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

Our WebDriver server implementation received a lot of attention this month!
Element clicks now receive the expected button value (@longvatrong111, #36871), wheel actions are supported (@PotatoCP, #36744, #36985), and we removed the possibility of races between some input actions and other WebDriver commands (@longvatrong111, @mrobinson, #36932).

We also added support for passing WebDriver references to DOM objects as arguments when executing scripts (@jdm, #36673), and fixed some bugs with JS value serialization (@yezhizhen, #36908) and cancelling inputs (@yezhizhen, #37010).

### Embedding

#### The engine

Embedders can now **evaluate JavaScript inside a given WebView** and receive results asynchronously (@Narfinger, @mrobinson, #35720).

All embedders will receive default styling and interactivity for elements like inputs and media elements (@webbeef, #36803), which reduces the amount of configuration required when embedding the engine.

Any provided system light/dark theme will be propagated to all documents loaded inside of a WebView (@mrobinson, #37132).

Servo's developer tools integration now highlights elements in the layout inspector (@simonwuelker, #35822), as well as displays `DocumentType` nodes correctly (@simonwuelker, #36787).

TODO: highlighting screenshot

We have **removed the `dom_shadowdom_enabled` preference**, since the feature has been enabled by default since March 2025 (@simonwuelker, #37043).

Our automated benchmarking setup is expanding, and we can now measure how long it takes to start up Servo and load the servo.org homepage on HarmoneyOS (@Narfinger, #36878), which will help us identify regressions in the future.

Finally, we can now write unit tests for Servo's embedding API (@mrobinson, #36791), which allows us to write better regression tests for shutdown-related issues (@mrobinson, #36808).

#### Servoshell

The `--user-agent`/`-u` flag now correctly sets the User-Agent header for network requests (@PartiallyUntyped, @mrobinson, #36859).

Service Workers have been removed from the list of features enabled by `--enable-experimental-web-platform-features` until they provide more value (@jdm, #36867).

Building Servoshell with `--with-asan` now causes all C++ dependencies to be built with [Address Sanitizer](https://clang.llvm.org/docs/AddressSanitizer.html) as well.

Bootstrapping on Windows now uses `winget` as a fallback if `chocolatey` is unavailable (@jschwe, #32836).

The current system light/dark theme is now queried on startup (@Legend-Master, #37128).
Additionally, the screen dimensions and geometry reported by the engine are now correct on Open Harmony OS (@PartiallyUntyped, @jschwe, #36915).


### Stability

#### Memory usage

Servo is now better at evicting image data from GPU caches (@webbeef, #36956).
We also reduced the memory used to store [HSTS data](https://developer.mozilla.org/en-US/docs/Glossary/HSTS), saving **more than 60mb** by doing so (@sebsebmc, #37000, #37015).

We now measure the memory usage of sessionStorage and localStorage data (@jdm, #37053), the [Public Suffix List](https://en.wikipedia.org/wiki/Public_Suffix_List) (@sebsebmc, #37049), and the system font storage (@jdm, #36834).
In addition, we **reduced the size of the final Servo binary** by 2mb by stripping out DOM code that should never be used outside of automated tests (@jdm, #37034).

#### Crashes

We fixed a number of crashes involving animated images (@simonwuelker, #37058), media elements with an unknown duration (@tharkum, [servo-media#437](https://github.com/servo/media/pull/437)), canvas elements during shutdown (@mrobinson, #37182), adding a Path2D to itself (@Taym95, #36847), calculating `IntersectionObserver` areas (@webbeef, #36955), using `Node.childNodes` (@jdm, #36889), resizing `OffscreenCanvas` (@simonwuelker, #36855), querying WebGL extensions (@mrobinson, #36911), and slicing a sliced `Blob` (@simonwuelker, #36866).

We also addressed a deadlock involving streams with very large chunks (@wusyong, #36914), and a source of intermittent crashes when closing tabs or removing iframes (@jdm, #37120).
Finally, we rewrote the implementation of `HTMLOptionElement.text` to avoid crashes with deeply-nested elements (@kkoyung, #37167).

Having previously noticed an unsafe pattern triggered by using JS-owned values in Rust Drop implementations ([#26488](https://github.com/servo/servo/issues/26488)), we have begun incrementally removing existing Drop implementations to remove the source of unsafety (@willypuzzle, #37136).

### Upgrades

We upgraded our fork of WebRender to an upstream revision from late April (@mrobinson, #36770), and we upgraded our Stylo dependency to a version from the start of May (@Loirooriol, #36835).
These changes ensure that Servo is up to date with ongoing work in Firefox, which shares these dependencies.

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