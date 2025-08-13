---
layout:     post
tags:       blog
title:      "This month in Servo: and more!"
date:       2025-08-15
summary:    ao!! wrrrrao!!
categories:
---

<!--
- 4691/month donations (4523/month without thanks.dev)
    - 1980.23/month opencollective
    - 2543.00/month github
    - 22 donors 168.55/month thanks.dev
    - benchmarking runners
- DONE windowing
    - DONE On some devices, hit testing is not working properly servo#36817
    - DONE [WebDriver Task] Window Size related commands gives inaccurate result servo#37804
    - DONE ScreenY and outerHeight ignores the title bar height servo#37824
    - DONE window.screen.availWidth and availHeight is inaccurate servo#37878
    - DONE rect for webview.rs and compositor: webview_renderer.rs is heavily mix-used servo#37978
    - DONE Resizing the window may reveal extra space that can’t be scrolled servo#38089
    - DONE --device-pixel-ratio breaks hit testing servo#38090
    - DONE WebDriver: documents loaded with Navigate To have incorrect scrollable area servo#38093
    - DONE servoshell: Tab bar dissapears when resizing the window servo#38255
- vello
    - Investigate other 2D canvas renderers in a post-Pathfinder world servo#30636
    - Tracking issue of Vello canvas backends servo#38345
- canvas
    - Move canvas state handling from CanvasData (canvas paint thread) into CanvasState (script) servo#38022
    - “We want our 2d canvas abstractions to become more general, for potential rendering of all content”
- webdriver
    - [WebDriver] PointerMove does not consider Global position servo#38042 <https://w3c.github.io/webdriver/#dfn-perform-a-pointer-move>
    - [webdriver] Moving webdriver to servoshell servo#37370
- DONE geometry
    - SKIP Create universal utility function for conversion between Physical & Logical unit servo#37937
-->
<!--
- DONE canvas
    - DONE https://github.com/servo/servo/pull/38098	(@sagudev, #38098)	canvas: Store current path only in user space (#38098)
      canvas; see issue 38022
    - DONE https://github.com/servo/servo/pull/38114	(@sagudev, #38114)	canvas: Move current_default_path to script CanvasState (#38114)
      canvas; see issue 38022
    - DONE https://github.com/servo/servo/pull/38164	(@sagudev, #38164)	canvas: Make script/canvas thread boundry mostly stateless (#38164)
      canvas; see issue 38022
    - DONE https://github.com/servo/servo/pull/38214	(@sagudev, #38214)	canvas: Fully stateless backend (#38214)
      canvas; see issue 38022
- crash
    - https://github.com/servo/servo/pull/37959	(@Narfinger, #37959)	OHOS: Make IME more robust against errors (#37959)
      crash; fix crash on ohos when trying to open keyboard while a system popup is open
    - https://github.com/servo/servo/pull/38280	(@arihant2math, #38280)	script: Don't panic on IndexedDB put operation structured clone (#38280)
      crash; fix crash when calling put() on IDBObjectStore
    - https://github.com/servo/servo/pull/38376	(@sebsebmc, #38376)	net: Add expiry limit to cookies and prevent panics from max-age (#38376)
      crash; fix crash when cookie has large max-age
- devtools
    - https://github.com/servo/servo/pull/37778	(@uthmaniv, #37778)	Send WillNavigate earlier during navigation startup (#37778)
      devtools; fix requests in Network tab for new page after navigation
    - https://github.com/servo/servo/pull/37686	(@atbrakhi, @delan, @simonwuelker, @the6p4c, #37686)	Devtools: send error replies instead of ignoring messages (#37686)
      devtools; fix whole bug class
    - https://github.com/servo/servo/pull/37906	(@uthmaniv, #37906)	Send early DevToolsHttpRequest and relocate response reporting to main_fetch (#37906)
      devtools; cached responses (and headers?) in Network tab
    - https://github.com/servo/servo/pull/38236	(@delan, @atbrakhi, #38236)	script: Add support for creating globals in isolated compartments (#38236)
      devtools; debugger tab
    - https://github.com/servo/servo/pull/38232	(@delan, @atbrakhi, #38232)	script: Implement jsglue traps for saveJobQueue() (#38232)
      devtools; debugger tab
    - https://github.com/servo/servo/pull/38330	(@atbrakhi, @delan, #38330)	devtools: Make contentType optional in source actor source responses (#38330)
      devtools; debugger tab
    - https://github.com/servo/servo/pull/38265	(@delan, @atbrakhi, #38265)	script: Implement jsglue trap for runJobs() (#38265)
      devtools; debugger tab
    - https://github.com/servo/servo/pull/38359	(@delan, @atbrakhi, #38359)	devtools: Fix source contents tests and fix a race (#38359)
      devtools; fix loading sources
- dx
    - https://github.com/servo/servo/pull/38043	(@jerensl, @mukilan, #38043)	Mach: add type check on python tidy folder (#38043)
      dx; python type checking
    - https://github.com/servo/servo/pull/38085	(@jerensl, #38085)	mach: Add type check on `python/servo` directory (#38085)
      dx; mach now has python type checking
    - https://github.com/servo/servo/pull/38335	(@jerensl, #38335)	mach: Make test-tidy line length check Unicode-aware (#38335)
      dx; improve unicode handling for line length check in mach test-tidy
    - https://github.com/servo/servo/pull/38324	(@jerensl, #38324)	mach: Fail on invalid argument in try_parser (#38324)
      dx; fail loudly on bad mach try
- embedding
    - https://github.com/servo/servo/pull/37752	(@mrobinson, @Loirooriol, #37752)	libservo|compositor: Have scroll offset directionality match that of WebRender and the web (#37752)
      embedding; breaking change due to flipping y axis in scroll offsets
- features
    - https://github.com/servo/servo/pull/37784	(@CarePackage17, #37784)	Enable LinuxSampler to be used on Android (#37784)
      features; background hang monitor now works on android? try test case to assess how user-facing this is
    - DONE https://github.com/servo/servo/pull/37880	(@tharkum, #37880)	canvas: Add OffscreenCanvas 'transferToImageBitmap' method (#37880)
      features; transferToImageBitmap() method on OffscreenCanvas
    - DONE https://github.com/servo/servo/pull/37803	(@janvarga, #37803)	storage: Isolate sessionStorage per top-level browsing context and copy sessionStorage when creating a new auxiliary browsing context (#37803)
      features; sessionStorage is now isolated between tabs/webviews, and copied when opening a new tab/webview with opener
    - DONE https://github.com/servo/servo/pull/37786	(@tharkum, #37786)	canvas: Add OffscreenCanvas 'convertToBlob' method (#37786)
      features; convertToBlob() method on OffscreenCanvas
    - DONE https://github.com/servo/servo/pull/37718	(@wusyong, #37718)	WebGL2: support TexImage3D (#37718)
      features; texImage3D() method on WebGL2RenderingContext, now support three.js(!), now support texture_2d_array and texture_3d webgl2 samples
    - DONE https://github.com/servo/servo/pull/37637	(@rayguo17, #37637)	add support for apng and webp animated image decoding (#37637)
      features; apng and animated webp support
    - DONE https://github.com/servo/servo/pull/38050	(@tharkum, #38050)	imagebitmap: Remove ImageBitmap from experimental web platform features (#38050)
      features; ImageBitmap now enabled by default
    - DONE https://github.com/servo/servo/pull/38163	(@stevennovaryo, #38163)	script: Implement `DocumentOrShadowDOM.adoptedStylesheet` with `FrozenArray` (#38163)
      features; experimental support for adoptedStyleSheets property on Document/ShadowRoot (--pref dom_adoptedstylesheet_enabled)
    - DONE https://github.com/servo/servo/pull/38244	(@stevennovaryo, #38244)	script: Implement `CSSStyleSheet.replace` (#38244)
      features; replace() method on CSSStyleSheet
    - DONE https://github.com/servo/servo/pull/38152	(@leo030303, @xiaochengh, #38152)	Add dimension source attribute to HTMLImageElement (#38152)
      features; now support <source width> and <source height>
    - DONE https://github.com/servo/servo/pull/38112	(@minghuaw, #38112)	Script: Implement `TextDecoderStream` (#38112)
      features; implement TextDecoderStream
    - DONE https://github.com/servo/servo/pull/38346	(@lumiscosity, @Loirooriol, #38346)	layout: respect `image-rendering` on border images (#38346)
      features; ‘image-rendering’ now works on ‘border-image’ too
- DONE geometry
    - DONE https://github.com/servo/servo/pull/38082	(@yezhizhen, #38082)	servoshell: reduce duplication for conversion between physical/logical position/size (#38082)
      geometry; fixing bug class (see issue 37937)
- indexeddb
    - https://github.com/servo/servo/pull/37684	(@arihant2math, #37684)	[IndexedDB] Key ranges implementation (#37684)
      indexeddb
    - https://github.com/servo/servo/pull/38027	(@jdm, #38027)	IndexedDB: communicate transaction errors and async response data more precisely (#38027)
      indexeddb
    - https://github.com/servo/servo/pull/37682	(@arihant2math, #37682)	[IndexedDB] Adhere better to the specification for idb object store related operations (#37682)
      indexeddb
    - https://github.com/servo/servo/pull/38076	(@jdm, #38076)	indexeddb: Allow deleting unknown DBs. (#38076)
      indexeddb
    - https://github.com/servo/servo/pull/38078	(@jdm, #38078)	tests: Force a blank config directory for each WPT test run. (#38078)
      indexeddb
    - https://github.com/servo/servo/pull/38268	(@arihant2math, @jdm, #38268)	script: implement IDBKeyRange (#38268)
      indexeddb
    - https://github.com/servo/servo/pull/38269	(@arihant2math, #38269)	script: Update indexeddb serialization (#38269)
      indexeddb
    - https://github.com/servo/servo/pull/38278	(@arihant2math, #38278)	script: Implement converting values to indexeddb key ranges (#38278)
      indexeddb
- internals
    - https://github.com/servo/servo/pull/37819	(@spookyvision, #37819)	bhm: Add backtrace demangling (#37819)
      internals; background hang monitor now demangles backtraces
- DONE layout
    - DONE https://github.com/servo/servo/pull/37758	(@Loirooriol, #37758)	layout: Fix block SizeConstraint for replaced elements (#37758)
      layout; fix intrinsic sizing keywords in min/max-height of replaced elements
    - DONE https://github.com/servo/servo/pull/37814	(@Loirooriol, #37814)	layout: Only include quirks-mode.css in actual quirks mode (#37814)
      layout; fix limited-quirks mode
    - DONE https://github.com/servo/servo/pull/37831	(@Loirooriol, #37831)	script: Remove the quirk of flooring rowSpan by 1 (#37831)
      layout; fix quirks mode tables
    - DONE https://github.com/servo/servo/pull/37820	(@Loirooriol, #37820)	script: Only enforce rowSpan >= 1 in actual quirks mode (#37820)
      layout; fix limited-quirks mode tables
    - DONE https://github.com/servo/servo/pull/37837	(@Loirooriol, #37837)	layout: Implement `list-style-position` quirk (#37837)
      layout; quirks mode accuracy
    - SEE OTHER https://github.com/servo/servo/pull/37864	(@Loirooriol, #37864)	layout: Unify logic for laying out replaced and non-replaced in a BFC (#37864)
      layout perf; fix stretch keyword in block-level replaced elements around floats / see replaced caching
    - DONE https://github.com/servo/servo/pull/37917	(@Loirooriol, #37917)	layout: Require specific layout info in `BoxFragment::new()` (#37917)
      layout; fix clientWidth/clientHeight in for (inline?) grids
    - DONE https://github.com/servo/servo/pull/37981	(@Loirooriol, #37981)	layout: Lay out grid items with a consistent tentative block size (#37981)
      layout; fix layout of grid item contents
    - DONE https://github.com/servo/servo/pull/38007	(@leo030303, @Loirooriol, #38007)	layout: Fix bug where whitespace didn't have line decorations (#38007)
      layout; fix underlines (and other line decorations) on whitespace, very noticeable!
    - DONE https://github.com/servo/servo/pull/37315	(@shubhamg13, #37315)	renderer: Have the viewport meta element establish the initial zoom of new pages (#37315)
      layout; each page has its own initial pinch zoom (vs page zoom, see #38194)
    - DONE https://github.com/servo/servo/pull/38166	(@mrobinson, #38166)	compositor: Request reflow when doing a page zooming (#38166)
      layout; fix reflow when doing page zoom
    - SEE OTHER https://github.com/servo/servo/pull/38318	(@Loirooriol, #38318)	layout: Fix `depends_on_block_constraints` logic (#38318)
      perf layout; reduced cache misses when stretching flex items / fix stretching flex items
    - DONE https://github.com/servo/servo/pull/38290	(@Loirooriol, #38290)	layout: Include spanned gutters when laying out contents of table cell (#38290)
      layout; fix layout of table cell contents
- perf
    - https://github.com/servo/servo/pull/37832	(@mrobinson, #37832)	layout: Stop using Rayon in single-threaded mode (#37832)
      perf; more efficient in single-threaded mode
    - https://github.com/servo/servo/pull/37851	(@Loirooriol, @mrobinson, #37851)	layout: Add incremental box tree construction for table column (#37851)
      perf; incremental layout for table column boxes
    - https://github.com/servo/servo/pull/37850	(@Loirooriol, @mrobinson, #37850)	layout: Add incremental box tree construction for table cell (#37850)
      perf; incremental layout for table cell boxes
    - https://github.com/servo/servo/pull/37849	(@mrobinson, @Loirooriol, #37849)	layout: Add incremental box tree construction for table caption (#37849)
      perf; incremental layout for table caption boxes
    - https://github.com/servo/servo/pull/37751	(@mrobinson, @Loirooriol, @coding-joedow, #37751)	layout: Add a first pass at incremental box tree construction (#37751)
      perf; incremental box tree construction via layout damage
    - https://github.com/servo/servo/pull/37864	(@Loirooriol, #37864)	layout: Unify logic for laying out replaced and non-replaced in a BFC (#37864)
      layout perf; fix stretch keyword in block-level replaced elements around floats / see replaced caching
    - https://github.com/servo/servo/pull/37868	(@coding-joedow, #37868)	layout: Add incremental box tree construction for inline floats and abspos (#37868)
      perf; incremental layout for inline floats and abspos
    - https://github.com/servo/servo/pull/37866	(@coding-joedow, #37866)	layout: Add incremental box tree construction for inline atomics (#37866)
      perf; incremental layout for inline atomics
    - https://github.com/servo/servo/pull/37854	(@coding-joedow, #37854)	Layout: Continue support incremental box tree reconstruction for flex&taffy level box (#37854)
      perf; incremental layout for flex items and grid items
    - https://github.com/servo/servo/pull/37892	(@coding-joedow, #37892)	layout: Add incremental box tree construction for inline floats and abspos (#37892)
      perf; incremental layout for inline floats and abspos
    - https://github.com/servo/servo/pull/37941	(@mrobinson, @Loirooriol, #37941)	layout: Store most anonymous pseudo-elements in box slots (#37941)
      perf; supporting change for incremental layout
    - https://github.com/servo/servo/pull/37963	(@Narfinger, #37963)	OHOS CI allow profile (#37963)
      perf; bencher results are now split by build profile
    - https://github.com/servo/servo/pull/37897	(@Loirooriol, #37897)	layout: Unify layout logic for replaced and non-replaced floats&atomics (#37897)
      perf; see replaced caching
    - https://github.com/servo/servo/pull/37954	(@coding-joedow, #37954)	layout: remove the finished animations to avoid to mark their dom nodes dirty (#37954)
      perf; avoid reflow after animations
    - https://github.com/servo/servo/pull/37957	(@mrobinson, @Loirooriol, #37957)	layout: Skip box tree construction when possible (#37957)
      perf; initial incremental box tree construction by skipping rebuild
    - https://github.com/servo/servo/pull/37962	(@Loirooriol, #37962)	layout: Unify layout logic for replaced and non-replaced flex items (#37962)
      perf; see replaced caching
    - https://github.com/servo/servo/pull/37938	(@Loirooriol, #37938)	layout: Move `BoxFragment`'s block-level info into a dedicated struct (#37938)
      perf; reduced layout memory usage
    - https://github.com/servo/servo/pull/37943	(@Loirooriol, #37943)	layout: Unify layout logic for replaced and non-replaced abspos (#37943)
      perf; see replaced caching
    - https://github.com/servo/servo/pull/37971	(@Loirooriol, #37971)	layout: Remove `IndependentNonReplacedContents` (#37971)
      perf; we now cache the layout results of replaced boxes
    - https://github.com/servo/servo/pull/37985	(@Loirooriol, #37985)	layout: Unify layout logic for replaced and non-replaced grid items (#37985)
      perf; see replaced caching
    - https://github.com/servo/servo/pull/38018	(@jdm, #38018)	script: Minimize layout queries for window scroll offsets. (#38018)
      perf; reduce layout queries when firing mouse/pointer events
    - https://github.com/servo/servo/pull/38057	(@coding-joedow, #38057)	layout: dirty parent node with NodeDamage::ContentOrHeritage when text content changed (#38057)
      perf; more precise incremental layout for text content changes
    - https://github.com/servo/servo/pull/38097	(@sagudev, #38097)	canvas: Use stored transform instead of querying canvas paint thread (#38097)
      perf; reduce ipc to canvas paint thread
    - https://github.com/servo/servo/pull/38113	(@yezhizhen, #38113)	webdriver: Reduce IPC for viewport boundary check (#38113)
      webdriver perf; reduce ipc in webdriver pointerMove and scroll
    - https://github.com/servo/servo/pull/38196	(@jschwe, #38196)	dom: Optimize IFrameCollection::validate (#38196)
      perf; 30% of script time in DOM heavy scenarios
    - https://github.com/servo/servo/pull/38198	(@coding-joedow, #38198)	script: Use `NodeDamage::ContentOrHeritage` for slot changes (#38198)
      perf; more precise incremental layout for shadow dom slot changes
    - https://github.com/servo/servo/pull/38245	(@lumiscosity, #38245)	Remove unused resources (#38245)
      perf; reduce binary size
    - https://github.com/servo/servo/pull/38229	(@lumiscosity, #38229)	Optimize PNG images in resources folder (#38229)
      perf; reduce binary size
    - https://github.com/servo/servo/pull/38222	(@stevennovaryo, #38222)	script: Batch `scroll` event firing (#38222)
      perf; batch `scroll` events
    - https://github.com/servo/servo/pull/38199	(@coding-joedow, #38199)	layout: optimize the propagation and cleanup of RestyleDamage (#38199)
      perf; more precise incremental layout propagation to descendants
    - https://github.com/servo/servo/pull/38084	(@coding-joedow, #38084)	layout: Add incremental box tree construction for inline boxes (#38084)
      perf; incremental layout for inline boxes
    - https://github.com/servo/servo/pull/38059	(@coding-joedow, #38059)	layout: Correctly marking box damage when text-related style changed (#38059)
      perf; fix incremental layout error when ‘white-space’ changes
    - https://github.com/servo/servo/pull/38332	(@lumiscosity, #38332)	Losslessly optimize Android resources (#38332)
      perf; reduce binary size
    - https://github.com/servo/servo/pull/38318	(@Loirooriol, #38318)	layout: Fix `depends_on_block_constraints` logic (#38318)
      perf layout; reduced cache misses when stretching flex items / fix stretching flex items
    - https://github.com/servo/servo/pull/38349	(@Loirooriol, #38349)	layout: Make a couple tracing reflect what they actually trace (#38349)
      perf; see replaced caching
- servoshell
    - https://github.com/servo/servo/pull/37794	(@MichaelMcDonnell, #37794)	Add alt-d shortcut to select address bar text (#37794)
      servoshell
    - https://github.com/servo/servo/pull/37839	(@MichaelMcDonnell, #37839)	servoshell: Select address bar text on click (#37839)
      servoshell
    - https://github.com/servo/servo/pull/38038	(@MichaelMcDonnell, #38038)	Add Linux .desktop file (#38038)
      servoshell; now has a desktop file and window name, so it can be pinned to taskbar
    - https://github.com/servo/servo/pull/37982	(@yezhizhen, #37982)	servoshell: Fix scroll speed for Desktop (#37982)
      servoshell; more ergonomic scrolling with mouse wheel
- upgrades
    - https://github.com/servo/servo/pull/37822	(@Loirooriol, #37822)	Upgrade Stylo to 2025-07-01 (#37822)
      upgrades
    - https://github.com/servo/servo/pull/37736	(@simonwuelker, #37736)	deps: Bump `html5ever` and friends to version `0.35.0` (#37736)
      upgrades
    - https://github.com/servo/servo/pull/38119	(@sagudev, #38119)	servoshell: Update egui to 0.32 (#38119)
      upgrades; will help with browser menus and context menus
    - https://github.com/servo/servo/pull/38351	(@Loirooriol, #38351)	build(deps): bump Stylo to servo/stylo#215 (#38351)
      upgrades; also mention that we fixed bustage for third-party consumers of stylo (@nicoburns, stylo#215)
- vello
    - https://github.com/servo/servo/pull/37630	(@sagudev, #37630)	canvas: Do not draw arc/ellipse with small sweep (#37630)
      vello; preparing to migrate to vello for gpu-accelerated 2d canvas (see issue 30636, 38345)
    - https://github.com/servo/servo/pull/37863	(@sagudev, #37863)	canvas: Use snapshot in canvas backends (#37863)
      vello; more preparation for vello
    - https://github.com/servo/servo/pull/37842	(@sagudev, #37842)	canvas: Join `Path` and `PathBuilder` into `Path` (#37842)
      vello; more preparation for vello
    - https://github.com/servo/servo/pull/37668	(@sagudev, @mrobinson, #37668)	canvas: Properly bound all image pattern axis by inserting clip (#37668)
      vello; more preparation for vello
    - https://github.com/servo/servo/pull/37967	(@sagudev, #37967)	canvas: Use wrapped `kurbo::BezPath` for path everywhere (#37967)
      vello; path building now done in script
    - https://github.com/servo/servo/pull/36821	(@sagudev, #36821)	canvas: Add vello backend (#36821)
      vello; initial support for gpu-accelerated 2d canvas
    - https://github.com/servo/servo/pull/38264	(@sagudev, #38264)	canvas: Make pixel obtaining methods take &mut GenericDrawTarget (#38264)
      vello; more preparation for vello
    - https://github.com/servo/servo/pull/38279	(@sagudev, #38279)	canvas: Move peniko/kurbo conversions in separate file (#38279)
      vello; more preparation for vello
    - https://github.com/servo/servo/pull/38282	(@sagudev, #38282)	canvas: Add vello_cpu backend (#38282)
      vello; added non-gpu backend that also uses vello
    - https://github.com/servo/servo/pull/38312	(@sagudev, #38312)	canvas: Gate raqote backend behind feature (enabled for now) (#38312)
      vello; more preparation for vello
    - https://github.com/servo/servo/pull/38310	(@sagudev, #38310)	canvas: Make 2D context state creation failable and use `dom_canvas_backend` pref for backend selection (#38310)
      vello; more preparation for vello
    - https://github.com/servo/servo/pull/38336	(@sagudev, #38336)	canvas: Use `create_similar_draw_target` for recreate (#38336)
      vello; more preparation for vello
- webdriver
    - https://github.com/servo/servo/pull/37783	(@yezhizhen, #37783)	[WebDriver] Implement XPath Locator Strategy (#37783)
      webdriver
    - https://github.com/servo/servo/pull/37712	(@yezhizhen, #37712)	webdriver: Greatly improve execution speed for all tests using `SetWindowSize` (#37712)
      webdriver; perf
    - https://github.com/servo/servo/pull/37826	(@PotatoCP, #37826)	webdriver: enable getting closed shadow root (#37826)
      webdriver
    - https://github.com/servo/servo/pull/37498	(@PotatoCP, @sagudev, #37498)	CI: WebDriver test on try (#37498)
      webdriver; can now run webdriver test suite with explicit mach try <wd|webdriver>
    - https://github.com/servo/servo/pull/37669	(@longvatrong111, #37669)	Move webdriver actions commands to servoshell (#37669)
      webdriver; consistent command order / rearchitected the server to be managed by servoshell instead of libservo
    - https://github.com/servo/servo/pull/37873	(@yezhizhen, #37873)	servoshell: Set `dom_testing_html_input_element_select_files_enabled` when WebDriver is enabled (#37873)
      webdriver; work towards running webdriver test suite
    - https://github.com/servo/servo/pull/37908	(@PotatoCP, #37908)	Webdriver: Keyboard Action use `webview::notify_input_event` instead of directly sent to constellation (#37908)
      webdriver; consistent command order
    - https://github.com/servo/servo/pull/37913	(@longvatrong111, #37913)	webdriver: Implement support for simple dialogs (#37913)
      webdriver; add commands for accept alert, dismiss alert, get alert text
    - https://github.com/servo/servo/pull/37663	(@longvatrong111, @mrobinson, #37663)	webdriver: Evaluate script commands via the `WebView` API in servoshell (#37663)
      webdriver; consistent command order
    - https://github.com/servo/servo/pull/37911	(@PotatoCP, #37911)	Webdriver: Send Keys use `webview::notify_input_event` (#37911)
      webdriver; consistent command order
    - https://github.com/servo/servo/pull/38058	(@yezhizhen, #38058)	script: Improve `webdriver_handler::get_element_in_view_center_point` (#38058)
      webdriver; fix PointerMove see issue 38042
    - https://github.com/servo/servo/pull/38095	(@yezhizhen, #38095)	webdriver: improve perform pointermove & wheel actions with more accurate coordinates (#38095)
      webdriver; fix PointerMove see issue 38042
    - https://github.com/servo/servo/pull/37950	(@longvatrong111, @jdm, #37950)	Webdriver GoBack and GoForward commands wait for navigation complete (#37950)
      webdriver; fix navigation on Back and Forward
    - https://github.com/servo/servo/pull/37935	(@longvatrong111, #37935)	webdriver: Element click waits for navigation complete (#37935)
      webdriver; fix navigation on Element Click
    - https://github.com/servo/servo/pull/38113	(@yezhizhen, #38113)	webdriver: Reduce IPC for viewport boundary check (#38113)
      webdriver perf; reduce ipc in webdriver pointerMove and scroll
    - https://github.com/servo/servo/pull/38079	(@PotatoCP, #38079)	WebDriver: Implement some missing steps of wait for navigation to complete (#38079)
      webdriver; fix navigation on command
    - https://github.com/servo/servo/pull/38140	(@longvatrong111, #38140)	webdriver: Implement send alert text (#38140)
      webdriver; implement Send Alert Text command
    - https://github.com/servo/servo/pull/38160	(@yezhizhen, #38160)	WebDriver: Wait focus to complete when switching window (#38160)
      webdriver; fix Switch To Window <https://w3c.github.io/webdriver/#switch-to-window>
    - https://github.com/servo/servo/pull/38212	(@yezhizhen, #38212)	Remove Webdriver Server's access to Constellation (#38212)
      webdriver; consistent command order
    - https://github.com/servo/servo/pull/38189	(@PotatoCP, #38189)	webdriver: Implement element send keys command for non-typeable form control (#38189)
      webdriver; improve Element Send Keys
    - https://github.com/servo/servo/pull/38208	(@PotatoCP, @yezhizhen, @jdm, #38208)	webdriver: Implement element clear (#38208)
      webdriver; implement Element Clear
    - https://github.com/servo/servo/pull/38314	(@yezhizhen, #38314)	cargo: Remove last traces of webdriver from libservo (#38314)
      webdriver; consistent command order
    - https://github.com/servo/servo/pull/38329	(@longvatrong111, #38329)	Implement webdriver element in view (#38329)
      webdriver; improve Element Click
    - https://github.com/servo/servo/pull/38234	(@longvatrong111, #38234)	Rework on webdriver wait for navigation complete (#38234)
      webdriver; fix navigation on command
    - https://github.com/servo/servo/pull/37410	(@yezhizhen, #37410)	webdriver: Keep constellation alive and Open new top-level browsing context with new session request when none is open (#37410)
      webdriver
- DONE windowing
    - DONE https://github.com/servo/servo/pull/37812	(@yezhizhen, #37812)	webdriver: Get the window position as well as the size when resolving "Get Window Rect" (#37812)
      windowing; issue 37804
    - DONE https://github.com/servo/servo/pull/37879	(@yezhizhen, @mrobinson, #37879)	embedder: Improve documentation for various places that talk about "available screen size" (#37879)
      windowing; issue 37878
    - DONE https://github.com/servo/servo/pull/37856	(@yezhizhen, #37856)	Rename original `window_resizeTo.html` to `window_resize_event.html` & Fix wrong usage of `innerHeight` & add new test (#37856)
      windowing; issue 37824
    - DONE https://github.com/servo/servo/pull/37848	(@yezhizhen, #37848)	servoshell: Make `fn request_resize` resize window w.r.t. outer_size accurately (#37848)
      windowing; issue 37804
    - DONE https://github.com/servo/servo/pull/37893	(@yezhizhen, #37893)	servoshell: Use DeviceIndependentPixel for WebDriver Rect related requests (#37893)
      windowing; issue 37804
    - DONE https://github.com/servo/servo/pull/37934	(@yezhizhen, #37934)	servoshell: Fix `screen_geometry` for headed_window (#37934)
      windowing; issue 37824
    - DONE https://github.com/servo/servo/pull/37961	(@yezhizhen, #37961)	servoshell: Consider both OS decoration width and height when resizing (#37961)
      windowing; fix resize errors with decorations
    - DONE https://github.com/servo/servo/pull/37960	(@yezhizhen, @mrobinson, #37960)	script: Get the window rectangle from the `WebViewDelegate` instead of via the compositor (#37960)
      windowing; window size/position operations now go directly to embedder
    - DONE https://github.com/servo/servo/pull/38020	(@yezhizhen, #38020)	script: Get the screen metrics from the `WebViewDelegate` instead of via the compositor (#38020)
      windowing; screen size operations now go directly to embedder
    - DONE https://github.com/servo/servo/pull/38110	(@yezhizhen, #38110)	doc: Add doc for compositor/webview/embedder related to window/rect/inner_size/rendering_context (#38110)
      windowing; issues #38089, #38090, #37978, #38093
    - DONE https://github.com/servo/servo/pull/38174	(@yezhizhen, #38174)	servoshell: Consider window decorations when handling resize requests from web content (#38174)
      windowing; issue 38093
    - DONE https://github.com/servo/servo/pull/38307	(@yezhizhen, #38307)	servoshell: Remove redundant `WindowEvent::Resized` handler (#38307)
      windowing; issue 38255
- windows
    - https://github.com/servo/servo/pull/37975	(@yezhizhen, @jdm, #37975)	servoshell: Enable headless event loop for Windows (#37975)
      windows; can now run in headless mode on windows
    - https://github.com/servo/servo/pull/38028	(@yezhizhen, #38028)	mach (Windows): make `vswhere.exe` work properly (#38028)
      windows; fix building on windows 11
-->

Servo has smashed its record again in July, with **367 pull requests** landing in our nightly builds!
This includes several new web platform features:

- **APNG** and **WebP animated images**, in addition to GIF (@rayguo17, #37637)
- **&lt;source width>** and **&lt;source height>** (@leo030303, @xiaochengh, #38152)
- **‘image-rendering’ property** now affects **‘border-image’** (@lumiscosity, @Loirooriol, #38346)
- **TextDecoderStream** (@minghuaw, #38112)
- **replace() method** on **CSSStyleSheet** (@stevennovaryo, #38244)
- **texImage3D() method** on **WebGL2RenderingContext** (@wusyong, #37718)
- **convertToBlob()** and **transferToImageBitmap() methods** on **OffscreenCanvas** (@tharkum, #37786, #37880)
- **adoptedStyleSheets property** on **Document** and **ShadowRoot**, with `--pref dom_adoptedstylesheet_enabled` (@stevennovaryo, #38163)
- **ImageBitmap** no longer requires `--enable-experimental-web-platform-features` (@tharkum, #38050)

**sessionStorage** is now isolated between webviews, and copied to new webviews with the same `opener` (@janvarga, #37803).

## Layout changes

Like many browsers, Servo has two kinds of zoom: **page zoom** affects the size of the viewport, while **pinch zoom** does not (@shubhamg13, #38194).
**Page zoom** now correctly triggers reflow (@mrobinson, #38166), and **pinch zoom** is now reset to the viewport meta config when navigating (@shubhamg13, #37315).

**‘text-decoration[-line]’ now applies to whitespace** (@leo030303, @Loirooriol, #38007), and we’ve also fixed several layout bugs around **grid item contents** (@Loirooriol, #37981), **table cell contents** (@Loirooriol, #38290), **quirks mode** (@Loirooriol, #37814, #37831, #37820, #37837), **clientWidth** and **clientHeight** queries of grid layouts (@Loirooriol, #37917), and **‘min-height’** and **‘max-height’** of replaced elements (@Loirooriol, #37758).

## 2D graphics

**&lt;canvas>** is key to programmable graphics on the web, with Servo supporting WebGPU, WebGL, and 2D canvas contexts.
But the **general-purpose 2D graphics** routines that power Servo’s 2D canvases are potentially useful for a lot more than &lt;canvas>: **font rendering** is bread and butter for Servo, but **SVG rendering** is only minimally supported right now, and **PDF output** is not yet implemented at all.

Those features have one thing in common: they require things that WebRender can’t yet do.
**WebRender** does one thing and does it well: rasterise the layouts of the web, really fast, by [using the GPU as much as possible](https://hacks.mozilla.org/2017/10/the-whole-web-at-maximum-fps-how-webrender-gets-rid-of-jank/).
Font rendering and SVG rendering both involve rasterising arbitrary paths, which currently has to be done outside WebRender, and PDF output is out of scope entirely.

The more code we can share between these tasks, the better we can make that code, and the smaller we can make Servo’s binary sizes ([#38022](https://github.com/servo/servo/issues/38022)).
We’ve started by moving 2D-&lt;canvas>-specific state out of the `canvas` crate (@sagudev, #38098, #38114, #38164, #38214), which has in turn allowed us to modernise it with **new backends based on [Vello](https://github.com/linebender/vello)** (@EnnuiL, @sagudev, [#30636](https://github.com/servo/servo/issues/30636), [#38345](https://github.com/servo/servo/issues/38345)).

<!-- TODO: write about vello patches -->

## What is a pixel?

Many recent Servo bugs have been related to our handling of **viewport**, **window**, and **screen coordinate spaces** ([#36817](https://github.com/servo/servo/issues/36817), [#37804](https://github.com/servo/servo/issues/37804), [#37824](https://github.com/servo/servo/issues/37824), [#37878](https://github.com/servo/servo/issues/37878), [#37978](https://github.com/servo/servo/issues/37978), [#38089](https://github.com/servo/servo/issues/38089), [#38090](https://github.com/servo/servo/issues/38090), [#38093](https://github.com/servo/servo/issues/38093), [#38255](https://github.com/servo/servo/issues/38255)).
Symptoms of these bugs include **bad hit testing** (e.g. links that can’t be clicked), **inability to scroll** to the end of the page, or **graphical glitches** like disappearing browser UI or black bars.

Windows rarely take up the whole screen, viewports rarely take up the whole window due to window decorations, and when different units come into play, like CSS `px` vs device pixels, a more systematic approach is needed.
We built [**euclid**](https://docs.rs/euclid/0.22.11/euclid/) to solve these problems in a strongly typed way within Servo, but beyond the viewport, we need to convert between euclid types and the geometry types provided by the embedder, the toolkit, the platform, or WebDriver, which creates opportunities for errors.

Embedders are now the single source of truth for **window rects** and **screen sizes** (@yezhizhen, @mrobinson, #37960, #38020), and we’ve fixed incorrect coordinate handling in [**Get Window Rect**](https://w3c.github.io/webdriver/#get-window-rect), [**Set Window Rect**](https://w3c.github.io/webdriver/#set-window-rect) (@yezhizhen, #37812, #37893), **resizeTo()** (@yezhizhen, #37848), **screenX**, **screenY**, **screenLeft**, **screenTop** (@yezhizhen, #37934), and in **servoshell** (@yezhizhen, #37961, #38174, #38307, #38082).
We’ve also improved the Web Platform Tests (@yezhizhen, #37856) and clarified our docs (@yezhizhen, @mrobinson, #37879, #38110) in these areas.

## Donations

Thanks again for your generous support!
We are now receiving **4691 USD/month** (+5.0% <!-- (+1.3% without thanks.dev) --> over June) in recurring donations.
This helps cover the cost of our [self-hosted](https://ci0.servo.org) [CI](https://ci1.servo.org) [runners](https://ci2.servo.org) and one of our [latest Outreachy interns](https://www.outreachy.org/alums/2025-06/#:~:text=Servo)!

Keep an eye out for [further improvements to our CI system](https://github.com/servo/servo/issues/38141) in the coming months, including [**ten-minute WPT builds**](https://github.com/servo/ci-runners/issues/21) and our new proposal for [**dedicated benchmarking runners**](https://github.com/servo/project/issues/160), all thanks to your support.

Servo is also on [thanks.dev](https://thanks.dev), and already **22 GitHub users** (−3 from June) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 4691 / 10000); padding-left: 0.5em;"><strong>4691</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 4691 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="4691" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
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
