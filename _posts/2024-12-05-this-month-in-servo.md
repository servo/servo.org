---
layout:     post
tags:       blog
title:      "This month in Servo: grid layout, parallel flexbox, smaller binaries, and more!"
date:       2024-12-05
summary:    ao!! wrrrrao!!
categories:
---

Servo now supports **CSS grid layout** (@nicoburns, @taniishkaa, #32619, #34352, #34421), **:is() and :where() selectors** (@mrobinson, #34066), and the **getClientRects()** method on Element (@chickenleaf, #34025)!
We’ve also added support for two key Shadow DOM interfaces, the **shadowRoot property** on Element (@simonwuelker, #34306) and the **innerHTML property on ShadowRoot** (@simonwuelker, #34335).

Last month we also landed support for **‘justify-self’** on positioned elements (@chickenleaf, #34235), form submission with **&lt;input type=image>** (@shanehandley, #34203), **DataTransfer** (@Gae24, #34205), the **close()** method on ImageBitmap (@simonwuelker, #34124), plus several new **[SubtleCrypto](https://developer.mozilla.org/en-US/docs/Web/API/SubtleCrypto) API** features:

- crypto.subtle.**deriveKey()** (@simonwuelker, #34185)
- **wrapKey()** and **unwrapKey()** (@simonwuelker, #34262)
- **“HMAC”** algorithm in **generateKey()** (#34278), **sign()**, **verify()** (#34223), and **deriveKey(`"get key length"`)** (#34230)
- **“AES-GCM”** algorithm in **encrypt()**, **decrypt()**, **generateKey()**, and **importKey()** (#34269)
- **“AES-KW”** algorithm in **generateKey()**, **importKey()**, **wrapKey()**, and **unwrapKey()** (#34262)
- **“PBKDF2”** (#34164) and **“HKDF”** (#34200) algorithms in **deriveBits()**

<!--
- 4291.50/month donations
    - 2131.50/month opencollective
    - 2160.00/month github
    - ?.??/month thanks.dev (15 donors)
- CODEOWNERS 34316 34308 34304 34334 34351
- new features
    - DONE shadowRoot property on Element 34306
    - DONE innerHTML property on ShadowRoot 34335
    - DONE getClientRects() method on Element 34025
    - DONE crypto.subtle.deriveKey() 34185
    - DONE crypto.subtle.{wrapKey,unwrapKey} 34262
    - DONE crypto.subtle.{encrypt,decrypt,generateKey,importKey} for AES-GCM 34269
    - DONE crypto.subtle.generateKey() for HMAC 34278
    - DONE crypto.subtle.deriveKey("get key length") for HMAC 34230
    - DONE crypto.subtle.{sign,verify} for HMAC 34223
    - DONE crypto.subtle.{generateKey,importKey,wrapKey,unwrapKey} for AES-KW 34262
    - DONE crypto.subtle.deriveBits() for PBKDF2 34164
    - DONE crypto.subtle.deriveBits() for HKDF 34200
    - DONE :is() and :where() 34066
    - DONE form submission with <input type=image> 34203
    - js.disable_jit pref 34231
    - DONE ?DataTransfer api 34205
    - DONE ?close() method on ImageBitmap 34124
- layout
    - DONE css grid 32619 34352 34421
    - parallel flexbox 34132
    - DONE ‘justify-self’ on abspos elements 34235
    - faster column flex 34346 34372
    - faster intrinsic size caching 34384
    - fixed clientWidth etc for floats and replaced inlines 34083
    - fixed ‘object-fit’ when ‘aspect-ratio’ is set 34413
    - fixed sizing of non-replaced abspos elements with ‘place-self’ 34264
    - fixed min/max-content block sizes of replaced elements 34284
    - fixed offsetLeft and offsetTop relative to <body> with ‘position:static’ 32761 nicoburns Loirooriol
    - fixed bugs in flexbox stretch and free space 34162 34150
- stylo
    - upgrade to 2024-11-01 34322
    - prepare for crates.io releases 34332 34353
- script
    - more work on split 34357 34356 34163
    - `--unminify-js` now supports module scripts 34206
- usability
    - scroll anywhere, not just over content 34347 mrobinson mukilan
- ohos
    - keyboard and ime support 34188
    - touch fling 33219 jschwe mrobinson
    - cjk fallback fonts 34410
    - better build errors 34267
    - fixed build on windows hosts 34113
- perf and binary size
    - fixed font template caching 34325
    - pending paint metrics 34305
    - layout 2013 compiled out by default 34290
    - webxr feature flag 34241 34348 wusyong augustkline jdm sagudev
    - webxr optional on ohos/android 34242
    - working on webgpu feature flag 34415
    - more unification of gl bindings 33918 34292
- crashes
    - fixed crash when launching ohos app 34237
    - fixed crash when accessing style of non-shadow descendants of shadow hosts 34298
    - fixed crash in crypto.subtle handling of Algorithm 34239
    - fixed more crashes due to gc borrow hazards 34122 34087 34182
    - fixed crash in width/height properties on OffscreenCanvas 34165
- tracing
    - filtering with SERVO_TRACING 34236
    - interval profiler migration 34238 34337
    - trace level and `servo_profiling` 34256 34209
    - fixed ScriptParseHTML and ScriptParseXML overcounting script/style/layout 34273
    - fixed ScriptEvaluate undercounting events and timers 34286
    - tracing for flex + inline + fonts 34392
    - tracing for display lists 34128
- hacking
    - `medium` cargo profile 34035

>>> 2024-11-01T06:07:41Z
    0d7fa7544779842aa19bac88f380168e85668956	https://github.com/servo/servo/pull/34084	Use default object size as fallback for intrinsic size of replaced element (#34084)	
    f5fd560ef8cc1ae9c67641808956cefbacfa3169	https://github.com/servo/servo/pull/34081	net: Ensure that origin serialization is consistent (#34081)	
    851b125d4b42ff9663e1f9bed423aedf0657fa13	https://github.com/servo/servo/pull/34082	Properly handle fallback aspect ratio for videos (#34082)	
+   31566aef02af25625ec2f28d3b108f8e0234b974	https://github.com/servo/servo/pull/34083	Fix geometry queries for floats and replaced inlines (#34083)	
>>> 2024-11-02T06:06:55Z
    a3fda3893f1c48ba857e1fa9da0102632db66119	https://github.com/servo/servo/pull/34104	build(deps): bump syn from 2.0.85 to 2.0.86 (#34104)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    3420b27d101608641dd7abf7079b12ddde3c7dda	https://github.com/servo/servo/pull/34103	build(deps): bump svg_fmt from 0.4.3 to 0.4.4 (#34103)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    7d71f260a9e7d042ad78f7dc9d5e923dd90db669	https://github.com/servo/servo/pull/34102	build(deps): bump anstyle from 1.0.9 to 1.0.10 (#34102)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    5512ff3491b9f2b2e3c4d4c6c31fa066d6a73fe8	https://github.com/servo/servo/pull/34101	build(deps): bump anyhow from 1.0.91 to 1.0.92 (#34101)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
+   257f4b84dbf523dd9079079c894ea53107dc2834	https://github.com/servo/servo/pull/34025	DOMRectList interface implementation (#34025)	
    d2c4448ac88669488a48ec93085b6183972089ad	https://github.com/servo/servo/pull/34076	Unify sizing logic for replaced elements (#34076)	
    f95c4cfaba1a3ee6e35bd3deac0973895a555598	https://github.com/servo/servo/pull/34096	servoshell: fix logical screen size calculation (#34096)	
    cc6f7c5bc42c049302480d42a5ebd70f984a1e8e	https://github.com/servo/servo/pull/33772	Conversion to Gradle KTS (#33772)	Mukilan Thiyagarajan <mukilan@igalia.com>
>>> 2024-11-03T06:05:52Z
    b22c0771be89e1962a2e39a43988278229fc0496	https://github.com/servo/servo/pull/34115	Update web-platform-tests to revision b'd2f2efe271ae2fa661c52ed2fe8564e21ad4036f' (#34115)	
+   0759dde11b8cbf8f06dee35314c60c845bd4062d	https://github.com/servo/servo/pull/34113	ohos: Fix mach build on windows hosts (#34113)	
    900d13fc2f785fa48346e6cfe2b1ab91790e4f5f	https://github.com/servo/servo/pull/34100	frozen array in XRInputSourcesChangeEvent, update `to_frozen_array` doc (#34100)	
    f47cc927a0934097fd97b0ad7595c43e22c5ca40	https://github.com/servo/servo/pull/34099	build(deps): bump thiserror from 1.0.65 to 1.0.66 (#34099)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
>>> 2024-11-04T06:09:07Z
    5d1d3d6b5a88fb94daae1acd8aa3bdaf21c9cd31	https://github.com/servo/servo/pull/33121	Update webgl conformance tests (#33121)	
    e64831d68a806bfa5dfd1bd05f489aaa42cf7b67	https://github.com/servo/servo/pull/34086	build(deps): bump exr from 1.72.0 to 1.73.0 (#34086)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>	Mukilan Thiyagarajan <mukilan@igalia.com>
+   e5cc7ad235bf9782b0831350d85f87bcf80c4354	https://github.com/servo/servo/pull/34124	Implement `ImageBitmap.close` (#34124)	
    e93544c0039b196a2514207731ec9280e22a8564	https://github.com/servo/servo/pull/34118	Cleanup malloc_size_of for NodeIterator and HTMLCollection (#34118)	
    a2af619009a6adf2c845411c3dfc365b00457535	https://github.com/servo/servo/pull/34116	Enable more DOM preferences for unofficial WPT test runs (#34116)	
    2a6d480cd8ce4dccaa74420fd6a436d39c328bf7	https://github.com/servo/servo/pull/34114	Remove unnecessary clamping in used_size_as_if_inline_element() (#34114)	
>>> 2024-11-05T06:10:31Z
    537958a3ccb57502c558e4da0963307fd7481a14	https://github.com/servo/servo/pull/34137	build(deps): bump cc from 1.1.31 to 1.1.34 (#34137)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    8dab5f4b80833902eb21ab5f694d190c1caa2fbb	https://github.com/servo/servo/pull/34136	build(deps): bump url from 2.5.1 to 2.5.3 (#34136)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>	Oriol Brufau <obrufau@igalia.com>
+   cc6163dcddcc6918f11bb4b7f134929bd50023bd	https://github.com/servo/servo/pull/34122	Fix GC borrow hazards triggered by LoadBlocker::terminate (#34122)	
    072ff302d2142fa684b2d5e7024522384e1daf58	https://github.com/servo/servo/pull/34090	Replace ComputedValues with WritingMode on IndefiniteContainingBlock (#34090)	
    73d2f3c453d23099845fe215987853e227e84f67	https://github.com/servo/servo/pull/34092	Return cached object from `CryptoKey.algorithm` getter (#34092)	
    f6aaf82b9b3b6756afde8b059b29e911b2de8bf3	https://github.com/servo/servo/pull/34141	build(deps): bump thiserror from 1.0.66 to 1.0.68 (#34141)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    735618e9ad0dc1735a40512fa455855fb03b05fd	https://github.com/servo/servo/pull/34139	build(deps): bump tracing-perfetto from 0.1.1 to 0.1.2 (#34139)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    89f75a90553da7e9139646315ba288128d509697	https://github.com/servo/servo/pull/34138	build(deps): bump idna from 1.0.2 to 1.0.3 (#34138)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    93f6396e6b8a16a1599bd7bad4e630e08a130e06	https://github.com/servo/servo/pull/34135	build(deps): bump tar from 0.4.42 to 0.4.43 (#34135)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    cbfcd68bcc5b5f411400b603b76cb31b884b21ea	https://github.com/servo/servo/pull/34068	CI: use new intermittent-tracker deployment (#34068)	
    e355cc02637421d19a980d5af0ff2295da979472	https://github.com/servo/servo/pull/34130	Bigger timeout for mac unit tests (#34130)	
>>> 2024-11-06T06:06:32Z
    756c2491452e493289c5ac17f9101d3c44965946	https://github.com/servo/servo/pull/34157	build(deps): bump cc from 1.1.34 to 1.1.35 (#34157)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    bff58cb44e72d67a3201ebb2bac8dd242dcc921c	https://github.com/servo/servo/pull/34156	build(deps): bump rustix from 0.38.38 to 0.38.39 (#34156)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    0231571ecf0a0e65c19c1b8d68116cb4dc42b74f	https://github.com/servo/servo/pull/34155	ohos: Bump ohos-vsync and ohos-sys (#34155)	
    included in last month	ee7b207f967135c95733439ed9f34c8001cf3122	https://github.com/servo/servo/pull/34091	Implement keyword sizes for replaced elements (#34091)	
+   3289e7d84dd6d905099d99751781a66da55fe04e	https://github.com/servo/servo/pull/34150	layout: Properly calculate free space in flexbox flexible length resolution (#34150)	
+   fe0701e226c5f3f34380cdff3e3cfef76aca9893	https://github.com/servo/servo/pull/34132	layout: Add parallel layout to flexbox (#34132)	
    80cc4500a370f457bbe27aef17646b83acd44f56	https://github.com/servo/servo/pull/34149	Rename ImageOrientation default to "from-image" (#34149)	
    f151cdf6eede508eb0b4fc972413e0a4b442f5b5	https://github.com/servo/servo/pull/34148	layout: Remove an obselete comment from flexbox (#34148)	
+   25a0764a37a585d032ca352923b24995f8cbf1a0	https://github.com/servo/servo/pull/34087	Use out parameter for generated methods returning JSVal (#34087)	
>>> 2024-11-07T06:08:59Z
    48d193cb835422dcdd3aeb39bd2bf27313eadf07	https://github.com/servo/servo/pull/34145	implement CachedFrozenArray (#34145)	
+   6c2b840e37825ecf47140ece52f882df4bc5cc03	https://github.com/servo/servo/pull/34163	Support associated types in must_root lint (#34163)	
    2d3b46670fed62d39e5876feb092443e61889e48	https://github.com/servo/servo/pull/34170	build(deps): bump xml-rs from 0.8.22 to 0.8.23 (#34170)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    63348e707acf4f788095910b91b2a9126e2d0069	https://github.com/servo/servo/pull/34169	build(deps): bump anyhow from 1.0.92 to 1.0.93 (#34169)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    47997b117740401cb37a122aff5f5546c0792c09	https://github.com/servo/servo/pull/34168	build(deps): bump cc from 1.1.35 to 1.1.36 (#34168)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    07aa561295895cca5ea2afcb5db9775f3bbd4c77	https://github.com/servo/servo/pull/34166	ohos: Remove unneeded dirs dependency in servo_config (#34166)	
+   2f6ca9407bf28245b74304ee981080ecf12265cb	https://github.com/servo/servo/pull/34164	Implement `SubtleCrypto.deriveBits` with PBDKF2 (#34164)	
+   c0a4eee1feace81a77c54d982943bb3e11172e47	https://github.com/servo/servo/pull/34165	Add [EnforceRange] on OffscreenCanvas width/height idl attribute (#34165)	
    a61522a1e8b9f0254786ea6a304489c8ba138a9a	https://github.com/servo/servo/pull/34153	layout: Clean up the flexible length resolution algorithm (#34153)	
>>> 2024-11-08T06:08:02Z
    4f6283d7fead1b2489456651185e3a8bbbc725e8	https://github.com/servo/servo/pull/34178	ohos/android: Fix some compiler warnings (#34178)	
    219d3c9cd57f4743821fd7fc2446a3be196e51bc	https://github.com/servo/servo/pull/34181	build(deps): bump polling from 3.7.3 to 3.7.4 (#34181)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    3af928eb7b3a49801964a4831f7339e316bab06d	https://github.com/servo/servo/pull/34179	build(deps): bump tokio from 1.41.0 to 1.41.1 (#34179)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    ac7419cf57d13c73fc35fe156e6f38d378814868	https://github.com/servo/servo/pull/34167	Consistently use `Dom` in native promise handlers (#34167)	
    05ee551af8b6ccbd18aaf27b04237ee4751bd2cb	https://github.com/servo/servo/pull/34175	sort Bindings.conf (#34175)	
>>> 2024-11-09T06:04:46Z
    da462d0fcda24f11ad2c67f5db7a2db0ea0f95e2	https://github.com/servo/servo/pull/34192	Implement referrer policy for dom worker construction (#34192)	
    6c1cd56e529c392b323033618c9bed4760a6aef7	https://github.com/servo/servo/pull/34189	build(deps): bump fastrand from 2.1.1 to 2.2.0 (#34189)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    2e844d6b3a3d7612abb3435779f1e83273c68ee5	https://github.com/servo/servo/pull/34190	build(deps): bump tempfile from 3.13.0 to 3.14.0 (#34190)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
+   f4cc20f7ef1e8b59fe6e088c43982a9cc9d1d935	https://github.com/servo/servo/pull/34162	layout: Fix caching of streching flex items in row flex (#34162)	Oriol Brufau <obrufau@igalia.com>
    e366d253dc4306bec2da246bca04dd7435b355ea	https://github.com/servo/servo/pull/34187	build(deps): bump cc from 1.1.36 to 1.1.37 (#34187)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
+   6b94b2c6846b52a94aaee184c1e0d276b8f85887	https://github.com/servo/servo/pull/34185	Implement `subtlecrypto.deriveKey` (#34185)	
    fe58556c0bf37f9f13685c367341d598fcb52d33	https://github.com/servo/servo/pull/34177	Disable resources_for_tests in production (#34177)	
    39ef61c324da49308bc4e796d6f5ac1257dd9c9b	https://github.com/servo/servo/pull/34173	Exclude `crown` from the root Cargo workspace (#34173)	Delan Azabani <dazabani@igalia.com>
    ac5c67849e97c82abf1bc9fdbb30b8d85713fbcc	https://github.com/servo/servo/pull/34180	build(deps): bump libc from 0.2.161 to 0.2.162 (#34180)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
+   85a9ca7cb6b850f24c06a4bee71a9f61100f1d0c	https://github.com/servo/servo/pull/34128	layout: Add instrumentation for `display_list` (#34128)	
    645176742813c423c3c5016eaba69a546b286339	https://github.com/servo/servo/pull/33977	Implement PolicyContainer and update the default ReferrerPolicy (#33977)	
>>> 2024-11-10T06:06:06Z
    dcb9058fe367390c3043d2d261f53eff485a52d2	https://github.com/servo/servo/pull/34160	ohos: Bump napi-ohos (#34160)	
    5e2c7908d0206e6a7a2e57cea72a3ca432a1afbb	https://github.com/servo/servo/pull/34201	Use the correct fallback referrer policy for the empty string case (#34201)	
    4da378a987fe4b47aad4e993d2e079010e495823	https://github.com/servo/servo/pull/34202	Update web-platform-tests to revision b'8686b7a6d288d3b2c22b5ddb5a21773619b22b85' (#34202)	
+   cdd0006e3d5ac4a8bc7731c2747a0d1a47f28078	https://github.com/servo/servo/pull/34200	Implement HKDF support for `subtlecrypto.deriveBits` (#34200)	
    67ac59b80994bb2b5ad11e54315165efcbabcaba	https://github.com/servo/servo/pull/34193	subtlecrypto: Replace `NormalizedAlgorithm` with specialized variants (#34193)	
>>> 2024-11-11T06:10:55Z
+   72971bd2716a7e574a4c6c3395c7a710652427b4	https://github.com/servo/servo/pull/33219	Add simple fling implementation (#33219)	Martin Robinson <mrobinson@igalia.com>
>>> 2024-11-12T06:11:06Z
    8801698ecaf05fbd7ff9ac77bf15b12d75afc56e	https://github.com/servo/servo/pull/34219	build(deps): bump allocator-api2 from 0.2.18 to 0.2.20 (#34219)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
+   8d3d7b74035a0cb501d9b3192a79636ede8bfce2	https://github.com/servo/servo/pull/34223	Implement `crypto.subtle.sign/verify` with HMAC (#34223)	
    deddcf2c7a7ad182720aed3da50d028c1e5ecb7d	https://github.com/servo/servo/pull/34224	Fix writing of apis.html (#34224)	
    4f4b7b1abf8919ff045da0295a45111a890a75e5	https://github.com/servo/servo/pull/34214	build(deps): bump thiserror from 1.0.68 to 1.0.69 (#34214)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    6a62d52cbb0385276de617c956a0e1d880469bc9	https://github.com/servo/servo/pull/34211	Use LazyCells instead of callbacks when resolving size keywords (#34211)	
    5423e622ed283dfdde832c18479a3d6b95c8cf69	https://github.com/servo/servo/pull/34212	Allow tidy to pass without support/crown/target (#34212)	
+   f83e0a8b678075fd6063e2f93b4ed727dc3f66fc	https://github.com/servo/servo/pull/34209	Filter Perfetto traces to `servo_profiling` spans and events only (#34209)	
    b28260aa130ce36230bb01686495845b5523ebc1	https://github.com/servo/servo/pull/34152	Fix inline content sizes of intrinsic element with indefinite block size (#34152)	
>>> 2024-11-13T06:04:55Z
+   5e7664b72e4f1940f4719dddbedc6d1656c8c47e	https://github.com/servo/servo/pull/34230	Implement `"get key length"` operation for HMAC algorithm (#34230)	
    81c1f961e910fc4ac761d96ca70abf9fdeb40031	https://github.com/servo/servo/pull/34234	build(deps): bump cc from 1.1.37 to 1.2.0 (#34234)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    bf75f17348d4174127973d19c72e405dbc5efaa3	https://github.com/servo/servo/pull/34233	Add `BoxFragment::is_inline_box()` (#34233)	
+   ae029242f82459233a683c7623121dde6cae3f5b	https://github.com/servo/servo/pull/34206	Unminify module scripts. (#34206)	
    672b37dd9c4b27fb9892ce7148d163444bf10de0	https://github.com/servo/servo/pull/34229	build(deps): bump cpufeatures from 0.2.14 to 0.2.15 (#34229)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    2f53e24131f18f6c56f10583102ed7e2a3964537	https://github.com/servo/servo/pull/34228	build(deps): bump serde from 1.0.214 to 1.0.215 (#34228)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    5970132595e5fc7b3c251aa96c37fdc62bfca47f	https://github.com/servo/servo/pull/34227	build(deps): bump napi-ohos related crates (#34227)	
    128b017f1e1e86e4342140e13e13c5cffbccdac7	https://github.com/servo/servo/pull/34217	build(deps): bump rustix from 0.38.39 to 0.38.40 (#34217)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
>>> 2024-11-14T06:06:28Z
+   3fd1a229df65406699c5795cf504948cdb314320	https://github.com/servo/servo/pull/34182	Add some more CanGc arguments for compiling module scripts. (#34182)	
+   6b6697e97bd3f88c3e5da4d632afb611be1a403e	https://github.com/servo/servo/pull/34242	servoshell: Fix --no-default-features and make webxr optional on ohos/android (#34242)	
+   47a243614f920cb9cf4c058ee9d0584377a2a11e	https://github.com/servo/servo/pull/34241	feat: `webxr` feature flag (#34241)	august kline <me@augustkline.com>
+   91f96cc9dd028939715a2854b11bbdade6050a5e	https://github.com/servo/servo/pull/34235	Support justify-self on absolutely positioned elements (#34235)	
+   114cf9a1cc75ea97ce461079519d161981af1a34	https://github.com/servo/servo/pull/34237	ohos: avoid passing some cli arguments to servo (#34237)	
    91026444701cfd68658beb21fbf446f6ed8723e6	https://github.com/servo/servo/pull/34232	Use a RwLock to cache inline_content_sizes() (#34232)	
+   c00804190cdc256183ade8f050d5f0408b550303	https://github.com/servo/servo/pull/34236	Allow filtering of tracing events via SERVO_TRACING (#34236)	
+   873e82a5329dffeeef9c91d0e47cf34c41c53b03	https://github.com/servo/servo/pull/34231	Add `js.disable_jit` pref (#34231)	
>>> 2024-11-15T06:23:51Z
    495cceb7de813f6f1936d77821e8cf04ca2857cd	https://github.com/servo/servo/pull/34251	build(deps): bump cc from 1.2.0 to 1.2.1 (#34251)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    69cbdd24911d2fa01511343c9aeb85d5c3a9222b	https://github.com/servo/servo/pull/34250	build(deps): bump flate2 from 1.0.34 to 1.0.35 (#34250)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    30423bb6ac6bc00435ad32512f9b9ab461c29e40	https://github.com/servo/servo/pull/34249	build(deps): bump clap_lex from 0.7.2 to 0.7.3 (#34249)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    557a0ceb89c91983df83b984ac47f60ac8e1a97b	https://github.com/servo/servo/pull/34247	Protect against arithmetic underflow in TableBuilder::current_y() (#34247)	
+   313597f325a48243300c73bf786d1c2421825ca4	https://github.com/servo/servo/pull/34203	fix: allow form submission for input [type=image] (#34203)	
>>> 2024-11-16T06:05:15Z
+   ee63174d6ff0b3b7d9b255fc47c72a82ae63bc09	https://github.com/servo/servo/pull/34239	subtlecrypto: Don't throw exceptions twice when converting to Algorithm object (#34239)	
    7ae0459360dad977d24fe81fbb322c92308f6c88	https://github.com/servo/servo/pull/34261	build(deps): bump clap from 4.5.20 to 4.5.21 (#34261)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
+   538ac61a82ebd4f6bd02062c23c654cf83fb18ec	https://github.com/servo/servo/pull/34188	ohos: Add basic IME and keyboard support (#34188)	Josh Matthews <josh@joshmatthews.net>	Mukilan Thiyagarajan <mukilanthiagarajan@gmail.com>
    c64d5e9d30c48f59e61439947c63a2b97a45512f	https://github.com/servo/servo/pull/34258	mach bootstrap: Lock cargo-deny to 0.16.1 (#34258)	
    56fed22a5bc3ef000ec6393c9369015d4d68ba5e	https://github.com/servo/servo/pull/34257	CI: Fix lint job (#34257)	
+   aa7116c75d2f13f554ce4db162344aaea59e60b0	https://github.com/servo/servo/pull/34238	Plumb time profiler output into tracing (#34238)	
>>> 2024-11-17T06:05:54Z
    dca33f681ab6b33e2680d053add83e30e01665bd	https://github.com/servo/servo/pull/34265	Update web-platform-tests to revision b'6cf69a4f431581e9438681abc776029308ee8a8c' (#34265)	
+   695595094838f1081b426906264ff438c323acba	https://github.com/servo/servo/pull/32761	Fix offsetLeft/offsetTop to match major browsers (#32761)	Oriol Brufau <obrufau@igalia.com>
>>> 2024-11-18T06:19:52Z
    f71f38bd3de00180b2dc632ef3cce90c558cfa06	https://github.com/servo/servo/pull/34266	mach: Fix notifications on windows 11 (#34266)	
+   0d2ce68d5006214a5aa4c5b7e98c9073f135db7c	https://github.com/servo/servo/pull/34267	mach: ohos: Print error message when hvigor fails (#34267)	
>>> 2024-11-19T06:08:33Z
+   caf2467649336abefe1deb71c669fa6f13fc8086	https://github.com/servo/servo/pull/34256	Set all tracing spans to trace level for now (#34256)	
+   9a98852806272779be0b9562c7f90a57e4f7b80d	https://github.com/servo/servo/pull/34273	Make ScriptParseHTML and ScriptParseXML only count actual parsing time (#34273)	
+   124c5bbbf3b2bbcaecedfa275ad22005806940c2	https://github.com/servo/servo/pull/34262	crypto: Support key wrap operations + AES-KW (#34262)	
+   8c689aac677064fa50a4cb061be7b582cb9c9db0	https://github.com/servo/servo/pull/34284	Fix min/max-content block size of replaced element (#34284)	
    696c591d81a0429365f41806e05e827cbb9f507c	https://github.com/servo/servo/pull/34279	build(deps): bump libc from 0.2.162 to 0.2.164 (#34279)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    9f71ca09bd9320124dd1a1e5a0806e1acaf126a7	https://github.com/servo/servo/pull/34280	build(deps): bump serde_json from 1.0.132 to 1.0.133 (#34280)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
+   2485bd9a63addf6f1523f591801e26716e80b627	https://github.com/servo/servo/pull/34278	Implement HMAC key generation (#34278)	
+   11dfbd6f90bc7bc8b8d7485695548b5ad685d0e1	https://github.com/servo/servo/pull/34264	layout: Use `Size::FitContent` when the alignment isn't `normal` or `stretch` for absolutely positioned elements (#34264)	
    997b6411c034a3d8ea3d285e24cca982d4b4f3e8	https://github.com/servo/servo/pull/34272	mach: run linux unit tests for 'full' try jobs (#34272)	sagudev <16504129+sagudev@users.noreply.github.com>
>>> 2024-11-20T06:07:43Z
    this and 34295 cancel each other out	c73e4baca206c172802be145c1fb8d110c1be863	https://github.com/servo/servo/pull/34295	Preference-gate `crypto.subtle` (#34295)	
    this and 34295 cancel each other out	79a2f070ed17a227e0dd3a499252716a6adf1361	https://github.com/servo/servo/pull/34294	Enable SubtleCrypto by default (#34294)	
+   65c84d230bcac6545cde7c06fe7fe22b1fb2f8cb	https://github.com/servo/servo/pull/34292	Replace sparkle with glow in shared/canvas (#34292)	
    4d28d6f96e05e6aa3b05097407acf7f20f4870e2	https://github.com/servo/servo/pull/34291	build(deps): bump rustix from 0.38.40 to 0.38.41 (#34291)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    b4643c1f11d1929c715f38cdf1bdd32559bc9fdf	https://github.com/servo/servo/pull/34288	script: Remove a warning about a common situation involving OOP iframes (#34288)	Mukilan Thiyagarajan <mukilan@igalia.com>
+   0eda2de19fd69619bf9a8ac47da34b764c3d06f8	https://github.com/servo/servo/pull/34066	style: Add support for `is()` and `where()` selectors (#34066)	
    975e2ae85925d5660d09415de33ea77537bcf0d4	https://github.com/servo/servo/pull/34263	Remove referrer policy from document (#34263)	
+   83f8e888189cc265e73d6a3849f7b8c71c080181	https://github.com/servo/servo/pull/34269	Implement AES-GCM support for subtlecrypto (#34269)	
    5113147f801bc6ef1f1da7d181599f13b76c0a0d	https://github.com/servo/servo/pull/34287	mach: Remove `mach rustup` (#34287)	
+   26748621cda6301038647b3b3f06ed9c681c5d11	https://github.com/servo/servo/pull/34286	Make ScriptEvaluate count script execution in DOM events and timers (#34286)	
    4a06dc53f66a1d9a7b2f8619bfe13c6ccacb28c4	https://github.com/servo/servo/pull/34285	[NFC] Remove unused interval profiler events (#34285)	
    0a849adfa118ff8e76518cc390edd3d1551469d0	https://github.com/servo/servo/pull/34283	Update vergen to v9 (#34283)	
    09684a350121db480959959832162b7cd03fbab8	https://github.com/servo/servo/pull/34281	Fix various clippy warnings on OpenHarmony (#34281)	
>>> 2024-11-21T06:05:05Z
+   527e2d426d1101b281e5b30b870859d44425465a	https://github.com/servo/servo/pull/34306	Implement `element.shadowRoot` attribute (#34306)	
+   c5cf2621b672ff481ad1494dc280f578e146c4e0	https://github.com/servo/servo/pull/34316	Add @Loirooriol to the `CODEOWNERS` file (#34316)	
+   f3ad078358c6e6eefd6326283b7e9fc0a2e2f406	https://github.com/servo/servo/pull/34298	Include non-shadowdom children of shadow hosts in style calculation (#34298)	
    2889e934f5bdb2096a0b01da05f58047d393b66b	https://github.com/servo/servo/pull/34314	build(deps): bump ctor from 0.2.8 to 0.2.9 (#34314)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    716a183f742ce3035169fb262327f99df07a1286	https://github.com/servo/servo/pull/34313	build(deps): bump bytemuck from 1.19.0 to 1.20.0 (#34313)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    e13b4bda27ade84f3433e8be84d5c5c5d9f9d5bb	https://github.com/servo/servo/pull/34312	build(deps): bump unicode-ident from 1.0.13 to 1.0.14 (#34312)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    2ae411b2b108114350afe9eb476fffbf7c601950	https://github.com/servo/servo/pull/34310	build(deps): bump itoa from 1.0.11 to 1.0.12 (#34310)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    2bc5469efe786f262b1b245f28f295f9a2fc23d7	https://github.com/servo/servo/pull/34309	build(deps): bump the napi-ohos-related group with 4 updates (#34309)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
+   b3eb5bb02ca7a2b0735aa34ccbfae9814e037320	https://github.com/servo/servo/pull/34308	Add @mrobinson to the `CODEOWNERS` file (#34308)	
    138ec6d0ec5575009aa7d0c3aae3c80ceea476b7	https://github.com/servo/servo/pull/34297	Remove the containing_block parameter from TableLayout::layout_caption (#34297)	
+   4451a59f883c22f38aa66c2b3e656b10362b49f9	https://github.com/servo/servo/pull/34305	compositing: Properly clean up pending paint metrics (#34305)	Mukilan Thiyagarajan <mukilan@igalia.com>
    06dce314f80a886bb10fec889d1b6e5c6ac070b7	https://github.com/servo/servo/pull/34307	crown: fix build for rust 1.82 on musl (#34307)	
    c8626985ca3aeafb186ecdf1ab6e5d75f793470d	https://github.com/servo/servo/pull/34146	Use try-parser in main workflow (#34146)	
+   a58d6d1fa107cb208c11d47a234e082837b05a42	https://github.com/servo/servo/pull/34304	Update CODEOWNERS (#34304)	
+   063071ba72c8cfc98bc3b5914a2114c335531d7a	https://github.com/servo/servo/pull/33918	Replace `sparkle` with `glow` in `components/canvas` (#33918)	
    910e8dc89f675cf6877b44b3b743033e07e3fff4	https://github.com/servo/servo/pull/34299	Enable Shadow DOM for tests (#34299)	
>>> 2024-11-22T06:02:02Z
    67012a5091dc1d1dde5e3a46f926851e57b35226	https://github.com/servo/servo/pull/34336	Remove etc/shell.nix in favour of shell.nix (#34336)	
    1f0b88934b628b49ad12db599ec36fc552bd49fd	https://github.com/servo/servo/pull/34276	script: Throw a `TypeError` when trying to create an `OffscreenCanvas` with an unknown context type (#34276)	
    bd9843405a04c062df982ef9fa917bbb756149a9	https://github.com/servo/servo/pull/34333	crypto: Fix 192-bit checks for AES-GCM encrypt/decrypt (#34333)	
    108e316aa602a502b98c4f8a8460599b66aa81bd	https://github.com/servo/servo/pull/34329	build(deps): bump syn from 2.0.87 to 2.0.89 (#34329)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
+   6cbd89dbb0452f30477671ff72ff6c03b3fac097	https://github.com/servo/servo/pull/32619	Layout: Implement CSS Grid using `taffy` (#32619)	
    339062c890361017d91ec84121c833ce5ee43c84	https://github.com/servo/servo/pull/34331	build(deps): bump proc-macro2 from 1.0.89 to 1.0.91 (#34331)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    ce0cda07192557e79b737d438d86ee4b2cbe0322	https://github.com/servo/servo/pull/34330	build(deps): bump itoa from 1.0.12 to 1.0.13 (#34330)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
+   97f53021b1b93890d51e16786423c28536705d6d	https://github.com/servo/servo/pull/34322	Upgrade Stylo to 2024-11-01 (#34322)	
+   a6db3cb7029bb6915f6ffed430e0b1a49f88585f	https://github.com/servo/servo/pull/34290	Disable layout-2013 feature by default (#34290)	
+   a731b25f0cc245bf949e86aa134ee0163cc76c54	https://github.com/servo/servo/pull/34325	fonts: fix broken caching of font template matches (#34325)	Martin Robinson <mrobinson@igalia.com>
    c05612fc9ad1dc1f6852ea0ee61dcc5a0edc3f42	https://github.com/servo/servo/pull/34327	Fix nix-shell without an explicit path (#34327)	
    3d8f99c4e65b64e7231a1b5789e397c750e04569	https://github.com/servo/servo/pull/34317	crypto: Include `key_ops` in exported JWKs, support JWK for HMAC import (#34317)	
+   80529ef3588a0e7cf32e9783d5cd671118627ec7	https://github.com/servo/servo/pull/34035	Add `medium` profile for daily work scenario (#34035)	
>>> 2024-11-23T06:04:32Z
    9542466b31c46f6866383c023c889e0e7713097a	https://github.com/servo/servo/pull/34350	Remove unnecessary clone in layout (#34350)	
+   f943ba023a3547543bace0c104c7bb8c51f44cd8	https://github.com/servo/servo/pull/34346	Improve performance of column flexboxes (#34346)	Martin Robinson <mrobinson@igalia.com>
    524c54640dc2e9ac743e1dc2895fb51a3f9d9783	https://github.com/servo/servo/pull/34345	build(deps): bump cpufeatures from 0.2.15 to 0.2.16 (#34345)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
+   1198b26ec99af88210090fb958233181f83a0ba0	https://github.com/servo/servo/pull/34335	Implement `ShadowRoot.innerHtml` attribute (#34335)	
    44ed111c0adec7e4ebaadde2baaf44185ccc72ef	https://github.com/servo/servo/pull/34344	build(deps): bump proc-macro2 from 1.0.91 to 1.0.92 (#34344)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    f040c5db78b53113d77def6f2815f9f248d3fb1d	https://github.com/servo/servo/pull/34343	Update mozjs_sys to 128.3-5 (#34343)	
+   a3c24713443767992ecf6763a4999721781ddcaa	https://github.com/servo/servo/pull/34332	Fork Stylo's `malloc_size_of` into Servo (#34332)	
+   3a32af0c852fc14571a59b0ef2d3820317fed4ab	https://github.com/servo/servo/pull/34337	Plumb URL into interval profiler tracing events (#34337)	
+   fd3af6ad04d9e1e1acf6c36da9327ff79fcde8d4	https://github.com/servo/servo/pull/34334	Add @atbrakhi to the CODEOWNERS file (#34334)	
>>> 2024-11-24T06:11:40Z
    468f9cf014c9dc41e43974ab17fb790e42d7e6ee	https://github.com/servo/servo/pull/34360	Update web-platform-tests to revision b'6d461cc41e1a9951e1991a94f651e389b0ca24ba' (#34360)	
+   5bd28f2abda5f4ca87dac852d2bec82f5fce0539	https://github.com/servo/servo/pull/34351	Add nicoburns to CODEOWNERS (#34351)	
>>> 2024-11-25T06:01:56Z
+   c11e0e8e706f565c4cd0e80ddfbf210d7660fbb6	https://github.com/servo/servo/pull/34347	layout: Add a hit test item that covers all scroll frame contents (#34347)	Mukilan Thiyagarajan <mukilan@igalia.com>
+   c60e4afbee1bc70bb9fe36ad138c6aa5bb98414d	https://github.com/servo/servo/pull/34356	Support custom derives for generated types (#34356)	
+   3faed9b9212fee1f0ff9be5f7cfb5e24c5b84b91	https://github.com/servo/servo/pull/34348	Filter out webidl files based on special comments, and feature-gate webxr interfaces. (#34348)	Samson <16504129+sagudev@users.noreply.github.com>
+   e956f3124c230549c6ef4a63e2c27e56d0965453	https://github.com/servo/servo/pull/34357	Generate a trait abstracting over all known DOM interfaces (#34357)	
>>> 2024-11-26T06:04:09Z
+   63793ccbb7c0768af3f31c274df70625abacb508	https://github.com/servo/servo/pull/34353	Use `webrender_api::units::DevicePixel` rather than `style_traits::DevicePixel`  unless interfacing with Stylo (#34353)	
+   97154d9cf8a42564742eab9d0a8974766edd210f	https://github.com/servo/servo/pull/34352	Avoid laying out grid items and generating fragments if only inline size is requested (#34352)	
    fdaf44bbc0e12703490ff4f621ca983b14859418	https://github.com/servo/servo/pull/34383	build(deps): bump wgpu-core from 23.0.0 to 23.0.1 (#34383)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    5c59bc193e97097a65ecafef0188a734cc9dcc3a	https://github.com/servo/servo/pull/34382	build(deps): bump zerofrom from 0.1.4 to 0.1.5 (#34382)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    2316ee4df77ef1be72c09286519ddf08a5606cf6	https://github.com/servo/servo/pull/34380	build(deps): bump zerofrom-derive from 0.1.4 to 0.1.5 (#34380)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    5a59eac088dafac2455ce856a2bd7d99c0160f9b	https://github.com/servo/servo/pull/34379	build(deps): bump yoke-derive from 0.7.4 to 0.7.5 (#34379)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    0edd037f4c41d9ccd3b6a629021d3ae3eaf8617a	https://github.com/servo/servo/pull/34378	build(deps): bump yoke from 0.7.4 to 0.7.5 (#34378)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    a8bf9d52b3709205600c569058fc4adb4a1b073f	https://github.com/servo/servo/pull/34377	build(deps): bump async-compression from 0.4.17 to 0.4.18 (#34377)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
+   ba061ec2b0ef7124a5e64ec11a406cbc45cac02f	https://github.com/servo/servo/pull/34372	Refine logic for laying out flex item in column layout after #34346 (#34372)	
+   c9e3d3e25e37068cff5164d83dfa906a7d74f528	https://github.com/servo/servo/pull/34205	Implement `DataTransfer` and related interfaces (#34205)	
    810a91ecac71f656ca6573045ff51e7fee35ca53	https://github.com/servo/servo/pull/34355	Remove some unused dependencies (#34355)	
    0d91da610a73b7abeb76f2d1d49a23c9ca3e704d	https://github.com/servo/servo/pull/34370	[NFC] Remove unused metrics code (#34370)	
    cb212633b63e238e400ec5110475693478924eb3	https://github.com/servo/servo/pull/34369	Bump tracing-perfetto to 0.1.3 (#34369)	
>>> 2024-11-27T06:07:26Z
+   d65a2e97970cbc3900c7f62e1c51776710623887	https://github.com/servo/servo/pull/34392	Additional tracing for flex layout, inline layout, and fonts (#34392)	
    a4caa0efcb22084bef36c2a9a151831a62548198	https://github.com/servo/servo/pull/34403	Implement MallocSizeOf for markup5ever rather than xml5ever. (#34403)	
    ffca6abb3a66ac5774e9291622f70e10391823ee	https://github.com/servo/servo/pull/34398	build(deps): bump litemap from 0.7.3 to 0.7.4 (#34398)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    1af3d46ea4328d34189f1721d1a183e3946a5840	https://github.com/servo/servo/pull/34401	build(deps): bump itoa from 1.0.13 to 1.0.14 (#34401)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    74d4e89ad5e0003200bf0827652c0c35dd297545	https://github.com/servo/servo/pull/34397	build(deps): bump libc from 0.2.164 to 0.2.165 (#34397)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    3a736c4a4e40d74889d3382ba2ecca8af5e4b8f0	https://github.com/servo/servo/pull/34399	build(deps): bump tracing-core from 0.1.32 to 0.1.33 (#34399)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    100bbe2eee767f6635e9f7e85cb9326c93129137	https://github.com/servo/servo/pull/34396	build(deps): bump vergen from 9.0.1 to 9.0.2 (#34396)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    972bc76f9cfb3760e9f4fff89c936f1adb4a3042	https://github.com/servo/servo/pull/34395	build(deps): bump wgpu-hal from 23.0.0 to 23.0.1 (#34395)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    6228bac13ddd2beed651f841a54855d221f174b3	https://github.com/servo/servo/pull/34394	build(deps): bump calendrical_calculations from 0.1.1 to 0.1.2 (#34394)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
+   d034385f7643433b6bc738d32f84d45b70948534	https://github.com/servo/servo/pull/34384	Use an AtomicRefCell instead of a RwLock for caching intrinsic sizes (#34384)	
>>> 2024-11-28T06:12:12Z
    9168375b337511e0b1f3e22cd55a790d7ec89956	https://github.com/servo/servo/pull/34412	Differentiate between missing/invalid value in `make_enumerated_getter!` (#34412)	
    612492b372c550533e1f3a51fe9e16eb44e73b2b	https://github.com/servo/servo/pull/34409	build(deps): bump tracing from 0.1.40 to 0.1.41 (#34409)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
>>> 2024-11-29T06:05:02Z
+   16da1c2721d471277c3981795d8d6000e8876cea	https://github.com/servo/servo/pull/34421	Ensure taffy uses margin when calling used_size_as_if_inline_element_from_content_box_sizes() (#34421)	
    6daae7666e5ef0dbae0b8504f06c9b2f5be75745	https://github.com/servo/servo/pull/34420	build(deps): bump socket2 from 0.5.7 to 0.5.8 (#34420)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    13fa98e5fd4d6d7a9102acc25556b2ef08a9946f	https://github.com/servo/servo/pull/34418	build(deps): bump bytes from 1.8.0 to 1.9.0 (#34418)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    c8adcdcbc6d828723098ae2a8c40ad10fb1ff9c3	https://github.com/servo/servo/pull/34419	build(deps): bump errno from 0.3.9 to 0.3.10 (#34419)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
+   d2d3407501b83d03db522b5dde5e159073fd9e4b	https://github.com/servo/servo/pull/34415	Move script gpu files into webgpu folder (#34415)	
+   a37ccc3e64c92e8ba10a3cdc48ebd7f031bb7298	https://github.com/servo/servo/pull/34413	Use natural ratio for `object-fit` (#34413)	
+   895b8d30eac41afbdbd20efd65c5a6e58ae3f43d	https://github.com/servo/servo/pull/34410	ohos: fonts: Fix HalfwidthandFullwidthForms font fallback (#34410)	
    f9eb32a51518a77e9a37a24299a7b1933ae0c537	https://github.com/servo/servo/pull/34400	build(deps): bump vergen-git2 from 1.0.1 to 1.0.2 (#34400)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    fe98e2b5491ead9f44fd6656ce42508168cda30e	https://github.com/servo/servo/pull/34407	build(deps): bump libc from 0.2.165 to 0.2.166 (#34407)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
>>> 2024-11-30T06:01:53Z
    096439b35ec07003e2d360a0448db54daec712d8	https://github.com/servo/servo/pull/34431	ohos: Specify SDK version more accurately. (#34431)	
    8daede2f453b47b89049029f57a1c67c39727243	https://github.com/servo/servo/pull/34429	build(deps): bump libc from 0.2.166 to 0.2.167 (#34429)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    e1e9d0adbb3463687b9c2877bd785d16f4c96982	https://github.com/servo/servo/pull/34428	build(deps): bump cc from 1.2.1 to 1.2.2 (#34428)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    not web-facing yet	2dbda695349b910e009135d897a81bedba75b9bd	https://github.com/servo/servo/pull/34423	Make Servo compatible with Stylo with `prefers-color-scheme` support (#34423)	
    19a7e95a6a4cc4e6aa187f2fe2302c4707401e34	https://github.com/servo/servo/pull/34416	Refactor computation of preferred aspect ratios (#34416)	
-->

## Donations

Thanks again for your generous support!
We are now receiving **4291 USD/month** (+2.1% over October) in recurring donations.
**We are no longer accepting donations on LFX** — if you were donating there, please move your recurring donations to [GitHub](https://github.com/sponsors/servo) or [Open Collective](https://opencollective.com/servo).

Servo is also on [thanks.dev](https://thanks.dev), and already **fifteen GitHub users** that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 4291 / 10000); padding-left: 0.5em;"><strong>4291</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 4291 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="4291" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

With this money, we’ve been able to cover our web hosting and self-hosted CI runners for Windows and Linux builds.
When the time comes, we’ll also be able to afford macOS runners and perf bots, as well as additional Outreachy interns next year!
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