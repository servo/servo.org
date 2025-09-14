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

<!--
- canvas
    - https://github.com/servo/servo/pull/38496	(@sagudev, #38496)	canvas: pop many clips on restore (#38496)
      canvas
- css
    - https://github.com/servo/servo/pull/38682	(@simonwuelker, #38682)	script: Implement `CSS.registerProperty` (#38682)
      css
    - https://github.com/servo/servo/pull/38642	(@simonwuelker, #38642)	fonts: Implement CSS `font-variation-settings` property for FreeType platforms (#38642)
      css
    - https://github.com/servo/servo/pull/38760	(@mrobinson, #38760)	fonts: Add font variation support for macOS (#38760)
      css
    - https://github.com/servo/servo/pull/38831	(@mrobinson, #38831)	fonts: Add font variations support for Windows (#38831)
      css
    - https://github.com/servo/servo/pull/38832	(@mrobinson, #38832)	fonts: Add support for `format(*-variations)` to `@font-face` (#38832)
      css
    - https://github.com/servo/servo/pull/38564	(@simonwuelker, #38564)	script: Support custom element states (#38564)
      css
- devex
    - https://github.com/servo/servo/pull/37152	(@jschwe, #37152)	CI: Check MSRV in CI (#37152)
      devex
- devtools
    - https://github.com/servo/servo/pull/38331	(@delan, @atbrakhi, #38331)	script: Create a debugger script for the SpiderMonkey Debugger API (#38331)
      devtools
    - https://github.com/servo/servo/pull/38216	(@uthmaniv, #38216)	Calculate and send  the missing transferred_size and content_size to dev tools (#38216)
      devtools
    - https://github.com/servo/servo/pull/38363	(@delan, @atbrakhi, #38363)	script: Tell SpiderMonkey whether scripts are inline (#38363)
      devtools
    - https://github.com/servo/servo/pull/38333	(@delan, @atbrakhi, #38333)	script: Add new Window globals as debuggees (#38333)
      devtools
    - https://github.com/servo/servo/pull/38575	(@simonwuelker, #38575)	script: Tell devtools whether a node is displayed or not (#38575)
      devtools
    - https://github.com/servo/servo/pull/38551	(@delan, @atbrakhi, #38551)	script: Add new worker globals as debuggees (#38551)
      devtools
    - https://github.com/servo/servo/pull/38550	(@delan, @atbrakhi, #38550)	script: Set correct `introductionType` values in more places (#38550)
      devtools
    - https://github.com/servo/servo/pull/38334	(@delan, @atbrakhi, #38334)	devtools: Create source actors from Debugger API notifications (#38334)
      devtools
    - https://github.com/servo/servo/pull/38624	(@delan, @atbrakhi, #38624)	devtools: Fix `getBreakpointListActor` handler in watcher actor (#38624)
      devtools
    - https://github.com/servo/servo/pull/37667	(@delan, @atbrakhi, #37667)	devtools: Show clients where they can set breakpoints (#37667)
      devtools
    - https://github.com/servo/servo/pull/38601	(@uthmaniv, #38601)	net: Send Cookies to Devtools (#38601)
      devtools
    - https://github.com/servo/servo/pull/38625	(@uthmaniv, @jdm, #38625)	net: Send ResponseContentObj to Devtools (#38625)
      devtools
    - https://github.com/servo/servo/pull/38826	(@delan, @atbrakhi, #38826)	devtools: Fix available breakpoint positions with nested scripts (#38826)
      devtools
    - https://github.com/servo/servo/pull/38797	(@atbrakhi, #38797)	devtools: Handle `removeBreakpoint` on breakpoint-list actor (#38797)
      devtools
- dom
    - https://github.com/servo/servo/pull/38321	(@stevennovaryo, #38321)	script: Fire `scroll` event whenever JS scrolled  (#38321)
      dom
    - https://github.com/servo/servo/pull/38301	(@TimvdLippe, #38301)	Implement initial version of `navigator.sendBeacon` (#38301)
      dom ; pref-gated
    - https://github.com/servo/servo/pull/38433	(@leo030303, #38433)	Implement HTMLDocument API (#38433)
      dom
    - https://github.com/servo/servo/pull/38470	(@gterzian, #38470)	script: allow for undefined chunks in stream piping (#38470)
      dom
    - https://github.com/servo/servo/pull/38230	(@abdelrahman1234567, #38230)	script: Implement `scrollIntoView` (#38230)
      dom
    - https://github.com/servo/servo/pull/38579	(@simonwuelker, #38579)	script: Convert `CSS` from a IDL interface with static methods to a namespace (#38579)
      dom
    - https://github.com/servo/servo/pull/37838	(@arthmis, #37838)	add implementation for Path2D addPath method (#37838)
      dom
    - https://github.com/servo/servo/pull/38589	(@euclid.ye@huawei.com, #38589)	script: Focus on mousedown instead of mouse click according to spec (#38589)
      dom
    - https://github.com/servo/servo/pull/38595	(@TimvdLippe, #38595)	Implement Trusted Types for ShadowRoot (#38595)
      dom
    - https://github.com/servo/servo/pull/38539	(@mrobinson, @Loirooriol, #38539)	script/compositor: Send `mouseleave` events when cursor moves between `<iframe>`s (#38539)
      dom
    - https://github.com/servo/servo/pull/37834	(@TimvdLippe, #37834)	Implement Trusted Type eval checks (#37834)
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
    - https://github.com/servo/servo/pull/38700	(@TimvdLippe, #38700)	Implement trusted types for setAttribute (#38700)
      dom
    - https://github.com/servo/servo/pull/38466	(@wuminghua7@huawei.com, #38466)	Script: Implement `TextEncoderStream` (#38466)
      dom
    - https://github.com/servo/servo/pull/38720	(@menonrahul02@gmail.com, #38720)	content: Make QuotaExceededError serializable (#38720)
      dom
    - https://github.com/servo/servo/pull/38736	(@TimvdLippe, @jdm, #38736)	Implement trusted types for setTimeout/setInterval (#38736)
      dom
    - https://github.com/servo/servo/pull/38718	(@TimvdLippe, #38718)	Add trusted type checks for global event handler attributes (#38718)
      dom
    - https://github.com/servo/servo/pull/38735	(@kkoyung, #38735)	script: Throw error when lower is greater than upper in IDBKeyRange (#38735)
      dom
    - https://github.com/servo/servo/pull/38746	(@Taym95, #38746)	Implement AbortSignal static abort(reason) (#38746)
      dom
    - https://github.com/servo/servo/pull/37968	(@sebsebmc@gmail.com, #37968)	script: initial CookieStore implementation (#37968)
      dom
    - https://github.com/servo/servo/pull/38801	(@averyrudelphe@gmail.com, #38801)	Add `matrixTransform` for `DOMPointReadOnly` (#38801)
      dom
    - https://github.com/servo/servo/pull/38828	(@averyrudelphe@gmail.com, #38828)	Make DOM geometry structs serializable (#38828)
      dom
    - https://github.com/servo/servo/pull/38810	(@averyrudelphe@gmail.com, #38810)	Add legacy window aliases `SVGMatrix`/`SVGPoint` for `DOMMatrix`/`DOMPoint` (#38810)
      dom
    - https://github.com/servo/servo/pull/38784	(@TimvdLippe, #38784)	Implement trusted types for remaining attribute sinks (#38784)
      dom
    - https://github.com/servo/servo/pull/38734	(@TimvdLippe, #38734)	Remove event handlers when attribute is removed (#38734)
      dom
    - https://github.com/servo/servo/pull/38871	(@TimvdLippe, #38871)	Propagate Trusted Types errors for Node.textContent (#38871)
      dom
    - https://github.com/servo/servo/pull/38495	(@abdelrahman1234567, #38495)	script: Add `FocusOptions` argument to `Element.focus` and implement `FocusOptions.preventScroll` (#38495)
      dom
    - https://github.com/servo/servo/pull/38676	(@gterzian, @mrobinson, #38676)	script: abort planned form navigations (#38676)
      dom
    - https://github.com/servo/servo/pull/38984	(@euclid.ye@huawei.com, #38984)	script: Support decomposing ShadowRoot from mozjs `HandleValue` (#38984)
      dom
    - https://github.com/servo/servo/pull/38876	(@sebsebmc@gmail.com, #38876)	script: Do not include fragments when comparing URLs in `CookieStore` (#38876)
      dom
    - https://github.com/servo/servo/pull/38623	(@TimvdLippe, #38623)	Implement trusted types processing for JavaScript URL (#38623)
      dom
    - https://github.com/servo/servo/pull/38874	(@TimvdLippe, #38874)	script: Implement trusted types for `Range.createContextualFragment` (#38874)
      dom
    - https://github.com/servo/servo/pull/38872	(@TimvdLippe, #38872)	script: Implement trusted types for `DOMParser.parseFromString` (#38872)
      dom
    - https://github.com/servo/servo/pull/38886	(@TimvdLippe, #38886)	Disallow invalid trusted type policy names (#38886)
      dom
    - https://github.com/servo/servo/pull/38993	(@Gae24, #38993)	`XMLHttpRequest` `Send`: fix Content-Type failures (#38993)
      dom
    - https://github.com/servo/servo/pull/38979	(@mrobinson, #38979)	canvas: Move font selection and text shaping to `script` (#38979)
      dom
    - https://github.com/servo/servo/pull/39020	(@andrei.volykhin@gmail.com, @volykhin.andrei@huawei.com, #39020)	webgpu: Add the dedicated WebGPU task source (#39020)
      dom
    - https://github.com/servo/servo/pull/37776	(@sagudev, @mrobinson, #37776)	compositor: Allow canvas to upload rendered contents asynchronously (#37776)
      dom
    - https://github.com/servo/servo/pull/39011	(@kot@kot.pink, #39011)	script: Clear all associated event listeners when removing an event listener content attribute. (#39011)
      dom
- embedding
    - https://github.com/servo/servo/pull/38602	(@rodion.borovyk@gmail.com, #38602)	script: Send JS evaluation errors to constellation (#38602)
      embedding
- font
    - https://github.com/servo/servo/pull/38753	(@nicoburns, #38753)	Fix loading raw data from `.ttc` files on macos (#38753)
      font
    - https://github.com/servo/servo/pull/39001	(@darryl@dpogue.ca, #39001)	fonts: Use `Helvetica` as the `system-ui` font on macOS (#39001)
      font
- indexeddb
    - https://github.com/servo/servo/pull/38744	(@arihant2math@gmail.com, #38744)	net: fix indexeddb backend bugs (#38744)
      indexeddb
    - https://github.com/servo/servo/pull/38737	(@arihant2math@gmail.com, #38737)	Enable access to transaction from idbobjectstore (#38737)
      indexeddb
    - https://github.com/servo/servo/pull/38836	(@arihant2math@gmail.com, #38836)	net: Fix initial indexeddb version storage (#38836)
      indexeddb
    - https://github.com/servo/servo/pull/38813	(@arihant2math@gmail.com, #38813)	Stub out IDBIndex (#38813)
      indexeddb
    - https://github.com/servo/servo/pull/38819	(@jdm, #38819)	indexeddb: Initialize DB version to zero. (#38819)
      indexeddb
    - https://github.com/servo/servo/pull/38115	(@jdm, #38115)	IndexedDB: Handle missing object stores in object store operations (#38115)
      indexeddb
    - https://github.com/servo/servo/pull/38944	(@rodion.borovyk@gmail.com, #38944)	indexeddb: Use UUIDs instead of sanitization of object store names (#38944)
      indexeddb
    - https://github.com/servo/servo/pull/38740	(@arihant2math@gmail.com, @jdm, #38740)	script: correctly handle indexeddb backend errors (#38740)
      indexeddb
    - https://github.com/servo/servo/pull/38891	(@arihant2math@gmail.com, #38891)	indexeddb: Add index schemas (#38891)
      indexeddb
    - https://github.com/servo/servo/pull/38723	(@arihant2math@gmail.com, #38723)	indexeddb: Implement autoincremented keys and report autoincrementedness properly through DOM interface (#38723)
      indexeddb
    - https://github.com/servo/servo/pull/38850	(@kkoyung, #38850)	script: Initialize IDBCursor and IDBCursorWithValue interfaces (#38850)
      indexeddb
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
    - https://github.com/servo/servo/pull/38306	(@nicoburns, #38306)	layout(grid): implement named grid lines and areas (#38306)
      layout
    - https://github.com/servo/servo/pull/38480	(@mrobinson, @Loirooriol, @kongbai1996, #38480)	compositor/layout: Rely on layout for fine-grained input event hit testing (#38480)
      layout
    - https://github.com/servo/servo/pull/38526	(@Loirooriol, #38526)	layout: Let `stretch` on flex item cross size stretch to the line (#38526)
      layout
    - https://github.com/servo/servo/pull/38574	(@Loirooriol, #38574)	layout: Paint flex and grid items like inline blocks (#38574)
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
    - https://github.com/servo/servo/pull/38884	(@kongbai1996, @yezhizhen, #38884)	layout: Skip adding `ScrollFrameHitTestItem` to stacking context tree if the `BoxFragment` has inherited style `pointer-events: none` (#38884)
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
    - https://github.com/servo/servo/pull/38464	(@mrobinson, @Loirooriol, #38464)	layout: Cache projected point in spatial node when hit testing (#38464)
      performance
    - https://github.com/servo/servo/pull/38493	(@nicoburns, #38493)	Use cached layout in grid layout (#38493)
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
    - https://github.com/servo/servo/pull/38373	(@averyrudelphe@gmail.com, #38373)	servoshell: make the color picker and select picker closeable (#38373)
      servoshell
    - https://github.com/servo/servo/pull/36680	(@simonwuelker, #36680)	servoshell: Display favicons in tab bar (#36680)
      servoshell
    - https://github.com/servo/servo/pull/38949	(@simonwuelker, #38949)	script: Load and rasterize favicons before passing them to the embedder (#38949)
      servoshell
    - https://github.com/servo/servo/pull/39038	(@averyrudelphe@gmail.com, #39038)	servoshell: Redraw on closing a dialog (#39038)
      servoshell
- stability
    - https://github.com/servo/servo/pull/38385	(@gterzian, #38385)	script: in stream piping, ensure the heap is set only after it has been moved (#38385)
      stability
    - https://github.com/servo/servo/pull/38463	(@mrobinson, @Loirooriol, @kongbai1996, #38463)	layout: Add a layout hit test and use it for `document.elementsFromPoint` (#38463)
      stability
    - https://github.com/servo/servo/pull/38473	(@mrobinson, #38473)	script/layout: Ensure a StackingContextTree before IntersectionObserver geometry queries (#38473)
      stability
    - https://github.com/servo/servo/pull/38664	(@gterzian, #38664)	script: check if the canvas is paintable before measuring text (#38664)
      stability
    - https://github.com/servo/servo/pull/38709	(@jdm, #38709)	script: Ensure JS->webdriver conversions have a non-empty settings stack (#38709)
      stability
    - https://github.com/servo/servo/pull/38739	(@gterzian, #38739)	script: when handling page headers, stop if pipeline closed already (#38739)
      stability
- svg
    - https://github.com/servo/servo/pull/38188	(@mukilan, #38188)	script: support inline SVG by serializing the subtree (#38188)
      svg
    - https://github.com/servo/servo/pull/38603	(@Loirooriol, @mukilan, #38603)	layout: Improve sizing for inline SVG (#38603)
      svg
- upgrade
    - https://github.com/servo/servo/pull/38429	(@Loirooriol, #38429)	Upgrade Stylo to 2025-08-01 (#38429)
      upgrade
    - https://github.com/servo/servo/pull/38563	(@jdm, #38563)	Upgrade to SpiderMonkey 140. (#38563)
      upgrade
- upgrades
    - https://github.com/servo/servo/pull/37077	(@jdm, #37077)	Update to SpiderMonkey 137. (#37077)
      upgrades
- webdriver
    - https://github.com/servo/servo/pull/38401	(@kkoyung, #38401)	webdriver: consider boolean attribute when get element attribute (#38401)
      webdriver
    - https://github.com/servo/servo/pull/38383	(@yezhizhen, #38383)	webdriver: Fix "element in view" by correctly computing resolved `PointerEvents` style (#38383)
      webdriver
    - https://github.com/servo/servo/pull/38397	(@longvatrong111, #38397)	webdriver: improve session commands (#38397)
      webdriver
    - https://github.com/servo/servo/pull/38436	(@euclid.ye@huawei.com, #38436)	webdriver: Improve "element click" by using container + Upgrade outdated test (#38436)
      webdriver
    - https://github.com/servo/servo/pull/38491	(@euclid.ye@huawei.com, #38491)	webdriver: Search ancestors instead of preceding nodes when computing container for `option`&`optgroup` (#38491)
      webdriver
    - https://github.com/servo/servo/pull/38497	(@euclid.ye@huawei.com, #38497)	webdriver: Check if container is obscured for "Element Click" (#38497)
      webdriver
    - https://github.com/servo/servo/pull/38536	(@Kenzie.Raditya.Tirtarahardja@huawei.com, #38536)	script(webdriver): Fix element clear for file (#38536)
      webdriver
    - https://github.com/servo/servo/pull/38490	(@Kenzie.Raditya.Tirtarahardja@huawei.com, #38490)	script(webdriver): Check if element is disabled based on WebDriver specification (#38490)
      webdriver
    - https://github.com/servo/servo/pull/38620	(@euclid.ye@huawei.com, #38620)	webdriver: Synchronize "close window" command & Return correct error type (#38620)
      webdriver
    - https://github.com/servo/servo/pull/38591	(@Kenzie.Raditya.Tirtarahardja@huawei.com, #38591)	webdriver: Add handle user prompt for some command (#38591)
      webdriver
    - https://github.com/servo/servo/pull/38357	(@longvatrong111, #38357)	Implement webdriver extract script arguments (#38357)
      webdriver
    - https://github.com/servo/servo/pull/38622	(@longvatrong111, #38622)	webdriver: Implement the "Get Window Handles" command (#38622)
      webdriver
    - https://github.com/servo/servo/pull/38407	(@Kenzie.Raditya.Tirtarahardja@huawei.com, @euclid.ye@huawei.com, #38407)	script(webdriver): Element send keys append to the end of `filelist` if Multiple (#38407)
      webdriver
    - https://github.com/servo/servo/pull/38745	(@longvatrong111, @euclid.ye@huawei.com, #38745)	webdriver: Refactor webdriver session and improve window handles (#38745)
      webdriver
    - https://github.com/servo/servo/pull/38841	(@euclid.ye@huawei.com, #38841)	webdriver: Consider shadow including descendant when computing "obscured" step of “element click” (#38841)
      webdriver
    - https://github.com/servo/servo/pull/38444	(@Kenzie.Raditya.Tirtarahardja@huawei.com, @euclid.ye@huawei.com, #38444)	webdriver: Element Send keys use dispatch actions for KeyboardEvent (#38444)
      webdriver
    - https://github.com/servo/servo/pull/38889	(@euclid.ye@huawei.com, #38889)	webdriver: Focus when "switch to window" (#38889)
      webdriver
    - https://github.com/servo/servo/pull/38943	(@euclid.ye@huawei.com, #38943)	script: Fix wrong procedure when deserializing `JSValue` from mozjs `HandleValue` (#38943)
      webdriver
    - https://github.com/servo/servo/pull/38909	(@euclid.ye@huawei.com, #38909)	webdriver: Raise `WebView` to top when focus (#38909)
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

