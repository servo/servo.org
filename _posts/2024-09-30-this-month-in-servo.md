---
layout:     post
tags:       blog
title:      "This month in Servo: and more!"
date:       2024-09-30
summary:    ao!! wrrrrao!!
categories:
---

<!--
- donations
    - opencollective 2005.00/month
    - github 2022.00/month
    - lfx 120/month (11 donors)
    - thanks.dev (11 donors)
- new features
    - ‘table-layout: fixed’ 33384 33442
    - ‘object-fit’ and ‘object-position’ 33479
    - innerText and outerText 33312
    - console.timeLog 33377
    - encodeInto() method on TextEncoder 33360
    - Crypto.getRandomValues() now accepts BigInt64 and BigUint64 33485
    - <link rel=prefetch> 33345
    - <ul type> and <ul compact> 33303
    - <q cite> 33307
- rendering
    - right-to-left support (except floats) 33375
    - absolute descendants of atomic inlines 33336
    - min/max-block-size block containers 33203
    - min/max-block-size floats 33241
    - start work on min-content|max-content|fit-content|stretch 33492
    - correct ‘white-space: break-spaces’ with ‘word-break: keep-all’ 33376
    - ‘position: relative’ on <caption> 33426
    - more correct CustomEvent 33481
    - more correct requestAnimationForm delivery 33395
    - canvas width height? 33211
- intrinsic sizes (min/max-content)
    - block size for percentage descendants 33204
    - replaced aspect ratio 33240
    - column flex containers 33299
    - ‘white-space: nowrap’ 33343
- tables
    - width and height attributes on table-related elements 33405 33425
    - better handling of extra <col> and <colgroup> 33451
    - better ‘border-collapse’ 33452
- fetch
    - send Accept-Encoding with Range header 33496
- flexbox
    - ‘align-self: normal’ 33314
    - cross-axis percentages in flex items 33242
    - automatic minimum sizes 33248
    - automatic minimum sizes ‘aspect-ratio’ 33256
    - replaced aspect ratio 33263
    - correct baselines 33347
    - absolute descendants of flex containers 33346
- webgpu
    - texture formats 33504
    - GPUBuffer 33154
    - destroy() method on GPUTexture 33534
    - pipeline-overridable constants in GPUProgrammableStage 33291
    - faster uploads to webrender 33387
- webxr
    - reference space reset events 33460
- servoshell
    - nightly builds for android aarch64 33435
    - gamepads now enabled by default 33466
    - better navigation on android 33294
    - windows keyboard input and scrolling 33225 33252
    - fixed hidpi 33529
    - now supports ohos 33295
    - tab mouse x/+/middle-click 33244
    - tab keyboard shortcuts 33319
    - tab empty titles 33354 33391
    - location when switching tabs 33316
- ohos
    - back forward 33206 33511
    - ffi vsync 33117
    - webgl 33257
- perf
    - faster window resizing 33297
    - faster test shaping on windows 33123
    - shared memory font data 33530
    - mach test-speedometer headless 33187 33247
    - start(?) of splitting up script crate 33169
    - experimental tracing support with perfetto 33188 33301
    - ...and hitrace 33324
    - ...and tracing events 33189 33417 33436
    - profiling build profile 33432 book#22
    - fixed excessive document title updates 33286
- upgrades
    - stylo 2024-09-02 33370 33472
    - wgpu 33266 33357 33506
    - mozjs 33536 33537
    - html5ever 0.29 xml5ever 0.20 33412
    - rust-version in Cargo.toml 33483
- crashes
    - duration underflow on finsandfoamfreediving.com 33341
    - devtools 33305 33381
    - large table column widths 33424
- ci
    - self-hosted linux 33321 33389
    - self-hosted fixes 33283 33308 33315 33373 33471

untriaged from last month:
>>> 2024-08-26T06:09:38Z
    e0e562137ce8d985c5bda8e65add5edb8409c25f	https://github.com/servo/servo/pull/33185	Add fallback value for data['message'] (#33185)
+   88d87702147b296de230c120e636fe97f8466e96	https://github.com/servo/servo/pull/33169	Use global exports from derives (#33169)
>>> 2024-08-27T06:07:55Z
    b6d5ac09b0b2acbb0f5b00232e53d0111a159063	https://github.com/servo/servo/pull/33114	mach: introduce `BuildTarget` abstraction (#33114)
+   4397d8a02156a009d16d8b79796b1e54ca635624	https://github.com/servo/servo/pull/33187	Add `dom.allow_scripts_to_close_windows` pref. (#33187)
>>> 2024-08-28T05:55:51Z
+   253723409022546475240b04843ed19ad321d847	https://github.com/servo/servo/pull/33206	ohos: Add FFI-APIs to navigate back and forward (#33206)
+   5d43d88b6c335bf786de910dacb5e898d51b961b	https://github.com/servo/servo/pull/33203	Respect min/max constraints in the block axis of block containers (#33203)
+   7fce24f9d54a015db7ee813fc16c74d2feacbb12	https://github.com/servo/servo/pull/33154	webgpu: Sync `GPUBuffer` (#33154)
>>> 2024-08-29T06:01:33Z
    c69acd184826b87d29a91c78b149cd413dec29bd	https://github.com/servo/servo/pull/33239	Fix run_dromaeo.py (#33239)
    fe4401000065185b4d4feca4bffc5dc469848b4a	https://github.com/servo/servo/pull/33205	mach: Extract binary select into common_command_arguments (#33205)
    bb5547a5d05b1f002d9cce3197cfb9cdcb71d33c	https://github.com/servo/servo/pull/33162	Fix panic in parser-reentrancy-customelement.window.js (#33162)
+   9639d36550a47bc66efcea2f05117efc318ad3c4	https://github.com/servo/servo/pull/33211	Remove `width` and `height` presentational hints for `<canvas>` (#33211)
>>> 2024-08-30T05:56:52Z
+   4bf941bc8a0eff281da668dbe550fb52c0e7a983	https://github.com/servo/servo/pull/33248	Fix automatic minimum size for column flexbox (#33248)
+   9ea02fa4b46e92c00d3efa252e36681729d385a0	https://github.com/servo/servo/pull/33252	Fix minibrowser scroll by keyboard (#33252)
+   99bd6afa81adc81b90b723fa8673f5992e7af722	https://github.com/servo/servo/pull/33225	Pass keyboard events to WebView on Windows (#33225)
+   8dd40ed2bd4411d73ca1661803635345c2d9c3c1	https://github.com/servo/servo/pull/33247	mach: Add `test-speedometer` command and `--bmf-output` to speedometer and dromaeo (#33247)
+   0643aa47089838353e80f6fd509cbe70d13af271	https://github.com/servo/servo/pull/33240	Handle aspect ratios in `ReplacedContent::inline_content_sizes` (#33240)
+   93abdf7cb56fa9db6aa160d63e8773292c5e7520	https://github.com/servo/servo/pull/33204	layout: Add an indefinite containing block for intrinsic sizing (#33204)
+   46dbe4ce320eb99e851dd422f624615e18c39e15	https://github.com/servo/servo/pull/33242	Obey min and max cross sizes of flex items (#33242)
+   59c74c874a082dc2c4652747d768498c2d03d3ee	https://github.com/servo/servo/pull/33241	Obey `min-block-size` and `max-block-size` in floats (#33241)

this month:
>>> 2024-08-31T05:55:56Z
+   3acc9edd82ce159a356bd88a26fd37b2b39d6a44	https://github.com/servo/servo/pull/33263	Fix various issues with replaced elements in flex layout (#33263)
+   4ae2610c24bfbd7acabf7ff327cf97d6df55c06f	https://github.com/servo/servo/pull/33123	fonts: Enable fast text shaping on Windows (#33123)
    6f333a8e299d84c98a07a0b708fe32f40aeeeb72	https://github.com/servo/servo/pull/33260	net: Stop using both versions of the `time` crate in the cookie code (#33260)
    1e9344cb5c4b8e050319791ce4d489a347a2875b	https://github.com/servo/servo/pull/33270	build(deps): bump tokio from 1.39.3 to 1.40.0 (#33270)
+   5e89643fa7864a4e40593c561ec3f16d590d52bf	https://github.com/servo/servo/pull/33266	chore: Update wgpu to 34bb9e4ceb45a5b1cfc5df6aa2b2e201cc55372c (#33266)
    a4ceb82ef5647050050184c0c76aa3fe7e0dbc7b	https://github.com/servo/servo/pull/33262	script: Stop using `time` in DOM timers (#33262)
+   8a0c7487e7853602bc38679eb78bef9347bd0d2c	https://github.com/servo/servo/pull/33117	ohos: Present on vsync signals (#33117)
    a58d8163197bd08b8cb568fd7057ff6b2f8e285e	https://github.com/servo/servo/pull/33259	net: Stop using legacy time in the HTTP and CORS caches (#33259)
    817a91f2acafd839a83bd8f627475fc1f29494c2	https://github.com/servo/servo/pull/33223	webgpu: Clean up `GPUCommandEncoders` and add some validation (#33223)
    83a40c51809cdac3c7d58731b555dc95cdc5c5bf	https://github.com/servo/servo/pull/33258	script: Stop using legacy `time` for `Document::reflow_timeout` (#33258)
+   cd8b803368fd917a474af15ab71c4b622a7c6154	https://github.com/servo/servo/pull/33256	Use the proper aspect ratio in flexbox (#33256)
>>> 2024-09-01T05:57:09Z
    3453d9fdadf3274bec73086b15204acf760b202a	https://github.com/servo/servo/pull/33274	Update web-platform-tests to revision b'5d8ec746ed021738e7ee0cee92ad1a1814ba00fe' (#33274)
>>> 2024-09-02T06:01:44Z
    35ca050bfb82b27cac0fe142768a4876759fced0	https://github.com/servo/servo/pull/33277	android: Fix install (#33277)
    a62612a025c619c4a7d0eab120a20dea9b69e306	https://github.com/servo/servo/pull/33279	Make all platforms use a delay during cookie tests. (#33279)
    12a782dc200b3a81ab9de4050a8cd8f2035522b8	https://github.com/servo/servo/pull/33268	build(deps): bump glslopt from 0.1.10 to 0.1.11 (#33268)
    06778e3643b8cea710def5ae0955a68070bdfcd9	https://github.com/servo/servo/pull/33269	build(deps): bump object from 0.36.3 to 0.36.4 (#33269)
    9fdaf9bf0c6958356b8e3b4f5d03f838c13c6307	https://github.com/servo/servo/pull/33271	Update FakeXRDevice to support updating bounds (#33271)
>>> 2024-09-03T06:07:36Z
    6c0394bc80963163f36dd273f8e6ed64b177dfa0	https://github.com/servo/servo/pull/33212	Impl PartialEq and Eq for DomObject (#33212)
+   31e84a8c484e74448c982f610abc42a8f8b7a9fb	https://github.com/servo/servo/pull/33257	ohos: Enable Webgl context creation on OH 5.0 (#33257)
    c9548d82efc5568ec66f67940b543f4709ceb152	https://github.com/servo/servo/pull/33281	bootstrap: Avoid needless sudo when pkgs are installed (#33281)
>>> 2024-09-05T06:07:10Z
    75c7712905c522f604a454dcb1c18b8e3f163d3b	https://github.com/servo/servo/pull/33318	webxr: Add some missing internal checks/validation (#33318)
    aadc212b95cdef2a25475f025aa7fab659dde646	https://github.com/servo/servo/pull/33306	jsstring_to_str should accept a NonNull argument for the JS string (#33306)
+   642c25d9a73b2c3fbe6f98a32bae5c7bdb6c448f	https://github.com/servo/servo/pull/33315	CI: use monitor API for self-hosted runners (#33315)
    00389cf00746e7e38ff704c867f3401440b3a462	https://github.com/servo/servo/pull/33302	Transform convert_* functions in gpuconvert.rs to From/TryFrom implementations (#33302)
+   c0ced7a524b1c487a0b38dcb1875f2fa7fe21097	https://github.com/servo/servo/pull/33301	Make tracing available on all platforms, with or without perfetto (#33301)
+   891562be8e295d616776315e08f0ffb2bbc97c92	https://github.com/servo/servo/pull/33244	servoshell: Add close buttons and increase interactivity of tabs (#33244)
+   3c6ca338327c5ee1db7cf7c83325771ad0a6b43d	https://github.com/servo/servo/pull/33291	webgpu: Support pipeline-overridable constants (#33291)
+   a976db3ec05304387055034cd1f2f3f3c5fb65f5	https://github.com/servo/servo/pull/33294	Update layout of servoshell android app (#33294)
+   961fcfc46de123e966362f985d64540af6521b9c	https://github.com/servo/servo/pull/33297	Only handle most recent resize event in script thread (#33297)
+   fc5f8e9237f95153b642846f8d89682cc4061573	https://github.com/servo/servo/pull/33307	Implement HTMLQuoteElement "cite" attribute (#33307)
    febb4f24c444dd5c85ca2ed41b633ddadbf24eb5	https://github.com/servo/servo/pull/33285	build(deps): bump syn from 2.0.76 to 2.0.77 (#33285)
+   ba7e53264d2daf1f2ca0157c645dbe477708c649	https://github.com/servo/servo/pull/33188	Add initial support for tracing and tracing-perfetto (#33188)
+   abe532dd2f7b9931a75f5c2a0925b09a2bfae730	https://github.com/servo/servo/pull/33308	CI: Force github hosted runners and remove concurrency on select-runner job (#33308)
+   27d87f104e015c1c661a4a7fc0741d2ccb32fde6	https://github.com/servo/servo/pull/33299	Fix intrinsic sizing of column flex containers (#33299)
+   e43e4778421be8ea30db9d5c553780c042161522	https://github.com/servo/servo/pull/33303	Implement compact/type attributes for HTMLUListElement (#33303)
    93cd8d1ba47838832327d88f00bb26c9cc5e7d77	https://github.com/servo/servo/pull/33284	build(deps): bump indexmap from 2.4.0 to 2.5.0 (#33284)
    e857cdf022f319ae3fbd54e10e279ab43485995b	https://github.com/servo/servo/pull/33290	Hack around DCO not in MQ (#33290)
+   4b96d8ef3648fd3bd47f3778e0ad06fdfea31b46	https://github.com/servo/servo/pull/33283	CI: label self-hosted runners with run id to aid debugging (#33283)
>>> 2024-09-06T05:59:08Z
    ebed9218f2907767ba3c9dd9f27f30a6a6e9f225	https://github.com/servo/servo/pull/33320	webgpu: Move actual Create* implementations from `GPUDevice` to Self (#33320)
    312cf0df08e8a5044d286734bfdf3d6f0caff8dd	https://github.com/servo/servo/pull/33282	script: Create a `CrossProcessInstant` to enable serializable monotonic time (#33282)
    35baf056f6feb9eccfe36854da88d4fc454b654d	https://github.com/servo/servo/pull/33333	build(deps): bump serde_json from 1.0.127 to 1.0.128 (#33333)
    5d30f8f3cc5f5ce418acbf0dbda48388de8b0dd3	https://github.com/servo/servo/pull/33332	build(deps): bump rustix from 0.38.35 to 0.38.36 (#33332)
    a59f295fa2f963914281de2996737fbbfd91d632	https://github.com/servo/servo/pull/33330	build(deps): bump wayland-scanner from 0.31.4 to 0.31.5 (#33330)
    004fd0281bcc55b24076a294e36efd44ee43067b	https://github.com/servo/servo/pull/33331	build(deps): bump wayland-client from 0.31.5 to 0.31.6 (#33331)
    5350edb6eae63b5da5e16cc34b69a7402c4f0049	https://github.com/servo/servo/pull/33329	build(deps): bump ohos-sys from 0.3.0 to 0.3.1 (#33329)
    0ee1a5e82c1ebb089d9e2c7c2fb6217ce1b8db20	https://github.com/servo/servo/pull/33328	build(deps): bump rustfix from 0.8.4 to 0.8.5 (#33328)
    aa8c8f8153b2c5f8d6e435e4f9dc5559bccbc9fd	https://github.com/servo/servo/pull/33326	build(deps): bump tokio-util from 0.7.11 to 0.7.12 (#33326)
    e271a47c0680d7796d49c20bc86b12e1f0a9d5a8	https://github.com/servo/servo/pull/33327	build(deps): bump wayland-backend from 0.3.6 to 0.3.7 (#33327)
    66544c39cccefa83ac16d3215bbee226923aafae	https://github.com/servo/servo/pull/33325	build(deps): bump tokio-stream from 0.1.15 to 0.1.16 (#33325)
+   7e493ba865ef7e748ce3b14d59117315a0ec8aee	https://github.com/servo/servo/pull/33316	minibrowser: Reset the location field when switching tabs (#33316)
    e6ee879d2af7ef473ec294ecb7b6eed2546c645e	https://github.com/servo/servo/pull/33317	build(deps): bump cc from 1.1.15 to 1.1.16 (#33317)
+   0f24b8c823ec57a6fad309dda4c36dbaab604e89	https://github.com/servo/servo/pull/33189	Add tracing events (#33189)
+   37e1c3385e03e1976aecfad3b558049c94ad9e76	https://github.com/servo/servo/pull/33314	Treat `align-self: normal` as `stretch` on flex items (#33314)
+   8263fe5495d2273cc876ebb9a7402f196292f5a4	https://github.com/servo/servo/pull/33319	Added some keyboard shortcuts for focusing tabs (#33319)
>>> 2024-09-07T05:58:52Z
    152e62022a8c69d28c217b0fce651fd2d02dc08f	https://github.com/servo/servo/pull/33348	Move convert_label to Into implementation (#33348)
    bc04f94a301b1575a1bca90e145778d3596e7b1b	https://github.com/servo/servo/pull/33351	build(deps): bump wayland-cursor from 0.31.5 to 0.31.6 (#33351)
    5d85f283c78e860f4fa6583f1d15b06e360db418	https://github.com/servo/servo/pull/33350	build(deps): bump cpufeatures from 0.2.13 to 0.2.14 (#33350)
    3fb4833c88705a3f6f17d39cd097218d7c5f3dd0	https://github.com/servo/servo/pull/33349	build(deps): bump bytemuck from 1.17.1 to 1.18.0 (#33349)
+   c24c7d8e4d52604dba755251f7222efcb07d738d	https://github.com/servo/servo/pull/33336	layout: Lay out absolutes in atomic containing blocks (#33336)
>>> 2024-09-08T05:52:58Z
    85823edd01e2636342a02e0bf3e2b51a54eea592	https://github.com/servo/servo/pull/33359	Update web-platform-tests to revision b'ec9b870fec350e59e9db48ae2858e914a07f38d6' (#33359)
    1c6fb1a7ba12f2af635ca7bdf7982b9b3757ef87	https://github.com/servo/servo/pull/33358	Set empty object as `console` prototype (#33358)
+   f3f96c3393edad9d576d9c4f64c57d75fa2902a2	https://github.com/servo/servo/pull/33347	layout: Do not use orthogonal baselines in flex layout (#33347)
+   a43e296436e6d6f139b312bdcbe3dc03d1ab3c6a	https://github.com/servo/servo/pull/33305	Fix devtool crashs after clicking `Enable connection prompt` (#33305)
+   567c3185f8d42898e754f85a63b51ad32680972d	https://github.com/servo/servo/pull/33357	chore: Update wgpu (#33357)
>>> 2024-09-10T06:06:42Z
    f1ad364ec2dacca3ec7d79830ef8da9f26fbf4e2	https://github.com/servo/servo/pull/33383	Fix reordering of table-header-group and table-footer-group (#33383)
+   193f5926171b59d5b8175621074e5d543f983a31	https://github.com/servo/servo/pull/33287	Send less title changes to the embedder (#33287)
    e5150dbda1f89ff07294dbd1ca4e8f4f08cf4874	https://github.com/servo/servo/pull/33386	Propagate `CanGc` from `Document::new()` (#33386)
+   10e5bb72d9e16655b625b8971e346ff479b17fd2	https://github.com/servo/servo/pull/33345	Initial support for `<link rel="prefetch">` (#33345)
    2993577ac0ea2638a1dde3cfb9e4cb7b45b542ae	https://github.com/servo/servo/pull/33380	script: Added missing spec step in `Location::SetHash` (#33380)
+   cc3c69b95364268610858f4a149d84c4cfee1a5f	https://github.com/servo/servo/pull/33377	implement `console.timeLog` (#33377)
+   8c0a566860cf0f43662dc9d6c3474ae194c1a9fc	https://github.com/servo/servo/pull/33381	Fix devtool crashs after entering window.location in console (#33381)
+   d169a82d2e146704db3d9eb2b5f9f49f9ef8b1da	https://github.com/servo/servo/pull/33346	layout: Implement proper absolute child position for flexbox (#33346)
+   a3a86d59132b03526217f570defd903221b6ba65	https://github.com/servo/servo/pull/33360	script: Implement `TextEncoder::encodeInto()` (#33360)
    52a447b1e37aea0712a5ef40a6e2c95f15148af4	https://github.com/servo/servo/pull/33379	android: make aarch64 the default target (#33379)
    8842fe9df580c4458d8ffe0247e49bae846ce6b6	https://github.com/servo/servo/pull/33355	script: Use `time@0.3` for input elements and do conversion in a &str trait (#33355)
    687f356db9dc0ac9f50cf172e5c44aca581d3ee7	https://github.com/servo/servo/pull/33367	webgpu: Factor out swapchain to separate file (#33367)
    938fd8c12fc2489303e12538d3e3585bd771141f	https://github.com/servo/servo/pull/33369	webxr: Update XRInputSource gamepad index to be -1 (#33369)
+   9cfbaf92e5bc80dca90f1226dbc4cdcfe025eeb3	https://github.com/servo/servo/pull/33373	CI: fix self-hosted runners in try-label builds (#33373)
    4d0bef0ac3d31a7ea5933b2fa8bc2118d0452ea9	https://github.com/servo/servo/pull/33371	Remove unused imports (#33371)
+   8bb739b818dc21a2ef71d56a3b97a040cc44f384	https://github.com/servo/servo/pull/33321	CI: use self-hosted runners for Linux build jobs (#33321)
    e70507ca403c9475a92b3c1b8230fad08c9c7ab2	https://github.com/servo/servo/pull/33366	tidy: Fix rustdoc warnings and add a tidy check for a common URL issue (#33366)
+   f6ae05007751968f90a702b15c8b5083453ad8c7	https://github.com/servo/servo/pull/33341	net: use saturating_sub when substracting durations to prevent underflows (#33341)
>>> 2024-09-11T06:04:00Z
    095590e2247517cf22e4aea7956f341a9a38b206	https://github.com/servo/servo/pull/33396	layout: Use `Au` in `ComputedValuesExt` (#33396)
    9346d9cc8d686d6bb7c96c427d4d7a0b1ac28142	https://github.com/servo/servo/pull/33398	Align Servo version between user agent string and servoshell about dialog (#33398)
    1b27a911af4ae4370baa1562e3d8773f390fa613	https://github.com/servo/servo/pull/33344	Make Crashtests with test-wait wait (#33344)
+   9d3d00989591d3250762525b901dee8253cde666	https://github.com/servo/servo/pull/33376	Allow breaking line after space with `white-space: break-spaces` (#33376)
+   6d6cd0f2dc395dc8dd50a0df1b54bee48d9b1ae6	https://github.com/servo/servo/pull/33324	Plumb selected tracing spans into hitrace (#33324)
+   d4be678a692bfa3ae6def528d939ca86cb884a4a	https://github.com/servo/servo/pull/33389	CI: fix self-hosted runners in Linux builds (#33389)
+   8286dd33a539fe063dd438f6ce74d9445a9c973a	https://github.com/servo/servo/pull/33354	script: fixed document title being set to Some("") instead of None (#33354)
+   7ec22306e80c85f2c3fc15bb83cec4170ec1a254	https://github.com/servo/servo/pull/33391	Fallback to the url if a tabs title is empty (#33391)
>>> 2024-09-12T05:57:32Z
    637770600fe23d9cb51091d9c53a408205677727	https://github.com/servo/servo/pull/33385	libservo: Improve finding python (#33385)
    08a4d751d7762fa36490998ba17bf3eece8d9bef	https://github.com/servo/servo/pull/33403	webxr: Update XRInputSource Gamepad handling, FakeXRInputController (#33403)
+   d9be9d6bd464c664e7ddad86937a9aa54a6c7baf	https://github.com/servo/servo/pull/33343	Handle all `white-space` values when intrinsically sizing an IFC (#33343)
    777fb81260ed10e016370dcd83fc750367e97535	https://github.com/servo/servo/pull/33411	Use raqote from crates.io and update canvas Cargo.toml (#33411)
    b42f5eaa17c897270e9de5dadc6ab19fb1dfff43	https://github.com/servo/servo/pull/33410	mach: remove python2 compatibility code (#33410)
    ed5dc43f160993ff491e2eab17fae1db872ed964	https://github.com/servo/servo/pull/33406	layout: Reverse space-between alignment properly for absolute children of flex containers (#33406)
    68246df89ec0055312ecbcff35ad9a1e7d381e84	https://github.com/servo/servo/pull/33408	fix clean-cargo-cache command (#33408)
+   23b0dc603c02db990ba793f61dbb6f82066416a8	https://github.com/servo/servo/pull/33395	Raf delivery: run rafs for all pipeline if tick received for any. (#33395)
    9175e598adcf33097cd6bd29a1e2b428d564c295	https://github.com/servo/servo/pull/33400	Let table-related boxes adjust their `overflow` values (#33400)
+   027fc53e2fa6b5d15f0e73e6685266b77e993a35	https://github.com/servo/servo/pull/33375	layout: Right-to-left support for other layout modes (#33375)
    bc8d8b62c3017dbdb413a636b80bc3a2df0172d6	https://github.com/servo/servo/pull/33394	Stop using `time@0.1` in Servo (#33394)
>>> 2024-09-13T06:08:20Z
    03abf7751aead3d42f5a4e2207567dd3012cee96	https://github.com/servo/servo/pull/33428	compositor: Do not allow script to scroll past maximum scroll node offsets (#33428)
    db0aee6b58509401642712d18418c9150ca2cc18	https://github.com/servo/servo/pull/33427	layout: `<th>` should have `text-align: center` when the child of an element with `text-align: initial` (#33427)
    219a2f20388daf30038b6bd718ff557698f2c931	https://github.com/servo/servo/pull/33429	Cleanup after #33396 (#33429)
+   dc018b5f9f0cbdede459a0236743e39df24cb018	https://github.com/servo/servo/pull/33384	Add support for `table-layout: fixed` (#33384)
+   52e495c1a698826c494ece7c3a58dad37d847eb2	https://github.com/servo/servo/pull/33424	Avoid crash with large table column widths (#33424)
+   b048bf80a40afe275d1052e57ba1bcd7701db03c	https://github.com/servo/servo/pull/33425	Accept zero values on some `width`/`height` attributes on table elements (#33425)
+   4839cdf1764eac2b520692d2b9c3da002b509d01	https://github.com/servo/servo/pull/33405	Add `width` and `height` presentational hints for table-related elements (#33405)
    37ab4b98259d45c9efd3645ebc961ca518adb5c6	https://github.com/servo/servo/pull/33421	chore: Fix two compiler warnings (#33421)
+   b1486d311aca665b62c7d48ee32660f55e8ad7cb	https://github.com/servo/servo/pull/33412	Upgrade to html5ever 0.29 and xml5ever 0.20 (#33412)
    747e562ff098c5eca6941c210ecd87180600610b	https://github.com/servo/servo/pull/33407	Make CanGc derive Copy and Clone (#33407)
>>> 2024-09-14T06:04:03Z
    6a3cdc47ec61e9d5122dd68aba8c75c00c9e5051	https://github.com/servo/servo/pull/33418	Improve spec conformance around request header validation (#33418)
    6071b4a96187b0f4d9f683e60878f39145c457ab	https://github.com/servo/servo/pull/33448	build(deps): bump serde from 1.0.209 to 1.0.210 (#33448)
    6539a889c71d7773819385e7aabebe5941bb37c0	https://github.com/servo/servo/pull/33447	build(deps): bump anyhow from 1.0.86 to 1.0.88 (#33447)
    db09ddacabd7ca1513c6d2e004ee4e099bf11998	https://github.com/servo/servo/pull/33449	build(deps): bump memmap2 from 0.9.4 to 0.9.5 (#33449)
+   a2b8bdb903c9bd3c76ff6a0491cb264df0dcabb5	https://github.com/servo/servo/pull/33442	Allow table-layout:fixed to shrink cells to less than the border+padding (#33442)
    b4a0a240a7b67ecc6712178b871eef1308173d80	https://github.com/servo/servo/pull/33443	build(deps): bump unicode-ident from 1.0.12 to 1.0.13 (#33443)
    8b32bdac26c11769521dd7dacd8312b7f2ca6b61	https://github.com/servo/servo/pull/33444	build(deps): bump cc from 1.1.16 to 1.1.18 (#33444)
    3d3f8e6dbd7edd806b97ebd9adf54ecd0a6cfa33	https://github.com/servo/servo/pull/33446	build(deps): bump backtrace from 0.3.73 to 0.3.74 (#33446)
    02dd483ff7fc6ce3dc7e1cb470e70e1947fea877	https://github.com/servo/servo/pull/33441	build(deps): bump error-code from 3.2.0 to 3.3.1 (#33441)
    cf501d582ad7b77f0f294e8406414dbfef35773b	https://github.com/servo/servo/pull/33439	build(deps): bump rustix from 0.38.36 to 0.38.37 (#33439)
    11fba78963c6904927c06ad0dba7c0f831806454	https://github.com/servo/servo/pull/33445	build(deps): bump xml-rs from 0.8.21 to 0.8.22 (#33445)
    fa8752df6a2c9cdec3d9108614bf2bf9b713626b	https://github.com/servo/servo/pull/33438	Fix precision issue with line heights (#33438)
+   a76daaf04c121b70c9b0f3883b682983d676ff7f	https://github.com/servo/servo/pull/33370	Upgrade stylo to 2024-09-02 (#33370)
+   261d60e456b678939b8a0ceff4d8eafcd44e582e	https://github.com/servo/servo/pull/33387	webgpu: Do one allocation less on presentation by keeping GPUBuffer mapped (#33387)
    f76692035b841661e9f0c4afa7f3651f2bfe91b8	https://github.com/servo/servo/pull/33420	uses app units in display_list (#33420)
    52f89c95b9decf86b445f311b8c04412d8c1754f	https://github.com/servo/servo/pull/33433	Fix inset box-shadow to use the padding box (#33433)
    6e80a34d09e8bb22bdac5feeff4cf30b571987ff	https://github.com/servo/servo/pull/33431	Simplify table logic in effective_ovherflow() (#33431)
+   497df024b185feb7370d3f9ebca10e18e7585099	https://github.com/servo/servo/pull/33417	Trace more functions by adding perfetto tracing events (#33417)
>>> 2024-09-15T06:01:13Z
    9f2306f76095cf81d299d0c977490803f5703c75	https://github.com/servo/servo/pull/33461	Update web-platform-tests to revision b'4c3d068f942231dc905ea283e4f82bd70801c37c' (#33461)
    ed908f3fd418f51f27dd0e063f1851863018354c	https://github.com/servo/servo/pull/33458	Fix rustdoc problems (#33458)
    97495e45f8a19f8772cca4035d6521762f94640d	https://github.com/servo/servo/pull/33456	libservo: Don't set features of log (#33456)
    f8ca5c31946e11dd298ccb9da1fa76fda9c2066e	https://github.com/servo/servo/pull/33454	Fix packaging when cross compiling (#33454)
    ed6b1b5e6a5002bdeab51214576b50b10822b5f8	https://github.com/servo/servo/pull/33453	clippy: Fix suggestions in `script`, `libservo`, and `servoshell` (#33453)
>>> 2024-09-16T05:51:39Z
>>> 2024-09-16T14:56:31Z
+   ea109d549023e01b97e510088871a351b9ec7543	https://github.com/servo/servo/pull/33435	android: publish nightly builds for aarch64 (#33435)
    5b6a9110c7c79159c3150f7f9739f67f271cb0c0	https://github.com/servo/servo/pull/33469	Clear `self.pending_whitespace.max_content` in `forced_line_break()` (#33469)
    10c64820e817ce47fae26b6a7925320f5fa9299d	https://github.com/servo/servo/pull/33434	chore: update script to use phf 0.11 (#33434)
    7df30f3788a14baa590c9123f5e1616ccfe0a0f0	https://github.com/servo/servo/pull/33468	Replace .map_or(false with Option::is_some_and (#33468)
+   236cae9ce53019036710032a980966542a64fbce	https://github.com/servo/servo/pull/33436	Add perfetto tracing events to fonts (#33436)
+   b12cebd1ac3b2bc809e5ac69f708cf61b515590d	https://github.com/servo/servo/pull/33452	Small improvements for table border collapse (#33452)
+   679afe519591c3c36036154afb1e9b6d73ffa1ac	https://github.com/servo/servo/pull/33451	Do not remove extra columns at the end of the table (#33451)
    17f796dfc133f6dbe744fd04ad70bbff06c7a7d5	https://github.com/servo/servo/pull/33450	Let `LengthPercentage::maybe_to_used_value()` accept `Option<Au>` (#33450)
>>> 2024-09-17T06:11:48Z
+   f8e0fde044c257943ee0e3c0213230a69fb9a432	https://github.com/servo/servo/pull/33460	webxr: Implement reference space reset events (#33460)
    b0cae28c837656a6c5fc1418543adc95d539bfde	https://github.com/servo/servo/pull/33478	build(deps): bump unicode-segmentation from 1.11.0 to 1.12.0 (#33478)
    4405b260351f2a1768db3ecf65a4a5c935332096	https://github.com/servo/servo/pull/33477	build(deps): bump arrayref from 0.3.8 to 0.3.9 (#33477)
    f255393a45a7328b8978dab33cce52e5356ae3d5	https://github.com/servo/servo/pull/33476	build(deps): bump iana-time-zone from 0.1.60 to 0.1.61 (#33476)
    594342224df674df704b1d45eb2299da46b8e0ba	https://github.com/servo/servo/pull/33474	build(deps): bump anyhow from 1.0.88 to 1.0.89 (#33474)
    8d29515a30b143ef30794c3b405a6acfc14eca91	https://github.com/servo/servo/pull/33473	build(deps): bump cc from 1.1.18 to 1.1.19 (#33473)
    06bf6124c4aa5effb57fcb00bbd758e6bc457296	https://github.com/servo/servo/pull/33457	webgpu: Use `PresentationBufferState` instead of bucketing buffer_ids per state (#33457)
+   3b33ef0cfad829b2e62f3184859ab46944ec424d	https://github.com/servo/servo/pull/33472	Bump Stylo from 6059306e6 to 25daa6b91 (#33472)
>>> 2024-09-18T06:03:40Z
    7eda58ea6dcf7bcc54f6c02766e641c209ed7cb6	https://github.com/servo/servo/pull/33484	build(deps): bump cc from 1.1.19 to 1.1.20 (#33484)
+   aa0029c11c797693dd2e8b31c4da3f7f16377511	https://github.com/servo/servo/pull/33483	Add `rust-version` to all `Cargo.toml` files (#33483)
+   25bce9f6b9b8dfa138044c45adc33c9c32bf5fba	https://github.com/servo/servo/pull/33471	CI: fix self-hosted runner timeout detection (#33471)
+   7cbc5f6ee61102864528eed513e399f256b4e5cb	https://github.com/servo/servo/pull/33481	Update CustomEvent webidl interface (#33481)
+   4c3b3529a800778c46bcb92018df6f5c895f70bc	https://github.com/servo/servo/pull/33466	servoshell: Update gilrs version, enable gamepad pref by default (#33466)
>>> 2024-09-19T06:11:13Z
    05b2aa29c310c806507c580f1a25b1321f91927e	https://github.com/servo/servo/pull/33494	build(deps): bump cc from 1.1.20 to 1.1.21 (#33494)
    5c070ee3895948543cfa3aa84347b7cc19e0e9ad	https://github.com/servo/servo/pull/33493	build(deps): bump bytes from 1.7.1 to 1.7.2 (#33493)
    777a3ec13f6a2c519e8688124fb34030fbb9623f	https://github.com/servo/servo/pull/33490	Append the Sec-Purpose header for prefetch requests (#33490)
    aa5bf94b35fb796a8f95784b6848364233db6cdf	https://github.com/servo/servo/pull/33487	dom: Append stream chunks in the correct order. (#33487)
    313fc663a6d3076349a1170f9dabc953922ea278	https://github.com/servo/servo/pull/33488	android/ohos: Fix wrong production cfg (#33488)
+   bd632fc8144e347db7452c8013137e6a16e30bd1	https://github.com/servo/servo/pull/33479	layout: Add support for `object-fit` and `object-position` (#33479)
+   632d83270498f6cb2e9d284503d86607f250b80e	https://github.com/servo/servo/pull/33485	Add checks for BigInt/BigUint in getRandomValues (#33485)
>>> 2024-09-20T05:55:37Z
    457d37d94ee6966cad377c373d333a00c637e1ae	https://github.com/servo/servo/pull/33501	build(deps): bump unicode-xid from 0.2.5 to 0.2.6 (#33501)
+   ef229b93863b7b1f1f718c4f1fbb755d0136e40d	https://github.com/servo/servo/pull/33426	layout: Ensure that `<caption>`'s support `position: relative` (#33426)
+   eecf5bdea16581f201d674a9079a888858ec84bc	https://github.com/servo/servo/pull/33432	Add a profiling build profile in Cargo (#33432)
+   06f0893b9496452f2c2937fac76ce36bd12604cb	https://github.com/servo/servo/pull/33496	fetch: add an accept encoding header when the range header exists (#33496)
>>> 2024-09-21T05:58:08Z
+   24ad2a05268ebc21b5ad127dac28d1e6f880512c	https://github.com/servo/servo/pull/33506	chore: Update wgpu (#33506)
    28d28d0a0a9c9ee2acf45593b9e6c0288857f0a9	https://github.com/servo/servo/pull/33507	build(deps): bump unicode-script from 0.5.6 to 0.5.7 (#33507)
    d98f9787a909e0343d74136a042c81043d7097b8	https://github.com/servo/servo/pull/33505	build(deps): bump unicode-width from 0.1.13 to 0.1.14 (#33505)
+   9597390d2bc6f68492cc9fae6287d0a456cdb3c1	https://github.com/servo/servo/pull/33492	Enable min-content, max-content, fit-content and stretch (#33492)
+   4bde9af5159b18eba1b65256de0d2dda328a1eb2	https://github.com/servo/servo/pull/33504	webgpu: Support more `TextureFormat`s in `GPUCanvasContext.configure()` (#33504)
+   157e28c59b34ec8c7334161fda658cbbb1e66a25	https://github.com/servo/servo/pull/33295	openharmony: add servoshell for ohos (#33295)
>>> 2024-09-22T06:00:44Z
    8276673bae999c3e74d71c81ca84842ed1365c89	https://github.com/servo/servo/pull/33515	Update web-platform-tests to revision b'8e164c249d2b93a4234a2710a5e2cc5a16fab499' (#33515)
    f986160ed405817160e89b178e8e3b372132e792	https://github.com/servo/servo/pull/33510	fix many clippy warnings (#33510)
    4e4b137eaa242fea4356e30b36f9ef3262781968	https://github.com/servo/servo/pull/33508	bindings: Allow Guard to take multiple conditions, check for SecureContext in ConstructorEnabled (#33508)
>>> 2024-09-23T05:56:50Z
+   d3d6a22d27df5095c3342249d0eea0bce153cbe1	https://github.com/servo/servo/pull/33511	ohos: Add back and fwd button to vendored app (#33511)
    188fa329eb3b163cc6028a9b34f9647a16539582	https://github.com/servo/servo/pull/33514	Stop sending EmbedderMsg::WebViewOpened from WindowProxy (#33514)
    3e29131d642b3273fe4f302f9a29602289ae8616	https://github.com/servo/servo/pull/33519	Add `HTMLCanvasDataSource::Empty` that represent transparent black instead of `HTMLCanvasDataSource::Image(None)` (#33519)
    bab769a7cff3309819fb0efb60b279b53e483165	https://github.com/servo/servo/pull/33517	reuse ImageKey for gpucanvascontext (#33517)
    3a0d27b2312c6396e85178615290ac2ec3592ce1	https://github.com/servo/servo/pull/33509	webgl: Update IDL exposed members (#33509)
>>> 2024-09-25T06:08:25Z
    2c6d9a190f947ca6fe58a06d2549c4924e678d3a	https://github.com/servo/servo/pull/33535	build(deps): bump libc from 0.2.158 to 0.2.159 (#33535)
+   e73416b54ed0042473b475fb6cc7aa6cb17c48b5	https://github.com/servo/servo/pull/33536	Bump mozjs to 128.0-10 (#33536)
+   ba67a0a4fbd512cb14f4bda80b2c64dc27433cdd	https://github.com/servo/servo/pull/33529	servoshell: fix issues related to HiDPI (#33529)
+   dbd1666b17b22130bcce75e6255f376e6fbe256c	https://github.com/servo/servo/pull/33312	Layout: Implement innerText/outerText (#33312)
    88ffe9f7a56ef0981805a7b8264f870947cebcf5	https://github.com/servo/servo/pull/33513	ohos: Bundle resource files in hap (#33513)
    ff86771b481bb241d85a913ca923b5d31ed8352c	https://github.com/servo/servo/pull/33524	build(deps): bump quick-xml from 0.36.1 to 0.36.2 (#33524)
    5d9b316dd70cb31789d59fb316d588cb896a5c86	https://github.com/servo/servo/pull/33525	build(deps): bump pkg-config from 0.3.30 to 0.3.31 (#33525)
    a1d4edb3809b8e773d8e018f5c8f3edec040b5d3	https://github.com/servo/servo/pull/33523	build(deps): bump thiserror from 1.0.63 to 1.0.64 (#33523)
    a165982622de1064c38480e5489e5dfd2bb81bec	https://github.com/servo/servo/pull/33462	Properly track `rel` keywords for `<a>`/`<area>`/`<form>` elements (#33462)
>>> 2024-09-26T06:05:16Z
    a97afebdcc7a06201638c45a9c7e4b7aab25203a	https://github.com/servo/servo/pull/33548	Avoid unnecessary recomputation of `inline-size` being `auto` (#33548)
    01ed5064dee128abe4818f13e95124b528c04f19	https://github.com/servo/servo/pull/33547	fonts: Fix a couple warnings introduced by recent changes (#33547)
    6725f716e73132798d0501675d8a7c42174ddb8b	https://github.com/servo/servo/pull/33544	layout: Switch `.len()` comparison to `is_empty()` in `components/layout_2020/query.rs`. (#33544)
    ac567645a75630830a99d90946e0e96d0a759ead	https://github.com/servo/servo/pull/33541	fonts: Simplify `FontContext` in two ways that affect the unit test (#33541)
    1daa0b4fc7a45f0020e6677c4e67fd78dd4f3eec	https://github.com/servo/servo/pull/33546	build(deps): bump tar from 0.4.41 to 0.4.42 (#33546)
    531fb3bc135bb4934a3317643875af2ac484199d	https://github.com/servo/servo/pull/33537	Bump mozjs to 128.0-12 (#33537)
    64f32f7ab36846d2536a74b6184ba1adfbdb3495	https://github.com/servo/servo/pull/33540	fonts: Make fast shaping determination platform-independent (#33540)
+   6f797709cfcd7ff4e824d95e8373b81ad2c88473	https://github.com/servo/servo/pull/33534	webgpu: destroy GPUTexture without erroring (#33534)
    43d92ecbcbb297906f2d7d5735eaffbefdd6cfeb	https://github.com/servo/servo/pull/33527	Use `ContentSizes::shrink_to_fit` when possible (#33527)
+   ade902207fc1f941fc77fa47bff1db0375ed7220	https://github.com/servo/servo/pull/33530	fonts: Use `IpcSharedMemory` to send font data (#33530)
>>> 2024-09-27T06:07:33Z
    fa0521481beb3f8e8b2516ce5855363b7b674d1f	https://github.com/servo/servo/pull/33557	Update ipc-channel and de-dupe windows (#33557)
    a212464a8427db95844ab22eb5ef6f6b3a0fc800	https://github.com/servo/servo/pull/33555	build(deps): bump serde_spanned from 0.6.7 to 0.6.8 (#33555)
    0cefee48e125c3f392e44bd1ae161d41d7246808	https://github.com/servo/servo/pull/33550	Fix table track constrainedness (#33550)
    1346643727336485b8ee19b3db6d4a28366e89f1	https://github.com/servo/servo/pull/33549	Assert that we don't get malformed ContentSizes in tables (#33549)
    7fdaccde5501283708503e9a64efa578ac9ae7f7	https://github.com/servo/servo/pull/33512	ohos: Support product flavors (#33512)
-->

## Donations

Thanks again for your generous support!
We are now receiving **4147 USD/month** (+34.7% over July) in recurring donations.
This includes donations from **12 people** on LFX, but we will stop accepting donations there soon — **please move your recurring donations to [GitHub](https://github.com/sponsors/servo) or [Open Collective](https://opencollective.com/servo)**.

Servo is also on [thanks.dev](https://thanks.dev), and already **eleven GitHub users** that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 4147 / 10000); padding-left: 0.5em;"><strong>4147</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 4147 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="4147" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

<!-- TODO: self-hosted runners and outreachy -->

As always, use of these funds will be decided transparently in the Technical Steering Committee.
For more details, head to our [Sponsorship page]({{ '/sponsorship/' | url }}).

<style>
    /* guaranteed minimum width for first paragraph after a float */
    ._floatmin {
        display: block;
        width: 13em;
        overflow: hidden;
    }
    ._none {
        display: none;
    }
    ._fig:not(#specificity) {
        width: 33em;
        max-width: 100%;
        margin: 1em auto;
    }
    ._fig > ._flex {
        display: flex;
    }
    ._fig table {
        text-align: initial;
    }
    ._fig figcaption._notes {
        text-align: left;
        width: max-content;
        max-width: 100%;
    }
    ._figl:not(#specificity),
    ._figr:not(#specificity) {
        margin: 0 1em 1em;
    }
    ._figl {
        float: left;
        max-width: 100%;
    }
    ._figr {
        float: right;
        max-width: 100%;
    }
    ._figl > figcaption,
    ._figr > figcaption,
    ._figl > iframe,
    ._figr > iframe,
    ._figl > video,
    ._figr > video,
    ._figl > a > img,
    ._figr > a > img {
        width: 21em;
        max-width: 100%;
    }
    ._runin {
        margin-bottom: 1em;
    }
    ._runin > p,
    ._runin > h2 {
        display: inline;
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