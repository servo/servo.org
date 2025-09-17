---
layout:     post
tags:       blog
title:      "This month in Servo: ?????????"
date:       2025-09-01
summary:    Who even knows?
categories:
---

Another month, another record number of pull requests merged!
August flew by, and with it came **447 pull requests** from Servo contributors.

Our big new feature this month is rendering support **inline SVG elements** (@mukilan, @Loirooriol, #38188, #38603).
This improves the appearance of many popular websites.

[[add inline svg figure]]

We have implemented **named grid line lines and areas** (@nicoburns, @loirooriol, #38306, #38574, #38493), still gated behind the `layout_grid_enabled` preference (#38306, #38574).

Servo now supports CSS **font-variation-settings** on all main desktop platforms (@simonwuelker, @mrobinson, #38642, #38760, #38831).
This feature is currently gated behind the `layout_variable_fonts_enabled` preference.
We also respect `format(*-variations)` inside `@font-face` rules (@mrobinson, #38832).
Additionally, Servo now reads data from **OpenType Collection** system font files on macOS (@nicoburns, #38753), and uses `Helvetica` for the **system-ui** font (@dpogue, #39001).

Our developer tools continue to make progress! We now have a functional network monitor panel (@uthmaniv, @jdm, #38216, #38601, #38625),
and our JS debugger can show potential breakpoints (@delan, @atbrakhi, #38331, #38363, #38333, #38551, #38550, #38334, #38624, #38826, #38797).
Additionally, the layout inspector now dims nodes that are not displayed (@simonwuelker, #38575).

[[add network monitor figure here]]

We fixed a significant source of crashes in the engine: hit testing using outdated display lists.
Hit testing in a web rendering engine is the process that determines which element(s) the user's mouse is hovering over.
Previously, this process ran inside of [WebRender](https://github.com/servo/webrender), which receives a display list representing what should be rendered for a particular page.
Since this is either a separate thread or process from the actual page content, display lists are updated asynchronously.
This means it was possible to trigger crashes by performing a hit test (e.g. moving the mouse quickly) over parts of the page that were rapidly changing, since the elements reported may not exist any more.
This was fixed by making the hit test operation synchronous and moving it into the same thread as the actual content being tested against, eliminating the possibility of outdated results (@mrobinson, @Loirooriol, @kongbai1996, @yezhizhen, #38480, #38464, #38463, #38884).

Numerous pieces of the [**Trusted Types API**](https://developer.mozilla.org/en-US/docs/Web/API/Trusted_Types_API) are now present in Servo
(@TimvdLippe, @jdm, #38595, #37834, #38700, #38736, #38718, #38784, #38871, #8623, #38874, #38872, #38886), all gated behind the `dom_trusted_types_enabled` preference.

The IndexedDB implementation (gated behind `dom_indexeddb_enabled`) is progressing quickly (@arihant2math, @jdm, @rodion, @kkoyung, #28744, #38737, #38836, #38813, #38819, #38115, #38944, #38740, #38891, #38723, #38850, #38735), now reporting errors via `IDBRequest` interface and supporting autoincrement keys.

A prototype implementation of the [CookieStore API](https://developer.mozilla.org/en-US/docs/Web/API/CookieStore) is now implemented and gated by the `dom_cookiestore_enabled` preference (@sebsebmc, #37968, #38876).

Servo now passes over 99.6% of the CSS geometry testsuite, thanks to an implementation of **DOMPointReadOnly.matrixTransform**, making all geometry interfaces serializable, and adding the **SVGMatrix and SVGPoint aliases** (@lumiscosity, #38801, #38828, #38810).

Servo now fires a **scroll event** whenever a page is scrolled (@stevennovaryo, #38321). Additionally, the **Window.scrollIntoView** method is now available (@abdelrahman1234567, #38230).

[[figure showing scrolling effect?]]

The **Navigator.sendBeacon()** API is implemented, gated behind the `dom.navigator.sendbeacon_enabled` preference (@TimvdLippe, #38301).

The **HTMLDocument** interface now exists as a property on the `Window` object (@leo030303, #38433).

Our 2d canvas implementation now supports the **Path2D.addPath** method (@arthmis, #37838) and the `restore` method now pops all applied clipping paths (@sagudev, #38496).
Additionally, we now support **using web fonts in the 2D canvas** (@mrobinson, #38979).

Our WebDriver implementation now passes 80% of the implementation conformance tests.
This is the result of lots of iteration and fixes for things like handling user prompts (@PotatoCP, #38591), computing obscured/disabled elements while clicking (@yezhizhen, #38497, #38841, #38436, #38490, #38383), and improving window focus behaviours (@yezhizhen, #38889, #38909).

We upgraded to **SpiderMonkey v140** (@jdm, #37077, #38563), as well as the **upstream Stylo** revision as of August 1, 2025.

## Embedding

Servo has declared a **Minimum Supported Rust Version** (1.85.0), and this is verified with every new pull request (@jschwe, #37152).

Evaluating JS from the embedding layer now **reports an error** if the evaluation failed for any reason (@rodio, #38602).

## Servoshell

We now **display favicons** in the tab bar for each toplevel page (#36680, @simonwuelker).

Resizing the browser window to a very small dimension no longer crashes the browser (@leo030303, #38461).

Various popup dialogs (e.g. the `<select>` option chooser dialog) now can be closed without choosing a value (@TimvdLippe, #38373, #38949).
Additionally, the browser now responds to a popup closing without any other inputs (@lumiscosity, #39038).

<!--
- css
    - https://github.com/servo/servo/pull/38682	(@simonwuelker, #38682)	script: Implement `CSS.registerProperty` (#38682)
      css
    - https://github.com/servo/servo/pull/38564	(@simonwuelker, #38564)	script: Support custom element states (#38564)
      css
- dom
    - https://github.com/servo/servo/pull/38470	(@gterzian, #38470)	script: allow for undefined chunks in stream piping (#38470)
      dom
    - https://github.com/servo/servo/pull/38579	(@simonwuelker, #38579)	script: Convert `CSS` from a IDL interface with static methods to a namespace (#38579)
      dom
    - https://github.com/servo/servo/pull/38589	(@euclid.ye@huawei.com, #38589)	script: Focus on mousedown instead of mouse click according to spec (#38589)
      dom
    - https://github.com/servo/servo/pull/38539	(@mrobinson, @Loirooriol, #38539)	script/compositor: Send `mouseleave` events when cursor moves between `<iframe>`s (#38539)
      dom
    - https://github.com/servo/servo/pull/37100	(@mrobinson, #37100)	script: Properly fire `input` events for clipboard use in input elements (#37100)
      dom
    - https://github.com/servo/servo/pull/38535	(@Kenzie.Raditya.Tirtarahardja@huawei.com, #38535)	script: Implement `getModifierState` for mouse event (#38535)
      dom
    - https://github.com/servo/servo/pull/38671	(@euclid.ye@huawei.com, #38671)	script: Stop handling native `mousedown` and `mouseup` for disabled elements (#38671)
      dom
    - https://github.com/servo/servo/pull/38507	(@menonrahul02@gmail.com, #38507)	script: Implement QuotaExceededError WebIDL interface (#38507)
      dom
    - https://github.com/servo/servo/pull/38677	(@simonwuelker, #38677)	script: Always throw when trying to `setProperty` on a readonly style `CSSStyleDeclaration` (#38677)
      dom
    - https://github.com/servo/servo/pull/38599	(@averyrudelphe@gmail.com, #38599)	script: Strip `javascript` URL scheme using `Position::AfterScheme` rather than `Position::BeforePath` (#38599)
      dom
    - https://github.com/servo/servo/pull/38466	(@wuminghua7@huawei.com, #38466)	Script: Implement `TextEncoderStream` (#38466)
      dom
    - https://github.com/servo/servo/pull/38720	(@menonrahul02@gmail.com, #38720)	content: Make QuotaExceededError serializable (#38720)
      dom
    - https://github.com/servo/servo/pull/38746	(@Taym95, #38746)	Implement AbortSignal static abort(reason) (#38746)
      dom
    - https://github.com/servo/servo/pull/38734	(@TimvdLippe, #38734)	Remove event handlers when attribute is removed (#38734)
      dom
    - https://github.com/servo/servo/pull/38495	(@abdelrahman1234567, #38495)	script: Add `FocusOptions` argument to `Element.focus` and implement `FocusOptions.preventScroll` (#38495)
      dom
    - https://github.com/servo/servo/pull/38676	(@gterzian, @mrobinson, #38676)	script: abort planned form navigations (#38676)
      dom
    - https://github.com/servo/servo/pull/38984	(@euclid.ye@huawei.com, #38984)	script: Support decomposing ShadowRoot from mozjs `HandleValue` (#38984)
      dom
    - https://github.com/servo/servo/pull/38993	(@Gae24, #38993)	`XMLHttpRequest` `Send`: fix Content-Type failures (#38993)
      dom
    - https://github.com/servo/servo/pull/39020	(@andrei.volykhin@gmail.com, @volykhin.andrei@huawei.com, #39020)	webgpu: Add the dedicated WebGPU task source (#39020)
      dom
    - https://github.com/servo/servo/pull/37776	(@sagudev, @mrobinson, #37776)	compositor: Allow canvas to upload rendered contents asynchronously (#37776)
      dom
    - https://github.com/servo/servo/pull/39011	(@kot@kot.pink, #39011)	script: Clear all associated event listeners when removing an event listener content attribute. (#39011)
      dom
- layout
    - https://github.com/servo/servo/pull/38391	(@mrobinson, @Loirooriol, #38391)	layout: Account for sticky nodes in ScrollTree transforms and cache transforms (#38391)
      layout
    - https://github.com/servo/servo/pull/38418	(@averyrudelphe@gmail.com, @mrobinson, #38418)	layout: Fix negative outline offset (#38418)
      layout
    - https://github.com/servo/servo/pull/38366	(@Loirooriol, #38366)	layout: Recreate lazy block size when re-doing layout to avoid floats (#38366)
      layout
    - https://github.com/servo/servo/pull/38443	(@shubhamg13, #38443)	Include the scrollable overflow of a child box if either its parent or child has `overflow: visible` (#38443)
      layout
    - https://github.com/servo/servo/pull/38518	(@mrobinson, @Loirooriol, #38518)	script/compositor: Handle cursor updates from script (#38518)
      layout
    - https://github.com/servo/servo/pull/38521	(@Loirooriol, #38521)	layout: Floor content-box size by zero when stretching flex item (#38521)
      layout
    - https://github.com/servo/servo/pull/38526	(@Loirooriol, #38526)	layout: Let `stretch` on flex item cross size stretch to the line (#38526)
      layout
    - https://github.com/servo/servo/pull/38570	(@simonwuelker, #38570)	layout: Set color and text decoration on `<select>` elements by default (#38570)
      layout
    - https://github.com/servo/servo/pull/38678	(@mrobinson, @Loirooriol, #38678)	layout: Support storing layout data for two-level nested pseudo-elements (#38678)
      layout
    - https://github.com/servo/servo/pull/38530	(@ibluegalaxy_taoj@163.com, #38530)	script: Ensure `notify_invalidations()` is always called when modifying stylesheets (#38530)
      layout
    - https://github.com/servo/servo/pull/38529	(@ibluegalaxy_taoj@163.com, #38529)	script: Mark the entire shadow tree for restyle when its stylesheet is invalidated (#38529)
      layout
    - https://github.com/servo/servo/pull/38618	(@stevennovaryo, #38618)	layout: Do not include `position:fixed` children when calculating scrollable overflow for root element (#38618)
      layout
    - https://github.com/servo/servo/pull/38705	(@Loirooriol, #38705)	layout: Stop making `<video>` fall back to a preferred aspect ratio of 2 (#38705)
      layout
    - https://github.com/servo/servo/pull/38598	(@shubhamg13, @Loirooriol, #38598)	layout: Use `overflow: visible` if `overflow` was propagated to viewport (#38598)
      layout
    - https://github.com/servo/servo/pull/38775	(@stevennovaryo, #38775)	layout: Stretch `<input>` inner container to its containing block (#38775)
      layout
    - https://github.com/servo/servo/pull/38825	(@shubhamg13, #38825)	layout: Remove workaround for `body` while building overflow frame for `StackingContextTree` construction. (#38825)
      layout
- media
    - https://github.com/servo/servo/pull/38462	(@rayguo17, @jschwe, #38462)	script: fix set muted on html video element creation (#38462)
      media
- performance
    - https://github.com/servo/servo/pull/38406	(@sagudev, #38406)	canvas: prune vello scene on each render and make rendering cacheable (#38406)
      performance
    - https://github.com/servo/servo/pull/38356	(@sagudev, #38356)	canvas: Clear vello scene if possible (#38356)
      performance
    - https://github.com/servo/servo/pull/38440	(@sagudev, #38440)	canvas: Do not use vello layers for opacity or default composition (#38440)
      performance
    - https://github.com/servo/servo/pull/38437	(@sagudev, #38437)	canvas: Use OptimizeSpeed in vello_cpu (#38437)
      performance
    - https://github.com/servo/servo/pull/38431	(@mrobinson, @Loirooriol, #38431)	script: Unify script-based "update the rendering" and throttle it to 60 FPS (#38431)
      performance
    - https://github.com/servo/servo/pull/38666	(@jschwe, #38666)	mozjs: Remove unneeded icu_capi features (#38666)
      performance
    - https://github.com/servo/servo/pull/38540	(@ibluegalaxy_taoj@163.com, #38540)	Reuse `StylesheetContent` for inline style sheets with identical content (#38540)
      performance
    - https://github.com/servo/servo/pull/38857	(@mrobinson, #38857)	script: Do not iterate through all image frames when advancing animated images (#38857)
      performance
    - https://github.com/servo/servo/pull/38916	(@ibluegalaxy_taoj@163.com, #38916)	script: mark image-related node dirty only when image resource loaded (#38916)
      performance
- servoshell
    - https://github.com/servo/servo/pull/38328	(@euclid.ye@huawei.com, #38328)	servoshell: Sync window toolbar height with minibrowser (#38328)
      servoshell
    - https://github.com/servo/servo/pull/38461	(@leo030303, #38461)	Servoshell: Update `Window::inner_size` on `WindowEvent::Resized` (fix resize bug) (#38461)
      servoshell
- stability
    - https://github.com/servo/servo/pull/38385	(@gterzian, #38385)	script: in stream piping, ensure the heap is set only after it has been moved (#38385)
      stability
    - https://github.com/servo/servo/pull/38473	(@mrobinson, #38473)	script/layout: Ensure a StackingContextTree before IntersectionObserver geometry queries (#38473)
      stability
    - https://github.com/servo/servo/pull/38664	(@gterzian, #38664)	script: check if the canvas is paintable before measuring text (#38664)
      stability
    - https://github.com/servo/servo/pull/38709	(@jdm, #38709)	script: Ensure JS->webdriver conversions have a non-empty settings stack (#38709)
      stability
    - https://github.com/servo/servo/pull/38739	(@gterzian, #38739)	script: when handling page headers, stop if pipeline closed already (#38739)
      stability
- webdriver
    - https://github.com/servo/servo/pull/38401	(@kkoyung, #38401)	webdriver: consider boolean attribute when get element attribute (#38401)
      webdriver
    - https://github.com/servo/servo/pull/38397	(@longvatrong111, #38397)	webdriver: improve session commands (#38397)
      webdriver
    - https://github.com/servo/servo/pull/38491	(@euclid.ye@huawei.com, #38491)	webdriver: Search ancestors instead of preceding nodes when computing container for `option`&`optgroup` (#38491)
      webdriver
    - https://github.com/servo/servo/pull/38536	(@Kenzie.Raditya.Tirtarahardja@huawei.com, #38536)	script(webdriver): Fix element clear for file (#38536)
      webdriver
    - https://github.com/servo/servo/pull/38620	(@euclid.ye@huawei.com, #38620)	webdriver: Synchronize "close window" command & Return correct error type (#38620)
      webdriver
    - https://github.com/servo/servo/pull/38357	(@longvatrong111, #38357)	Implement webdriver extract script arguments (#38357)
      webdriver
    - https://github.com/servo/servo/pull/38622	(@longvatrong111, #38622)	webdriver: Implement the "Get Window Handles" command (#38622)
      webdriver
    - https://github.com/servo/servo/pull/38407	(@Kenzie.Raditya.Tirtarahardja@huawei.com, @euclid.ye@huawei.com, #38407)	script(webdriver): Element send keys append to the end of `filelist` if Multiple (#38407)
      webdriver
    - https://github.com/servo/servo/pull/38745	(@longvatrong111, @euclid.ye@huawei.com, #38745)	webdriver: Refactor webdriver session and improve window handles (#38745)
      webdriver
    - https://github.com/servo/servo/pull/38444	(@Kenzie.Raditya.Tirtarahardja@huawei.com, @euclid.ye@huawei.com, #38444)	webdriver: Element Send keys use dispatch actions for KeyboardEvent (#38444)
      webdriver
    - https://github.com/servo/servo/pull/38943	(@euclid.ye@huawei.com, #38943)	script: Fix wrong procedure when deserializing `JSValue` from mozjs `HandleValue` (#38943)
      webdriver
    - https://github.com/servo/servo/pull/39012	(@euclid.ye@huawei.com, #39012)	webdriver: Improve parsing of Frame and Window (#39012)
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

