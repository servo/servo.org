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
-->

<!--[commits]
>>> 2025-02-01T06:01:38Z
https://github.com/servo/servo/pull/35247	(@Loirooriol, #35247)	Let `resolve_color()` take its parameter by reference (#35247)
https://github.com/servo/servo/pull/35248	(@atouchet, #35248)	Cargo.toml cleanup (#35248)
-https://github.com/servo/servo/pull/35242	(@dependabot[bot], @dependabot[bot], #35242)	build(deps): bump cmake from 0.1.52 to 0.1.53 (#35242)
-https://github.com/servo/servo/pull/35243	(@dependabot[bot], @dependabot[bot], #35243)	build(deps): bump rustls from 0.23.21 to 0.23.22 (#35243)
-https://github.com/servo/servo/pull/35244	(@dependabot[bot], @dependabot[bot], #35244)	build(deps): bump aws-lc-rs from 1.12.1 to 1.12.2 (#35244)
-https://github.com/servo/servo/pull/35240	(@dependabot[bot], @dependabot[bot], #35240)	build(deps): bump webpki-roots from 0.26.7 to 0.26.8 (#35240)
https://github.com/servo/servo/pull/35073	(@sagudev, @mrobinson, #35073)	crown: Pass `--cfg crown` to rustc from crown (#35073)
-https://github.com/servo/servo/pull/35241	(@dependabot[bot], @dependabot[bot], #35241)	build(deps): bump toml_edit from 0.22.22 to 0.22.23 (#35241)
https://github.com/servo/servo/pull/35229	(@mrobinson, #35229)	Finish the integration of `webxr` into the Cargo workspace (#35229)
https://github.com/servo/servo/pull/35234	(@Loirooriol, #35234)	Avoid starting transitions if values can't be interpolated (#35234)
https://github.com/servo/servo/pull/35237	(@sagudev, #35237)	webgpu: implement get image for webgpu canvas (#35237)
https://github.com/servo/servo/pull/35235	(@webbeef, #35235)	Fix crash in screenX and screenY getters returning negative values (#35235)
>>> 2025-02-02T06:05:48Z
https://github.com/servo/servo/pull/35258	(@servo-wpt-sync, #35258)	Update web-platform-tests to revision b'f630424a79c1ae17deaaf27a21efdbca1378af0e' (#35258)
https://github.com/servo/servo/pull/35257	(@shalvin.deo@live.com, #35257)	Consolidated opts into a manual Default trait implementation (#35257)
https://github.com/servo/servo/pull/35256	(@jdm, #35256)	libservo: Make background hang monitor integration optional. (#35256)
https://github.com/servo/servo/pull/35245	(@webbeef, #35245)	Only consider fully active documents when running the 'update the rendering' steps (#35245)
https://github.com/servo/servo/pull/35253	(@roberto.huertas@outlook.com, #35253)	chore(servo): simplify servo example (#35253)
https://github.com/servo/servo/pull/35249	(@webbeef, #35249)	More cleanup, less unwrap() (#35249)
>>> 2025-02-04T06:04:27Z
https://github.com/servo/servo/pull/35263	(@dklassic, #35263)	chore: Rename `CompositeTarget` enum (#35263)
https://github.com/servo/servo/pull/35205	(@arthmis, #35205)	Update implementations of `HTTP-network fetch` and `HTTP-network-or-cache fetch` to take `fetchParams` as an argument (#35205)
https://github.com/servo/servo/pull/35260	(@mrobinson, #35260)	libservo: Combine `LoadStart, `HeadParsed`, and `LoadComplete` messages (#35260)
-https://github.com/servo/servo/pull/35272	(@dependabot[bot], @dependabot[bot], #35272)	build(deps): bump syn from 2.0.96 to 2.0.98 (#35272)
-https://github.com/servo/servo/pull/35271	(@dependabot[bot], @dependabot[bot], #35271)	build(deps): bump pin-project from 1.1.8 to 1.1.9 (#35271)
-https://github.com/servo/servo/pull/35273	(@dependabot[bot], @dependabot[bot], #35273)	build(deps): bump core_maths from 0.1.0 to 0.1.1 (#35273)
-https://github.com/servo/servo/pull/35270	(@dependabot[bot], @dependabot[bot], #35270)	build(deps): bump cc from 1.2.10 to 1.2.11 (#35270)
-https://github.com/servo/servo/pull/35268	(@dependabot[bot], @dependabot[bot], #35268)	build(deps): bump wayland-backend from 0.3.7 to 0.3.8 (#35268)
-https://github.com/servo/servo/pull/35267	(@dependabot[bot], @dependabot[bot], #35267)	build(deps): bump wayland-scanner from 0.31.5 to 0.31.6 (#35267)
-https://github.com/servo/servo/pull/35266	(@dependabot[bot], @dependabot[bot], #35266)	build(deps): bump bytes from 1.9.0 to 1.10.0 (#35266)
https://github.com/servo/servo/pull/35264	(@Loirooriol, #35264)	layout: Don't let table grid boxes inherit `display: inline-table` (#35264)
https://github.com/servo/servo/pull/35219	(@Loirooriol, #35219)	layout: Fix painting order of collapsed table borders (#35219)
https://github.com/servo/servo/pull/35178	(@rayguo17, #35178)	layout: align-content with default value normal should behave as strech in flex container (#35178)
https://github.com/servo/servo/pull/35220	(@simonwuelker, #35220)	Lay out the contents of slot elements (#35220)
https://github.com/servo/servo/pull/35250	(@shanehandley, #35250)	script: Implement the Bytes() method on Request and Response (#35250)
>>> 2025-02-05T06:08:38Z
https://github.com/servo/servo/pull/35289	(@Loirooriol, #35289)	Upgrade Stylo to 2025-02-03 (#35289)
https://github.com/servo/servo/pull/35209	(@Loirooriol, #35209)	layout: Limit `content_inline_size_for_table` override to collapsed columns (#35209)
https://github.com/servo/servo/pull/35208	(@Loirooriol, #35208)	layout: Implement default overflow alignment for abspos (#35208)
https://github.com/servo/servo/pull/35276	(@simonwuelker, #35276)	Make traverse_preorder follow children of shadow hosts (#35276)
https://github.com/servo/servo/pull/35285	(@sagudev, #35285)	Remove `get_ipc_renderer` from `CanvasRenderingContext2D` (#35285)
https://github.com/servo/servo/pull/34823	(@chickenleaf, #34823)	servoshell: Migrate to egui-file-dialog from tinyfiledialogs (#34823)
https://github.com/servo/servo/pull/35283	(@mrobinson, #35283)	libservo: Remove `Servo::repaint_synchronously` (#35283)
https://github.com/servo/servo/pull/35281	(@xiaochengh.work@gmail.com, #35281)	Clean up some stale debug options for ServoDriver (#35281)
https://github.com/servo/servo/pull/35074	(@Taym95, #35074)	Script: implement ReadableStreamBYOBRequest (#35074)
https://github.com/servo/servo/pull/35280	(@jdm, #35280)	Move more foundational types to script_bindings (#35280)
https://github.com/servo/servo/pull/35278	(@simonwuelker, #35278)	Specify C ABI for generated extern functions in CodegenRust.py (#35278)
https://github.com/servo/servo/pull/35277	(@mrobinson, #35277)	libservo: Remove `EmbedderEvent::WindowResize` (#35277)
https://github.com/servo/servo/pull/35279	(@jdm, #35279)	Move various reflector types and traits to script_bindings (#35279)
https://github.com/servo/servo/pull/35181	(@sagudev, #35181)	ci: Free some disc space on GitHub hosted runners (#35181)
>>> 2025-02-06T06:05:16Z
-https://github.com/servo/servo/pull/35269	(@dependabot[bot], @dependabot[bot], #35269)	build(deps): bump string_cache from 0.8.7 to 0.8.8 (#35269)
-https://github.com/servo/servo/pull/35302	(@dependabot[bot], @dependabot[bot], #35302)	build(deps): bump markup5ever from 0.14.0 to 0.14.1 (#35302)
https://github.com/servo/servo/pull/35293	(@longvatrong111, #35293)	Add border radius to overflow scrollable frame (#35293)
https://github.com/servo/servo/pull/35307	(@mrobinson, #35307)	webxr: Rename sender & receiver type aliases to `WebXrSender` and `WebXrReceiver` (#35307)
https://github.com/servo/servo/pull/35290	(@Loirooriol, #35290)	layout: Simplify `Table::compute_inline_content_sizes` (#35290)
-https://github.com/servo/servo/pull/35305	(@dependabot[bot], @dependabot[bot], #35305)	build(deps): bump derive_more from 0.99.18 to 0.99.19 (#35305)
-https://github.com/servo/servo/pull/35304	(@dependabot[bot], @dependabot[bot], #35304)	build(deps): bump wayland-client from 0.31.7 to 0.31.8 (#35304)
-https://github.com/servo/servo/pull/35300	(@dependabot[bot], @dependabot[bot], #35300)	build(deps): bump winnow from 0.7.0 to 0.7.1 (#35300)
-https://github.com/servo/servo/pull/35299	(@dependabot[bot], @dependabot[bot], #35299)	build(deps): bump cc from 1.2.11 to 1.2.12 (#35299)
https://github.com/servo/servo/pull/35294	(@simonwuelker, #35294)	Inform the devtools about shadow roots on a node (#35294)
https://github.com/servo/servo/pull/35292	(@jdm, #35292)	Make generated proxy handlers and DOM object hooks generic (#35292)
https://github.com/servo/servo/pull/34986	(@shubhamg13, @shubham.gupta@chromium.org, @jdm, #34986)	Add support for Upgrade request to a potentially trustworthy URL. (#34986)
https://github.com/servo/servo/pull/35295	(@Loirooriol, #35295)	Don't require index parameter in `CSSGroupingRule`'s `insertRule()` (#35295)
https://github.com/servo/servo/pull/35251	(@wusyong, #35251)	Simplify `RenderingContext` trait methods (#35251)
https://github.com/servo/servo/pull/35196	(@delan, @mrobinson, @mukilan, #35196)	libservo: Add WebViewDelegate and ServoDelegate and port `winit_minimal` (#35196)
https://github.com/servo/servo/pull/35291	(@yezhizhenjiakang@gmail.com, #35291)	script: delay Mutation initialization (#35291)
https://github.com/servo/servo/pull/34328	(@sagudev, #34328)	Use surfman with glow bindings (#34328)
>>> 2025-02-07T06:05:18Z
https://github.com/servo/servo/pull/35343	(@Loirooriol, #35343)	Enable aws-lc-sys feature for aws-lc-rs (#35343)
https://github.com/servo/servo/pull/35338	(@simonwuelker, #35338)	Implement ServoLayoutNode::traversal_parent (#35338)
-https://github.com/servo/servo/pull/35336	(@dependabot[bot], @dependabot[bot], #35336)	build(deps): bump phf_generator from 0.11.2 to 0.11.3 (#35336)
-https://github.com/servo/servo/pull/35335	(@dependabot[bot], @dependabot[bot], #35335)	build(deps): bump wayland-cursor from 0.31.7 to 0.31.8 (#35335)
-https://github.com/servo/servo/pull/35333	(@dependabot[bot], @dependabot[bot], #35333)	build(deps): bump aws-lc-sys from 0.25.0 to 0.25.1 (#35333)
-https://github.com/servo/servo/pull/35331	(@dependabot[bot], @dependabot[bot], #35331)	build(deps): bump phf_shared from 0.11.2 to 0.11.3 (#35331)
-https://github.com/servo/servo/pull/35332	(@dependabot[bot], @dependabot[bot], #35332)	build(deps): bump winit from 0.30.8 to 0.30.9 (#35332)
-https://github.com/servo/servo/pull/35330	(@dependabot[bot], @dependabot[bot], #35330)	build(deps): bump wayland-protocols from 0.32.5 to 0.32.6 (#35330)
https://github.com/servo/servo/pull/35324	(@simonwuelker, #35324)	Cleanup blocking fetch operations with bad ports (#35324)
https://github.com/servo/servo/pull/35327	(@rayguo17, #35327)	change terminal wrapper library from blessing to blessed to support running mach test-wpt on windows. (#35327)
https://github.com/servo/servo/pull/35315	(@mukilan, @mrobinson, #35315)	Migrate Android and OHOS ports to the delegate API (#35315)
https://github.com/servo/servo/pull/35317	(@mrobinson, #35317)	libservo: Enable file directory listing by default (#35317)
https://github.com/servo/servo/pull/35320	(@yezhizhenjiakang@gmail.com, #35320)	malloc_size_of: enable sync in tokio (#35320)
-https://github.com/servo/servo/pull/35306	(@dependabot[bot], @dependabot[bot], #35306)	build(deps): bump clap from 4.5.27 to 4.5.28 (#35306)
https://github.com/servo/servo/pull/35284	(@mrobinson, @delan, @mukilan, #35284)	servoshell: Port desktop servoshell to use delegate API (#35284)
https://github.com/servo/servo/pull/35312	(@jdm, #35312)	Only compile platform samplers when cargo feature enabled (#35312)
https://github.com/servo/servo/pull/35313	(@yezhizhenjiakang@gmail.com, #35313)	Update `pixels::unmultiply_inplace` to support RB swap and use it in canvas_state (#35313)
>>> 2025-02-08T06:05:28Z
https://github.com/servo/servo/pull/35380	(@simonwuelker, #35380)	Handle assigned slottables in an Event's path (#35380)
https://github.com/servo/servo/pull/35014	(@stevennovaryo, #35014)	layout: Fix relative positioned grid item (#35014)
https://github.com/servo/servo/pull/35367	(@stephenmuss@gmail.com, #35367)	script: make methods of ErrorInfo safe (#35367)
https://github.com/servo/servo/pull/35377	(@mrobinson, #35377)	servoshell: Move `headless` setting to ServoShellPreferences (#35377)
-https://github.com/servo/servo/pull/35373	(@dependabot[bot], @dependabot[bot], #35373)	build(deps): bump once_cell from 1.20.2 to 1.20.3 (#35373)
-https://github.com/servo/servo/pull/35375	(@dependabot[bot], @dependabot[bot], #35375)	build(deps): bump wayland-protocols-wlr from 0.3.5 to 0.3.6 (#35375)
-https://github.com/servo/servo/pull/35376	(@dependabot[bot], @dependabot[bot], #35376)	build(deps): bump webrender_api from `9f552be` to `8846253` (#35376)
-https://github.com/servo/servo/pull/35374	(@dependabot[bot], @dependabot[bot], #35374)	build(deps): bump webrender from `9f552be` to `8846253` (#35374)
-https://github.com/servo/servo/pull/35372	(@dependabot[bot], @dependabot[bot], #35372)	build(deps): bump wayland-protocols-plasma from 0.3.5 to 0.3.6 (#35372)
-https://github.com/servo/servo/pull/35371	(@dependabot[bot], @dependabot[bot], #35371)	build(deps): bump wr_malloc_size_of from `9f552be` to `8846253` (#35371)
https://github.com/servo/servo/pull/35357	(@shubhamg13, #35357)	Modify the checks for upgrade-request algorithm (#35357)
https://github.com/servo/servo/pull/35360	(@stephenmuss@gmail.com, #35360)	script: make throw_invalid_this and throw_constructor_without_new safe (#35360)
https://github.com/servo/servo/pull/35325	(@mrobinson, #35325)	deps: Upgrade to `webrender@0.66` (#35325)
https://github.com/servo/servo/pull/35362	(@Loirooriol, #35362)	Enable surfman's sm-x11 feature for webrender_traits (#35362)
https://github.com/servo/servo/pull/35297	(@mrobinson, #35297)	libservo: Add a `ClipboardDelegate` and a default implementation (#35297)
https://github.com/servo/servo/pull/35358	(@wusyong, #35358)	fix: bring back connection method to fix WebGL texture error (#35358)
https://github.com/servo/servo/pull/35352	(@simonwuelker, #35352)	Add support for the `::slotted` selector (#35352)
https://github.com/servo/servo/pull/35350	(@webbeef, #35350)	wini_minimal: trigger initial rendering and scroll properly (#35350)
https://github.com/servo/servo/pull/35354	(@jdm, #35354)	script: Annotate steps for custom element creation. (#35354)
https://github.com/servo/servo/pull/35353	(@mukilan, #35353)	servoshell: upgrade egui and related depenencies (#35353)
>>> 2025-02-09T06:03:54Z
https://github.com/servo/servo/pull/35383	(@maxtidev, @max@maxti.dev, #35383)	script: Replace unnecessary macro in get_constructor_object_from_local_name (#35383)
https://github.com/servo/servo/pull/35384	(@servo-wpt-sync, #35384)	Update web-platform-tests to revision b'1a5b13545ae58e468ed11e4c21912a3faf3355ea' (#35384)
https://github.com/servo/servo/pull/35351	(@nolen@scaife.org, #35351)	make report_pending_exception safe and adjust callers (#35351)
https://github.com/servo/servo/pull/35379	(@webbeef, #35379)	suppress build warnings when disabling webgpu and webxr (#35379)
https://github.com/servo/servo/pull/35370	(@jschwe, #35370)	Add cli option for tracing-filter (#35370)
>>> 2025-02-10T06:07:48Z
https://github.com/servo/servo/pull/35366	(@mrobinson, #35366)	libservo: Remove message-based API (#35366)
https://github.com/servo/servo/pull/35382	(@maxtidev, @max@maxti.dev, @jdm, #35382)	script: Add shadow dom check to custom element constructor (#35382)
https://github.com/servo/servo/pull/35381	(@mrobinson, #35381)	dom: Always replace unpaired surrogates when handling page text (#35381)
>>> 2025-02-11T06:04:45Z
https://github.com/servo/servo/pull/35411	(@stephenmuss@gmail.com, #35411)	script: make Error::to_jsval safe (#35411)
https://github.com/servo/servo/pull/35400	(@mrobinson, #35400)	libservo: Add a delegate method for HTTP authentication (#35400)
https://github.com/servo/servo/pull/35407	(@mrobinson, #35407)	servoshell: Move `initial_window_size` and `screen_size_override` into `ServoShellPreferences` from `Opts` (#35407)
https://github.com/servo/servo/pull/35309	(@willypuzzle, #35309)	implemented feture and tests (#35309)
-https://github.com/servo/servo/pull/35409	(@dependabot[bot], @dependabot[bot], #35409)	build(deps): bump ohos-sys-opaque-types from 0.1.4 to 0.1.5 (#35409)
-https://github.com/servo/servo/pull/35404	(@dependabot[bot], @dependabot[bot], #35404)	build(deps): bump cc from 1.2.12 to 1.2.13 (#35404)
-https://github.com/servo/servo/pull/35408	(@dependabot[bot], @dependabot[bot], #35408)	build(deps): bump cmake from 0.1.53 to 0.1.54 (#35408)
-https://github.com/servo/servo/pull/35406	(@dependabot[bot], @dependabot[bot], #35406)	build(deps): bump winnow from 0.7.1 to 0.7.2 (#35406)
-https://github.com/servo/servo/pull/35403	(@dependabot[bot], @dependabot[bot], #35403)	build(deps): bump data-encoding from 2.7.0 to 2.8.0 (#35403)
https://github.com/servo/servo/pull/35402	(@sagudev, #35402)	Revert "Use surfman with glow bindings (#34328)" (#35402)
https://github.com/servo/servo/pull/35401	(@sagudev, #35401)	Remove unintended `dbg!` from `components/net/fetch/methods.rs` (#35401)
https://github.com/servo/servo/pull/35396	(@mrobinson, @mukilan, #35396)	libservo: Flesh out permissions API (#35396)
https://github.com/servo/servo/pull/34794	(@shubhamg13, #34794)	Add support for Upgrade a mixed content request. (#34794)
>>> 2025-02-12T06:04:26Z
-https://github.com/servo/servo/pull/35426	(@dependabot[bot], @dependabot[bot], #35426)	build(deps): bump rustls from 0.23.22 to 0.23.23 (#35426)
-https://github.com/servo/servo/pull/35425	(@dependabot[bot], @dependabot[bot], #35425)	build(deps): bump toml_edit from 0.22.23 to 0.22.24 (#35425)
https://github.com/servo/servo/pull/35424	(@Loirooriol, #35424)	Let script/webgpu feature imply script_traits/webgpu (#35424)
https://github.com/servo/servo/pull/35420	(@Loirooriol, #35420)	Enable the `quotes` CSS property (#35420)
https://github.com/servo/servo/pull/35417	(@shanehandley, #35417)	script: remove a fixed todo from script/dom/xmlhttprequest.rs (#35417)
>>> 2025-02-14T06:14:23Z
https://github.com/servo/servo/pull/35413	(@Loirooriol, #35413)	layout: Basic implementation of size keywords on `flex-basis` (#35413)
https://github.com/servo/servo/pull/35443	(@Loirooriol, #35443)	layout: Remove `BoxFragment::overflow_clip_rect()` (#35443)
https://github.com/servo/servo/pull/35445	(@mukilan, #35445)	libservo: change 'request_fullscreen_state_change' API to a notification (#35445)
https://github.com/servo/servo/pull/35450	(@kongbai1996, #35450)	fix issue #35449: handle touch events in on_input_event. (#35450)
https://github.com/servo/servo/pull/35314	(@stevennovaryo, #35314)	dom: IntersectionObserver initialization (#35314)
https://github.com/servo/servo/pull/35422	(@sagudev, #35422)	Use surfman with glow bindings (take II) (#35422)
https://github.com/servo/servo/pull/35441	(@webbeef, #35441)	(chore): tinyfiledialog::MessageBoxIcon is only used on Linux (#35441)
https://github.com/servo/servo/pull/35246	(@webbeef, #35246)	Update window.screenX and window.screenY when moving the embedder window (#35246)
https://github.com/servo/servo/pull/35437	(@Loirooriol, #35437)	Protect `create_spanned_slot_based_on_cell_above()` against arithmetic underflow (#35437)
https://github.com/servo/servo/pull/35442	(@jdm, #35442)	Run WPT notifications tests. (#35442)
-https://github.com/servo/servo/pull/35439	(@dependabot[bot], @dependabot[bot], #35439)	build(deps): bump miniz_oxide from 0.8.3 to 0.8.4 (#35439)
-https://github.com/servo/servo/pull/35438	(@dependabot[bot], @dependabot[bot], #35438)	build(deps): bump clap from 4.5.28 to 4.5.29 (#35438)
https://github.com/servo/servo/pull/35430	(@mrobinson, @mukilan, #35430)	libservo: Expose a single `InputEvent` type and pass it to script (#35430)
https://github.com/servo/servo/pull/35435	(@mukilan, #35435)	script: reset spurious frame counter *only* when reflow is triggered (#35435)
https://github.com/servo/servo/pull/35392	(@Taym95, #35392)	Add Precustomized state to CustomElementState (#35392)
https://github.com/servo/servo/pull/35399	(@chickenleaf, #35399)	servoshell: Port alert/confirm dialog code to use egui intead of tinyfiledialogs (#35399)
https://github.com/servo/servo/pull/35433	(@Loirooriol, #35433)	Test `overflow-clip-margin` with `border-radius` (#35433)
https://github.com/servo/servo/pull/35364	(@pewsheen, #35364)	feat: dispatch mouse `contextmenu` event to DOM and embedder (#35364)
https://github.com/servo/servo/pull/35387	(@mukilan, #35387)	script: fix spurious animation checks to correctly invoke rAF callbacks (#35387)
https://github.com/servo/servo/pull/35431	(@mrobinson, #35431)	prefs: Stop precaching WebRender shaders by default (#35431)
https://github.com/servo/servo/pull/35369	(@mrobinson, #35369)	libservo: Don't bounce ready-to-present frame notifications to the Constellation (#35369)
https://github.com/servo/servo/pull/35103	(@longvatrong111, #35103)	Implement overflow:clip (#35103)
https://github.com/servo/servo/pull/35427	(@jdm, #35427)	bindings: Support non-object this values for callbacks. (#35427)
>>> 2025-02-15T06:05:56Z
https://github.com/servo/servo/pull/35472	(@shanehandley, #35472)	script: remove non-actionable todo from script/dom/document.rs (#35472)
-https://github.com/servo/servo/pull/35468	(@dependabot[bot], @dependabot[bot], #35468)	build(deps): bump ring from 0.17.8 to 0.17.9 (#35468)
-https://github.com/servo/servo/pull/35467	(@dependabot[bot], @dependabot[bot], #35467)	build(deps): bump cc from 1.2.13 to 1.2.14 (#35467)
https://github.com/servo/servo/pull/35466	(@mrobinson, #35466)	deps: Remove some unused `Cargo.toml` (#35466)
https://github.com/servo/servo/pull/35464	(@chickenleaf, #35464)	servoshell: Port input dialog code to use egui intead of tinyfiledialogs (#35464)
https://github.com/servo/servo/pull/35462	(@yezhizhenjiakang@gmail.com, #35462)	Fix scroll_sensitivity related naming issue (#35462)
https://github.com/servo/servo/pull/35414	(@yezhizhenjiakang@gmail.com, @mrobinson, #35414)	layout: Implement overflow scroll support for different axes (#35414)
https://github.com/servo/servo/pull/35458	(@jdm, #35458)	chore: Remove outdated FIXME. (#35458)
>>> 2025-02-16T06:05:40Z
https://github.com/servo/servo/pull/35480	(@servo-wpt-sync, #35480)	Update web-platform-tests to revision b'de61904887c13679551c32e5e3e70b4dc870c98a' (#35480)
https://github.com/servo/servo/pull/35473	(@github@gravition.art, #35473)	script: Take away Fallible from new_resolved and new_rejected (#35473)
>>> 2025-02-17T06:06:01Z
https://github.com/servo/servo/pull/35502	(@mrobinson, #35502)	servoshell: Actually set the Servo delegate in servoshell (#35502)
https://github.com/servo/servo/pull/35418	(@Gae24, #35418)	 `DataTransferItem`: improve spec compliance (#35418)
https://github.com/servo/servo/pull/35503	(@sagudev, #35503)	chore: Update wgpu (#35503)
https://github.com/servo/servo/pull/35483	(@jdm, #35483)	net: Use the unfiltered response status when comparing against cached resources. (#35483)
https://github.com/servo/servo/pull/35482	(@shanehandley, #35482)	script: implement HTMLHyperlinkElementUtils for HTMLAreaElement (#35482)
>>> 2025-02-18T06:03:11Z
https://github.com/servo/servo/pull/35479	(@jdm, #35479)	Make WebBluetooth an optional feature. (#35479)
https://github.com/servo/servo/pull/35519	(@simonwuelker, #35519)	Don't attempt to report style attribute for non-htmlelements to devtools (#35519)
https://github.com/servo/servo/pull/35471	(@Loirooriol, #35471)	layout: Fully support sizing keywords on main size property of flex item (#35471)
-https://github.com/servo/servo/pull/35515	(@dependabot[bot], @dependabot[bot], #35515)	build(deps): bump smallvec from 1.13.2 to 1.14.0 (#35515)
https://github.com/servo/servo/pull/35469	(@Loirooriol, #35469)	layout: Partial support for sizing keywords on flex items (#35469)
-https://github.com/servo/servo/pull/35513	(@dependabot[bot], @dependabot[bot], #35513)	build(deps): bump document-features from 0.2.10 to 0.2.11 (#35513)
-https://github.com/servo/servo/pull/35512	(@dependabot[bot], @dependabot[bot], #35512)	build(deps): bump equivalent from 1.0.1 to 1.0.2 (#35512)
-https://github.com/servo/servo/pull/35511	(@dependabot[bot], @dependabot[bot], #35511)	build(deps): bump smallbitvec from 2.5.3 to 2.6.0 (#35511)
-https://github.com/servo/servo/pull/35510	(@dependabot[bot], @dependabot[bot], #35510)	build(deps): bump the gstreamer-related group with 4 updates (#35510)
https://github.com/servo/servo/pull/35508	(@Gae24, #35508)	window: avoid NonNull<JSObject> in NamedGetter (#35508)
https://github.com/servo/servo/pull/35506	(@simonwuelker, #35506)	Don't remove used fonts in collect_unused_webrender_resources (#35506)
https://github.com/servo/servo/pull/35031	(@kongbai1996, #35031)	implement Touchevent prevent default behavior (#35031)
https://github.com/servo/servo/pull/35465	(@mrobinson, @mukilan, #35465)	libservo: Expose an `OffscreenRenderingContext` and use it for servoshell (#35465)
https://github.com/servo/servo/pull/35505	(@yezhizhenjiakang@gmail.com, #35505)	dom: expose obsolete `scheme` attribute for meta tag (#35505)
>>> 2025-02-19T06:07:15Z
https://github.com/servo/servo/pull/35530	(@simonwuelker, #35530)	Ensure that qualified-name segments start with a valid start character (#35530)
https://github.com/servo/servo/pull/35516	(@jschwe, #35516)	Fix android build on arm macs (#35516)
-https://github.com/servo/servo/pull/35527	(@dependabot[bot], @dependabot[bot], #35527)	build(deps): bump typenum from 1.17.0 to 1.18.0 (#35527)
https://github.com/servo/servo/pull/34842	(@pewsheen, @jdm, #34842)	feat: add `Notification` Web API binding (#34842)
-https://github.com/servo/servo/pull/35526	(@dependabot[bot], @dependabot[bot], #35526)	build(deps): bump clap from 4.5.29 to 4.5.30 (#35526)
-https://github.com/servo/servo/pull/35525	(@dependabot[bot], @dependabot[bot], #35525)	build(deps): bump the gstreamer-related group with 22 updates (#35525)
https://github.com/servo/servo/pull/35501	(@mrobinson, #35501)	libservo: Expose `SoftwareRenderingContext` and `WindowRenderingContext` (#35501)
https://github.com/servo/servo/pull/35416	(@jdm, #35416)	script: Add custom logging representation for DOM interfaces. (#35416)
>>> 2025-02-20T06:07:24Z
-https://github.com/servo/servo/pull/35545	(@dependabot[bot], @dependabot[bot], #35545)	build(deps): bump unicode-ident from 1.0.16 to 1.0.17 (#35545)
https://github.com/servo/servo/pull/35536	(@mrobinson, @wusyong, #35536)	compositing: Split non-WebView-specific data into `ServoRenderer` (#35536)
https://github.com/servo/servo/pull/35544	(@mrobinson, #35544)	Remove `Servo::allow_navigation_request` (#35544)
https://github.com/servo/servo/pull/35507	(@chickenleaf, #35507)	servoshell: Port Authentication dialog code to use egui intead of tinyfiledialogs (#35507)
https://github.com/servo/servo/pull/34844	(@gterzian, @jdm, #34844)	dom: Implement `WritableStream` (#34844)
https://github.com/servo/servo/pull/35535	(@dklassic, #35535)	feat: support pre-edit text display for IME (#35535)
https://github.com/servo/servo/pull/35474	(@jschwe, #35474)	pixels: Fix webp detection (#35474)
https://github.com/servo/servo/pull/35522	(@mrobinson, @wusyong, @mukilan, #35522)	libservo: Rework and clarify the rendering model of the `WebView` (#35522)
https://github.com/servo/servo/pull/35262	(@mukilan, #35262)	script: add skeleton implementation of `FontFace` API (#35262)
>>> 2025-02-21T06:06:29Z
-https://github.com/servo/servo/pull/35566	(@jdm, #35566)	Revert "build(deps): bump aws-lc-rs from 1.12.2 to 1.12.3 (#35561)" (#35566)
https://github.com/servo/servo/pull/35538	(@mrobinson, @wusyong, #35538)	compositing: Move image output and shutdown management out of the compositor (#35538)
-https://github.com/servo/servo/pull/35561	(@dependabot[bot], @dependabot[bot], #35561)	build(deps): bump aws-lc-rs from 1.12.2 to 1.12.3 (#35561)
-https://github.com/servo/servo/pull/35562	(@dependabot[bot], @dependabot[bot], #35562)	build(deps): bump taffy from 0.7.5 to 0.7.6 (#35562)
-https://github.com/servo/servo/pull/35563	(@dependabot[bot], @dependabot[bot], #35563)	build(deps): bump serde_json from 1.0.138 to 1.0.139 (#35563)
-https://github.com/servo/servo/pull/35560	(@dependabot[bot], @dependabot[bot], #35560)	build(deps): bump string_cache_codegen from 0.5.3 to 0.5.4 (#35560)
-https://github.com/servo/servo/pull/35559	(@dependabot[bot], @dependabot[bot], #35559)	build(deps): bump serde from 1.0.217 to 1.0.218 (#35559)
-https://github.com/servo/servo/pull/35558	(@dependabot[bot], @dependabot[bot], #35558)	build(deps): bump anyhow from 1.0.95 to 1.0.96 (#35558)
-https://github.com/servo/servo/pull/35557	(@dependabot[bot], @dependabot[bot], #35557)	build(deps): bump app_units from 0.7.6 to 0.7.7 (#35557)
-https://github.com/servo/servo/pull/35556	(@dependabot[bot], @dependabot[bot], #35556)	build(deps): bump winnow from 0.7.2 to 0.7.3 (#35556)
https://github.com/servo/servo/pull/35541	(@augustebaum, #35541)	Propagate `CanGc` arguments through callers in constructors (#35541)
https://github.com/servo/servo/pull/35553	(@mrobinson, #35553)	libservo: Move GL acclerated media setup out of `RenderingContext` and simplify it (#35553)
https://github.com/servo/servo/pull/35547	(@delan, #35547)	libservo: Clean up destroyed webview handles (#35547)
https://github.com/servo/servo/pull/35546	(@dklassic, #35546)	chore: cleanup IME code for Servoshell (#35546)
>>> 2025-02-22T06:07:09Z
https://github.com/servo/servo/pull/35578	(@jdm, #35578)	Move more bindings code to script_bindings (#35578)
https://github.com/servo/servo/pull/35593	(@yerkebulan@gmail.com, #35593)	refactor: add CanGc as argument to extract_size_algorithm (#35593)
https://github.com/servo/servo/pull/35592	(@webbeef, #35592)	dom: Move child_list to rare data (#35592)
https://github.com/servo/servo/pull/35590	(@webbeef, #35590)	build winit_minimal with bluetooth disabled (#35590)
https://github.com/servo/servo/pull/35448	(@sagudev, #35448)	script: Add `CanvasContext` trait (#35448)
https://github.com/servo/servo/pull/35589	(@webbeef, #35589)	Add get_url() to GlobalScopeHelper (#35589)
https://github.com/servo/servo/pull/35554	(@webbeef, #35554)	dom: move node ranges to raredata (#35554)
-https://github.com/servo/servo/pull/35586	(@dependabot[bot], @dependabot[bot], #35586)	build(deps): bump cc from 1.2.14 to 1.2.15 (#35586)
-https://github.com/servo/servo/pull/35585	(@dependabot[bot], @dependabot[bot], #35585)	build(deps): bump ring from 0.17.9 to 0.17.10 (#35585)
-https://github.com/servo/servo/pull/35584	(@dependabot[bot], @dependabot[bot], #35584)	build(deps): bump log from 0.4.25 to 0.4.26 (#35584)
-https://github.com/servo/servo/pull/35582	(@dependabot[bot], @dependabot[bot], #35582)	build(deps): bump aws-lc-rs from 1.12.2 to 1.12.4 (#35582)
https://github.com/servo/servo/pull/35565	(@augustebaum, #35565)	refactor: propagate CanGc arguments through callers (#35565)
https://github.com/servo/servo/pull/35524	(@simonwuelker, #35524)	Support the `<meter>` element (#35524)
https://github.com/servo/servo/pull/35580	(@simonwuelker, #35580)	Allow resetting multiple flags at once in Element::set_state (#35580)
https://github.com/servo/servo/pull/35564	(@mrobinson, #35564)	libservo: Convert `intercept_web_resource_load` into `load_web_resource` (#35564)
https://github.com/servo/servo/pull/35577	(@chickenleaf, #35577)	servoshell: Port Permission dialog code to use egui instead of tinyfiledialogs (#35577)
https://github.com/servo/servo/pull/35459	(@jdm, #35459)	script: Make callbacks generic over DOM interfaces. (#35459)
https://github.com/servo/servo/pull/35567	(@xiaochengh.work@gmail.com, #35567)	Rebase and squash (#35567)
https://github.com/servo/servo/pull/35457	(@jdm, #35457)	script: Refer to DOM interfaces with generic types in generated bindings. (#35457)
https://github.com/servo/servo/pull/35573	(@delan, #35573)	Fix mach argument quoting on NixOS (#35573)
https://github.com/servo/servo/pull/35569	(@pewsheen, #35569)	fix(servoshell): blank view when close non focused tab (#35569)
https://github.com/servo/servo/pull/35550	(@kongbai1996, #35550)	fix touch event wrong coordinates. pageX, pageY, clientX, clientY etc. (#35550)
>>> 2025-02-23T06:01:43Z
https://github.com/servo/servo/pull/35610	(@yerkebulan@gmail.com, #35610)	refactor: add CanGc as argument to DataBlock::view (#35610)
https://github.com/servo/servo/pull/35591	(@augustebaum, #35591)	refactor: propagate CanGc arguments through callers (#35591)
https://github.com/servo/servo/pull/35609	(@yerkebulan@gmail.com, #35609)	refactor: add CanGc as argument to WindowProxy::set_window (#35609)
https://github.com/servo/servo/pull/35612	(@yerkebulan@gmail.com, #35612)	chore: silence unused import warning in app_state.rs (#35612)
https://github.com/servo/servo/pull/35607	(@webbeef, #35607)	Remove the traversal for DomRoot values when collection memory usage (#35607)
https://github.com/servo/servo/pull/35555	(@Narfinger, @mrobinson, #35555)	Use counter instead of time for HTMLFormElement. (#35555)
https://github.com/servo/servo/pull/35601	(@yerkebulan@gmail.com, #35601)	refactor: add CanGc as argument to SubtleCrypto::import_key_{pbkdf2, aes, hkdf, hmac} (#35601)
https://github.com/servo/servo/pull/35596	(@yerkebulan@gmail.com, @jdm, #35596)	refactor: add CanGc as argument to create_buffer_source_with_length (#35596)
https://github.com/servo/servo/pull/35595	(@yerkebulan@gmail.com, #35595)	refactor: add CanGc as argument to CountQueuingStrategy::GetSize (#35595)
https://github.com/servo/servo/pull/35594	(@yerkebulan@gmail.com, #35594)	refactor: add CanGc as argument to ByteLengthQueuingStrategy::GetSize (#35594)
https://github.com/servo/servo/pull/35597	(@yerkebulan@gmail.com, #35597)	refactor: add CanGc as argument to create_buffer_source (#35597)
>>> 2025-02-24T06:04:42Z
https://github.com/servo/servo/pull/35622	(@yerkebulan@gmail.com, #35622)	refactor: add CanGc as argument to Promise::reject (#35622)
https://github.com/servo/servo/pull/35618	(@webbeef, #35618)	Improve scheduling of the memory profiler. (#35618)
https://github.com/servo/servo/pull/35604	(@augustebaum, #35604)	Propagate more `CanGc` (#35604)
https://github.com/servo/servo/pull/35619	(@sagudev, #35619)	Unify `(Offscreen)CanvasRenderingContext2d` and make `PaintRenderingContext2D` standalone (#35619)
https://github.com/servo/servo/pull/35617	(@yerkebulan@gmail.com, #35617)	refactor RTCError::new_inherited (#35617)
https://github.com/servo/servo/pull/35620	(@jdm, #35620)	Move more bindings types to script_bindings (#35620)
https://github.com/servo/servo/pull/35616	(@yerkebulan@gmail.com, #35616)	refactor: add CanGc as argument to Promise::resolve (#35616)
https://github.com/servo/servo/pull/35605	(@Gae24, #35605)	script: add `CanGc` argument to `Promise::new_resolved` and `Promise::new_rejected` (#35605)
>>> 2025-02-25T06:06:52Z
https://github.com/servo/servo/pull/35640	(@yerkebulan@gmail.com, #35640)	refactor: add CanGc as argument to Promise::reject_native (#35640)
https://github.com/servo/servo/pull/35639	(@sagudev, #35639)	chore: Update wgpu (#35639)
https://github.com/servo/servo/pull/35606	(@simonwuelker, #35606)	Don't tell stylo about stylesheets that are not in a browsing context (#35606)
https://github.com/servo/servo/pull/35628	(@simonwuelker, #35628)	Update to rust 1.85 (#35628)
https://github.com/servo/servo/pull/35637	(@sagudev, #35637)	ci: Always install crown, even on self-hosted (#35637)
https://github.com/servo/servo/pull/35552	(@kingsley@kkoyung.dev, @Loirooriol, #35552)	Support for the `isolation` CSS property (#35552)
https://github.com/servo/servo/pull/35627	(@yezhizhenjiakang@gmail.com, #35627)	script: Fix typo in `ScriptThread::process_pending_input_events` (#35627)
https://github.com/servo/servo/pull/35624	(@delan, #35624)	libservo: Refactor ipc-channel default response logic (#35624)
https://github.com/servo/servo/pull/35629	(@sagudev, #35629)	Do not assume `OffscreenCanvasContext` to be 2d (#35629)
https://github.com/servo/servo/pull/35602	(@mrobinson, #35602)	libservo: Move WebDriver messages to the `embedder` crate (#35602)
https://github.com/servo/servo/pull/35630	(@Loirooriol, #35630)	layout: Ignore indefinite `stretch` on min and max sizing properties (#35630)
https://github.com/servo/servo/pull/35632	(@Loirooriol, #35632)	Prevent lint job from trying to use incompatible cargo-deny version (#35632)
https://github.com/servo/servo/pull/35625	(@sagudev, #35625)	Remove `get_ipc_sender` from `OffscreenCanvasRenderingContext2D` (#35625)
>>> 2025-02-26T06:06:57Z
https://github.com/servo/servo/pull/35664	(@IsaacMarovitz, #35664)	Don’t prompt user for credentials for non-Navigate request (#35664)
-https://github.com/servo/servo/pull/35661	(@dependabot[bot], @dependabot[bot], #35661)	build(deps): bump either from 1.13.0 to 1.14.0 (#35661)
-https://github.com/servo/servo/pull/35660	(@dependabot[bot], @dependabot[bot], #35660)	build(deps): bump miniz_oxide from 0.8.4 to 0.8.5 (#35660)
-https://github.com/servo/servo/pull/35658	(@dependabot[bot], @dependabot[bot], #35658)	build(deps): bump tar from 0.4.43 to 0.4.44 (#35658)
-https://github.com/servo/servo/pull/35656	(@dependabot[bot], @dependabot[bot], #35656)	build(deps): bump ring from 0.17.10 to 0.17.11 (#35656)
-https://github.com/servo/servo/pull/35655	(@dependabot[bot], @dependabot[bot], #35655)	build(deps): bump libc from 0.2.169 to 0.2.170 (#35655)
https://github.com/servo/servo/pull/35621	(@mrobinson, #35621)	libservo: Move size handling to `RenderContext` from `WindowMethods` (#35621)
https://github.com/servo/servo/pull/35653	(@Loirooriol, #35653)	layout: Change the `IndefiniteContainingBlock` sizes to `Option<Au>` (#35653)
https://github.com/servo/servo/pull/35647	(@yerkebulan@gmail.com, #35647)	refactor: add CanGc as argument to exception_to_promise (#35647)
https://github.com/servo/servo/pull/35261	(@simonwuelker, #35261)	Allow the `<details>` element to be opened and closed (#35261)
https://github.com/servo/servo/pull/35643	(@mukilan, #35643)	Bump channel in shell.nix to support rustc 1.85. (#35643)
https://github.com/servo/servo/pull/35646	(@yerkebulan@gmail.com, #35646)	refactor: add CanGc as argument to Promise::reject_error (#35646)
https://github.com/servo/servo/pull/35648	(@mrobinson, #35648)	servoshell: Fall back to PNG format when outputting an image (#35648)
https://github.com/servo/servo/pull/35642	(@Loirooriol, #35642)	layout: Let `automatic_min_size()` take a flex-relative cb size (#35642)
https://github.com/servo/servo/pull/35623	(@dklassic, #35623)	feat: support IME cursor area (#35623)
https://github.com/servo/servo/pull/35537	(@kongbai1996, @schwenderjonathan@gmail.com, #35537)	Touch handler: Fix race condition and rate-limit move events (#35537)
-https://github.com/servo/servo/pull/35583	(@dependabot[bot], @dependabot[bot], #35583)	build(deps): bump inout from 0.1.3 to 0.1.4 (#35583)
>>> 2025-02-27T06:04:20Z
https://github.com/servo/servo/pull/35686	(@webbeef, #35686)	winit_minimal: fix build breakage (#35686)
https://github.com/servo/servo/pull/35579	(@delan, #35579)	libservo: Clean up interfaces for alert()/confirm()/prompt() (#35579)
https://github.com/servo/servo/pull/35663	(@Loirooriol, #35663)	layout: Support `stretch` cross size for flex base size (#35663)
-https://github.com/servo/servo/pull/35680	(@dependabot[bot], @dependabot[bot], #35680)	build(deps): bump chrono from 0.4.39 to 0.4.40 (#35680)
https://github.com/servo/servo/pull/35652	(@Loirooriol, #35652)	layout: Support `stretch` cross size for automatic min size in flexbox (#35652)
https://github.com/servo/servo/pull/35662	(@mrobinson, #35662)	libservo: Add `WebView` immediately to the Compositor (#35662)
https://github.com/servo/servo/pull/35677	(@jdm, #35677)	Allow webdriver screenshots to occur immediately upon request. (#35677)
https://github.com/servo/servo/pull/35671	(@chickenleaf, #35671)	Blocks all background webview interactions when a dialog is open (#35671)
https://github.com/servo/servo/pull/35672	(@delan, @mrobinson, #35672)	Make auxiliary webviews exist in the constellation immediately (#35672)
-https://github.com/servo/servo/pull/35654	(@dependabot[bot], @dependabot[bot], #35654)	build(deps): bump flate2 from 1.0.35 to 1.1.0 (#35654)
https://github.com/servo/servo/pull/35531	(@simonwuelker, #35531)	Implement the <progress> element (#35531)
https://github.com/servo/servo/pull/35657	(@chickenleaf, #35657)	servoshell: Port SelectDevice dialog code to use egui instead of tinyfiledialogs (#35657)
-https://github.com/servo/servo/pull/35659	(@dependabot[bot], @dependabot[bot], #35659)	build(deps): bump clap from 4.5.30 to 4.5.31 (#35659)
>>> 2025-02-28T06:07:21Z
https://github.com/servo/servo/pull/35674	(@chickenleaf, #35674)	Remove tinyfiledialogs dependency (#35674)
https://github.com/servo/servo/pull/35699	(@Gae24, #35699)	script: Avoid double borrow crash in `DataTransferItem` (#35699)
https://github.com/servo/servo/pull/35151	(@yoseio, @gterzian, @Taym95, #35151)	script: Implement `Blob::bytes()` (#35151)
-https://github.com/servo/servo/pull/35711	(@dependabot[bot], @dependabot[bot], #35711)	build(deps): bump calendrical_calculations from 0.1.2 to 0.1.3 (#35711)
-https://github.com/servo/servo/pull/35710	(@dependabot[bot], @dependabot[bot], #35710)	build(deps): bump litemap from 0.7.4 to 0.7.5 (#35710)
-https://github.com/servo/servo/pull/35709	(@dependabot[bot], @dependabot[bot], #35709)	build(deps): bump zerofrom from 0.1.5 to 0.1.6 (#35709)
-https://github.com/servo/servo/pull/35706	(@dependabot[bot], @dependabot[bot], #35706)	build(deps): bump async-compression from 0.4.18 to 0.4.19 (#35706)
-https://github.com/servo/servo/pull/35708	(@dependabot[bot], @dependabot[bot], #35708)	build(deps): bump zerofrom-derive from 0.1.5 to 0.1.6 (#35708)
https://github.com/servo/servo/pull/34770	(@xiaochengh.work@gmail.com, #34770)	layout: Implement a non-recursive version of CSS `quotes` (#34770)
https://github.com/servo/servo/pull/35691	(@webbeef, #35691)	winit_mininal: support proper window resizing (#35691)
https://github.com/servo/servo/pull/35703	(@mrobinson, #35703)	clippy: Fix a couple clippy warnings on macOS (#35703)
https://github.com/servo/servo/pull/35702	(@mrobinson, #35702)	compositor Remove `frame_tree_id` member (#35702)
https://github.com/servo/servo/pull/35688	(@Loirooriol, #35688)	layout: Use definite cross size to compute flex base size (#35688)
https://github.com/servo/servo/pull/35694	(@yezhizhenjiakang@gmail.com, #35694)	Update sensitivity naming in `DisplayList::new` (#35694)
https://github.com/servo/servo/pull/35692	(@shubhamg13, #35692)	Set limits on pinch zoom (#35692)
https://github.com/servo/servo/pull/35695	(@sagudev, #35695)	Reuse same `ImageKey` for 2d canvas (#35695)
https://github.com/servo/servo/pull/35651	(@mukilan, #35651)	bindings: Fix support for interface members in setlike/maplike. (#35651)
>>> 2025-03-01T06:05:03Z
[/commits]-->


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
