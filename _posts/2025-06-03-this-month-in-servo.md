---
layout:     post
tags:       blog
title:      "This month in Servo: ??????"
date:       2025-06-03
summary:    Who even knows?
categories:
---


Two big pieces of news for images in Servo this month:

1. We now **display animated GIFs** in all their animated glory ([@rayguo17](https://github.com/rayguo17), [#36286](https://github.com/servo/servo/pull/36286))!
This work required careful architecting to integrate with existing animation mechanisms in the engine without incurring unnecessary CPU usage.

<figure><a href="{{ '/img/blog/2025-06-servo-gif.gif' | url }}"><img alt="Animated GIFs rendering in Servo" src="{{ '/img/blog/2025-06-servo-gif.gif' | url }}"></a></figure>

2. We support **loading SVG images** as `<img>` element sources ([@mukilan](https://github.com/mukilan), [@mrobinson](https://github.com/mrobinson), [#36721](https://github.com/servo/servo/pull/36721)).

<figure><a href="{{ '/img/blog/2025-06-servo-svg.png' | url }}"><img alt="SVG image rendering in Servo" src="{{ '/img/blog/2025-06-servo-svg.png' | url }}"></a></figure>

### Outreachy

We're excited to sponsor two [Outreachy interns](https://outreachy.org) until the end of August!
**Jerens Lensun** ([@jerensl](https://github.com/jerensl)) will be working on improving Servo's CI setup and other Python-focused infrastructure, while **Usman Baba Yahaya** ([@uthmaniv](https://github.com/uthmaniv)) will implement support for the [Network Monitor](https://firefox-source-docs.mozilla.org/devtools-user/network_monitor/) in the developer tools.

They will both be blogging about their internships, and you can follow their work at [Jeren's blog](https://www.jerensl.com/blog/) and [Usman's blog](https://uthmaniv.github.io/).

### Web content

Servo's layout implementation has historically been all-or-nothing—any change in the page, no matter how isolated, requires laying out the entire page from scratch.
Fixing this is called "incremental layout", and it's a key performance optimization in all browser engines.
This month we made a number of changes to **support incremental layout** that make various classes of CSS changes much more efficient than a full layout ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#36896](https://github.com/servo/servo/pull/36896), [#36978](https://github.com/servo/servo/pull/36978), [#37004](https://github.com/servo/servo/pull/37004), [#37047](https://github.com/servo/servo/pull/37047), [#37069](https://github.com/servo/servo/pull/37069), [#37048](https://github.com/servo/servo/pull/37048), [#37088](https://github.com/servo/servo/pull/37088), [#37099](https://github.com/servo/servo/pull/37099)).

We have also made **significant progress on the [Trusted Types API](https://developer.mozilla.org/en-US/docs/Web/API/Trusted_Types_API)**, going from 47% of tests passing to 58% over the course of May ([@TimvdLippe](https://github.com/TimvdLippe), [#36710](https://github.com/servo/servo/pull/36710), [#36668](https://github.com/servo/servo/pull/36668), [#36811](https://github.com/servo/servo/pull/36811), [#36824](https://github.com/servo/servo/pull/36824), [#36941](https://github.com/servo/servo/pull/36941), [#36960](https://github.com/servo/servo/pull/36960)).

Supporting this work on Trusted Types, our [Content Security Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/CSP) implementation has been steadily improving, now passing 59% of automated tests ([@TimvdLippe](https://github.com/TimvdLippe), [@jdm](https://github.com/jdm), [@simonwuelker](https://github.com/simonwuelker), [#36709](https://github.com/servo/servo/pull/36709), [#36710](https://github.com/servo/servo/pull/36710), [#36776](https://github.com/servo/servo/pull/36776), [#36832](https://github.com/servo/servo/pull/36832), [#36860](https://github.com/servo/servo/pull/36860), [#36887](https://github.com/servo/servo/pull/36887), [#36923](https://github.com/servo/servo/pull/36923), [#36963](https://github.com/servo/servo/pull/36963), [#36962](https://github.com/servo/servo/pull/36962), [#36961](https://github.com/servo/servo/pull/36961), [#36965](https://github.com/servo/servo/pull/36965), [#37020](https://github.com/servo/servo/pull/37020)).

We've begun preparatory work to **integrate [Vello](https://github.com/linebender/vello)** as the backend for 2D canvases ([@sagudev](https://github.com/sagudev), [#36783](https://github.com/servo/servo/pull/36783), [#36790](https://github.com/servo/servo/pull/36790), [#36999](https://github.com/servo/servo/pull/36999)).
We've also merged some preparatory work to support `::placeholder` pseudo-elements and fix rendering issues with text inputs ([@stevennovaryo](https://github.com/stevennovaryo), [#37065](https://github.com/servo/servo/pull/37065)).

We've **enabled support for `URLPattern`** ([@simonwuelker](https://github.com/simonwuelker), [#36826](https://github.com/servo/servo/pull/36826), [#37004](https://github.com/servo/servo/pull/37004), [#37116](https://github.com/servo/servo/pull/37116)), as well as **&lt;input type="color">** ([@simonwuelker](https://github.com/simonwuelker), [#36992](https://github.com/servo/servo/pull/36992)).

<figure><a href="{{ '/img/blog/2025-06-servo-input.png' | url }}"><img alt="Color input integration in Servo" src="{{ '/img/blog/2025-06-servo-input.png' | url }}"></a></figure>

Additionally, Servo now supports:
* `ShadowRoot.setHTMLUnsafe` ([@TG199](https://github.com/TG199), [#36240](https://github.com/servo/servo/pull/36240))
* `document.scrollingElement` ([@JimmyDdotEXE](https://github.com/JimmyDdotEXE), [#35994](https://github.com/servo/servo/pull/35994))
* `ReadableStream.pipeThrough` ([@Taym95](https://github.com/Taym95), [#36977](https://github.com/servo/servo/pull/36977))
* `TransformStream` ([@Taym95](https://github.com/Taym95), [@gterzian](https://github.com/gterzian), [#36739](https://github.com/servo/servo/pull/36739), [#36905](https://github.com/servo/servo/pull/36905))
* `asyncClipboard.readText` ([@Gae24](https://github.com/Gae24), [#36689](https://github.com/servo/servo/pull/36689))
* `Stylesheet.type` ([@simonwuelker](https://github.com/simonwuelker), [#37126](https://github.com/servo/servo/pull/37126))

Our layout and CSS support continues to improve.
This month, we improved our page background sizing and style computation ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#36917](https://github.com/servo/servo/pull/36917), [#37147](https://github.com/servo/servo/pull/37147)) and added support for `wavy` and `double` for the `text-decoration-line` property ([@mrobinson](https://github.com/mrobinson), [#37079](https://github.com/servo/servo/pull/37079)).
We also fixed bugs relating to transforms (both invertible and non-invertible) ([@Loirooriol](https://github.com/Loirooriol), [#36749](https://github.com/servo/servo/pull/36749), [#37147](https://github.com/servo/servo/pull/37147)), and addressed sizing issues for tables and flex containers ([@stevennovaryo](https://github.com/stevennovaryo), [@Loirooriol](https://github.com/Loirooriol), [#36703](https://github.com/servo/servo/pull/36703), [#36993](https://github.com/servo/servo/pull/36993), [#36980](https://github.com/servo/servo/pull/36980), [#37024](https://github.com/servo/servo/pull/37024), [#37011](https://github.com/servo/servo/pull/37011)).
Finally, we fixed missing underlines on macOS ([@mrobinson](https://github.com/mrobinson), [#37029](https://github.com/servo/servo/pull/37029)).

<figure><a href="{{ '/img/blog/2025-06-servo-decoration.png' | url }}"><img alt="text-decoration rendering in Servo" src="{{ '/img/blog/2025-06-servo-decoration.png' | url }}"></a></figure>

Additionally, HTMLVideoElement can be used as an image source for 2D canvas APIs ([@tharkum](https://github.com/tharkum), [#37135](https://github.com/servo/servo/pull/37135)), ImageBitmap objects can be serialized and transferred via `postMessage` ([@tharkum](https://github.com/tharkum), [#37101](https://github.com/servo/servo/pull/37101)), media elements redraw properly whenever their size changes ([@tharkum](https://github.com/tharkum), [#37056](https://github.com/servo/servo/pull/37056)), polygon image map areas are clickable ([@arihant2math](https://github.com/arihant2math), [#37064](https://github.com/servo/servo/pull/37064)), `<select>` elements are redrawn when their contents change ([@simonwuelker](https://github.com/simonwuelker), [#36958](https://github.com/servo/servo/pull/36958)), and `GPU.preferredCanvasFormat` returns platform-appropriate values ([@arihant2math](https://github.com/arihant2math), [#37073](https://github.com/servo/servo/pull/37073)).

We fixed a number of bugs where Servo's behaviour did not match relevant specifications:
* `input` events are now fired following `keydown` events ([@yezhizhen](https://github.com/yezhizhen), [#37078](https://github.com/servo/servo/pull/37078))
* unscopable objects are now writable and readable, and don't have a prototype ([@simonwuelker](https://github.com/simonwuelker), [#37119](https://github.com/servo/servo/pull/37119), [#37122](https://github.com/servo/servo/pull/37122))
* `Request` headers reject more erroneous headers ([@sebsebmc](https://github.com/sebsebmc), [#36943](https://github.com/servo/servo/pull/36943))
* External stylesheets in documents with quirks mode are more lenient about the stylesheet's `Content-Type` ([@ghostd](https://github.com/ghostd), [@mrobinson](https://github.com/mrobinson), [#28321](https://github.com/servo/servo/pull/28321))
* the `ImageData` constructor throws better errors for unsupported arguments ([@Taym95](https://github.com/Taym95), [#31398](https://github.com/servo/servo/pull/31398))
* Attribute nodes are serialized as the empty string ([@simonwuelker](https://github.com/simonwuelker), [#36875](https://github.com/servo/servo/pull/36875))
* custom element `is` values are serialized as attributes ([@simonwuelker](https://github.com/simonwuelker), [#36888](https://github.com/servo/servo/pull/36888))
* `EventSource` ignores invalid field values and treats non-200 responses codes as failures ([@KiChjang](https://github.com/KiChjang), [#36853](https://github.com/servo/servo/pull/36853), [#36854](https://github.com/servo/servo/pull/36854))
* the `premultipliedAlpha` flag for WebGL canvases premultiplies correctly ([@tharkum](https://github.com/tharkum), [#36895](https://github.com/servo/servo/pull/36895))

Our WebDriver server implementation received a lot of attention this month!
Element clicks now receive the expected button value ([@longvatrong111](https://github.com/longvatrong111), [#36871](https://github.com/servo/servo/pull/36871)), wheel actions are supported ([@PotatoCP](https://github.com/PotatoCP), [#36744](https://github.com/servo/servo/pull/36744), [#36985](https://github.com/servo/servo/pull/36985)), and we removed the possibility of races between some input actions and other WebDriver commands ([@longvatrong111](https://github.com/longvatrong111), [@mrobinson](https://github.com/mrobinson), [#36932](https://github.com/servo/servo/pull/36932)).

We also added support for passing WebDriver references to DOM objects as arguments when executing scripts ([@jdm](https://github.com/jdm), [#36673](https://github.com/servo/servo/pull/36673)), and fixed some bugs with JS value serialization ([@yezhizhen](https://github.com/yezhizhen), [#36908](https://github.com/servo/servo/pull/36908)) and cancelling inputs ([@yezhizhen](https://github.com/yezhizhen), [#37010](https://github.com/servo/servo/pull/37010)).

### Embedding

#### The engine

Embedders can now **evaluate JavaScript inside a given WebView** and receive results asynchronously ([@Narfinger](https://github.com/Narfinger), [@mrobinson](https://github.com/mrobinson), [#35720](https://github.com/servo/servo/pull/35720)).

All embedders will receive default styling and interactivity for elements like inputs and media elements ([@webbeef](https://github.com/webbeef), [#36803](https://github.com/servo/servo/pull/36803)), which reduces the amount of configuration required when embedding the engine.

Any provided system light/dark theme will be propagated to all documents loaded inside of a WebView ([@mrobinson](https://github.com/mrobinson), [#37132](https://github.com/servo/servo/pull/37132)).

Servo's developer tools integration now **highlights elements** in the layout inspector ([@simonwuelker](https://github.com/simonwuelker), [#35822](https://github.com/servo/servo/pull/35822)), as well as displays `DocumentType` nodes correctly ([@simonwuelker](https://github.com/simonwuelker), [#36787](https://github.com/servo/servo/pull/36787)).

<figure><a href="{{ '/img/blog/2025-06-servo-highlight.webp' | url }}"><img alt="Highlighting elements from the layout inspector" src="{{ '/img/blog/2025-06-servo-highlight.webp' | url }}"></a></figure>

We have **removed the `dom_shadowdom_enabled` preference**, since the feature has been enabled by default since March 2025 ([@simonwuelker](https://github.com/simonwuelker), [#37043](https://github.com/servo/servo/pull/37043)).

Our automated benchmarking setup is expanding, and we can now measure how long it takes to start up Servo and load the servo.org homepage on HarmoneyOS ([@Narfinger](https://github.com/Narfinger), [#36878](https://github.com/servo/servo/pull/36878)), which will help us identify regressions in the future.

Finally, we can now write unit tests for Servo's embedding API ([@mrobinson](https://github.com/mrobinson), [#36791](https://github.com/servo/servo/pull/36791)), which allows us to write better regression tests for shutdown-related issues ([@mrobinson](https://github.com/mrobinson), [#36808](https://github.com/servo/servo/pull/36808)).

#### Servoshell

The `--user-agent`/`-u` flag now correctly sets the User-Agent header for network requests ([@PartiallyUntyped](https://github.com/PartiallyUntyped), [@mrobinson](https://github.com/mrobinson), [#36859](https://github.com/servo/servo/pull/36859)).

Service Workers have been removed from the list of features enabled by `--enable-experimental-web-platform-features` until they provide more value ([@jdm](https://github.com/jdm), [#36867](https://github.com/servo/servo/pull/36867)).

Building Servoshell with `--with-asan` now causes all C++ dependencies to be built with [Address Sanitizer](https://clang.llvm.org/docs/AddressSanitizer.html) as well.

Bootstrapping on Windows now uses `winget` as a fallback if `chocolatey` is unavailable ([@jschwe](https://github.com/jschwe), [#32836](https://github.com/servo/servo/pull/32836)).

The current system light/dark theme is now queried on startup ([@Legend-Master](https://github.com/Legend-Master), [#37128](https://github.com/servo/servo/pull/37128)).
Additionally, the screen dimensions and geometry reported by the engine are now correct on Open Harmony OS ([@PartiallyUntyped](https://github.com/PartiallyUntyped), [@jschwe](https://github.com/jschwe), [#36915](https://github.com/servo/servo/pull/36915)).

### Stability

#### Memory usage

Servo is now better at evicting image data from GPU caches ([@webbeef](https://github.com/webbeef), [#36956](https://github.com/servo/servo/pull/36956)).
We also reduced the memory used to store [HSTS data](https://developer.mozilla.org/en-US/docs/Glossary/HSTS), saving **more than 60mb** by doing so ([@sebsebmc](https://github.com/sebsebmc), [#37000](https://github.com/servo/servo/pull/37000), [#37015](https://github.com/servo/servo/pull/37015)).

We now measure the memory usage of sessionStorage and localStorage data ([@jdm](https://github.com/jdm), [#37053](https://github.com/servo/servo/pull/37053)), the [Public Suffix List](https://en.wikipedia.org/wiki/Public_Suffix_List) ([@sebsebmc](https://github.com/sebsebmc), [#37049](https://github.com/servo/servo/pull/37049)), and the system font storage ([@jdm](https://github.com/jdm), [#36834](https://github.com/servo/servo/pull/36834)).
In addition, we **reduced the size of the final Servo binary** by 2mb by stripping out DOM code that should never be used outside of automated tests ([@jdm](https://github.com/jdm), [#37034](https://github.com/servo/servo/pull/37034)).

#### Crashes

We fixed a number of crashes involving animated images ([@simonwuelker](https://github.com/simonwuelker), [#37058](https://github.com/servo/servo/pull/37058)), media elements with an unknown duration ([@tharkum](https://github.com/tharkum), [servo-media#437](https://github.com/servo/media/pull/437)), canvas elements during shutdown ([@mrobinson](https://github.com/mrobinson), [#37182](https://github.com/servo/servo/pull/37182)), adding a Path2D to itself ([@Taym95](https://github.com/Taym95), [#36847](https://github.com/servo/servo/pull/36847)), calculating `IntersectionObserver` areas ([@webbeef](https://github.com/webbeef), [#36955](https://github.com/servo/servo/pull/36955)), using `Node.childNodes` ([@jdm](https://github.com/jdm), [#36889](https://github.com/servo/servo/pull/36889)), resizing `OffscreenCanvas` ([@simonwuelker](https://github.com/simonwuelker), [#36855](https://github.com/servo/servo/pull/36855)), querying WebGL extensions ([@mrobinson](https://github.com/mrobinson), [#36911](https://github.com/servo/servo/pull/36911)), and slicing a sliced `Blob` ([@simonwuelker](https://github.com/simonwuelker), [#36866](https://github.com/servo/servo/pull/36866)).

We also addressed a deadlock involving streams with very large chunks ([@wusyong](https://github.com/wusyong), [#36914](https://github.com/servo/servo/pull/36914)), and a source of intermittent crashes when closing tabs or removing iframes ([@jdm](https://github.com/jdm), [#37120](https://github.com/servo/servo/pull/37120)).
Finally, we rewrote the implementation of `HTMLOptionElement.text` to avoid crashes with deeply-nested elements ([@kkoyung](https://github.com/kkoyung), [#37167](https://github.com/servo/servo/pull/37167)).

Having previously noticed an unsafe pattern triggered by using JS-owned values in Rust Drop implementations ([[#26488](https://github.com/servo/servo/pull/26488)](https://github.com/servo/servo/issues/26488)), we have begun incrementally removing existing Drop implementations to remove the source of unsafety ([@willypuzzle](https://github.com/willypuzzle), [#37136](https://github.com/servo/servo/pull/37136)).

### Upgrades

We upgraded our fork of WebRender to an upstream revision from late April ([@mrobinson](https://github.com/mrobinson), [#36770](https://github.com/servo/servo/pull/36770)), and we upgraded our Stylo dependency to a version from the start of May ([@Loirooriol](https://github.com/Loirooriol), [#36835](https://github.com/servo/servo/pull/36835)).
These changes ensure that Servo is up to date with ongoing work in Firefox, which shares these dependencies.

## Donations

Thanks again for your generous support!
We are now receiving **4597 USD/month** (−1.4% over April) in recurring donations.
This helps cover the cost of our [self-hosted](https://ci0.servo.org) [CI](https://ci1.servo.org) [runners](https://ci2.servo.org) and our [latest Outreachy interns](https://www.outreachy.org/alums/2025-06/#:~:text=Servo), **Usman Baba Yahaya** ([@uthmaniv](https://github.com/uthmaniv)) and **Jerens Lensun** ([@jerensl](https://github.com/jerensl))!

Servo is also on [thanks.dev](https://thanks.dev), and already **25 GitHub users** (+1 over April) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 4597 / 10000); padding-left: 0.5em;"><strong>4597</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 4597 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="4597" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

As always, use of these funds will be decided transparently in the Technical Steering Committee.
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