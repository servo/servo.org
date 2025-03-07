---
layout:     post
tags:       blog
title:      "This month in Servo: and more!"
date:       2025-03-07
summary:    ao!! wrrrrao!!
categories:
---

<!--
- donations
    - 1686.48/month opencollective
    - 2677.00/month github
    - 21 donors thanks.dev
- api
    - `https://github.com/servo/servo/pull/35237	(@sagudev, #35237)	webgpu: implement get image for webgpu canvas (#35237)
      api
    - `https://github.com/servo/servo/pull/35250	(@shanehandley, #35250)	script: Implement the Bytes() method on Request and Response (#35250)
      api
    - `https://github.com/servo/servo/pull/35074	(@Taym95, #35074)	Script: implement ReadableStreamBYOBRequest (#35074)
      api
    - `https://github.com/servo/servo/pull/35295	(@Loirooriol, #35295)	Don't require index parameter in `CSSGroupingRule`'s `insertRule()` (#35295)
      api
    - https://github.com/servo/servo/pull/35314	(@stevennovaryo, #35314)	dom: IntersectionObserver initialization (#35314)
      api
    - https://github.com/servo/servo/pull/35246	(@webbeef, #35246)	Update window.screenX and window.screenY when moving the embedder window (#35246)
      api
    - `https://github.com/servo/servo/pull/35364	(@pewsheen, #35364)	feat: dispatch mouse `contextmenu` event to DOM and embedder (#35364)
      api
    - `https://github.com/servo/servo/pull/35482	(@shanehandley, #35482)	script: implement HTMLHyperlinkElementUtils for HTMLAreaElement (#35482)
      api
    - `https://github.com/servo/servo/pull/34844	(@gterzian, @jdm, #34844)	dom: Implement `WritableStream` (#34844)
      api
    - `https://github.com/servo/servo/pull/35262	(@mukilan, #35262)	script: add skeleton implementation of `FontFace` API (#35262)
      api
    - `https://github.com/servo/servo/pull/35151	(@yoseio, @gterzian, @Taym95, #35151)	script: Implement `Blob::bytes()` (#35151)
      api
- crash
    - https://github.com/servo/servo/pull/35235	(@webbeef, #35235)	Fix crash in screenX and screenY getters returning negative values (#35235)
      crash
    - https://github.com/servo/servo/pull/35381	(@mrobinson, #35381)	dom: Always replace unpaired surrogates when handling page text (#35381)
      crash
    - https://github.com/servo/servo/pull/35606	(@simonwuelker, #35606)	Don't tell stylo about stylesheets that are not in a browsing context (#35606)
      crash
    - https://github.com/servo/servo/pull/35699	(@Gae24, #35699)	script: Avoid double borrow crash in `DataTransferItem` (#35699)
      crash
- `css
    - `https://github.com/servo/servo/pull/35420	(@Loirooriol, #35420)	Enable the `quotes` CSS property (#35420)
      css
    - `https://github.com/servo/servo/pull/35413	(@Loirooriol, #35413)	layout: Basic implementation of size keywords on `flex-basis` (#35413)
      css
    - `https://github.com/servo/servo/pull/35103	(@longvatrong111, #35103)	Implement overflow:clip (#35103)
      css
    - `https://github.com/servo/servo/pull/35414	(@yezhizhenjiakang@gmail.com, @mrobinson, #35414)	layout: Implement overflow scroll support for different axes (#35414)
      css
    - `https://github.com/servo/servo/pull/35469	(@Loirooriol, #35469)	layout: Partial support for sizing keywords on flex items (#35469)
      css
    - `https://github.com/servo/servo/pull/35552	(@kingsley@kkoyung.dev, @Loirooriol, #35552)	Support for the `isolation` CSS property (#35552)
      css
    - `https://github.com/servo/servo/pull/34770	(@xiaochengh.work@gmail.com, #34770)	layout: Implement a non-recursive version of CSS `quotes` (#34770)
      css
- dev
    - https://github.com/servo/servo/pull/35327	(@rayguo17, #35327)	change terminal wrapper library from blessing to blessed to support running mach test-wpt on windows. (#35327)
      dev
    - https://github.com/servo/servo/pull/35573	(@delan, #35573)	Fix mach argument quoting on NixOS (#35573)
      dev
- devtools
    - https://github.com/servo/servo/pull/35502	(@mrobinson, #35502)	servoshell: Actually set the Servo delegate in servoshell (#35502)
      devtools
    - https://github.com/servo/servo/pull/35416	(@jdm, #35416)	script: Add custom logging representation for DOM interfaces. (#35416)
      devtools
- `element
    - `https://github.com/servo/servo/pull/35524	(@simonwuelker, #35524)	Support the `<meter>` element (#35524)
      element
    - `https://github.com/servo/servo/pull/35261	(@simonwuelker, #35261)	Allow the `<details>` element to be opened and closed (#35261)
      element
    - `https://github.com/servo/servo/pull/35531	(@simonwuelker, #35531)	Implement the <progress> element (#35531)
      element
- `embedding
    - `https://github.com/servo/servo/pull/35229	(@mrobinson, #35229)	Finish the integration of `webxr` into the Cargo workspace (#35229)
      embedding; embedders no longer need to know about webxr types
    - `https://github.com/servo/servo/pull/35256	(@jdm, #35256)	libservo: Make background hang monitor integration optional. (#35256)
      embedding
    - `https://github.com/servo/servo/pull/35253	(@roberto.huertas@outlook.com, #35253)	chore(servo): simplify servo example (#35253)
      embedding
    - -https://github.com/servo/servo/pull/35263	(@dklassic, #35263)	chore: Rename `CompositeTarget` enum (#35263)
      embedding
    - `https://github.com/servo/servo/pull/35260	(@mrobinson, #35260)	libservo: Combine `LoadStart, `HeadParsed`, and `LoadComplete` messages (#35260)
      embedding
    - `https://github.com/servo/servo/pull/35283	(@mrobinson, #35283)	libservo: Remove `Servo::repaint_synchronously` (#35283)
      embedding
    - `https://github.com/servo/servo/pull/35277	(@mrobinson, #35277)	libservo: Remove `EmbedderEvent::WindowResize` (#35277)
      embedding
    - `https://github.com/servo/servo/pull/35251	(@wusyong, #35251)	Simplify `RenderingContext` trait methods (#35251)
      embedding
    - `https://github.com/servo/servo/pull/35196	(@delan, @mrobinson, @mukilan, #35196)	libservo: Add WebViewDelegate and ServoDelegate and port `winit_minimal` (#35196)
      embedding
    - `https://github.com/servo/servo/pull/35315	(@mukilan, @mrobinson, #35315)	Migrate Android and OHOS ports to the delegate API (#35315)
      embedding
    - `https://github.com/servo/servo/pull/35284	(@mrobinson, @delan, @mukilan, #35284)	servoshell: Port desktop servoshell to use delegate API (#35284)
      embedding
    - `https://github.com/servo/servo/pull/35297	(@mrobinson, #35297)	libservo: Add a `ClipboardDelegate` and a default implementation (#35297)
      embedding
    - `https://github.com/servo/servo/pull/35350	(@webbeef, #35350)	wini_minimal: trigger initial rendering and scroll properly (#35350)
      embedding
    - `https://github.com/servo/servo/pull/35366	(@mrobinson, #35366)	libservo: Remove message-based API (#35366)
      embedding
    - `https://github.com/servo/servo/pull/35400	(@mrobinson, #35400)	libservo: Add a delegate method for HTTP authentication (#35400)
      embedding
    - `https://github.com/servo/servo/pull/35396	(@mrobinson, @mukilan, #35396)	libservo: Flesh out permissions API (#35396)
      embedding
    - -https://github.com/servo/servo/pull/35445	(@mukilan, #35445)	libservo: change 'request_fullscreen_state_change' API to a notification (#35445)
      embedding
    - `https://github.com/servo/servo/pull/35430	(@mrobinson, @mukilan, #35430)	libservo: Expose a single `InputEvent` type and pass it to script (#35430)
      embedding
    - `https://github.com/servo/servo/pull/35369	(@mrobinson, #35369)	libservo: Don't bounce ready-to-present frame notifications to the Constellation (#35369)
      perf
    - `https://github.com/servo/servo/pull/35479	(@jdm, #35479)	Make WebBluetooth an optional feature. (#35479)
      embedding
    - `https://github.com/servo/servo/pull/35465	(@mrobinson, @mukilan, #35465)	libservo: Expose an `OffscreenRenderingContext` and use it for servoshell (#35465)
      embedding
    - `https://github.com/servo/servo/pull/35501	(@mrobinson, #35501)	libservo: Expose `SoftwareRenderingContext` and `WindowRenderingContext` (#35501)
      embedding
    - `https://github.com/servo/servo/pull/35536	(@mrobinson, @wusyong, #35536)	compositing: Split non-WebView-specific data into `ServoRenderer` (#35536)
      embedding
    - `https://github.com/servo/servo/pull/35544	(@mrobinson, #35544)	Remove `Servo::allow_navigation_request` (#35544)
      embedding
    - `https://github.com/servo/servo/pull/35522	(@mrobinson, @wusyong, @mukilan, #35522)	libservo: Rework and clarify the rendering model of the `WebView` (#35522)
      embedding
    - `https://github.com/servo/servo/pull/35538	(@mrobinson, @wusyong, #35538)	compositing: Move image output and shutdown management out of the compositor (#35538)
      embedding
    - `https://github.com/servo/servo/pull/35553	(@mrobinson, #35553)	libservo: Move GL acclerated media setup out of `RenderingContext` and simplify it (#35553)
      embedding
    - https://github.com/servo/servo/pull/35547	(@delan, #35547)	libservo: Clean up destroyed webview handles (#35547)
      embedding
    - `https://github.com/servo/servo/pull/35590	(@webbeef, #35590)	build winit_minimal with bluetooth disabled (#35590)
      embedding
    - `https://github.com/servo/servo/pull/35564	(@mrobinson, #35564)	libservo: Convert `intercept_web_resource_load` into `load_web_resource` (#35564)
      embedding
    - -https://github.com/servo/servo/pull/35624	(@delan, #35624)	libservo: Refactor ipc-channel default response logic (#35624)
      embedding
    - https://github.com/servo/servo/pull/35602	(@mrobinson, #35602)	libservo: Move WebDriver messages to the `embedder` crate (#35602)
      webdriver
    - `https://github.com/servo/servo/pull/35621	(@mrobinson, #35621)	libservo: Move size handling to `RenderContext` from `WindowMethods` (#35621)
      embedding
    - `https://github.com/servo/servo/pull/35686	(@webbeef, #35686)	winit_minimal: fix build breakage (#35686)
      embedding
    - `https://github.com/servo/servo/pull/35579	(@delan, #35579)	libservo: Clean up interfaces for alert()/confirm()/prompt() (#35579)
      embedding
    - `https://github.com/servo/servo/pull/35662	(@mrobinson, #35662)	libservo: Add `WebView` immediately to the Compositor (#35662)
      embedding
    - `https://github.com/servo/servo/pull/35672	(@delan, @mrobinson, #35672)	Make auxiliary webviews exist in the constellation immediately (#35672)
      embedding
    - `https://github.com/servo/servo/pull/35691	(@webbeef, #35691)	winit_mininal: support proper window resizing (#35691)
      embedding
- gc
    - https://github.com/servo/servo/pull/35541	(@augustebaum, #35541)	Propagate `CanGc` arguments through callers in constructors (#35541)
      gc
    - https://github.com/servo/servo/pull/35593	(@yerkebulan@gmail.com, #35593)	refactor: add CanGc as argument to extract_size_algorithm (#35593)
      gc
    - https://github.com/servo/servo/pull/35565	(@augustebaum, #35565)	refactor: propagate CanGc arguments through callers (#35565)
      gc
    - https://github.com/servo/servo/pull/35610	(@yerkebulan@gmail.com, #35610)	refactor: add CanGc as argument to DataBlock::view (#35610)
      gc
    - https://github.com/servo/servo/pull/35591	(@augustebaum, #35591)	refactor: propagate CanGc arguments through callers (#35591)
      gc
    - https://github.com/servo/servo/pull/35609	(@yerkebulan@gmail.com, #35609)	refactor: add CanGc as argument to WindowProxy::set_window (#35609)
      gc
    - https://github.com/servo/servo/pull/35601	(@yerkebulan@gmail.com, #35601)	refactor: add CanGc as argument to SubtleCrypto::import_key_{pbkdf2, aes, hkdf, hmac} (#35601)
      gc
    - https://github.com/servo/servo/pull/35596	(@yerkebulan@gmail.com, @jdm, #35596)	refactor: add CanGc as argument to create_buffer_source_with_length (#35596)
      gc
    - https://github.com/servo/servo/pull/35595	(@yerkebulan@gmail.com, #35595)	refactor: add CanGc as argument to CountQueuingStrategy::GetSize (#35595)
      gc
    - https://github.com/servo/servo/pull/35594	(@yerkebulan@gmail.com, #35594)	refactor: add CanGc as argument to ByteLengthQueuingStrategy::GetSize (#35594)
      gc
    - https://github.com/servo/servo/pull/35597	(@yerkebulan@gmail.com, #35597)	refactor: add CanGc as argument to create_buffer_source (#35597)
      gc
    - https://github.com/servo/servo/pull/35622	(@yerkebulan@gmail.com, #35622)	refactor: add CanGc as argument to Promise::reject (#35622)
      gc
    - https://github.com/servo/servo/pull/35604	(@augustebaum, #35604)	Propagate more `CanGc` (#35604)
      gc
    - https://github.com/servo/servo/pull/35616	(@yerkebulan@gmail.com, #35616)	refactor: add CanGc as argument to Promise::resolve (#35616)
      gc
    - https://github.com/servo/servo/pull/35605	(@Gae24, #35605)	script: add `CanGc` argument to `Promise::new_resolved` and `Promise::new_rejected` (#35605)
      gc
    - https://github.com/servo/servo/pull/35640	(@yerkebulan@gmail.com, #35640)	refactor: add CanGc as argument to Promise::reject_native (#35640)
      gc
    - https://github.com/servo/servo/pull/35647	(@yerkebulan@gmail.com, #35647)	refactor: add CanGc as argument to exception_to_promise (#35647)
      gc
    - https://github.com/servo/servo/pull/35646	(@yerkebulan@gmail.com, #35646)	refactor: add CanGc as argument to Promise::reject_error (#35646)
      gc
- input
    - https://github.com/servo/servo/pull/35450	(@kongbai1996, #35450)	fix issue #35449: handle touch events in on_input_event. (#35450)
      input
    - https://github.com/servo/servo/pull/35031	(@kongbai1996, #35031)	implement Touchevent prevent default behavior (#35031)
      input
    - https://github.com/servo/servo/pull/35535	(@dklassic, #35535)	feat: support pre-edit text display for IME (#35535)
      input
    - https://github.com/servo/servo/pull/35550	(@kongbai1996, #35550)	fix touch event wrong coordinates. pageX, pageY, clientX, clientY etc. (#35550)
      input
    - https://github.com/servo/servo/pull/35623	(@dklassic, #35623)	feat: support IME cursor area (#35623)
      input
    - https://github.com/servo/servo/pull/35537	(@kongbai1996, @schwenderjonathan@gmail.com, #35537)	Touch handler: Fix race condition and rate-limit move events (#35537)
      input
    - https://github.com/servo/servo/pull/35692	(@shubhamg13, #35692)	Set limits on pinch zoom (#35692)
      input
- `layout
    - -https://github.com/servo/servo/pull/35264	(@Loirooriol, #35264)	layout: Don't let table grid boxes inherit `display: inline-table` (#35264)
      layout
    - `https://github.com/servo/servo/pull/35178	(@rayguo17, #35178)	layout: align-content with default value normal should behave as strech in flex container (#35178)
      layout
    - -https://github.com/servo/servo/pull/35209	(@Loirooriol, #35209)	layout: Limit `content_inline_size_for_table` override to collapsed columns (#35209)
      layout
    - `https://github.com/servo/servo/pull/35208	(@Loirooriol, #35208)	layout: Implement default overflow alignment for abspos (#35208)
      layout
    - -https://github.com/servo/servo/pull/35293	(@longvatrong111, #35293)	Add border radius to overflow scrollable frame (#35293)
      layout
    - -https://github.com/servo/servo/pull/35290	(@Loirooriol, #35290)	layout: Simplify `Table::compute_inline_content_sizes` (#35290)
      layout
    - `https://github.com/servo/servo/pull/35014	(@stevennovaryo, #35014)	layout: Fix relative positioned grid item (#35014)
      layout
    - -https://github.com/servo/servo/pull/35443	(@Loirooriol, #35443)	layout: Remove `BoxFragment::overflow_clip_rect()` (#35443)
      layout
    - `https://github.com/servo/servo/pull/35471	(@Loirooriol, #35471)	layout: Fully support sizing keywords on main size property of flex item (#35471)
      layout
    - `https://github.com/servo/servo/pull/35630	(@Loirooriol, #35630)	layout: Ignore indefinite `stretch` on min and max sizing properties (#35630)
      layout
    - `https://github.com/servo/servo/pull/35642	(@Loirooriol, #35642)	layout: Let `automatic_min_size()` take a flex-relative cb size (#35642)
      layout
    - `https://github.com/servo/servo/pull/35663	(@Loirooriol, #35663)	layout: Support `stretch` cross size for flex base size (#35663)
      layout
    - `https://github.com/servo/servo/pull/35652	(@Loirooriol, #35652)	layout: Support `stretch` cross size for automatic min size in flexbox (#35652)
      layout
    - `https://github.com/servo/servo/pull/35688	(@Loirooriol, #35688)	layout: Use definite cross size to compute flex base size (#35688)
      layout
- net
    - https://github.com/servo/servo/pull/34986	(@shubhamg13, @shubham.gupta@chromium.org, @jdm, #34986)	Add support for Upgrade request to a potentially trustworthy URL. (#34986)
      net
    - https://github.com/servo/servo/pull/35357	(@shubhamg13, #35357)	Modify the checks for upgrade-request algorithm (#35357)
      net
    - https://github.com/servo/servo/pull/35309	(@willypuzzle, #35309)	implemented feture and tests (#35309)
      net
    - https://github.com/servo/servo/pull/34794	(@shubhamg13, #34794)	Add support for Upgrade a mixed content request. (#34794)
      net
    - https://github.com/servo/servo/pull/35483	(@jdm, #35483)	net: Use the unfiltered response status when comparing against cached resources. (#35483)
      net
- notifications
    - https://github.com/servo/servo/pull/35442	(@jdm, #35442)	Run WPT notifications tests. (#35442)
      notifications
    - https://github.com/servo/servo/pull/34842	(@pewsheen, @jdm, #34842)	feat: add `Notification` Web API binding (#34842)
      notifications
- perf
    - https://github.com/servo/servo/pull/35245	(@webbeef, #35245)	Only consider fully active documents when running the 'update the rendering' steps (#35245)
      perf
    - https://github.com/servo/servo/pull/35370	(@jschwe, #35370)	Add cli option for tracing-filter (#35370)
      perf
    - https://github.com/servo/servo/pull/35592	(@webbeef, #35592)	dom: Move child_list to rare data (#35592)
      perf
    - https://github.com/servo/servo/pull/35554	(@webbeef, #35554)	dom: move node ranges to raredata (#35554)
      perf
    - https://github.com/servo/servo/pull/35607	(@webbeef, #35607)	Remove the traversal for DomRoot values when collection memory usage (#35607)
      perf
    - https://github.com/servo/servo/pull/35618	(@webbeef, #35618)	Improve scheduling of the memory profiler. (#35618)
      perf
- script
    - https://github.com/servo/servo/pull/35280	(@jdm, #35280)	Move more foundational types to script_bindings (#35280)
      script
    - https://github.com/servo/servo/pull/35279	(@jdm, #35279)	Move various reflector types and traits to script_bindings (#35279)
      script
    - https://github.com/servo/servo/pull/35292	(@jdm, #35292)	Make generated proxy handlers and DOM object hooks generic (#35292)
      script
    - https://github.com/servo/servo/pull/35435	(@mukilan, #35435)	script: reset spurious frame counter *only* when reflow is triggered (#35435)
      script
    - https://github.com/servo/servo/pull/35387	(@mukilan, #35387)	script: fix spurious animation checks to correctly invoke rAF callbacks (#35387)
      script
    - https://github.com/servo/servo/pull/35578	(@jdm, #35578)	Move more bindings code to script_bindings (#35578)
      script
    - https://github.com/servo/servo/pull/35459	(@jdm, #35459)	script: Make callbacks generic over DOM interfaces. (#35459)
      script
    - https://github.com/servo/servo/pull/35457	(@jdm, #35457)	script: Refer to DOM interfaces with generic types in generated bindings. (#35457)
      script
    - https://github.com/servo/servo/pull/35620	(@jdm, #35620)	Move more bindings types to script_bindings (#35620)
      script
- servodriver
    - https://github.com/servo/servo/pull/35677	(@jdm, #35677)	Allow webdriver screenshots to occur immediately upon request. (#35677)
      servodriver
- `servoshell
    - `https://github.com/servo/servo/pull/34823	(@chickenleaf, #34823)	servoshell: Migrate to egui-file-dialog from tinyfiledialogs (#34823)
      servoshell
    - `https://github.com/servo/servo/pull/35317	(@mrobinson, #35317)	libservo: Enable file directory listing by default (#35317)
      servoshell
    - `https://github.com/servo/servo/pull/35377	(@mrobinson, #35377)	servoshell: Move `headless` setting to ServoShellPreferences (#35377)
      embedding
    - `https://github.com/servo/servo/pull/35407	(@mrobinson, #35407)	servoshell: Move `initial_window_size` and `screen_size_override` into `ServoShellPreferences` from `Opts` (#35407)
      embedding
    - `https://github.com/servo/servo/pull/35399	(@chickenleaf, #35399)	servoshell: Port alert/confirm dialog code to use egui intead of tinyfiledialogs (#35399)
      servoshell
    - `https://github.com/servo/servo/pull/35464	(@chickenleaf, #35464)	servoshell: Port input dialog code to use egui intead of tinyfiledialogs (#35464)
      servoshell
    - `https://github.com/servo/servo/pull/35507	(@chickenleaf, #35507)	servoshell: Port Authentication dialog code to use egui intead of tinyfiledialogs (#35507)
      servoshell
    - -https://github.com/servo/servo/pull/35546	(@dklassic, #35546)	chore: cleanup IME code for Servoshell (#35546)
      servoshell
    - `https://github.com/servo/servo/pull/35577	(@chickenleaf, #35577)	servoshell: Port Permission dialog code to use egui instead of tinyfiledialogs (#35577)
      servoshell
    - `https://github.com/servo/servo/pull/35569	(@pewsheen, #35569)	fix(servoshell): blank view when close non focused tab (#35569)
      servoshell
    - `https://github.com/servo/servo/pull/35671	(@chickenleaf, #35671)	Blocks all background webview interactions when a dialog is open (#35671)
      servoshell
    - `https://github.com/servo/servo/pull/35657	(@chickenleaf, #35657)	servoshell: Port SelectDevice dialog code to use egui instead of tinyfiledialogs (#35657)
      servoshell
    - `https://github.com/servo/servo/pull/35674	(@chickenleaf, #35674)	Remove tinyfiledialogs dependency (#35674)
      servoshell
- `shadowdom
    - `https://github.com/servo/servo/pull/35220	(@simonwuelker, #35220)	Lay out the contents of slot elements (#35220)
      shadowdom
    - `https://github.com/servo/servo/pull/35276	(@simonwuelker, #35276)	Make traverse_preorder follow children of shadow hosts (#35276)
      shadowdom
    - `https://github.com/servo/servo/pull/35294	(@simonwuelker, #35294)	Inform the devtools about shadow roots on a node (#35294)
      shadowdom
    - `https://github.com/servo/servo/pull/35338	(@simonwuelker, #35338)	Implement ServoLayoutNode::traversal_parent (#35338)
      shadowdom
    - `https://github.com/servo/servo/pull/35352	(@simonwuelker, #35352)	Add support for the `::slotted` selector (#35352)
      shadowdom
    - `https://github.com/servo/servo/pull/35380	(@simonwuelker, #35380)	Handle assigned slottables in an Event's path (#35380)
      shadowdom
    - `https://github.com/servo/servo/pull/35382	(@maxtidev, @max@maxti.dev, @jdm, #35382)	script: Add shadow dom check to custom element constructor (#35382)
      shadowdom
    - `https://github.com/servo/servo/pull/35519	(@simonwuelker, #35519)	Don't attempt to report style attribute for non-htmlelements to devtools (#35519)
      shadowdom
- `tables
    - `https://github.com/servo/servo/pull/35219	(@Loirooriol, #35219)	layout: Fix painting order of collapsed table borders (#35219)
      tables
- unsafe
    - https://github.com/servo/servo/pull/35367	(@stephenmuss@gmail.com, #35367)	script: make methods of ErrorInfo safe (#35367)
      unsafe
    - https://github.com/servo/servo/pull/35360	(@stephenmuss@gmail.com, #35360)	script: make throw_invalid_this and throw_constructor_without_new safe (#35360)
      unsafe
    - https://github.com/servo/servo/pull/35351	(@nolen@scaife.org, #35351)	make report_pending_exception safe and adjust callers (#35351)
      unsafe
    - https://github.com/servo/servo/pull/35411	(@stephenmuss@gmail.com, #35411)	script: make Error::to_jsval safe (#35411)
      unsafe
- upgrade
    - https://github.com/servo/servo/pull/35289	(@Loirooriol, #35289)	Upgrade Stylo to 2025-02-03 (#35289)
      upgrade
    - https://github.com/servo/servo/pull/35325	(@mrobinson, #35325)	deps: Upgrade to `webrender@0.66` (#35325)
      upgrade
    - https://github.com/servo/servo/pull/35353	(@mukilan, #35353)	servoshell: upgrade egui and related depenencies (#35353)
      upgrade
    - https://github.com/servo/servo/pull/35503	(@sagudev, #35503)	chore: Update wgpu (#35503)
      upgrade
    - https://github.com/servo/servo/pull/35639	(@sagudev, #35639)	chore: Update wgpu (#35639)
      upgrade
    - https://github.com/servo/servo/pull/35628	(@simonwuelker, #35628)	Update to rust 1.85 (#35628)
      upgrade
-->

Servo now supports more HTML and CSS features:

- the **&lt;details>** element (@simonwuelker, #35261)
- the **&lt;meter>** element (@simonwuelker, #35524)
- the **&lt;progress>** element (@simonwuelker, #35531)
- the **‘quotes’** property (@xiaochengh, @Loirooriol, #34770, #35420)
- the **‘isolation’** property (@kkoyung, @Loirooriol, #35552)
- **‘overflow: clip’** (@longvatrong111, #35103)
- **‘overflow’** property with two values (@yezhizhen, @mrobinson, #35414)
- the **‘::slotted’** selector (@simonwuelker, #35352)

Plus several new web API features:

- **contextmenu** events (@pewsheen, #35364)
- **WritableStream** (@gterzian, @jdm, #34844)
- **ReadableStreamBYOBRequest** (@Taym95, #35074)
- initial support for **FontFace** and its **load()** method (@mukilan, #35262)
- **toBlob()** and **toDataURL()** on **WebGPU canvases** (@sagudev, #35237)
- **bytes()** on **Request**, **Response**, and **Blob** (@shanehandley, @yoseio, @gterzian, @Taym95, #35250, #35151)
- **href**, **origin**, **protocol**, **username**, **password**, **host**, **hostname**, **port**, **pathname**, **search**, and **hash** properties on **HTMLAreaElement** (@shanehandley, #35482)
- **insertRule() with no argument** on **CSSGroupingRule** (@Loirooriol, #35295)

**&lt;slot> elements** are now fully supported including layout (@simonwuelker, #35220, #35519), and we’ve also landed support for the **‘::slotted’** selector (@simonwuelker, #35352).
**Shadow roots** are now **supported in devtools** (@simonwuelker, #35294), and we’ve fixed some bugs related to shadow DOM trees (@simonwuelker, #35276, #35338), event handling (@simonwuelker, #35380), and custom elements (@maxtidev, @jdm, #35382).

We’ve landed layout improvements around **‘border-collapse’** (@Loirooriol, #35219), **‘align-content: normal’** (@rayguo17, #35178), **‘place-self’** with **‘position: absolute’** (@Loirooriol, #35208), the **intrinsic sizing keywords** (@Loirooriol, #35413, #35469, #35471, #35630, #35642, #35663, #35652, #35688), and **‘position: absolute’** now works correctly in a **‘position: relative’ grid item** (@stevennovaryo, #35014).

## Servo-the-browser (servoshell)

**Directory listings** are now enabled for local files (@mrobinson, #35317).

servoshell’s **dialogs now use egui** (@chickenleaf, #34823, #35399, #35464, #35507, #35564, #35577, #35657, #35671), rather than shelling out to a program like `zenity` (@chickenleaf, #35674), making them more secure and no longer falling back to terminal input.

We’ve also fixed a bug when closing a tab other than the current one (@pewsheen, #35569).

## Servo-the-engine (embedding)

We’ve simplified our embedding API by **merging all input event delivery** into [`WebView::notify_input_event`](https://doc.servo.org/servo/struct.WebView.html#method.notify_input_event) (@mrobinson, @mukilan, #35430), making **bluetooth optional** (@jdm, @webbeef, #35479, #35590), making the **“background hang monitor” optional** (@jdm, #35256), and **eliminating the need to depend on `webxr`** (@mrobinson, #35229).
We’ve also moved some servoshell-only options out of [`Opts`](https://doc.servo.org/servo_config/opts/struct.Opts.html) (@mrobinson, #35377, #35407), since they have no effect on Servo’s behaviour.

We’ve landed our initial **delegate-based API** (@delan, @mrobinson, @mukilan, #35196, #35260, #35297, #35396, #35400, #35544, #35579, #35662, #35672), which replaces our old message-based API for integrating Servo with your app (@mrobinson, @delan, @mukilan, #35284, #35315, #35366).
By implementing [`WebViewDelegate`](https://doc.servo.org/servo/trait.WebViewDelegate.html) and [`ServoDelegate`](https://doc.servo.org/servo/trait.ServoDelegate.html) and [installing](https://doc.servo.org/servo/struct.WebView.html#method.set_delegate) [them](https://doc.servo.org/servo/struct.Servo.html#method.set_delegate), you can have Servo call back into your app’s logic with ease.

We’ve simplified the [`RenderingContext`](https://doc.servo.org/servo/trait.RenderingContext.html) trait (@wusyong, @mrobinson, #35251, #35553) and **added three built-in `RenderingContext` impls** (@mrobinson, @mukilan, #35465, #35501), making it easier to set up a context Servo can render to:

- [`WindowRenderingContext`](https://doc.servo.org/servo/struct.WindowRenderingContext.html) renders to a **whole window**
- [`OffscreenRenderingContext`](https://doc.servo.org/servo/struct.OffscreenRenderingContext.html) renders to **part of a window**
- [`SoftwareRenderingContext`](https://doc.servo.org/servo/struct.SoftwareRenderingContext.html) renders to an image, **without hardware acceleration**

We’ve heavily reworked and documented our **webview rendering model** (@mrobinson, @wusyong, @mukilan, #35522, #35621), **moved image output** and **shutdown logic** out of the compositor (@mrobinson, @wusyong, #35538), and removed some complicated logic around synchronous repaints when a window is resized (@mrobinson, #35283, #35277).
These changes should make it a lot clearer how to get Servo’s webviews onto your display.

One part of this model that we’re starting to move away from is the support for multiple webviews in one rendering context (@mrobinson, @wusyong, #35536).
First landed in #31417, this was an expedient way to add support for multiple webviews, but it imposed some serious limitations on how webviews could be interleaved with other app content, and the performance and security was inadequate.

We’ve **updated our [winit_minimal example](https://github.com/servo/servo/blob/139774e6b55c297bc94f7fcb8c9bf5bb8c6a7474/components/servo/examples/winit_minimal.rs)** to take advantage of these changes (@webbeef, #35350, #35686), simplify it further (@robertohuertasm, #35253), and fix window resizing (@webbeef, #35691).

## Perf improvements

The compositor now **notifies the embedder of new frames immediately** (@mrobinson, #35369), not via the constellation thread.

## Donations

Thanks again for your generous support!
We are now receiving **4363 USD/month** (+13.7% over January) in recurring donations.
With this money, we’ve been able to expand our capacity for [self-hosted](https://ci0.servo.org) [CI](https://ci1.servo.org) [runners](https://ci2.servo.org) on Windows, Linux, and macOS builds, **halving `mach try` build times** from over an hour to under 30 minutes!

Servo is also on [thanks.dev](https://thanks.dev), and already **21 GitHub users** (+5 over December) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 4363 / 10000); padding-left: 0.5em;"><strong>4363</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 4363 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="4363" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
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
