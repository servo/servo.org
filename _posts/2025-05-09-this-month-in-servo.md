---
layout:     post
tags:       blog
title:      "This month in Servo: and more!"
date:       2025-05-09
summary:    ao!! wrrrrao!!
categories:
---

<!--
- donations
    - 1954.40/month opencollective
    - 2710.00/month github
    - 24 donors thanks.dev
- ai policy
- wpt
    - dashboard now has subtests
    - `fromDate = "2025-03-10"`
    - `toDate = "2025-04-30"`
-->

<!--
wpt dashboard analysis
>>> top deltas (score, pp):
/content-security-policy/ (50.9pp to 53.5%)
/trusted-types/ (47.2pp to 47.2%)
/css/css-text/ (17.9pp to 65.3%)
/css/css-sizing/ (10.3pp to 62.8%)
/streams/ (8.2pp to 18.8%)
/css/cssom/ (6.6pp to 72.2%)
All WPT tests (5.6pp to 62.0%)
/shadow-dom/ (5.2pp to 52.1%)
/css/CSS2/box-display/ (4.4pp to 92.2%)
/css/css-align/ (4.0pp to 72.7%)
/css/ (3.1pp to 69.2%)
/css/css-grid/ (3.1pp to 44.3%)
/css/css-flexbox/ (2.0pp to 78.4%)
/css/css-position/ (1.0pp to 52.8%)
/css/CSS2/tables/ & /css/css-tables/ (0.2pp to 92.2%)
/css/CSS2/positioning/ (0.2pp to 94.5%)
/css/CSS2/ (0.1pp to 85.0%)
/css/CSS2/linebox/ (0.0pp to 96.9%)
/css/CSS2/abspos/ (0.0pp to 98.2%)
/css/CSS2/floats/ (0.0pp to 91.5%)
/css/CSS2/floats-clear/ (0.0pp to 93.9%)
/css/CSS2/margin-padding-clear/ (0.0pp to 99.0%)
/css/CSS2/normal-flow/ (0.0pp to 96.5%)
/gamepad/ (0.0pp to 70.8%)
/WebCryptoAPI/ (0.0pp to 39.2%)
/webxr/ (0.0pp to 55.8%)
>>> top deltas (subtests, pp):
/shadow-dom/ (70.0pp to 77.9%)
/trusted-types/ (57.8pp to 57.8%)
/content-security-policy/ (54.0pp to 54.8%)
/streams/ (31.9pp to 68.1%)
/css/css-text/ (20.4pp to 57.6%)
/css/CSS2/linebox/ (5.5pp to 84.8%)
All WPT tests (4.6pp to 87.4%)
/css/CSS2/box-display/ (4.4pp to 92.2%)
/css/css-sizing/ (3.5pp to 72.9%)
/css/cssom/ (3.3pp to 84.7%)
/css/css-flexbox/ (3.1pp to 62.7%)
/css/css-grid/ (2.7pp to 44.3%)
/css/ (2.6pp to 63.0%)
/css/css-align/ (2.2pp to 80.0%)
/css/CSS2/ (0.6pp to 86.6%)
/css/CSS2/tables/ & /css/css-tables/ (0.3pp to 87.2%)
/css/css-position/ (0.2pp to 62.9%)
/css/CSS2/positioning/ (0.2pp to 94.5%)
/css/CSS2/abspos/ (0.0pp to 96.6%)
/css/CSS2/floats/ (0.0pp to 87.8%)
/css/CSS2/floats-clear/ (0.0pp to 92.2%)
/css/CSS2/margin-padding-clear/ (0.0pp to 99.0%)
/css/CSS2/normal-flow/ (0.0pp to 96.2%)
/gamepad/ (0.0pp to 93.0%)
/WebCryptoAPI/ (0.0pp to 60.7%)
/webxr/ (0.0pp to 64.0%)
-->

<!--
- api
    - https://github.com/servo/servo/pull/36225	(@simonwuelker, #36225)	script: Implement input preprocessing for URLPatterns (#36225)
      api
    - SEEN https://github.com/servo/servo/pull/36354	(@TimvdLippe, #36354)	Run Trusted Types tests (#36354)
      api; trusted types
    - SEEN https://github.com/servo/servo/pull/36355	(@TimvdLippe, #36355)	Stub out Trusted Types interfaces (#36355)
      api; trusted types
    - https://github.com/servo/servo/pull/36391	(@simonwuelker, #36391)	Split up the URLPattern implementation (#36391)
      api
    - https://github.com/servo/servo/pull/36382	(@simonwuelker, #36382)	Create a parser for URLPatterns (#36382)
      api
    - https://github.com/servo/servo/pull/36385	(@gterzian, #36385)	Streams: add an underlying sink type (#36385)
      api; streams
    - https://github.com/servo/servo/pull/36362	(@simonwuelker, #36362)	Add a tokenizer for URLPatterns (#36362)
      api
    - SEEN https://github.com/servo/servo/pull/36422	(@TimvdLippe, #36422)	Implement attribute and property lookup for Trusted Types (#36422)
      api; trusted types
    - SEEN https://github.com/servo/servo/pull/36454	(@TimvdLippe, @jdm, #36454)	Implement "Create a Trusted Type" algorithm (#36454)
      api; start of trusted types
    - SEEN https://github.com/servo/servo/pull/36409	(@TimvdLippe, @jdm, #36409)	Update FetchTaskTarget to propagate CSP violations. (#36409)
      api; trusted types
    - https://github.com/servo/servo/pull/36308	(@jerensl, #36308)	Support optional message for dataclone error (#36308)
      api; streams
    - SEEN https://github.com/servo/servo/pull/36363	(@TimvdLippe, @jdm, #36363)	Implement CSP check for Trusted Types (#36363)
      api; trusted types
    - SEEN https://github.com/servo/servo/pull/36511	(@TimvdLippe, #36511)	Gate `window.trustedTypes` behind flag (#36511)
      api; trusted types
    - https://github.com/servo/servo/pull/36560	(@sidntrivedi012, @jdm, #36560)	content/dom: set navigator.onLine attribute to `true` (#36560)
      api; fixes pinterest
    - SEEN https://github.com/servo/servo/pull/36596	(@TimvdLippe, @jdm, #36596)	Implement trusted types url setter (#36596)
      api; trusted types
- architecture
    - https://github.com/servo/servo/pull/36341	(@mrobinson, #36341)	constellation: Rename messages sent to the `Constellation` (#36341)
      architecture
    - https://github.com/servo/servo/pull/36364	(@mrobinson, #36364)	Move `ScriptToConstellationMsg` to `constellation_traits` (#36364)
      architecture
    - https://github.com/servo/servo/pull/36372	(@mrobinson, #36372)	`compositing`: Combine `webrender_traits` and `compositing_traits` (#36372)
      architecture
    - https://github.com/servo/servo/pull/36284	(@simonwuelker, #36284)	Unify the way html5ever and xml5ever block on script elements (#36284)
      architecture; towards non-utf-8 encoding support
    - https://github.com/servo/servo/pull/36582	(@mrobinson, #36582)	compositing: Remove `windowing.rs` and making `compositing` private (#36582)
      architecture; no more public api in compositing
    - https://github.com/servo/servo/pull/36613	(@mrobinson, #36613)	layout: Combine `layout_2020` and `layout_thread_2020` into a crate called `layout` (#36613)
      architecture legacy
    - https://github.com/servo/servo/pull/36574	(@mrobinson, #36574)	compositing: Rename `WebView` to `WebViewRenderer` (#36574)
      architecture
- build
    - https://github.com/servo/servo/pull/36070	(@jschwe, #36070)	mach: Fix cross-compiling from windows to non windows (#36070)
      build
    - https://github.com/servo/servo/pull/36564	(@jschwe, #36564)	uv: Use native-tls (#36564)
      build
- compat
    - https://github.com/servo/servo/pull/36338	(@sakupi01, #36338)	Fix: Add support for stylesheet MIME type quirk in quirks mode (#36338)
      compat
- compositor
    - https://github.com/servo/servo/pull/36662	(@mrobinson, #36662)	compositor: Tick animations for an entire WebView at once (#36662)
      compositor; refresh driver
- DONE crash
- css
    - https://github.com/servo/servo/pull/36272	(@mrobinson, @Loirooriol, #36272)	script: Create `CSSStyleOwner::Null` for `getComputedStyle` (#36272)
      css; marker pseudo
    - https://github.com/servo/servo/pull/36317	(@mrobinson, #36317)	layout: Add initial support for the `::marker` pseudo-element (#36317)
      css; internal support; no ‘content’ yet
    - https://github.com/servo/servo/pull/35978	(@yezhizhen, #35978)	Fix transition toggle & cancellation & delay (#35978)
      css; transitions
    - https://github.com/servo/servo/pull/36374	(@ToBinio, @mrobinson, @jdm, #36374)	layout: Scale images in `image_set` by their specified resolution (#36374)
      css; image-set()
    - https://github.com/servo/servo/pull/36430	(@Loirooriol, #36430)	layout: Let getComputedStyle resolve auto min size as 0px when needed (#36430)
      css; cssom fix
    - https://github.com/servo/servo/pull/36568	(@mrobinson, @Loirooriol, #36568)	layout: Throw away nested marker elements instead of storing them in a `BoxSlot` (#36568)
      css; marker pseudo
    - https://github.com/servo/servo/pull/36595	(@Loirooriol, #36595)	layout: Implement `justify-self` for block-level boxes (#36595)
      css layout
- custom-protocol
    - https://github.com/servo/servo/pull/36656	(@Legend-Master, @mrobinson, #36656)	Initial support for marking custom protocol secure (#36656)
      custom-protocol
- dev
    - https://github.com/servo/servo/pull/36384	(@sagudev, #36384)	script: copy include! files from script_bindings to script's OUT_DIR (#36384)
      dev; fixes rust-analyzer in script
- DONE devtools
- DONE editing
- DONE? embedding
    - DONE https://github.com/servo/servo/pull/36276	(@mrobinson, #36276)	libservo: Remove a couple `EmbedderMethods` (#36276)
      embedding
    - DONE https://github.com/servo/servo/pull/36223	(@mrobinson, #36223)	libservo: Start moving `WindowMethods` to `WebViewDelegate` (#36223)
      embedding
    - DONE https://github.com/servo/servo/pull/36312	(@mrobinson, #36312)	constellation: Stop assuming that the viewport is shared by all WebViews (#36312)
      embedding; per-webview dpi and zoom
    - DONE https://github.com/servo/servo/pull/36400	(@mrobinson, #36400)	libservo: Move animation tracking from `WindowMethods` to delegates (#36400)
      embedding
    - SKIP? https://github.com/servo/servo/pull/36420	(@mrobinson, #36420)	libservo: Move `EventLooperWaker` from `webxr_traits` to `embedder_traits` (#36420)
      embedding
    - SKIP? https://github.com/servo/servo/pull/36443	(@mrobinson, #36443)	compositor: Unify the cross process and in-process API (#36443)
      embedding; working towards more robust embedding that can destroy and recreate servo instances
    - SKIP? https://github.com/servo/servo/pull/36484	(@mrobinson, #36484)	compositing: Send `CompositorDisplayListInfo` as bytes to compositor (#36484)
      embedding; related to unified compositor
    - DONE https://github.com/servo/servo/pull/36483	(@mrobinson, #36483)	libservo: Create a `WebViewBuilder` class to construct `WebView`s (#36483)
      embedding
    - SKIP? https://github.com/servo/servo/pull/36440	(@mrobinson, #36440)	libservo: Add a very simple `libservo` API test (#36440)
      embedding
    - DONE https://github.com/servo/servo/pull/36419	(@mrobinson, @shubhamg13, #36419)	libservo: Make zooming and HiDPI scaling work per-`WebView` (#36419)
      embedding; per-webview dpi and zoom
    - -https://github.com/servo/servo/pull/36485	(@mrobinson, #36485)	libservo: Remove the unused `multiview` feature (#36485)
      embedding; multiview
    - SKIP? https://github.com/servo/servo/pull/36543	(@mrobinson, #36543)	compositor: Unify the cross process and in-process API (#36543)
      embedding; related to unified compositor
    - SKIP? https://github.com/servo/servo/pull/36533	(@mrobinson, #36533)	Revert "compositor: Unify the cross process and in-process API (#36443)" (#36533)
      embedding; related to unified compositor
    - DONE https://github.com/servo/servo/pull/36549	(@mrobinson, #36549)	libservo: Expose a `ServoBuilder` (#36549)
      embedding
    - SKIP? https://github.com/servo/servo/pull/36532	(@mrobinson, #36532)	libservo: Allow running more than one Servo test in a run (#36532)
      embedding; testing
    - DONE https://github.com/servo/servo/pull/36413	(@yezhizhen, #36413)	Move click event trigger from embedding layer to `ScriptThread` (#36413)
      embedding; reworking input for click events
- DONE forms
- DONE gc
- DONE html
- DONE incremental
- input
    - https://github.com/servo/servo/pull/36619	(@yezhizhen, #36619)	Rework `ScriptThread::handle_input_event` for behaviour and performance (#36619)
      input; fixes erroneous click event on right click
- layout
    - https://github.com/servo/servo/pull/36278	(@Loirooriol, #36278)	layout: Allow collapsing bottom margins with any indefinite block size (#36278)
      layout
    - https://github.com/servo/servo/pull/36298	(@Barry-dE, #36298)	Fix:  `display: inline-grid` considered an atomic inline (#36298)
      layout; fix atomic inlines
    - https://github.com/servo/servo/pull/36316	(@Loirooriol, #36316)	Enable layout_grid_enabled pref for all tests (#36316)
      layout
    - https://github.com/servo/servo/pull/36174	(@reesmichael1, #36174)	fix: root element not establishing stacking context (#35390) (#36174)
      layout; fix stacking contexts
    - https://github.com/servo/servo/pull/36311	(@Loirooriol, #36311)	layout: Improve style conversion for Taffy (#36311)
      layout; grid
    - https://github.com/servo/servo/pull/36288	(@Loirooriol, #36288)	layout: Restrict stretch alignment to flex items with computed auto size (#36288)
      layout; flex
    - https://github.com/servo/servo/pull/36469	(@Loirooriol, #36469)	layout: Enforce min-content min main size of flex-level tables (#36469)
      layout; tables in flex
    - https://github.com/servo/servo/pull/36518	(@Loirooriol, #36518)	layout: Floor the max-content size by the min-content size (#36518)
      layout crash
    - https://github.com/servo/servo/pull/36571	(@Loirooriol, #36571)	layout: Always floor the max-content size by the min-content size (#36571)
      layout crash
    - https://github.com/servo/servo/pull/36595	(@Loirooriol, #36595)	layout: Implement `justify-self` for block-level boxes (#36595)
      css layout
- DONE legacy
- multiprocess
    - https://github.com/servo/servo/pull/36329	(@webbeef, #36329)	Prevent zombie processes in multi-process mode. (#36329)
      multiprocess
    - https://github.com/servo/servo/pull/35863	(@webbeef, #35863)	Make the memory reporting multi-process aware (#35863)
      multiprocess
- net
    - https://github.com/servo/servo/pull/36227	(@simonwuelker, #36227)	Refuse to provide partial response from earlier ranged request to API that did not make a range request (#36227)
      net
    - https://github.com/servo/servo/pull/36390	(@sebsebmc, #36390)	fix: meta referrer updating to follow spec (#36390)
      net
    - https://github.com/servo/servo/pull/36455	(@sebsebmc, #36455)	Manually concatenate ACRH headers to not include a space (#36455)
      net; cors fix
    - DONE https://github.com/servo/servo/pull/36393	(@sebsebmc, #36393)	Handle HTTP Refresh header (#36393)
      api net
    - DONE https://github.com/servo/servo/pull/36523	(@sebsebmc, #36523)	Support static and instance members having the same name in IDLs (#36523)
      api net; for `Response.json` static method
    - https://github.com/servo/servo/pull/36605	(@elomscansio, @jdm, #36605)	htmlvideoelement: Include security settings in poster image request (#36605)
      net
    - https://github.com/servo/servo/pull/36606	(@elomscansio, #36606)	Fix missing settings in script module requests (#36606)
      net
    - https://github.com/servo/servo/pull/36621	(@elomscansio, #36621)	layout_image: Include missing request settings in layout-initiated image loads (#36621)
      net
- ohos
    - https://github.com/servo/servo/pull/36229	(@kongbai1996, #36229)	Fixed the crash issue when the openharmony web component is adapted. (#36229)
      crash ohos
    - https://github.com/servo/servo/pull/36459	(@coding-joedow, #36459)	Implement WebviewDelegate.screen_geometry for OHOS (#36459)
      ohos
    - https://github.com/servo/servo/pull/36444	(@PartiallyUntyped, @jschwe, #36444)	[OHOS] Allow setting the log-filter via cli arguments (#36444)
      ohos
- parse
    - https://github.com/servo/servo/pull/36622	(@elomscansio, #36622)	script_thread: HTML parser doesn't set relevant option (#36622)
      parse
- perf
    - https://github.com/servo/servo/pull/36474	(@mrobinson, @Loirooriol, #36474)	layout: Box `block_margins_collapsed_with_children` member of `BoxFragment` (#36474)
      perf; memory usage
    - SKIP https://github.com/servo/servo/pull/36579	(@jdm, #36579)	Refactor common infrastructure for creating memory reports. (#36579)
      perf; memory usage
    - https://github.com/servo/servo/pull/36600	(@Barry-dE, @jdm, #36600)	Prevent multiple notifications for image dimensions (#36600)
      perf
    - https://github.com/servo/servo/pull/36617	(@jdm, #36617)	Use swap_remove when unrooting DOM objects. (#36617)
      perf
    - https://github.com/servo/servo/pull/36612	(@jdm, #36612)	script: Only register one image callback per CSS image in use. (#36612)
      perf
    - https://github.com/servo/servo/pull/36604	(@jdm, #36604)	Eagerly define interfaces on non-Window globals (#36604)
      perf; memory usage
    - https://github.com/servo/servo/pull/36573	(@PartiallyUntyped, #36573)	[tracing] Add convenience macro for function tracing (#36573)
      perf; tracing support
    - DONE https://github.com/servo/servo/pull/36629	(@mrobinson, @Loirooriol, #36629)	layout: Add a new `FragmentTree` pass to calculate containing block rectangles (#36629)
      perf; layout queries
    - https://github.com/servo/servo/pull/36119	(@sagudev, #36119)	Introduce snapshot concept of canvas (#36119)
      perf
    - DONE https://github.com/servo/servo/pull/36681	(@mrobinson, @Loirooriol, #36681)	 layout: Use box tree `Fragment`s for offset parent queries (#36681)
      perf; layout queries
    - DONE https://github.com/servo/servo/pull/36663	(@mrobinson, @Loirooriol, #36663)	layout: Implement node geometry queries against `BoxTree`'s `Fragment` (#36663)
      perf; layout queries
    - https://github.com/servo/servo/pull/36692	(@PartiallyUntyped, #36692)	Propagate image resolution errors in layout context (#36692)
      perf
- DONE script
- security
    - https://github.com/servo/servo/pull/36510	(@TimvdLippe, #36510)	Check CSP for inline event handlers (#36510)
      security
    - https://github.com/servo/servo/pull/36603	(@TimvdLippe, #36603)	Set correct policy-container for worker construction (#36603)
      security; csp
    - https://github.com/servo/servo/pull/36623	(@TimvdLippe, #36623)	Support CSP report-only header (#36623)
      security; csp
- DONE servoshell
- DONE shadowdom
    - DONE https://github.com/servo/servo/pull/36230	(@jdm, #36230)	script: Fix resize observer depth calculation for Shadow DOM. (#36230)
      shadowdom
    - DONE https://github.com/servo/servo/pull/36620	(@sakupi01, #36620)	Fix: Slot Assignment mode according to the spec (#36620)
      shadowdom
- test
    - https://github.com/servo/servo/pull/36221	(@jdm, #36221)	Enable service worker WPT tests. (#36221)
      test
    - https://github.com/servo/servo/pull/36330	(@jdm, #36330)	constellation: Only return focused browsing contexts that exist. (#36330)
      test; servodriver bustage
    - https://github.com/servo/servo/pull/36301	(@sebsebmc, @sagudev, #36301)	Implement TestUtils (#36301)
      test
    - https://github.com/servo/servo/pull/36334	(@mrego, #36334)	wpt: Unskip webaudio tests as most are passing (#36334)
      test; unskip tests
    - https://github.com/servo/servo/pull/36333	(@mrego, #36333)	wpt: Unskip old-tests/ folder as most tests are passing (#36333)
      test; unskip tests
    - https://github.com/servo/servo/pull/36314	(@mrego, #36314)	wpt: Unskip css/css-text/i18n as many tests are passing there (#36314)
      test; unskip tests
    - https://github.com/servo/servo/pull/36327	(@jdm, #36327)	Ignore cert errors when running wdspec tests. (#36327)
      test; servodriver bustage
    - https://github.com/servo/servo/pull/36306	(@yezhizhen, #36306)	Webdriver delete cookie (#36306)
      test; servodriver bustage
    - https://github.com/servo/servo/pull/36340	(@mrego, #36340)	wpt: Unskip acid folder as most tests are passing (#36340)
      test; unskip tests
    - https://github.com/servo/servo/pull/36377	(@mukilan, #36377)	ci: use Ubuntu 22.04 for nightly jobs (#36377)
      test
    - https://github.com/servo/servo/pull/36402	(@jdm, #36402)	Run subset of CSP tests by default. (#36402)
      test
    - https://github.com/servo/servo/pull/36436	(@jdm, #36436)	Run all CSP tests in CI by default. (#36436)
      test
    - https://github.com/servo/servo/pull/36552	(@PotatoCP, #36552)	Implement GetComputedRole in wd (#36552)
      test; servodriver bustage
    - https://github.com/servo/servo/pull/27041	(@jdm, #27041)	Report exceptions for async script executions to webdriver (#27041)
      test; servodriver bustage
- DONE testing
- upgrade
    - https://github.com/servo/servo/pull/36486	(@sagudev, #36486)	chore: Update wgpu to v25 (#36486)
      upgrade
-->

Before we start, let’s address the elephant in the room.
Last month, we proposed that we would change our [AI contributions policy](https://book.servo.org/contributing.html#ai-contributions) to allow the use of AI tools in some situations, including GitHub Copilot for code.
[The feedback we received](https://github.com/servo/servo/discussions/36379) from the community was overwhelmingly clear, and we’ve listened.
We will **keep the AI contributions ban in place**, and any future proposals regarding this policy will be discussed together, as a community.

At the same time, we have other big news!
Complex sites such as **GMail** and **Google Chat** are **now usable in Servo**, with some caveats.
This milestone is only possible through the continued hard work of many Servo contributors across the engine, and we're thankful for all of the efforts to reach this point.

<figure><a href="{{ '/img/blog/2025-04-servo-gchat.png' | url }}"><img alt="Google Chat rendering in Servo" src="{{ '/img/blog/2025-04-servo-gchat.png' | url }}"></a></figure>
<figure><a href="{{ '/img/blog/2025-04-servo-gmail.png' | url }}"><img alt="GMail rendering in Servo" src="{{ '/img/blog/2025-04-servo-gmail.png' | url }}"></a></figure>

<aside class=_note>

**Caveats:** must run Servo with `--pref dom_abort_controller_enabled`. Accounts with 2FA enabled may not be able to log in yet.
</aside>

Servo now supports single-valued **&lt;select> elements** (@simonwuelker, #35684, #36677), disabling stylesheets with **&lt;link disabled>** (@Loirooriol, #36446), and the **Refresh** header in HTTP responses and &lt;meta> (@sebsebmc, #36393), plus several new CSS features:

- the **&amp;** selector for **CSS nesting** (@Loirooriol, #36246, #36254, #36248, #36249)
- **‘scale’**, **‘rotate’**, and **‘translate’** (@chocolate-pie, @Loirooriol, #35926)
- **‘will-change’** (@yezhizhen, #35787)
- the **‘fit-content()’** sizing function (@Loirooriol, #36056)
- the **‘image-set()’** notation (@chocolate-pie, #36210)

We’ve also landed a bunch of new web API features:

- the **Response.json()** static method (@sebsebmc, #36589, #36523)
- the **CSSStyleSheet()** constructor (@Loirooriol, #36521)
- the **seekable** property on **HTMLMediaElement** (@rayguo17, #36541)
- the **label** property on **HTMLOptGroupElement** (@simonwuelker, #35970)
- the **align** property on **HTMLParagraphElement** (@stephenmuss, #36054)
- **ClipboardItem** and **navigator.clipboard.writeText()** (@Gae24, #36336, #36498)
- **addRule()**, **removeRules()**, **replaceSync()**, and the **rules** property on **CSSStyleSheet** (@Loirooriol, @webbeef, #36313, #36586)
- **getLineDash**, **setLineDash**, and **lineDashOffset** on **CanvasRenderingContext2D** (@stevennovaryo, #36257)

<figure><a href="{{ '/img/blog/april-2025.png' | url }}"><img alt="servoshell showing new support for ‘image-set()’, ‘fit-content()’, ‘scale’, ‘translate’, ‘rotate’, ‘setLineDash()’, caret and text selection in <input>, and single-valued <select>" src="{{ '/img/blog/april-2025.png' | url }}"></a></figure>

[The biggest engine improvements](https://servo.org/wpt/) we’ve made recently were in **Shadow DOM** (+70.0pp to 77.9%), the **Trusted Types API** (+57.8pp to 57.8%), **Content Security Policy** (+54.0pp to 54.8%), the **Streams API** (+31.9pp to 68.1%), and **CSS Text** (+20.4pp to 57.6%).

We've **enabled Shadow DOM by default** after significantly improving support, allowing Servo to render sites like wpt.fyi correctly (@simonwuelker, @longvatron111, @elomscansio, @jdm, @sakupi01, #35923, #35899, #35930, #36104, #34964, #36024, #36106, #36173, #36010, #35769, #36230, #36620).

<figure><a href="{{ '/img/blog/2025-04-servo-wptfyi.png' | url }}"><img alt="wpt.fyi rendering in Servo" src="{{ '/img/blog/2025-04-servo-wptfyi.png' | url }}"></a></figure>

**ReadableStream**, **WritableStream**, **DOMPoint**, **DOMPointReadOnly**, and **DOMException** can now be sent over **postMessage()** and **structuredClone()** (@gterzian, @kkoyung, @jdm, @mrobinson, #36181, #36588, #36535, #35989).

We’ve started working on support for **stream transforms** (@Taym95, #36470) and the [**trusted types API**](https://developer.mozilla.org/en-US/docs/Web/API/Trusted_Types_API) (@TimvdLippe, @jdm, #36354, #36355, #36422, #36454, #36409, #36363, #36511, #36596).
We’ve also laid the groundwork for supporting the **::marker pseudo element** (@mrobinson, #36202), **animated images** in web content (@rayguo17, #36058, #36141), and **getClientRects()** and **getBoundingClientRect()** on **Range** (@simonwuelker, #35993).

Servo can now render the **caret** and **text selection** in input fields (@dklassic, @webbeef, #35830, #36478), and we’ve landed a few fixes to **radio buttons** (@elomscansio, #36252, #36431), **file inputs** (@sebsebmc, #36458), and **input validation** (@MDCODE247, #36236).

Our devtools now support **color scheme simulation** (@uthmaniv, #36253, #36168, #36297), and the beginnings of a **Sources panel** (@delan, @atbrakhi, #36164, #35971, #36631, #36632, #36667).

Having disabled by default Servo's original, experimental layout implementation back in November 2024, we have taken the step of **deleting all of the disabled code** (@Loirooriol, @TimvdLippe, @mrobinson, #35943, #36281, #36698) and moving all of the remaining layout code to [`layout`](https://doc.servo.org/layout/) (@mrobinson, #36613).
Our new layout engine is improving significantly month over month!

We’ve added a **`--enable-experimental-web-platform-features` option** that enables all engine features, even those that may not be stable or complete.
This works much like [Chromium’s option with the same name](https://source.chromium.org/chromium/chromium/src/+/main:third_party/blink/renderer/platform/RuntimeEnabledFeatures.md;drc=a4e3e1f59b6f4bcf64806cf40c1acbb043b0bddc), and it can be useful when a page is not functioning correctly, since it may allow the page to make further progress.
Servo now uses this option when running the Web Platform Tests (@Loirooriol, #36335, #36519, #36348, #36475), and the features enabled by this option are expected to change over time.

## Servo-the-browser (servoshell)

Our developer tools integration **supports iframes** (@simonwuelker, #35874), shows **computed display values** when inspecting elements (@stephenmuss, #35870), and supports **multiple tabs** open in the servoshell browser (@atbrakhi, #35884).
To use the developer tools, we now **require Firefox 133 or newer** (@atbrakhi, #35792).

Dialogs support **keyboard interaction** to close and cancel them (@chickenleaf, #3567), and the URL bar accepts any **domain-like input** (@kafji, #35756).
We also enabled **sRGB colorspaces** on macOS for better colour fidelity (@IsaacMarovitz, #35683).
Using the `--userscripts` argument without providing a path **defaults to ./resources/user-agent-js/**.
Finally, we **renamed the OpenHarmony app bundle** (@jschwe, #35790).

## Servo-the-engine (embedding)

We’ve landed some big changes to our webview API:

- **pinch zoom**, **page zoom**, and **HiDPI scaling** are now handled independently **for each webview** (@mrobinson, @shubhamg13, #36419, #36312)
- **mouse click events** no longer need to be generated by the embedder, only mouse button down and up events (@yezhizhen, #36413)
- webviews are now created with [**WebViewBuilder**](https://doc.servo.org/servo/struct.WebViewBuilder.html) (@mrobinson, #36483)
- **EmbedderMethods** is now [**ServoBuilder**](https://doc.servo.org/servo/struct.ServoBuilder.html) (@mrobinson, #36276, #36549)
- **WindowMethods** have moved to [**WebViewDelegate**](https://doc.servo.org/servo/webview_delegate/trait.WebViewDelegate.html) and [**ServoDelegate**](https://doc.servo.org/servo/servo_delegate/trait.ServoDelegate.html) (@mrobinson, #36223, #36400)

Embedders can now **inject userscript sources** into all webviews (@Legend-Master, #35388).
Links can be **opened in a new tab** by pressing the ctrl/meta modifier (@webbeef, @mrobinson, #35017).
Delegates will receive **send error notifications** for requests (@delan, #35668).

We fixed a bug causing **flickering cursors** (@DevGev, #35934), and now **create the config directory** if it does not exist (@yezhizhen, #35761).
We also fixed a number of bugs in the WebDriver server related to clicking on elements, opening and closing windows, and returning references to exotic objects (@jdm, #35737).

Finally, we made progress towards a per-webview renderer model (@mrobinson, @delan, #35701, #35716).

## Under the hood

We’ve finally finished **splitting up our massive `script` crate** (@jdm, #35988, #35987, #36107, #36216, #36220, #36095, #36323), which should **cut incremental build times** for that crate **by 60%**.
This is something we’ve wanted to do for **over eleven years** (@kmcallister, #1799)!

**`webgpu` rebuilds are now faster** as well, with changes to that crate no longer requiring a `script` rebuild (@mrobinson, #36332, #36320).

**Stylo** has been upgraded to 2025-03-15 (@nicoburns, @Loirooriol, #35782, #35925, #35990), and we upgraded to the **2024 Rust edition** (@simonwuelker, #35755).

We added a memory usage view for Servo embedders: **visit about:memory** for a breakdown of identified allocations (@webbeef, @jdm, #35728, #36557, #36558, #36556, #36581, #36553, #36664).

<figure><a href="{{ '/img/blog/2025-04-servo-aboutmemory.png' | url }}"><img alt="about:memory screenshot" src="{{ '/img/blog/2025-04-servo-aboutmemory.png' | url }}"></a></figure>

## Perf and stability

We’ve started building an **incremental layout** system in Servo (@mrobinson, @Loirooriol, #36404, #36448, #36447, #36513), with a huge speedup to **offsetWidth**, **offsetHeight**, **offsetLeft**, **offsetTop**, and **offsetParent** layout queries (@mrobinson, @Loirooriol, #36583, #36629, #36681, #36663).
Incremental layout will allow Servo to respond to page updates and layout queries without repeating layout work, which is critical on today’s highly dynamic web.

The `OffscreenRenderingContext` is **no longer double buffered**, which can improve rendering performance in embeddings that rely on it.
We also removed a source of **canvas rendering latency** (@sagudev, #35719), and fixed performance cliffs related to the Shadow DOM (@simonwuelker, #35802, #35725).
We improved layout performance by **reducing allocations** (@jschwe, #35781) and **caching layout results** (@Loirooriol, @mrobinson, #36082), and reduced the **latency of touch events** when they are non-cancelable (@kongbai1996, #35785).

We also fixed crashes involving **touch events** (@kongbai1996, @jschwe, #35763, #36531, #36229), **service workers** (@jdm, #36256), **WritableStream** (@Taym95, #36566), **Location** (@jdm, #36494), **&lt;canvas>** (@tharkum, @simonwuelker, #36569, #36705), **&lt;input>** (@dklassic, #36461), **&lt;iframe>** (@leftmostcat, #35742), **‘min-content’** and **‘max-content’** (@Loirooriol, #36518, #36571), **flexbox** (@mrobinson, #36123), global objects (@jdm, #36491), resizing the viewport (@sebsebmc, #35967), and `--pref shell_background_color_rgba` (@boluochoufeng, #35865).
Additionally, we **removed undefined behaviour** from the Rust bindings to the SpiderMonkey engine (@gmorenz, #35892, #36160, #36161, #36158).

The project to decrease the risk of [intermittent GC-related crashes](https://github.com/servo/servo/issues/33140) continues to make progress (@jdm, @Arya-A-Nair, @Dericko681, @yerke, #35753, #36014, #36043, #36156, #36116, #36180, #36111, #36375, #36371, #36395, #36392, #36464, #36504, #36495, #36492).

## More changes

Our flexbox implementation supports **min/max keyword sizes** for both cross and main axes (@Loirooriol, #35860, #35961), as well as **keyword sizes** for non-replaced content (@Loirooriol, #35826) and **min and max sizing properties** (@Loirooriol, #36015).
This means Servo's flexbox layout now has full support for sizing keywords!

We made lots of progress on web API features:
* we implemented **ReadableByteStreamController and ReadableStream.pipeTo** (@Taym95, @gterzian, #35410, #35650)
* the **nonce attribute** is used in Content Security Policy checks (@simonwuelker, #35876)
* we removed some cases where **custom element callbacks fired incorrectly** (@xiaochengh, #35960, #35883)
* added **partial support for InterSectionObserver** (@stevennovaryo, #35551)
* **touchmove events** are more reliable (@kongbai1996, #36218 #36200) and support the `cancelable` property (@kongbai1996, #35713)
* Notifications fetch **associated image resources** (@pewsheen, #35878)
* `ResizeObserver` callbacks are only invoked **when elements change size** (@simonwuelker, #36226)
* **Request objects with FormData bodies** use the correct `Content-Type` (@andreubotella, #36194)
* Text response bodies containing a BOM consume it (@andreubotella, #36192)
* We have begun **implementing the URLPattern API** (@simonwuelker, #36144)
* Backspace **no longer removes entire lines** in `<textarea>` (@elomscansio, @jdm, #36112)
* **passive event listeners** can be created (@shanehandley, #35877)
* cancelled enqueued animation frame callbacks **no longer run** (@xiaochengh, #35849)
* scripts are **no longer executed** in documents that should disable scripting (@simonwuelker, #35871)
* file inputs **show the selected file** (@dklassic, #35789)
* **removing an event listener** that has not run prevents it from running (@tharkum, #36163)
* members of radio input groups **apply validity constraints** more consistently (@jerensl, @elomscansio, @Barry-dE, #36197, #36090, #36103)
* indexing properties with **values near 2^32** resolves correctly (@reesmichael1, #36136)
* **history.replaceState()** can be called from file:// documents (@kkoyung, #35864)
* script elements **adopted between documents** use the original document to determine when to execute (@xiaochengh, #35718)

We’ve also fixed many layout bugs:
* incorrect **fallback font** caching (@mrobinson, #35705)
* improved **overflow handling** in some special cases (@yezhizhen, #35670)
* **table-layout: fixed** is no longer ignored when `inline-size` is `auto` (@Loirooriol, #35882)
* margins of block-level box stretches are always zero, regardless of collapsing status (@Loirooriol, #35904)
* fixed the intrinsic block size of replaced elements with auto width (@Loirooriol, #35275)
* indefinite stretch contributes to intrinsic sizes (@Loirooriol, #36030)
* static positions include ancestor padding (@Loirooriol, #36051)
* table rows with a span of >1 are sized appropriately (@PotatoCP, #36064)
* input element contents ignore any outer display value (@PotatoCP, #35908)

## Donations

Thanks again for your generous support!
We are now receiving **4664 USD/month** (+6.8% over February) in recurring donations.
This helps cover the cost of our [self-hosted](https://ci0.servo.org) [CI](https://ci1.servo.org) [runners](https://ci2.servo.org) and our [latest Outreachy interns](https://www.outreachy.org/alums/2025-06/#:~:text=Servo), **Usman Baba Yahaya** (@uthmaniv) and **Jerens Lensun** (@jerensl)!

Servo is also on [thanks.dev](https://thanks.dev), and already **24 GitHub users** (+3 over February) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 4664 / 10000); padding-left: 0.5em;"><strong>4664</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 4664 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="4664" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

As always, use of these funds will be decided transparently in the Technical Steering Committee.
For more details, head to our [Sponsorship page]({{ '/sponsorship/' | url }}).

## Conference talks

**Josh Matthews** (@jdm) will be [speaking about Servo](https://rustweek.org/talks/josh/) at [**RustWeek 2025**](https://rustweek.org), on **Tuesday 13 May** at [17:05 local time](https://everytimezone.com/?t=68228b80,929) (15:05 UTC).
See you there!

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
