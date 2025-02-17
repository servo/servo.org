---
layout:     post
tags:       blog
title:      "This month in Servo: and more!"
date:       2025-02-14
summary:    ao!! wrrrrao!!
categories:
---

Servo now supports several new web API features:

- **:host** selector (@simonwuelker, #34870)
- **Relative CSS colors**, like **color(from …)** and **rgb(from …)** (@Loirooriol, #34897)
- **ClipboardEvent** (@Gae24, #33576, #35146), with `--pref dom_clipboardevent_enabled`
- Detecting WGSL extensions via **WGSLLanguageFeatures** (@sagudev, #34928)
- **pointer_composite_access** WGSL extension (@sagudev, #35161)
- **blitFramebuffer()** on **WebGL2RenderingContext** (@jdm, Istvan, #26389)
- **media** property on **HTMLStyleElement** (@webbeef, #35148)

We’ve landed a bunch of **HTMLCanvasElement** improvements:

- **toDataURL()** now supports **image/jpeg** and **image/webp** (@webbeef, #34861)
- **toBlob()** is now supported (@webbeef, #34938)
- **transferControlToOffscreen()** is now supported (@webbeef, #34959)

**Streams** are a lot more useful now, with **ReadableStreamBYOBReader** now supporting **read()** (@Taym95, #35040), **cancel()**, **close()**, and **releaseLock()** (@Taym95, #34958).

<!--
- api
    - /https://github.com/servo/servo/pull/26389	(@jdm, @istvan.miklos@h-lab.eu, #26389)	Add initial support for WebGL 2 BlitFramebuffer (#26389)
      api
    - /https://github.com/servo/servo/pull/34870	(@simonwuelker, #34870)	Support the `:host` selector (#34870)
      api shadowdom
    - /https://github.com/servo/servo/pull/34938	(@webbeef, #34938)	Implement HTMLCanvasElement.toBlob (#34938)
      api
    - /https://github.com/servo/servo/pull/34928	(@sagudev, #34928)	Update wgpu and impl `WGSLLanguageFeatures` (#34928)
      api
    - /https://github.com/servo/servo/pull/34861	(@webbeef, #34861)	Add jpeg and webp support to canvas.toDataURL() (#34861)
      api
    - https://github.com/servo/servo/pull/34885	(@stevennovaryo, #34885)	layout: grid template getComputedStyle resolved value (#34885)
      api
    - /https://github.com/servo/servo/pull/34897	(@Loirooriol, #34897)	Enable relative color syntax (#34897)
      api; relative color values ‘color(from)’, ‘rgb(from)’, ‘hsl(from)’, etc
    - /https://github.com/servo/servo/pull/34959	(@webbeef, #34959)	Implement HTMLCanvasElement.transferControlToOffscreen (#34959)
      api
    - /https://github.com/servo/servo/pull/34958	(@Taym95, #34958)	script: Implement `set_up`, `ReleaseLock`, `Closed`, `Cancel`, `acquire_byob_reader` for `ReadableStreamBYOBReader` (#34958)
      api
    - /https://github.com/servo/servo/pull/33576	(@Gae24, #33576)	Implement Clipboard Event Api (#33576)
      api
    - https://github.com/servo/servo/pull/35096	(@Loirooriol, #35096)	layout: Fix clientWidth & friends for tables (#35096)
      api layout
    - /https://github.com/servo/servo/pull/35146	(@Gae24, #35146)	dom: set composed flag when constructing `ClipboardEvent` (#35146)
      api
    - https://github.com/servo/servo/pull/35066	(@shanehandley, #35066)	Update the FormData constructor to allow providing a submitter (#35066)
      api
    - /https://github.com/servo/servo/pull/35148	(@webbeef, #35148)	Add support for HTMLStyleElement.media (#35148)
      api
    - /https://github.com/servo/servo/pull/35161	(@sagudev, #35161)	chore: update wgpu to include pointer_composite_access WGSL language extension (#35161)
      api
    - https://github.com/servo/servo/pull/35138	(@willypuzzle, #35138)	[#34767] - Range header is missing from CORS header safelist (#35138)
      api; Range requests
    - /https://github.com/servo/servo/pull/35040	(@Taym95, #35040)	Script: implement `ReadableStreamBYOBReader::Read` (#35040)
      api
- ci
    - https://github.com/servo/servo/pull/34868	(@delan, #34868)	CI: use self-hosted runners for macOS build jobs (#34868)
      ci
    - https://github.com/servo/servo/pull/34983	(@delan, #34983)	CI: use new API for taking a runner (#34983)
      ci
    - https://github.com/servo/servo/pull/34957	(@jdm, #34957)	Various servodriver improvements (#34957)
      ci; towards testdriver.js support
    - https://github.com/servo/servo/pull/35002	(@delan, #35002)	CI: use new self-hosted runner servers (#35002)
      ci
    - https://github.com/servo/servo/pull/34997	(@jdm, #34997)	webdriver: Serialize JS int values as i32. (#34997)
      ci; towards testdriver.js support
    - https://github.com/servo/servo/pull/35006	(@jschwe, @mukilan, #35006)	CI: Test ohos on HarmonyOS device (#35006)
      ci
- crash
    - https://github.com/servo/servo/pull/34917	(@mukilan, #34917)	webgl: shutdown webrender before acknowledging Exit message (#34917)
      crash
    - https://github.com/servo/servo/pull/35058	(@jdm, #35058)	Fix crash when using builtin memory profiler (#35058)
      crash
    - https://github.com/servo/servo/pull/35168	(@willypuzzle, #35168)	[35131] Borrow hazard in Document::broadcast_active_resize_observations (#35168)
      crash
- dev
    - https://github.com/servo/servo/pull/34810	(@simonwuelker, #34810)	Support syntax highlighting of arguments in the devtools console (#34810)
      devtools
    - https://github.com/servo/servo/pull/34914	(@jdm, #34914)	script: Downgrade noisy debug logs. (#34914)
      dev
    - https://github.com/servo/servo/pull/35068	(@simonwuelker, #35068)	Correctly report number of expected test results from ./mach test-wpt (#35068)
      dev
    - https://github.com/servo/servo/pull/35228	(@mrobinson, #35228)	Merge webxr repository (#35228)
      dev
- devtools
    - https://github.com/servo/servo/pull/34810	(@simonwuelker, #34810)	Support syntax highlighting of arguments in the devtools console (#34810)
      devtools
- embedding
    - https://github.com/servo/servo/pull/34780	(@wusyong, #34780)	chore: remove `WindowMethods::rendering_context` (#34780)
      embedding
    - https://github.com/servo/servo/pull/34813	(@wusyong, #34813)	webxr: create glwindow with Rc window and without rendering context (#34813)
      embedding; RenderingContext trait
    - https://github.com/servo/servo/pull/34808	(@git@pews.dev, @mrobinson, #34808)	fix: add source browsing context to `Request` and HTTP credentials prompt (#34808)
      embedding
    - https://github.com/servo/servo/pull/34961	(@zhuhaichao518@gmail.com, #34961)	Implement WebResourceRequested Event. (#34961)
      embedding
    - https://github.com/servo/servo/pull/35055	(@jdm, #35055)	script: Feature-gate all crown support. (#35055)
      embedding
    - https://github.com/servo/servo/pull/35056	(@jdm, #35056)	Don't generate gstreamer data when dummy media backend enabled. (#35056)
      embedding
    - https://github.com/servo/servo/pull/35057	(@jdm, #35057)	config: Derive defaults for Opts. (#35057)
      embedding
    - https://github.com/servo/servo/pull/35049	(@andi.m.mcclure@gmail.com, #35049)	servo-media 1e28d1d997: don't unwrap ServoMedia::get() (#35049)
      embedding
    - https://github.com/servo/servo/pull/35052	(@dklassic, #35052)	feat: Turn `RenderingContext` into a trait (#35052)
      embedding; RenderingContext trait
- layout
    - https://github.com/servo/servo/pull/32103	(@Loirooriol, #32103)	Treat % as 0 for the min-content contribution of replaced elements (#32103)
      layout; img inside float (dn.se)
    - https://github.com/servo/servo/pull/34933	(@Loirooriol, #34933)	layout: Improve painting of collapsed borders in table layout (#34933)
      layout; table ‘border-collapse’ painting
    - https://github.com/servo/servo/pull/34932	(@Loirooriol, #34932)	layout: Improve sizing of tables in collapsed-borders mode (#34932)
      layout; table ‘border-collapse’ sizing
    - https://github.com/servo/servo/pull/34931	(@Loirooriol, #34931)	layout: Don't recalculate the PaddingBorderMargin in table layout (#34931)
      layout; table layout perf
    - https://github.com/servo/servo/pull/34908	(@Loirooriol, #34908)	layout: Set padding to zero on tables in collapsed-borders mode (#34908)
      layout; table ‘border-collapse’ layout
    - https://github.com/servo/servo/pull/34889	(@Loirooriol, #34889)	layout: Defer some table sizing logic to the parent formatting context (#34889)
      layout; correct table sizing
    - https://github.com/servo/servo/pull/34907	(@Loirooriol, #34907)	layout: Refine the check for dependending on available space (#34907)
      layout; float layout perf
    - https://github.com/servo/servo/pull/34947	(@Loirooriol, #34947)	layout: Improve logic for block size of table (#34947)
      layout; table sizing
    - https://github.com/servo/servo/pull/34923	(@mrobinson, @Loirooriol, #34923)	layout: Make `Fragment` hold `ArcRefCell` inside (#34923)
      layout; memory savings (also towards incremental layout)
    - https://github.com/servo/servo/pull/34984	(@rayguo17, @mrobinson, #34984)	layout: Make non-`normal` `align-content` establish a block formatting context (#34984)
      layout; ‘align-content’
    - https://github.com/servo/servo/pull/35003	(@Loirooriol, #35003)	layout: Allow different collapsed border style/color within a row/column (#35003)
      layout; table ‘border-collapse’ painting
    - https://github.com/servo/servo/pull/35097	(@Loirooriol, #35097)	layout: Fix border widths of table wrapper with collapsed borders (#35097)
      layout; table ‘border-collapse’ layout
    - https://github.com/servo/servo/pull/35100	(@Loirooriol, #35100)	layout: Fix conflict resolution for collapsed borders differing in color (#35100)
      layout; table ‘border-collapse’ painting
    - https://github.com/servo/servo/pull/35095	(@mrobinson, @Loirooriol, #35095)	layout: Improve distribution colspan cell inline size (#35095)
      layout; table rowspan sizing
    - https://github.com/servo/servo/pull/35075	(@Loirooriol, #35075)	layout: Paint collapsed table borders on their own (#35075)
      layout; table ‘border-collapse’ painting
    - https://github.com/servo/servo/pull/35038	(@webbeef, #35038)	Add support for HTMLStyleElement.type (#35038)
      layout
    - https://github.com/servo/servo/pull/35096	(@Loirooriol, #35096)	layout: Fix clientWidth & friends for tables (#35096)
      api layout
    - https://github.com/servo/servo/pull/35085	(@Loirooriol, #35085)	layout: Respect alignment when sizing replaced abspos (#35085)
      layout; replaced abspos sizing
    - https://github.com/servo/servo/pull/35129	(@Loirooriol, #35129)	layout: Hide collapsed borders crossed by spanning cells (#35129)
      layout; table ‘border-collapse’ painting
    - https://github.com/servo/servo/pull/35122	(@Loirooriol, #35122)	layout: Fix table geometry when collapsed borders have different sizes (#35122)
      layout; table ‘border-collapse’ layout
    - https://github.com/servo/servo/pull/35165	(@Loirooriol, #35165)	layout: Zero out collapsed track sizes when painting collapsed borders (#35165)
      layout; table ‘border-collapse’ layout
    - https://github.com/servo/servo/pull/35163	(@Loirooriol, #35163)	layout: Correctly resolve `currentcolor` on collapsed borders (#35163)
      layout; ‘border-collapse’
    - https://github.com/servo/servo/pull/35167	(@mrobinson, @Loirooriol, #35167)	layout: Take perentage columns into account when sizing table grid min and max (#35167)
      layout; table sizing with ‘width: %’ cell
    - https://github.com/servo/servo/pull/35170	(@Loirooriol, #35170)	layout: Improve fixed table layout (#35170)
      layout; ‘table-layout: fixed’ interop
    - https://github.com/servo/servo/pull/35207	(@Loirooriol, #35207)	layout: Remove wrong optimization when placing table among floats (#35207)
      layout; table float interaction
- net
    - https://github.com/servo/servo/pull/34919	(@mrobinson, #34919)	script: Move navigation fetching to the `ScriptThread` (#34919)
      net; network perf
    - https://github.com/servo/servo/pull/34883	(@mrobinson, #34883)	net: Use `RequestId` to cancel fetches instead of creating an IPC channel (#34883)
      net; network perf
    - https://github.com/servo/servo/pull/34797	(@rayguo17, #34797)	Add Content Range Header and add one for blob end range (#34797)
      net; correct handling of Range requests
    - https://github.com/servo/servo/pull/35041	(@mrobinson, #35041)	script: Do not set up an IPC route for every image load (#35041)
      net; network perf (dota2.com)
- ohos
    - https://github.com/servo/servo/pull/35158	(@jschwe, #35158)	ohos: Support resizing the surface (#35158)
      ohos
- perf
    - https://github.com/servo/servo/pull/34744	(@dklassic, @mrobinson, #34744)	feat: Track the binary size for all the different platforms (#34744)
      perf
- prefs
    - https://github.com/servo/servo/pull/34994	(@mrobinson, #34994)	config: Remove legacy-layout and unused `Preferences` and `Opts` (#34994)
      prefs
    - https://github.com/servo/servo/pull/34966	(@mrobinson, #34966)	api: Flatten and simplify Servo preferences (#34966)
      prefs; major rework that renames all existing prefs (see <https://doc.servo.org/servo_config/prefs/struct.Preferences.html>)
    - https://github.com/servo/servo/pull/34999	(@mrobinson, #34999)	Remove `resources/prefs.json` (#34999)
      prefs
    - https://github.com/servo/servo/pull/34998	(@mrobinson, #34998)	prefs: Move some `DebugOptions` to `Preferences` and clean up (#34998)
      prefs; renames some debug options to prefs
- script
    - https://github.com/servo/servo/pull/34359	(@jdm, #34359)	Support future uses of traits with associated types in rooting analysis (#34359)
      script; towards splitting script crate
    - https://github.com/servo/servo/pull/35157	(@jdm, #35157)	script: Move code generation and webidl files to new script_bindings crate. (#35157)
      script; towards splitting script crate
    - https://github.com/servo/servo/pull/35169	(@jdm, #35169)	Make generated bindings generic over DOM types (#35169)
      script; towards splitting script crate
    - https://github.com/servo/servo/pull/35172	(@jdm, #35172)	bindings: Move string-related bindings code to script_bindings. (#35172)
      script; towards splitting script crate
- shadowdom
    - https://github.com/servo/servo/pull/34803	(@simonwuelker, #34803)	Fix IS_IN_SHADOW_TREE flag for descendants after Node::remove call (#34803)
      shadowdom
    - https://github.com/servo/servo/pull/34787	(@willypuzzle, #34787)	Document's current script should not be updated when executing script elements inside shadow trees (#34787)
      shadowdom
    - https://github.com/servo/servo/pull/34834	(@simonwuelker, #34834)	Ensure Element ID modifications inside disconnected shadow roots are registered (#34834)
      shadowdom
    - https://github.com/servo/servo/pull/34863	(@simonwuelker, #34863)	Add shadow tree flags to Bind/UnbindContext (#34863)
      shadowdom
    - https://github.com/servo/servo/pull/34788	(@simonwuelker, #34788)	Consider shadow dom when dispatching events (#34788)
      shadowdom
    - https://github.com/servo/servo/pull/34870	(@simonwuelker, #34870)	Support the `:host` selector (#34870)
      api shadowdom
    - https://github.com/servo/servo/pull/34909	(@Taym95, #34909)	Fix shadow root binding children to the tree (#34909)
      shadowdom
    - https://github.com/servo/servo/pull/35076	(@simonwuelker, #35076)	Set descendant's attribute's owner document in Node::adopt (#35076)
      shadowdom
    - https://github.com/servo/servo/pull/35013	(@simonwuelker, #35013)	Implement shadow dom slots (#35013)
      shadowdom
    - https://github.com/servo/servo/pull/34884	(@simonwuelker, #34884)	Implement Event propagation across shadow roots (#34884)
      shadowdom
    - https://github.com/servo/servo/pull/35132	(@jdm, #35132)	script: Handle shadow roots when determining common ancestors of dirty roots. (#35132)
      shadowdom
    - https://github.com/servo/servo/pull/35177	(@simonwuelker, #35177)	Propagate events from slottables to their assigned slot instead of their parent (#35177)
      shadowdom
    - https://github.com/servo/servo/pull/35137	(@simonwuelker, #35137)	Fire slot change events when the slot content changes (#35137)
      shadowdom
    - https://github.com/servo/servo/pull/35198	(@simonwuelker, #35198)	Never compute style for children of shadow hosts (#35198)
      shadowdom
    - https://github.com/servo/servo/pull/35191	(@simonwuelker, #35191)	Use "slot" attribute for slottable name (#35191)
      shadowdom
    - https://github.com/servo/servo/pull/35222	(@simonwuelker, #35222)	Don't fire slotchange events when there's already a pending event for the same slot (#35222)
      shadowdom
    - https://github.com/servo/servo/pull/35221	(@simonwuelker, #35221)	Potentially signal a slot change in Node::insert (#35221)
      shadowdom
- upgrade
    - https://github.com/servo/servo/pull/34793	(@nicoburns, #34793)	Upgrade rustc to 1.83 (#34793)
      upgrade
    - https://github.com/servo/servo/pull/34927	(@nicoburns, #34927)	Bump taffy to v0.7.5 (#34927)
      upgrade
    - https://github.com/servo/servo/pull/34894	(@Loirooriol, #34894)	Upgrade Stylo to 2025-01-02 (#34894)
      upgrade
    - https://github.com/servo/servo/pull/34630	(@jdm, #34630)	Update all network-related dependencies to the latest versions (#34630)
      upgrade; whole network stack
- webview
    - https://github.com/servo/servo/pull/35118	(@delan, @mrobinson, #35118)	Add minimal libservo example using winit (#35118)
      webview
    - https://github.com/servo/servo/pull/35116	(@delan, @mrobinson, #35116)	Fix building libservo with `cargo build -p libservo` (#35116)
      webview
    - https://github.com/servo/servo/pull/35156	(@delan, @mrobinson, #35156)	Remove type parameter from Servo and IOCompositor (#35121) (#35156)
      webview
    - https://github.com/servo/servo/pull/35154	(@webbeef, #35154)	Fix winit_minimal.rs build (#35154)
      webview
    - https://github.com/servo/servo/pull/35119	(@delan, @mrobinson, #35119)	libservo: Add an initial WebView data structure to the API (#35119)
      webview
    - https://github.com/servo/servo/pull/35183	(@mrobinson, @delan, #35183)	libservo: Port desktop servoshell to use the new `WebView` API (#35183)
      webview
    - https://github.com/servo/servo/pull/35185	(@mrobinson, #35185)	libservo: Stop using `script_traits` in the embedding layer (#35185)
      webview
    - https://github.com/servo/servo/pull/35192	(@mrobinson, #35192)	servoshell: Port Android / OHOS servoshell to use the WebView API (#35192)
      webview
    - https://github.com/servo/servo/pull/35226	(@mrobinson, #35226)	script_traits: Rename `ConstellationControlMsg` to `ScriptThreadMessage` (#35226)
      webview
    - https://github.com/servo/servo/pull/35211	(@delan, @mrobinson, #35211)	Include `WebViewId` into EmbedderMsg variants where possible (#35211)
      webview
-->

<!--[commits]
From https://github.com/servo/servo
 * branch                  HEAD       -> FETCH_HEAD
>>> 2025-01-01T06:06:19Z
-https://github.com/servo/servo/pull/34807	(@mrobinson, #34807)	script: Remove unecessary `warn(deprecated)` directives (#34807)
-https://github.com/servo/servo/pull/34805	(@wusyong, #34805)	Update surfman to latest commit (#34805)
-https://github.com/servo/servo/pull/34801	(@dependabot[bot], @dependabot[bot], #34801)	build(deps): bump tracing-perfetto from 0.1.3 to 0.1.4 (#34801)
-https://github.com/servo/servo/pull/34800	(@dependabot[bot], @dependabot[bot], #34800)	build(deps): bump syn from 2.0.92 to 2.0.93 (#34800)
>>> 2025-01-02T06:04:57Z
-https://github.com/servo/servo/pull/34809	(@dependabot[bot], @dependabot[bot], #34809)	build(deps): bump winnow from 0.6.20 to 0.6.21 (#34809)
-https://github.com/servo/servo/pull/34798	(@mrobinson, #34798)	script: Eliminate code duplication in the task queue (#34798)
+https://github.com/servo/servo/pull/34793	(@nicoburns, #34793)	Upgrade rustc to 1.83 (#34793)
    upgrade
+https://github.com/servo/servo/pull/34780	(@wusyong, #34780)	chore: remove `WindowMethods::rendering_context` (#34780)
    embedding
>>> 2025-01-03T06:16:08Z
+https://github.com/servo/servo/pull/34813	(@wusyong, #34813)	webxr: create glwindow with Rc window and without rendering context (#34813)
    embedding; RenderingContext trait
+https://github.com/servo/servo/pull/34810	(@simonwuelker, #34810)	Support syntax highlighting of arguments in the devtools console (#34810)
    devtools
-https://github.com/servo/servo/pull/34818	(@dependabot[bot], @dependabot[bot], #34818)	build(deps): bump tracing-perfetto from 0.1.4 to 0.1.5 (#34818)
-https://github.com/servo/servo/pull/34817	(@dependabot[bot], @dependabot[bot], #34817)	build(deps): bump syn from 2.0.93 to 2.0.94 (#34817)
-https://github.com/servo/servo/pull/34795	(@sagudev, #34795)	chore: Update wgpu (#34795)
>>> 2025-01-04T06:03:22Z
+https://github.com/servo/servo/pull/34803	(@simonwuelker, #34803)	Fix IS_IN_SHADOW_TREE flag for descendants after Node::remove call (#34803)
    shadowdom
-https://github.com/servo/servo/pull/34832	(@mrobinson, #34832)	script: Expose node helpers as `NodeTraits` and give more descriptive names (#34832)
-https://github.com/servo/servo/pull/34824	(@mrobinson, #34824)	Elide lifetimes where possible after rustup (#34824)
-https://github.com/servo/servo/pull/34831	(@dependabot[bot], @dependabot[bot], #34831)	build(deps): bump cc from 1.2.6 to 1.2.7 (#34831)
-https://github.com/servo/servo/pull/34830	(@dependabot[bot], @dependabot[bot], #34830)	build(deps): bump taffy from 0.7.1 to 0.7.2 (#34830)
-https://github.com/servo/servo/pull/34829	(@dependabot[bot], @dependabot[bot], #34829)	build(deps): bump tempfile from 3.14.0 to 3.15.0 (#34829)
-https://github.com/servo/servo/pull/34828	(@dependabot[bot], @dependabot[bot], #34828)	build(deps): bump winnow from 0.6.21 to 0.6.22 (#34828)
-https://github.com/servo/servo/pull/34826	(@simonwuelker, #34826)	Upgrade lib to 0.20 to fix RUSTSEC-2024-0429 (#34826)
+https://github.com/servo/servo/pull/34808	(@git@pews.dev, @mrobinson, #34808)	fix: add source browsing context to `Request` and HTTP credentials prompt (#34808)
    embedding
-https://github.com/servo/servo/pull/34815	(@simonwuelker, #34815)	Fix building with feature=tracing (#34815)
>>> 2025-01-05T06:03:55Z
-https://github.com/servo/servo/pull/34837	(@servo-wpt-sync, #34837)	Update web-platform-tests to revision b'c72ee0c082d350b8b44f7a6bac1f028752b13527' (#34837)
+https://github.com/servo/servo/pull/34787	(@willypuzzle, #34787)	Document's current script should not be updated when executing script elements inside shadow trees (#34787)
    shadowdom
-https://github.com/servo/servo/pull/34835	(@Taym95, #34835)	Remove readable streams from webidl/codegen (#34835)
-https://github.com/servo/servo/pull/34825	(@mrobinson, #34825)	script: Move `TimerListener` creation to `OneShotTimers` (#34825)
-https://github.com/servo/servo/pull/34827	(@mrobinson, #34827)	script: Move `TaskManager` to `GlobalScope` (#34827)
+https://github.com/servo/servo/pull/34834	(@simonwuelker, #34834)	Ensure Element ID modifications inside disconnected shadow roots are registered (#34834)
    shadowdom
>>> 2025-01-06T06:03:12Z
-https://github.com/servo/servo/pull/34838	(@webbeef, #34838)	Update webdriver to 0.51 (#34838)
-https://github.com/servo/servo/pull/34836	(@Taym95, #34836)	ReadableStream: remove the use of get_js_stream and use DomRoot<ReadableStream> (#34836)
>>> 2025-01-07T06:02:43Z
-https://github.com/servo/servo/pull/34849	(@mrobinson, @mukilan, #34849)	script: Unsilence all main thread `TaskQueue` errors (#34849)
-https://github.com/servo/servo/pull/34862	(@webbeef, #34862)	Fix a leak in MacOS thread count function (#34862)
+https://github.com/servo/servo/pull/34863	(@simonwuelker, #34863)	Add shadow tree flags to Bind/UnbindContext (#34863)
    shadowdom
-https://github.com/servo/servo/pull/34848	(@Taym95, #34848)	Use patch to add arrayType in WebIDL.py  (#34848)
+https://github.com/servo/servo/pull/26389	(@jdm, @istvan.miklos@h-lab.eu, #26389)	Add initial support for WebGL 2 BlitFramebuffer (#26389)
    api
-https://github.com/servo/servo/pull/28364	(@cyb.ai.815@gmail.com, #28364)	Check regex syntax for pattern attribute with CheckRegexSyntax from mozjs (#28364)
-https://github.com/servo/servo/pull/34860	(@dependabot[bot], @dependabot[bot], #34860)	build(deps): bump taffy from 0.7.2 to 0.7.3 (#34860)
-https://github.com/servo/servo/pull/34859	(@dependabot[bot], @dependabot[bot], #34859)	build(deps): bump hilog-sys from 0.1.2 to 0.1.3 (#34859)
-https://github.com/servo/servo/pull/34858	(@dependabot[bot], @dependabot[bot], #34858)	build(deps): bump xattr from 1.3.1 to 1.4.0 (#34858)
-https://github.com/servo/servo/pull/34857	(@dependabot[bot], @dependabot[bot], #34857)	build(deps): bump syn from 2.0.94 to 2.0.95 (#34857)
-https://github.com/servo/servo/pull/34856	(@dependabot[bot], @dependabot[bot], #34856)	build(deps): bump hitrace-sys from 0.1.2 to 0.1.3 (#34856)
-https://github.com/servo/servo/pull/34852	(@dependabot[bot], @dependabot[bot], #34852)	build(deps): bump ohos-ime-sys from 0.1.1 to 0.1.2 (#34852)
-https://github.com/servo/servo/pull/34855	(@dependabot[bot], @dependabot[bot], #34855)	build(deps): bump pin-project-lite from 0.2.15 to 0.2.16 (#34855)
-https://github.com/servo/servo/pull/34854	(@dependabot[bot], @dependabot[bot], #34854)	build(deps): bump winit from 0.30.7 to 0.30.8 (#34854)
+https://github.com/servo/servo/pull/32103	(@Loirooriol, #32103)	Treat % as 0 for the min-content contribution of replaced elements (#32103)
    layout; img inside float (dn.se)
>>> 2025-01-08T06:06:31Z
+https://github.com/servo/servo/pull/34788	(@simonwuelker, #34788)	Consider shadow dom when dispatching events (#34788)
    shadowdom
-https://github.com/servo/servo/pull/34879	(@dependabot[bot], @dependabot[bot], #34879)	build(deps): bump pin-project from 1.1.7 to 1.1.8 (#34879)
-https://github.com/servo/servo/pull/34877	(@dependabot[bot], @dependabot[bot], #34877)	build(deps): bump phf_macros from 0.11.2 to 0.11.3 (#34877)
-https://github.com/servo/servo/pull/34878	(@dependabot[bot], @dependabot[bot], #34878)	build(deps): bump clap from 4.5.23 to 4.5.24 (#34878)
-https://github.com/servo/servo/pull/34876	(@dependabot[bot], @dependabot[bot], #34876)	build(deps): bump serde_json from 1.0.134 to 1.0.135 (#34876)
-https://github.com/servo/servo/pull/34875	(@dependabot[bot], @dependabot[bot], #34875)	build(deps): bump libz-sys from 1.1.20 to 1.1.21 (#34875)
-https://github.com/servo/servo/pull/34874	(@dependabot[bot], @dependabot[bot], #34874)	build(deps): bump phf_codegen from 0.11.2 to 0.11.3 (#34874)
+https://github.com/servo/servo/pull/34868	(@delan, #34868)	CI: use self-hosted runners for macOS build jobs (#34868)
    ci
-https://github.com/servo/servo/pull/34843	(@mrobinson, #34843)	script: Expose `NodeTraits::owner_global` / `Window::as_global_scope` (#34843)
-https://github.com/servo/servo/pull/34871	(@jdm, #34871)	Various servodriver fixes (#34871)
+https://github.com/servo/servo/pull/34870	(@simonwuelker, #34870)	Support the `:host` selector (#34870)
    api shadowdom
-https://github.com/servo/servo/pull/34867	(@shubhamg13, @shubham.gupta@chromium.org, #34867)	Remove obselete request parameter. (#34867)
-https://github.com/servo/servo/pull/34845	(@mrobinson, @mukilan, #34845)	script: Move the `FontContext` to `Window` (#34845)
>>> 2025-01-11T06:04:35Z
+https://github.com/servo/servo/pull/34933	(@Loirooriol, #34933)	layout: Improve painting of collapsed borders in table layout (#34933)
    layout; table ‘border-collapse’ painting
+https://github.com/servo/servo/pull/34932	(@Loirooriol, #34932)	layout: Improve sizing of tables in collapsed-borders mode (#34932)
    layout; table ‘border-collapse’ sizing
-https://github.com/servo/servo/pull/34943	(@dependabot[bot], @dependabot[bot], #34943)	build(deps): bump ohos-vsync from 0.1.2 to 0.1.3 (#34943)
+https://github.com/servo/servo/pull/34938	(@webbeef, #34938)	Implement HTMLCanvasElement.toBlob (#34938)
    api
-https://github.com/servo/servo/pull/34944	(@dependabot[bot], @dependabot[bot], #34944)	build(deps): bump hitrace-sys from 0.1.3 to 0.1.4 (#34944)
-https://github.com/servo/servo/pull/34945	(@dependabot[bot], @dependabot[bot], #34945)	build(deps): bump vergen-git2 from 1.0.2 to 1.0.3 (#34945)
+https://github.com/servo/servo/pull/34928	(@sagudev, #34928)	Update wgpu and impl `WGSLLanguageFeatures` (#34928)
    api
-https://github.com/servo/servo/pull/34942	(@dependabot[bot], @dependabot[bot], #34942)	build(deps): bump syn from 2.0.95 to 2.0.96 (#34942)
-https://github.com/servo/servo/pull/34941	(@dependabot[bot], @dependabot[bot], #34941)	build(deps): bump vergen-lib from 0.1.5 to 0.1.6 (#34941)
-https://github.com/servo/servo/pull/34940	(@dependabot[bot], @dependabot[bot], #34940)	build(deps): bump rustls from 0.23.20 to 0.23.21 (#34940)
-https://github.com/servo/servo/pull/34937	(@dependabot[bot], @dependabot[bot], #34937)	build(deps): bump uuid from 1.11.0 to 1.11.1 (#34937)
-https://github.com/servo/servo/pull/34939	(@dependabot[bot], @dependabot[bot], #34939)	build(deps): bump arkui-sys from 0.2.0 to 0.2.3 (#34939)
-https://github.com/servo/servo/pull/34936	(@dependabot[bot], @dependabot[bot], #34936)	build(deps): bump xcomponent-sys from 0.2.0 to 0.3.0 (#34936)
-https://github.com/servo/servo/pull/34935	(@dependabot[bot], @dependabot[bot], #34935)	build(deps): bump hilog-sys from 0.1.3 to 0.1.4 (#34935)
+https://github.com/servo/servo/pull/34931	(@Loirooriol, #34931)	layout: Don't recalculate the PaddingBorderMargin in table layout (#34931)
    layout; table layout perf
+https://github.com/servo/servo/pull/34927	(@nicoburns, #34927)	Bump taffy to v0.7.5 (#34927)
    upgrade
+https://github.com/servo/servo/pull/34919	(@mrobinson, #34919)	script: Move navigation fetching to the `ScriptThread` (#34919)
    net; network perf
+https://github.com/servo/servo/pull/34909	(@Taym95, #34909)	Fix shadow root binding children to the tree (#34909)
    shadowdom
-https://github.com/servo/servo/pull/34926	(@stevennovaryo, #34926)	layout: grid-template getComputedStyle cleanup (#34926)
-https://github.com/servo/servo/pull/34915	(@jdm, #34915)	script: Limit public exports. (#34915)
+https://github.com/servo/servo/pull/34861	(@webbeef, #34861)	Add jpeg and webp support to canvas.toDataURL() (#34861)
    api
+https://github.com/servo/servo/pull/34908	(@Loirooriol, #34908)	layout: Set padding to zero on tables in collapsed-borders mode (#34908)
    layout; table ‘border-collapse’ layout
-https://github.com/servo/servo/pull/34920	(@Loirooriol, #34920)	Add http2 feature for hyper-util (#34920)
-https://github.com/servo/servo/pull/34921	(@Loirooriol, #34921)	layout: Minor tweaks for table layout (#34921)
+https://github.com/servo/servo/pull/34885	(@stevennovaryo, #34885)	layout: grid template getComputedStyle resolved value (#34885)
    api
+https://github.com/servo/servo/pull/34917	(@mukilan, #34917)	webgl: shutdown webrender before acknowledging Exit message (#34917)
    crash
+https://github.com/servo/servo/pull/34914	(@jdm, #34914)	script: Downgrade noisy debug logs. (#34914)
    dev
+https://github.com/servo/servo/pull/34889	(@Loirooriol, #34889)	layout: Defer some table sizing logic to the parent formatting context (#34889)
    layout; correct table sizing
-https://github.com/servo/servo/pull/34904	(@dependabot[bot], @dependabot[bot], #34904)	build(deps): bump async-tungstenite from 0.28.0 to 0.28.2 (#34904)
-https://github.com/servo/servo/pull/34896	(@mrobinson, #34896)	script: Use `enum`s for event loop senders and receivers (#34896)
-https://github.com/servo/servo/pull/34905	(@dependabot[bot], @dependabot[bot], #34905)	build(deps): bump rustix from 0.38.42 to 0.38.43 (#34905)
+https://github.com/servo/servo/pull/34894	(@Loirooriol, #34894)	Upgrade Stylo to 2025-01-02 (#34894)
    upgrade
-https://github.com/servo/servo/pull/34906	(@dependabot[bot], @dependabot[bot], #34906)	build(deps): bump hyper-rustls from 0.27.3 to 0.27.5 (#34906)
-https://github.com/servo/servo/pull/34903	(@dependabot[bot], @dependabot[bot], #34903)	build(deps): bump tokio from 1.42.0 to 1.43.0 (#34903)
-https://github.com/servo/servo/pull/34900	(@dependabot[bot], @dependabot[bot], #34900)	build(deps): bump rustls-pki-types from 1.10.0 to 1.10.1 (#34900)
+https://github.com/servo/servo/pull/34907	(@Loirooriol, #34907)	layout: Refine the check for dependending on available space (#34907)
    layout; float layout perf
+https://github.com/servo/servo/pull/34897	(@Loirooriol, #34897)	Enable relative color syntax (#34897)
    api; relative color values ‘color(from)’, ‘rgb(from)’, ‘hsl(from)’, etc
-https://github.com/servo/servo/pull/34898	(@jschwe, #34898)	Update xcomponent-sys to 0.2.0 (#34898)
-https://github.com/servo/servo/pull/34902	(@dependabot[bot], @dependabot[bot], #34902)	build(deps): bump xml-rs from 0.8.24 to 0.8.25 (#34902)
-https://github.com/servo/servo/pull/34901	(@dependabot[bot], @dependabot[bot], #34901)	build(deps): bump rustls from 0.23.19 to 0.23.20 (#34901)
-https://github.com/servo/servo/pull/34899	(@dependabot[bot], @dependabot[bot], #34899)	build(deps): bump linux-raw-sys from 0.4.14 to 0.4.15 (#34899)
-https://github.com/servo/servo/pull/34895	(@Loirooriol, #34895)	layout: Remove wrong FIXME (#34895)
-https://github.com/servo/servo/pull/34891	(@Loirooriol, #34891)	layout: Don't use `content_inline_size_for_table` in taffy (#34891)
-https://github.com/servo/servo/pull/34892	(@Loirooriol, #34892)	layout: Assert that GRIDMIN <= GRIDMAX (#34892)
-https://github.com/servo/servo/pull/34886	(@jdm, #34886)	Make webgl test preferences more consistent. (#34886)
+https://github.com/servo/servo/pull/34630	(@jdm, #34630)	Update all network-related dependencies to the latest versions (#34630)
    upgrade; whole network stack
>>> 2025-01-13T06:06:37Z
+https://github.com/servo/servo/pull/34959	(@webbeef, #34959)	Implement HTMLCanvasElement.transferControlToOffscreen (#34959)
    api
-https://github.com/servo/servo/pull/34833	(@arthmis, @lazypassion, #34833)	add minimal implementation of FetchParams (#34833)
-https://github.com/servo/servo/pull/34955	(@jdm, #34955)	Enable wdspec and crashtest tests in servodriver. (#34955)
-https://github.com/servo/servo/pull/34954	(@jdm, #34954)	net: Raed RippyPNG resource once at startup. (#34954)
-https://github.com/servo/servo/pull/34956	(@servo-wpt-sync, #34956)	Update web-platform-tests to revision b'475127f90be9926867796ff98717b621a358af52' (#34956)
+https://github.com/servo/servo/pull/34883	(@mrobinson, #34883)	net: Use `RequestId` to cancel fetches instead of creating an IPC channel (#34883)
    net; network perf
>>> 2025-01-14T06:05:08Z
+https://github.com/servo/servo/pull/34797	(@rayguo17, #34797)	Add Content Range Header and add one for blob end range (#34797)
    net; correct handling of Range requests
-https://github.com/servo/servo/pull/34976	(@dependabot[bot], @dependabot[bot], #34976)	build(deps): bump ohos-sys-opaque-types from 0.1.3 to 0.1.4 (#34976)
-https://github.com/servo/servo/pull/34980	(@dependabot[bot], @dependabot[bot], #34980)	build(deps): bump proc-macro2 from 1.0.92 to 1.0.93 (#34980)
-https://github.com/servo/servo/pull/34979	(@dependabot[bot], @dependabot[bot], #34979)	build(deps): bump cc from 1.2.7 to 1.2.9 (#34979)
-https://github.com/servo/servo/pull/34978	(@dependabot[bot], @dependabot[bot], #34978)	build(deps): bump clap from 4.5.24 to 4.5.26 (#34978)
-https://github.com/servo/servo/pull/34977	(@dependabot[bot], @dependabot[bot], #34977)	build(deps): bump bitflags from 2.6.0 to 2.7.0 (#34977)
-https://github.com/servo/servo/pull/34975	(@dependabot[bot], @dependabot[bot], #34975)	build(deps): bump vergen from 9.0.3 to 9.0.4 (#34975)
-https://github.com/servo/servo/pull/34972	(@dependabot[bot], @dependabot[bot], #34972)	build(deps): bump vergen-git2 from 1.0.3 to 1.0.5 (#34972)
-https://github.com/servo/servo/pull/34974	(@dependabot[bot], @dependabot[bot], #34974)	build(deps): bump ohos-ime-sys from 0.1.2 to 0.1.3 (#34974)
-https://github.com/servo/servo/pull/34973	(@dependabot[bot], @dependabot[bot], #34973)	build(deps): bump glutin_wgl_sys from 0.6.0 to 0.6.1 (#34973)
-https://github.com/servo/servo/pull/34971	(@dependabot[bot], @dependabot[bot], #34971)	build(deps): bump the napi-ohos-related group with 4 updates (#34971)
-https://github.com/servo/servo/pull/34970	(@simonwuelker, #34970)	Remove incorrect TODO comment in htmlinputelement.rs (#34970)
+https://github.com/servo/servo/pull/34947	(@Loirooriol, #34947)	layout: Improve logic for block size of table (#34947)
    layout; table sizing
-https://github.com/servo/servo/pull/34946	(@Loirooriol, #34946)	layout: Generalize `ContainingBlock`'s block size to a `SizeConstraint` (#34946)
+https://github.com/servo/servo/pull/34923	(@mrobinson, @Loirooriol, #34923)	layout: Make `Fragment` hold `ArcRefCell` inside (#34923)
    layout; memory savings (also towards incremental layout)
>>> 2025-01-15T06:03:30Z
-https://github.com/servo/servo/pull/34996	(@simonwuelker, #34996)	Fix ./mach test-speedometer runs (#34996)
-https://github.com/servo/servo/pull/34995	(@Taym95, #34995)	Script: remove `SafeHandleValue::from_raw` from `DefaultTeeReadRequest` (#34995)
+https://github.com/servo/servo/pull/34994	(@mrobinson, #34994)	config: Remove legacy-layout and unused `Preferences` and `Opts` (#34994)
    prefs
-https://github.com/servo/servo/pull/34993	(@dependabot[bot], @dependabot[bot], #34993)	build(deps): bump miniz_oxide from 0.8.2 to 0.8.3 (#34993)
-https://github.com/servo/servo/pull/34991	(@dependabot[bot], @dependabot[bot], #34991)	build(deps): bump winnow from 0.6.22 to 0.6.24 (#34991)
-https://github.com/servo/servo/pull/34990	(@dependabot[bot], @dependabot[bot], #34990)	build(deps): bump gilrs-core from 0.6.0 to 0.6.1 (#34990)
-https://github.com/servo/servo/pull/34989	(@dependabot[bot], @dependabot[bot], #34989)	build(deps): bump log from 0.4.22 to 0.4.25 (#34989)
-https://github.com/servo/servo/pull/34988	(@dependabot[bot], @dependabot[bot], #34988)	build(deps): bump uuid from 1.11.1 to 1.12.0 (#34988)
-https://github.com/servo/servo/pull/34349	(@chickenleaf, #34349)	mach: Report an error instead of running `try` with a dirty working directory (#34349)
+https://github.com/servo/servo/pull/34966	(@mrobinson, #34966)	api: Flatten and simplify Servo preferences (#34966)
    prefs; major rework that renames all existing prefs (see <https://doc.servo.org/servo_config/prefs/struct.Preferences.html>)
+https://github.com/servo/servo/pull/34983	(@delan, #34983)	CI: use new API for taking a runner (#34983)
    ci
-https://github.com/servo/servo/pull/34812	(@kongbai1996, #34812)	fix click event when long time in touchstart (#34812)
+https://github.com/servo/servo/pull/34957	(@jdm, #34957)	Various servodriver improvements (#34957)
    ci; towards testdriver.js support
-https://github.com/servo/servo/pull/34982	(@delan, #34982)	CI: disable self-hosted runners for nightly.yml (#34982)
>>> 2025-01-16T06:06:18Z
+https://github.com/servo/servo/pull/34958	(@Taym95, #34958)	script: Implement `set_up`, `ReleaseLock`, `Closed`, `Cancel`, `acquire_byob_reader` for `ReadableStreamBYOBReader` (#34958)
    api
-https://github.com/servo/servo/pull/35010	(@atouchet, #35010)	Update test expectations (#35010)
-https://github.com/servo/servo/pull/35009	(@jschwe, #35009)	Fix build failure with tracing feature (#35009)
+https://github.com/servo/servo/pull/33576	(@Gae24, #33576)	Implement Clipboard Event Api (#33576)
    api
-https://github.com/servo/servo/pull/35005	(@dependabot[bot], @dependabot[bot], #35005)	build(deps): bump data-encoding from 2.6.0 to 2.7.0 (#35005)
-https://github.com/servo/servo/pull/35004	(@dependabot[bot], @dependabot[bot], #35004)	build(deps): bump bitflags from 2.7.0 to 2.8.0 (#35004)
+https://github.com/servo/servo/pull/34984	(@rayguo17, @mrobinson, #34984)	layout: Make non-`normal` `align-content` establish a block formatting context (#34984)
    layout; ‘align-content’
-https://github.com/servo/servo/pull/35001	(@mrobinson, #35001)	layout: Remove the obsolete layout tracing functionality (#35001)
+https://github.com/servo/servo/pull/35002	(@delan, #35002)	CI: use new self-hosted runner servers (#35002)
    ci
-https://github.com/servo/servo/pull/35000	(@mrobinson, #35000)	fonts: Remove synchronous web font loading functionality (#35000)
+https://github.com/servo/servo/pull/34997	(@jdm, #34997)	webdriver: Serialize JS int values as i32. (#34997)
    ci; towards testdriver.js support
>>> 2025-01-17T06:04:36Z
-https://github.com/servo/servo/pull/34952	(@jdm, #34952)	Enable more test directories and preferences (#34952)
+https://github.com/servo/servo/pull/34359	(@jdm, #34359)	Support future uses of traits with associated types in rooting analysis (#34359)
    script; towards splitting script crate
-https://github.com/servo/servo/pull/35012	(@Loirooriol, #35012)	layout: Allow layouts to customize their used style (#35012)
-https://github.com/servo/servo/pull/35022	(@Taym95, #35022)	Remove typedarray_elem_siz (#35022)
-https://github.com/servo/servo/pull/35020	(@sagudev, #35020)	chore: Update wgpu and fix webgpu pref (#35020)
+https://github.com/servo/servo/pull/35003	(@Loirooriol, #35003)	layout: Allow different collapsed border style/color within a row/column (#35003)
    layout; table ‘border-collapse’ painting
+https://github.com/servo/servo/pull/34961	(@zhuhaichao518@gmail.com, #34961)	Implement WebResourceRequested Event. (#34961)
    embedding
+https://github.com/servo/servo/pull/34999	(@mrobinson, #34999)	Remove `resources/prefs.json` (#34999)
    prefs
>>> 2025-01-18T06:03:49Z
-https://github.com/servo/servo/pull/35044	(@dependabot[bot], @dependabot[bot], #35044)	build(deps): bump valuable from 0.1.0 to 0.1.1 (#35044)
-https://github.com/servo/servo/pull/35043	(@dependabot[bot], @dependabot[bot], #35043)	build(deps): bump cc from 1.2.9 to 1.2.10 (#35043)
+https://github.com/servo/servo/pull/34998	(@mrobinson, #34998)	prefs: Move some `DebugOptions` to `Preferences` and clean up (#34998)
    prefs; renames some debug options to prefs
-https://github.com/servo/servo/pull/35036	(@sagudev, #35036)	Fix check for unused subdir in wpt import script (#35036)
>>> 2025-01-20T06:05:35Z
+https://github.com/servo/servo/pull/35076	(@simonwuelker, #35076)	Set descendant's attribute's owner document in Node::adopt (#35076)
    shadowdom
+https://github.com/servo/servo/pull/35013	(@simonwuelker, #35013)	Implement shadow dom slots (#35013)
    shadowdom
-https://github.com/servo/servo/pull/35070	(@jdm, #35070)	Make worker script errors more informative. (#35070)
+https://github.com/servo/servo/pull/35058	(@jdm, #35058)	Fix crash when using builtin memory profiler (#35058)
    crash
-https://github.com/servo/servo/pull/35069	(@simonwuelker, #35069)	Remove workaround for fixed ICE (#35069)
+https://github.com/servo/servo/pull/35068	(@simonwuelker, #35068)	Correctly report number of expected test results from ./mach test-wpt (#35068)
    dev
-https://github.com/servo/servo/pull/35025	(@jdm, #35025)	Remove unneeded allow annotation. (#35025)
-https://github.com/servo/servo/pull/35065	(@servo-wpt-sync, #35065)	Update web-platform-tests to revision b'8f3f629756d7351867a8be36d5f217608b9adc61' (#35065)
-https://github.com/servo/servo/pull/35064	(@Loirooriol, #35064)	layout: Remove some unneeded `is_table` parameters (#35064)
+https://github.com/servo/servo/pull/35055	(@jdm, #35055)	script: Feature-gate all crown support. (#35055)
    embedding
-https://github.com/servo/servo/pull/35062	(@Gae24, #35062)	DataTransfer: propagate CanGc argument (#35062)
-https://github.com/servo/servo/pull/35042	(@mrobinson, @Loirooriol, #35042)	layout: Make table column constraint distribution more generic (#35042)
+https://github.com/servo/servo/pull/35056	(@jdm, #35056)	Don't generate gstreamer data when dummy media backend enabled. (#35056)
    embedding
+https://github.com/servo/servo/pull/35057	(@jdm, #35057)	config: Derive defaults for Opts. (#35057)
    embedding
+https://github.com/servo/servo/pull/35049	(@andi.m.mcclure@gmail.com, #35049)	servo-media 1e28d1d997: don't unwrap ServoMedia::get() (#35049)
    embedding
>>> 2025-01-23T06:49:26Z
-https://github.com/servo/servo/pull/35142	(@mukilan, #35142)	ci: remove explicit `permissions` block in bencher.yml (#35142)
+https://github.com/servo/servo/pull/35006	(@jschwe, @mukilan, #35006)	CI: Test ohos on HarmonyOS device (#35006)
    ci
-https://github.com/servo/servo/pull/35130	(@jdm, #35130)	script: Avoid unwraps in DocumentOrShadowRoot::element_from_point. (#35130)
-https://github.com/servo/servo/pull/35136	(@Loirooriol, #35136)	layout: Proper check for BoxFragment generated by a table wrapper box (#35136)
-https://github.com/servo/servo/pull/35127	(@dependabot[bot], @dependabot[bot], #35127)	build(deps): bump is-terminal from 0.4.13 to 0.4.15 (#35127)
-https://github.com/servo/servo/pull/35128	(@dependabot[bot], @dependabot[bot], #35128)	build(deps): bump crunchy from 0.2.2 to 0.2.3 (#35128)
-https://github.com/servo/servo/pull/35126	(@dependabot[bot], @dependabot[bot], #35126)	build(deps): bump rustix from 0.38.43 to 0.38.44 (#35126)
+https://github.com/servo/servo/pull/34884	(@simonwuelker, #34884)	Implement Event propagation across shadow roots (#34884)
    shadowdom
-https://github.com/servo/servo/pull/35114	(@simonwuelker, #35114)	Remove BlobState abstraction (#35114)
-https://github.com/servo/servo/pull/35117	(@delan, #35117)	Install rust-src in rust-toolchain.toml (#35117)
-https://github.com/servo/servo/pull/35112	(@dependabot[bot], @dependabot[bot], #35112)	build(deps): bump uuid from 1.12.0 to 1.12.1 (#35112)
-https://github.com/servo/servo/pull/35109	(@dklassic, #35109)	fix: ohos workflow expression error (#35109)
-https://github.com/servo/servo/pull/35111	(@dependabot[bot], @dependabot[bot], #35111)	build(deps): bump brotli-decompressor from 4.0.1 to 4.0.2 (#35111)
-https://github.com/servo/servo/pull/35110	(@dependabot[bot], @dependabot[bot], #35110)	build(deps): bump etagere from 0.2.14 to 0.2.15 (#35110)
-https://github.com/servo/servo/pull/35104	(@mrobinson, #35104)	Make naming of variables consistent with `SpecificLayoutInfo` (#35104)
+https://github.com/servo/servo/pull/35097	(@Loirooriol, #35097)	layout: Fix border widths of table wrapper with collapsed borders (#35097)
    layout; table ‘border-collapse’ layout
+https://github.com/servo/servo/pull/35100	(@Loirooriol, #35100)	layout: Fix conflict resolution for collapsed borders differing in color (#35100)
    layout; table ‘border-collapse’ painting
+https://github.com/servo/servo/pull/35095	(@mrobinson, @Loirooriol, #35095)	layout: Improve distribution colspan cell inline size (#35095)
    layout; table rowspan sizing
+https://github.com/servo/servo/pull/35075	(@Loirooriol, #35075)	layout: Paint collapsed table borders on their own (#35075)
    layout; table ‘border-collapse’ painting
+https://github.com/servo/servo/pull/35038	(@webbeef, #35038)	Add support for HTMLStyleElement.type (#35038)
    layout
-https://github.com/servo/servo/pull/35102	(@dependabot[bot], @dependabot[bot], #35102)	build(deps): bump etagere from 0.2.13 to 0.2.14 (#35102)
-https://github.com/servo/servo/pull/35101	(@dependabot[bot], @dependabot[bot], #35101)	build(deps): bump clap from 4.5.26 to 4.5.27 (#35101)
-https://github.com/servo/servo/pull/35098	(@atouchet, #35098)	Create servo-media Dependabot group (#35098)
+https://github.com/servo/servo/pull/35096	(@Loirooriol, #35096)	layout: Fix clientWidth & friends for tables (#35096)
    api layout
-https://github.com/servo/servo/pull/35094	(@dependabot[bot], @dependabot[bot], #35094)	build(deps): bump serde_json from 1.0.135 to 1.0.137 (#35094)
-https://github.com/servo/servo/pull/35092	(@dependabot[bot], @dependabot[bot], #35092)	build(deps): bump semver from 1.0.24 to 1.0.25 (#35092)
-https://github.com/servo/servo/pull/35093	(@dependabot[bot], @dependabot[bot], #35093)	build(deps): bump indexmap from 2.7.0 to 2.7.1 (#35093)
-https://github.com/servo/servo/pull/35091	(@dependabot[bot], @dependabot[bot], #35091)	build(deps): bump range-alloc from 0.1.3 to 0.1.4 (#35091)
-https://github.com/servo/servo/pull/35088	(@dependabot[bot], @dependabot[bot], #35088)	build(deps): bump servo-media-dummy from `1ff6758` to `c7eab1a` (#35088)
-https://github.com/servo/servo/pull/35090	(@dependabot[bot], @dependabot[bot], #35090)	build(deps): bump servo-media-gstreamer from `1ff6758` to `c7eab1a` (#35090)
-https://github.com/servo/servo/pull/35089	(@dependabot[bot], @dependabot[bot], #35089)	build(deps): bump ohos-vsync-sys from 0.1.1 to 0.1.2 (#35089)
-https://github.com/servo/servo/pull/35087	(@dependabot[bot], @dependabot[bot], #35087)	build(deps): bump servo-media from `1ff6758` to `c7eab1a` (#35087)
+https://github.com/servo/servo/pull/35085	(@Loirooriol, #35085)	layout: Respect alignment when sizing replaced abspos (#35085)
    layout; replaced abspos sizing
-https://github.com/servo/servo/pull/35080	(@mrobinson, #35080)	Remove `Preferences::network_tls_ignore_unexpected_eof` (#35080)
+https://github.com/servo/servo/pull/34744	(@dklassic, @mrobinson, #34744)	feat: Track the binary size for all the different platforms (#34744)
    perf
>>> 2025-01-24T06:04:14Z
+https://github.com/servo/servo/pull/35052	(@dklassic, #35052)	feat: Turn `RenderingContext` into a trait (#35052)
    embedding; RenderingContext trait
+https://github.com/servo/servo/pull/35132	(@jdm, #35132)	script: Handle shadow roots when determining common ancestors of dirty roots. (#35132)
    shadowdom
+https://github.com/servo/servo/pull/35146	(@Gae24, #35146)	dom: set composed flag when constructing `ClipboardEvent` (#35146)
    api
-https://github.com/servo/servo/pull/35150	(@dependabot[bot], @dependabot[bot], #35150)	build(deps): bump unicode-ident from 1.0.14 to 1.0.15 (#35150)
-https://github.com/servo/servo/pull/35149	(@dependabot[bot], @dependabot[bot], #35149)	build(deps): bump objc2-encode from 4.0.3 to 4.1.0 (#35149)
+https://github.com/servo/servo/pull/35066	(@shanehandley, #35066)	Update the FormData constructor to allow providing a submitter (#35066)
    api
-https://github.com/servo/servo/pull/35147	(@mrobinson, #35147)	Fix some clippy issues on the Android build (#35147)
+https://github.com/servo/servo/pull/35129	(@Loirooriol, #35129)	layout: Hide collapsed borders crossed by spanning cells (#35129)
    layout; table ‘border-collapse’ painting
-https://github.com/servo/servo/pull/35125	(@Loirooriol, #35125)	layout: simplify `CollapsedBorderLine` (#35125)
+https://github.com/servo/servo/pull/35118	(@delan, @mrobinson, #35118)	Add minimal libservo example using winit (#35118)
    webview
+https://github.com/servo/servo/pull/35122	(@Loirooriol, #35122)	layout: Fix table geometry when collapsed borders have different sizes (#35122)
    layout; table ‘border-collapse’ layout
+https://github.com/servo/servo/pull/35116	(@delan, @mrobinson, #35116)	Fix building libservo with `cargo build -p libservo` (#35116)
    webview
-https://github.com/servo/servo/pull/35143	(@jschwe, #35143)	ci: Fix ohos test artifact name (#35143)
>>> 2025-01-25T06:12:33Z
+https://github.com/servo/servo/pull/35148	(@webbeef, #35148)	Add support for HTMLStyleElement.media (#35148)
    api
+https://github.com/servo/servo/pull/35168	(@willypuzzle, #35168)	[35131] Borrow hazard in Document::broadcast_active_resize_observations (#35168)
    crash
-https://github.com/servo/servo/pull/35145	(@Taym95, #35145)	Use Dom in native promise handlers instead of Trusted (#35145)
+https://github.com/servo/servo/pull/35157	(@jdm, #35157)	script: Move code generation and webidl files to new script_bindings crate. (#35157)
    script; towards splitting script crate
+https://github.com/servo/servo/pull/35161	(@sagudev, #35161)	chore: update wgpu to include pointer_composite_access WGSL language extension (#35161)
    api
+https://github.com/servo/servo/pull/35138	(@willypuzzle, #35138)	[#34767] - Range header is missing from CORS header safelist (#35138)
    api; Range requests
-https://github.com/servo/servo/pull/35166	(@Loirooriol, #35166)	wpt: Fix references for `/css/CSS2/tables/table-anonymous-objects-*` (#35166)
-https://github.com/servo/servo/pull/35144	(@Loirooriol, #35144)	layout: Remove min and max container sizes from `FlexContext` (#35144)
-https://github.com/servo/servo/pull/35162	(@Loirooriol, #35162)	wpt: Fix `/css/CSS2/tables/anonymous-table-box-width-001.xht` (#35162)
+https://github.com/servo/servo/pull/35156	(@delan, @mrobinson, #35156)	Remove type parameter from Servo and IOCompositor (#35121) (#35156)
    webview
+https://github.com/servo/servo/pull/35154	(@webbeef, #35154)	Fix winit_minimal.rs build (#35154)
    webview
>>> 2025-01-26T06:07:52Z
+https://github.com/servo/servo/pull/35041	(@mrobinson, #35041)	script: Do not set up an IPC route for every image load (#35041)
    net; network perf (dota2.com)
+https://github.com/servo/servo/pull/35119	(@delan, @mrobinson, #35119)	libservo: Add an initial WebView data structure to the API (#35119)
    webview
+https://github.com/servo/servo/pull/35169	(@jdm, #35169)	Make generated bindings generic over DOM types (#35169)
    script; towards splitting script crate
>>> 2025-01-27T06:06:26Z
-https://github.com/servo/servo/pull/35174	(@servo-wpt-sync, #35174)	Update web-platform-tests to revision b'e5e7dab5e72edd352b17105acce2b8f443face10' (#35174)
>>> 2025-01-28T06:05:12Z
+https://github.com/servo/servo/pull/35165	(@Loirooriol, #35165)	layout: Zero out collapsed track sizes when painting collapsed borders (#35165)
    layout; table ‘border-collapse’ layout
+https://github.com/servo/servo/pull/35163	(@Loirooriol, #35163)	layout: Correctly resolve `currentcolor` on collapsed borders (#35163)
    layout; ‘border-collapse’
-https://github.com/servo/servo/pull/35186	(@dependabot[bot], @dependabot[bot], #35186)	build(deps): bump rustls-pki-types from 1.10.1 to 1.11.0 (#35186)
+https://github.com/servo/servo/pull/35040	(@Taym95, #35040)	Script: implement `ReadableStreamBYOBReader::Read` (#35040)
    api
+https://github.com/servo/servo/pull/35177	(@simonwuelker, #35177)	Propagate events from slottables to their assigned slot instead of their parent (#35177)
    shadowdom
+https://github.com/servo/servo/pull/35167	(@mrobinson, @Loirooriol, #35167)	layout: Take perentage columns into account when sizing table grid min and max (#35167)
    layout; table sizing with ‘width: %’ cell
+https://github.com/servo/servo/pull/35170	(@Loirooriol, #35170)	layout: Improve fixed table layout (#35170)
    layout; ‘table-layout: fixed’ interop
+https://github.com/servo/servo/pull/35137	(@simonwuelker, #35137)	Fire slot change events when the slot content changes (#35137)
    shadowdom
-https://github.com/servo/servo/pull/35175	(@shanehandley, #35175)	Remove UTF-8 BOM before parsing JSON (#35175)
-https://github.com/servo/servo/pull/35180	(@delan, #35180)	CI: temporarily stop running libservo builds by default (#35180)
>>> 2025-01-29T06:04:28Z
+https://github.com/servo/servo/pull/35198	(@simonwuelker, #35198)	Never compute style for children of shadow hosts (#35198)
    shadowdom
-https://github.com/servo/servo/pull/35203	(@dependabot[bot], @dependabot[bot], #35203)	build(deps): bump hyper from 1.5.2 to 1.6.0 (#35203)
-https://github.com/servo/servo/pull/35202	(@dependabot[bot], @dependabot[bot], #35202)	build(deps): bump unicode-ident from 1.0.15 to 1.0.16 (#35202)
-https://github.com/servo/servo/pull/35201	(@dependabot[bot], @dependabot[bot], #35201)	build(deps): bump winnow from 0.6.24 to 0.6.25 (#35201)
-https://github.com/servo/servo/pull/35199	(@dependabot[bot], @dependabot[bot], #35199)	build(deps): bump ryu from 1.0.18 to 1.0.19 (#35199)
-https://github.com/servo/servo/pull/35200	(@dependabot[bot], @dependabot[bot], #35200)	build(deps): bump httparse from 1.9.5 to 1.10.0 (#35200)
+https://github.com/servo/servo/pull/35183	(@mrobinson, @delan, #35183)	libservo: Port desktop servoshell to use the new `WebView` API (#35183)
    webview
+https://github.com/servo/servo/pull/35185	(@mrobinson, #35185)	libservo: Stop using `script_traits` in the embedding layer (#35185)
    webview
-https://github.com/servo/servo/pull/35187	(@dependabot[bot], @dependabot[bot], #35187)	build(deps): bump cpufeatures from 0.2.16 to 0.2.17 (#35187)
>>> 2025-01-30T06:13:03Z
-https://github.com/servo/servo/pull/35217	(@dependabot[bot], @dependabot[bot], #35217)	build(deps): bump xcomponent-sys from 0.3.0 to 0.3.1 (#35217)
-https://github.com/servo/servo/pull/35216	(@dependabot[bot], @dependabot[bot], #35216)	build(deps): bump serde_json from 1.0.137 to 1.0.138 (#35216)
-https://github.com/servo/servo/pull/35215	(@dependabot[bot], @dependabot[bot], #35215)	build(deps): bump bumpalo from 3.16.0 to 3.17.0 (#35215)
-https://github.com/servo/servo/pull/35214	(@dependabot[bot], @dependabot[bot], #35214)	build(deps): bump arkui-sys from 0.2.3 to 0.2.4 (#35214)
-https://github.com/servo/servo/pull/35213	(@dependabot[bot], @dependabot[bot], #35213)	build(deps): bump ohos-ime-sys from 0.1.3 to 0.1.4 (#35213)
-https://github.com/servo/servo/pull/35212	(@dependabot[bot], @dependabot[bot], #35212)	build(deps): bump ohos-drawing-sys from 0.2.1 to 0.2.2 (#35212)
+https://github.com/servo/servo/pull/35207	(@Loirooriol, #35207)	layout: Remove wrong optimization when placing table among floats (#35207)
    layout; table float interaction
+https://github.com/servo/servo/pull/35158	(@jschwe, #35158)	ohos: Support resizing the surface (#35158)
    ohos
+https://github.com/servo/servo/pull/35191	(@simonwuelker, #35191)	Use "slot" attribute for slottable name (#35191)
    shadowdom
+https://github.com/servo/servo/pull/35192	(@mrobinson, #35192)	servoshell: Port Android / OHOS servoshell to use the WebView API (#35192)
    webview
+https://github.com/servo/servo/pull/35172	(@jdm, #35172)	bindings: Move string-related bindings code to script_bindings. (#35172)
    script; towards splitting script crate
>>> 2025-01-31T06:05:46Z
+https://github.com/servo/servo/pull/35226	(@mrobinson, #35226)	script_traits: Rename `ConstellationControlMsg` to `ScriptThreadMessage` (#35226)
    webview
-https://github.com/servo/servo/pull/34981	(@Loirooriol, #34981)	Let animations&transitions fall back to discrete interpolation (#34981)
-https://github.com/servo/servo/pull/35225	(@mrobinson, #35225)	libservo: Move Android `MediaSessionAction` conversion to servoshell (#35225)
-https://github.com/servo/servo/pull/35106	(@jschwe, #35106)	Use aws-lc-rs as rust-tls provider (#35106)
+https://github.com/servo/servo/pull/35228	(@mrobinson, #35228)	Merge webxr repository (#35228)
    dev
+https://github.com/servo/servo/pull/35222	(@simonwuelker, #35222)	Don't fire slotchange events when there's already a pending event for the same slot (#35222)
    shadowdom
+https://github.com/servo/servo/pull/35211	(@delan, @mrobinson, #35211)	Include `WebViewId` into EmbedderMsg variants where possible (#35211)
    webview
-https://github.com/servo/servo/pull/35223	(@mrobinson, #35223)	compositor: Remove some unused messages to the compositor (#35223)
-https://github.com/servo/servo/pull/35224	(@mrobinson, #35224)	servoshell: Remove debugging `println!` (#35224)
+https://github.com/servo/servo/pull/35221	(@simonwuelker, #35221)	Potentially signal a slot change in Node::insert (#35221)
    shadowdom
[/commits]-->

<style>
    .content {
        container-type: inline-size;
    }
    ._paired_figure {
        margin: 1em 0;
    }
    @container (min-width: 55em) {
        ._paired_figure {
            display: grid;
            grid-template-columns: auto 33em;
            column-gap: 2em;
            row-gap: 1em;
        }
        ._paired_figure > ._text_before,
        ._paired_figure > ._text_after {
            flex: 1 1 20em;
            grid-column: 1 / 2;
        }
        ._paired_figure > figure:not(#specificity) {
            flex: 0 1 33em;
            grid-row: 1 / 3;
            grid-column: 2 / 3;
            margin: 0;
        }
    }

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
