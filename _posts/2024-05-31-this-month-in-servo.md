---
layout:     post
tags:       blog
title:      "This month in Servo: and more!"
date:       2024-05-31
summary:    your text here
categories:
---

Servo now supports several CSS features in its nightly builds:

- as of 2024-04-29, **‘start’**, **‘end’**, and **‘space-evenly’** values in **‘align-content’** and **‘justify-content’** (@nicoburns, #31724)
- as of 2024-04-30, **‘white-space-collapse’**, **‘text-wrap-mode’**, and the new **‘white-space’** shorthand (@Loirooriol, #32146)
- as of 2024-05-03, **‘ch’** and **‘ic’ font-relative units** (@andreubotella, #32171)
- as of 2024-05-19, basic support for **‘border-collapse’** (@mrobinson, @Loirooriol, #32309)
- as of 2024-05-22, **‘empty-cells’** (@Loirooriol, #32331)
- as of 2024-05-22, **‘visibility: collapse’** on table parts (@Loirooriol, @mrobinson, #32333)

We now support **aborting fetch()** with AbortController and AbortSignal (@syvb, #31361), and several DOM properties:

- `value`, `min`, `max`, `low`, `high`, and `optimum` on HTMLMeterElement (@shanehandley, #32230)
- `autofocus` on HTMLElement and SVGElement, via HTMLOrSVGElement (@nolanlawson, #32170)
- `role` and 43 other ARIA string properties on Element (@nolanlawson, #32080)

We’ve also landed the first patch towards making Servo’s **event loop comply with the HTML spec** (@gterzian, #31505).
This will hopefully address some complex timing issues between the renderer and other kinds of tasks like requestAnimationFrame and ResizeObserver callbacks.

Together with correct sizing for **floating tables** (@Loirooriol, #32150) and **empty list items** (@mrobinson, @Loirooriol, #32152), as well as correct **‘line-height’ based on the first font** (@mrobinson, #32165), Servo has made some big strides in the Web Platform Tests this month:

- 90.8% (+1.6pp) in the **CSS2 floats** tests
- 68.7% (+5.7pp) in the **CSS2 and CSS tables** tests
- 53.3% (+4.0pp) in the **CSS text** tests
- 48.8% (+3.3pp) in the **CSS position** tests

## Font system

Servo now supports the **‘font-weight’**, **‘font-style’**, **‘font-stretch’**, and **‘unicode-range’ descriptors** in @font-face, correctly matching fonts split by ‘unicode-range’ (@mrobinson, @mukilan, #32164) and correctly selecting the nearest weights and styles (@mrobinson, @mukilan, #32366).

We also now support **font fallback on OpenHarmony** (@jschwe, #32141), and **bitmap color emoji** on Linux and macOS (@mrobinson, #32203, #32278).
Note that the layered `COLR` format is not yet supported, and that on macOS, we currently only support `sbix` (like in Apple Color Emoji), not `CBDT` (like in Noto Color Emoji).

Our [font system rework](https://github.com/servo/servo/issues/32033) continues, **saving up to 40 MB of memory** when loading servo.org by sharing font data and metadata across threads (@mrobinson, @mukilan, #32205).
We’ve fixed a bug where web fonts in one document can **clobber fonts with the same name** in other documents (@mrobinson, @mukilan, #32303), and a bug where the **font cache leaks unused web fonts** (@mrobinson, @mukilan, #32346).

## servoshell

servoshell now **handles all known keycodes**, passing them to Servo where appropriate (@Nopey, #32228), goes back and forward when **pressing the mouse side buttons** (@Nopey, #32283), and shows the link URL in a **status tooltip when hovering over links** (@iterminatorheart, @atbrakhi, #32011).

## Other changes

Servo for Android **now builds on aarch64** (@mukilan, #32137), **no longer crashes on startup** (@mukilan, #32273), and now supports the **SpiderMonkey JIT on 64-bit builds** (@mukilan, #31134).

Servo should no longer cause intermittent errors and **panics when exiting** (@mrobinson, #32207), and **ShowWebView** no longer fails if sent too quickly after a webview is created (@wusyong, #32163).

We’ve also landed several dev changes:

- You can now pass `--skip-platform` to `mach bootstrap` to **install taplo and crown only** (@mrobinson, #32176)
- `mach build` **no longer fails on Windows** due to `STATUS_DLL_NOT_FOUND` in crown (@sagudev, #32301)
- `mach build` **no longer fails on Windows Server 2019** due to `UnsupportedPlatform` in notifypy (@delan, #32352)

## Donations

Thanks again for your generous support!
We are now receiving **1630 USD/month** (+20.9% over April) in recurring donations.
We are still receiving donations from **15 people** on LFX, and we’re working on transferring the balance to our new fund, but we will stop accepting donations there soon — **please move your recurring donations to [GitHub](https://github.com/sponsors/servo) or [Open Collective](https://opencollective.com/servo)**.

As always, use of these funds will be decided transparently in the Technical Steering Committee.
[Our first proposal](https://github.com/servo/project/issues/88#issuecomment-2134485100) hopes to spend some of these funds on a **dedicated CI server**, which should make tryjobs and merge builds much faster!

We’ve also updated our [Sponsorship page]({{ '/sponsorship/' | url }}) with advice about how to make your donations most effective.
In short, donating via GitHub Sponsors is the best option, with 96% of the amount going to Servo in almost all cases.
Donations on Open Collective give Servo around 80% to 90%, depending on the amount and payment method.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 1630 / 10000); padding-left: 0.5em;"><strong>1630</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 1630 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="1630" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

<!--
- donations 1630/month
  - open collective 10+5+10+5+5+5+1000+5+5+10+5+5+3+5+5+25+1+20+5+5+10+5+10+25+5+5 = 1199/month
  - github page 3 5+5+5+50+100+5+1+15+1+5+5+5+5+1+5+5+1+1+5+5+5+5+1+5+5+5+5+5+5+10+3 = 284/month
  - lfx (15) 10+5+10+10+5+10+10+10+25+5+12+5+10+10+10 = 147/month

fromDate = "2024-04-23";
toDate = "2024-05-26";
>>> top deltas (servo, pp):
csstable (5.7pp to 68.7%)
csstext (4.0pp to 53.3%)
csspos (3.3pp to 48.8%)
floats (1.6pp to 90.8%)
css (1.0pp to 65.7%)
cssflex (0.8pp to 54.6%)
all (0.6pp to 57.3%)
css2 (0.4pp to 79.0%)
linebox (0.2pp to 93.8%)
margin-padding-clear (0.1pp to 96.7%)
abspos (0.0pp to 91.0%)
box-display (0.0pp to 84.4%)
floats-clear (0.0pp to 91.4%)
normal-flow (0.0pp to 94.0%)
positioning (0.0pp to 90.1%)
cssom (0.0pp to 65.4%)

- ai policy
- DONE donations
  - DONE lfx
  - DONE runners proposal?
- DONE wpt
- api support
  - SKIP (legacy only) CSSOM shorthands 32149
  - DONE aria string reflection on element 32080
  - DONE idl reflection for autofocus 32170
  - DONE ‘ch’ and ‘ic’ units 32171
  - DONE AbortController/AbortSignal 31361
- dom
  - DONE the start of a large effort to bring Servo's event loop closer to the HTML event loop specification 31505
  - improve parsing of floating point numbers in some DOM APIs 32272
  - DONE `<meter>` elements now support more DOM APIs 32230
- DONE layout
  - DONE correct sizing for floating tables 32150
  - DONE ‘start’, ‘end’, ‘space-evenly’ 31724
  - DONE correct sizing for empty list items 32152
  - DONE ‘white-space’ shorthand 32146
  - DONE naive border collapse implementation for tables 32309
  - DONE implement `visibility: collapse` on table parts 32333
  - DONE implement `empty-cells` for tables parts 32331
- webgpu
  - a thread is now used to poll devices 32266
  - webgpu: Use safe callbacks & try_recv_timeout 32008
  - webgpu: Move errorscopes to WGPU thread 32304
- upgrades
  - SKIP (already in last month’s update) stylo 32128
  - SKIP (not really a stylo upgrade) stylo html5ever xml5ever 32145
  - wgpu 31995, wgpu 0.20 32173
  - servoshell - egui, etc 31278
- DONE fonts
  - DONE ‘weight’, ‘style’, ‘stretch’, ‘unicode-range’, plus composite fonts 32164
  - DONE sbix color emoji (apple bitmap) 32203
  - DONE Support bitmap fonts support (color emojis) for FreeType platforms 32278
  - DONE add support for the full CSS font matching algorithm 32366
  - DONE font fallback on openharmony 32141
  - DONE improve line-height correctness when font fallback happens 32165
  - DONE font data
    - DONE fonts are no longer duplicated per layout thread (cross-thread FontContext) 32303
    - DONE removing stylesheets now deactivates the web fonts they included 32346
    - DONE shared fontcontext saving 40 megs of memory 32205
  - SKIP windows font loading 32115
- DONE embedding
  - DONE sync constellation and compositor 32163
- DONE reliability
  - DONE compositor shutdown 32207
- SKIP au
  - SKIP Au is used in HoistedSharedFragment 32288
- DONE dev changes
  - DONE android aarch64 32137
  - DONE android uses jemalloc again 32273
  - DONE android aarch64 JIT reenabled 32284
  - DONE mach bootstrap --skip-platform 32176
  - DONE windows build issue 32301
  - SKIP sccache re-enabled for CI builds 32330
  - SKIP fixed a bug in `./mach bootstrap --skip-platform` 32341
  - DONE fixed an issue that made the Servo build crash on Windows Server 2019 32352
- DONE servoshell
  - DONE cursor: None is now supported and winit key support expanded in servoshell 32228
  - DONE The back and forward mouse buttons now work properly 32283
  - DONE status tooltips added 32011
- conferences
  - rakhi talk (x2?)
    - RustNL 7-9 may
  - gregory gosim https://www.youtube.com/watch?v=EA_1jxzR85M

>>> 2024-04-24T06:11:08Z
    22729446270c4a748f3020ccf09570a1412e2df9	https://github.com/servo/servo/pull/32139	build(deps): bump freetype from 0.7.1 to 0.7.2 (#32139)
    2781728e90ef6301974874b49ba066ca97c05fec	https://github.com/servo/servo/pull/32140	build(deps): bump rustix from 0.38.33 to 0.38.34 (#32140)
    925d9420364c62c5781dd77bef35546bba536abe	https://github.com/servo/servo/pull/32138	build(deps): bump winapi-util from 0.1.6 to 0.1.7 (#32138)
+   3b1bbc1aaf194c6344de24949bf09108de997e06	https://github.com/servo/servo/pull/32137	android: add CI build for aarch64 (#32137)
+   de47dfe5c106984efb996fe0989d59180187624f	https://github.com/servo/servo/pull/32115	fonts: Merge multiple methods into `PlatformFont::descriptor()` (#32115)
>>> 2024-04-25T06:11:34Z
    1440406e91684771bb810ead6ac5ae710f55f3ea	https://github.com/servo/servo/pull/32129	script: Prevent "scroll to fragment" from scrolling offscreen (#32129)
    bef6c295aadc7e9ea80ad9268642686fb37c26ee	https://github.com/servo/servo/pull/32142	Stop publishing the Rust book in mach doc and doc.servo.org (#32142)
>>> 2024-04-26T06:09:50Z
    81c4f2ae7a0b605befae652c0feeea03caba6292	https://github.com/servo/servo/pull/32144	build(deps): bump winapi-util from 0.1.7 to 0.1.8 (#32144)
+   401e49010f4851e5a8b14a72741b287945824e3e	https://github.com/servo/servo/pull/32128	Upgrade Stylo to 2024-04-16 (#32128)
>>> 2024-04-27T06:09:56Z
    66563ed0273c05ab9d687c883649521d14d610e8	https://github.com/servo/servo/pull/32159	build(deps): bump parking_lot from 0.12.1 to 0.12.2 (#32159)
    f8ffa2e8d1cc1149726d90a264334f0992fb6f78	https://github.com/servo/servo/pull/32158	build(deps): bump flate2 from 1.0.28 to 1.0.29 (#32158)
    a8d0bdb3231178f844f713b03d25cf1b91426478	https://github.com/servo/servo/pull/32157	build(deps): bump parking_lot_core from 0.9.9 to 0.9.10 (#32157)
    e6cb2242b666237b2fe6ae1749eca63c8b701ac2	https://github.com/servo/servo/pull/32155	build(deps): bump rustls from 0.21.11 to 0.21.12 (#32155)
    8647b9fb0b85f7b8f86507c74d3af0254b999025	https://github.com/servo/servo/pull/32156	build(deps): bump lock_api from 0.4.11 to 0.4.12 (#32156)
+  fdb6fb7920f6122a0830f248ba46baf7fccaac4e	https://github.com/servo/servo/pull/32149	Let legacy layout serialize shorthands in getComputedStyle (#32149)
  1a0565bbecd956456380b738965c20eb34677697	https://github.com/servo/servo/pull/32151	Cleanup obsolete expectations for /css/css-values/round-function.html (#32151)
+ a14ee03de39ecd963ec88d81b0cba99d72eabff1	https://github.com/servo/servo/pull/32150	Implement special table sizing for floats (#32150)
+  18a4c7503a388519e7f9bc229337f433ff6b7a53	https://github.com/servo/servo/pull/32145	Bump Stylo to servo/stylo#34 and upgrade html5ever and xml5ever (#32145)
+  4af413cd04a962eb46e60005a1958622629e4a4f	https://github.com/servo/servo/pull/31995	webgpu: Update wgpu to 0.19 (#31995)
>>> 2024-04-28T06:05:40Z
+  02b3dd0b6127e213dbbc866c97336e23f4c999c5	https://github.com/servo/servo/pull/32080	feat: implement ARIA string reflection on Element (#32080)
>>> 2024-04-29T06:09:38Z
+  1d6be62454cee22e40516c040663246bbf39d063	https://github.com/servo/servo/pull/31724	layout2020 (flexbox): Implement `start`, `end`, and `space-evenly` content alignment (#31724)
>>> 2024-04-30T06:11:45Z
    4715f64f6bc764e912c092f6b5a0c4a040239742	https://github.com/servo/servo/pull/32182	build(deps): bump glib from 0.19.4 to 0.19.5 (#32182)
+  4732da347795c7a9e009a5125c20c1f5c3215209	https://github.com/servo/servo/pull/32164	fonts: Add support for more @font-face features (#32164)
    628e33bfa95b286e1b8b974e426ffdad7850097e	https://github.com/servo/servo/pull/32183	build(deps): bump gobject-sys from 0.19.0 to 0.19.5 (#32183)
    047609fcae5fdac44d9a9d6fc1308452a2ac4d7e	https://github.com/servo/servo/pull/32180	build(deps): bump gilrs from 0.10.6 to 0.10.7 (#32180)
    039c4b8c5c7143286e8a7124e9b4a1cc91e1e641	https://github.com/servo/servo/pull/32181	build(deps): bump unicode-width from 0.1.11 to 0.1.12 (#32181)
    8a321c7f36e8666d1059dd52d020984d04ae8073	https://github.com/servo/servo/pull/32179	build(deps): bump flate2 from 1.0.29 to 1.0.30 (#32179)
+  f68a2e7743bffef524f1fb6cade9a43f25fc7789	https://github.com/servo/servo/pull/32152	layout: Ensure empty list items are at least as tall as outside markers (#32152)
  adcaf2e881fc22bde15bbf37fd970ad1ab57c28c	https://github.com/servo/servo/pull/32177	url: Only truncate data URLs for `Debug` (#32177)
+  4a12c0630927be1ffdedd8f1329081a09337aa1e	https://github.com/servo/servo/pull/32176	bootstrap: Add a `--skip-platform` option (#32176)
+  3014e201ab9d7f189a496a4c3c97467e85779f83	https://github.com/servo/servo/pull/32170	script: implement autofocus IDL reflection (#32170)
+  6ca3bb440ea23480a3825cefa7a85a429d793a94	https://github.com/servo/servo/pull/31840	Run platform_bootstrap first (#31840)
  fe6e1cfb296ac4d850163ee1f68a5c600eb0b6ab	https://github.com/servo/servo/pull/32160	Android: load url from Intent, plus fixed some warnings (#32160)
  5a4c81f841136ecb74d521c14925ee0354f10543	https://github.com/servo/servo/pull/32131	Fixe some clippy warnings (#32131)
+  d490fdf83c84871ecf92f6ba9ca4216e41e0a977	https://github.com/servo/servo/pull/32146	Turn white-space into a shorthand (#32146)
  a1f8c19355f7e0e673511c24feeae60d47f19c1c	https://github.com/servo/servo/pull/32174	Fix flip_rect calculation (#32174)
+  74897c38512793455f4c1622e2b454b274aa8cec	https://github.com/servo/servo/pull/32163	Update WebView variants of ConstellationMsg  (#32163)
>>> 2024-05-01T06:06:46Z
  bccbc87db7b986cae31c8f14f0a130336f8417b2	https://github.com/servo/servo/pull/32192	Remove unused import (#32192)
    b30fb90b8e4d9e424452a1d9980288a675bd0ff9	https://github.com/servo/servo/pull/32198	build(deps): bump cc from 1.0.95 to 1.0.96 (#32198)
    f6b1182f882efc4d9c875bdeefde9a948907134e	https://github.com/servo/servo/pull/32197	build(deps): bump glib-sys from 0.19.0 to 0.19.5 (#32197)
    8a8926225adb958be329e8c48f115e7abffb07d8	https://github.com/servo/servo/pull/32196	build(deps): bump libc from 0.2.153 to 0.2.154 (#32196)
    52d46431fc779da18b5d04a6c28b57aabc7bfaad	https://github.com/servo/servo/pull/32195	build(deps): bump serde from 1.0.198 to 1.0.199 (#32195)
    9d4a173b66e56d013786531d6b2bd85b4f55b9be	https://github.com/servo/servo/pull/32194	build(deps): bump glib-macros from 0.19.4 to 0.19.5 (#32194)
  f6dc09c1c680632907465c671916674d1d4a6844	https://github.com/servo/servo/pull/32188	Disable `/fetch/api/crashtests/huge-fetch.any.js` (#32188)
+  b6748db69d1eb94cf36d5eaa7271a6291a11f1c1	https://github.com/servo/servo/pull/32008	webgpu: Use safe callbacks & try_recv_timeout (#32008)
    1e186e92515afa694996f53d19f5a614642d2cec	https://github.com/servo/servo/pull/32187	build(deps): bump gio-sys from 0.19.0 to 0.19.5 (#32187)
    35a8e793f3f19b047ce8f904cdba6974b263c304	https://github.com/servo/servo/pull/32186	build(deps): bump socket2 from 0.5.6 to 0.5.7 (#32186)
    14221ed82298a99924685a57bd96cb5eb0920060	https://github.com/servo/servo/pull/32178	build(deps): bump data-encoding from 2.5.0 to 2.6.0 (#32178)
    7d39b9d933741f1db0b3e9acace8d0c299a9c314	https://github.com/servo/servo/pull/32185	build(deps): bump fastrand from 2.0.2 to 2.1.0 (#32185)
>>> 2024-05-02T06:09:16Z
+  0df79b939a642027325c2e050f07eefcf569d87d	https://github.com/servo/servo/pull/32207	compositor: Do not handle embedder events during or after shutdown (#32207)
    50c2e1834717a264a860dd870d0aeb5dedde5ff4	https://github.com/servo/servo/pull/32211	build(deps): bump x11rb from 0.13.0 to 0.13.1 (#32211)
    4cfbc515c70d8af3248310965978eb38f9b89f22	https://github.com/servo/servo/pull/32210	build(deps): bump serde from 1.0.199 to 1.0.200 (#32210)
    32c9f443774d39b528e1bb9e114439bc167c03ea	https://github.com/servo/servo/pull/32209	build(deps): bump x11rb-protocol from 0.13.0 to 0.13.1 (#32209)
  814bf5b6e8cd4600ce4bf8e9ee726da9aa89372e	https://github.com/servo/servo/pull/32208	mach: Upgrade boto3 and remove Python < 3.10 dependencies (#32208)
	eb7484de5ea71be0d9c24eeddad82f5744d7ce25	https://github.com/servo/servo/pull/32200	Update web-platform-tests to revision b'86de4ffa4e439098e05f05de7d8cae1c24ff84fb' (#32200)
  6065abcb6bfcc28ad1995349b6f16f6752d0f051	https://github.com/servo/servo/pull/32204	script: Include layout when collecting memory reports (#32204)
>>> 2024-05-03T06:07:21Z
	160c7c0b0f061afa1277fa56cdd1d898379a8223	https://github.com/servo/servo/pull/32215	Fix some clippy warnings in `components/gfx` and `components/script` (#32215)
+  ca064eaa518f407988751ce51834eff3d65b681c	https://github.com/servo/servo/pull/32141	Add font-fallback on OpenHarmony and fix several compilation issues (#32141)
+  9acf2182cd440d4080bb0eb2a2fbc7238d71e953	https://github.com/servo/servo/pull/31278	servoshell: Upgrade `egui` and many other dependencies (#31278)
+  556bfb7dff48f64e9e02872dba29fbdabc8c6ad0	https://github.com/servo/servo/pull/32205	fonts: Make `FontContext` thread-safe and share it per-Layout (#32205)
+  8ec5344f70dd1d556cacd72d778924048b0b1154	https://github.com/servo/servo/pull/32171	feat: Support font-relative `ch` and `ic` units (#32171)
+  928214518cc2ed44112295c7aae675fc29f5a50b	https://github.com/servo/servo/pull/32203	fonts: Use `FontInstanceFlags::EMBEDDED_BITMAPS` for color fonts on MacOS (#32203)
	60613e77c589d736e6ccabc425eab332c44410fb	https://github.com/servo/servo/pull/32214	Update web-platform-tests to revision b'9b5719f9756aba6e4aa3c855db9cc54648df815f' (#32214)
>>> 2024-05-04T06:05:36Z
  d297eb1f067b02d15479928b2f786663bc5b9ca6	https://github.com/servo/servo/pull/32224	Cargo.toml cleanup (#32224)
  1c9120c293cc16c11637feb6003117d4093642b5	https://github.com/servo/servo/pull/32206	fonts: Add `MallocSizeOf` implementation for `FontContext` (#32206)
>>> 2024-05-05T06:07:41Z
  ff3cd1494ea5c333d8f53450ccd50fe3a287e2a1	https://github.com/servo/servo/pull/32225	android: Remove outdated `#[allow(bare_trait_objects)]` (#32225)
+  7fce850cffb72a6fbcf763a40164a9b35b7fa833	https://github.com/servo/servo/pull/31361	script: implement AbortController (#31361)
383607d01e97076283752c880ca6ac7cc6dfa2db	https://github.com/servo/servo/pull/32220	Do not use crown when building docs (#32220)
>>> 2024-05-06T06:07:37Z
>>> 2024-05-07T06:09:38Z
	45f2433d7695231d509fc2b316c390d6d7e0e6f7	https://github.com/servo/servo/pull/32232	Update web-platform-tests to revision b'536297144c737f84096d1f448e790de0fb654956' (#32232)
>>> 2024-05-08T06:04:57Z
6a2e4a61f7272b02bcc93b05521e50b359357892	https://github.com/servo/servo/pull/32227	Devtools device description: improve how Servo is advertised in Firefox's about:debugging (fixes #27528) (#32227)
    ec3b3c006c6dbd870edfaa2ed48c393fecabfc3f	https://github.com/servo/servo/pull/32253	build(deps): bump anyhow from 1.0.82 to 1.0.83 (#32253)
    66dc62a08d1e196036fd3a3020230a590f6254a6	https://github.com/servo/servo/pull/32252	build(deps): bump thiserror from 1.0.59 to 1.0.60 (#32252)
    db82efa6201be2289bbdf3cd42b3c02bce1e9076	https://github.com/servo/servo/pull/32251	build(deps): bump syn from 2.0.60 to 2.0.61 (#32251)
    162f142fadf2363eaf705d7b8c28bae0d56089e8	https://github.com/servo/servo/pull/32250	build(deps): bump zerocopy from 0.7.33 to 0.7.34 (#32250)
    d2153f46d76d08ee59efb54dd89d9990e955845d	https://github.com/servo/servo/pull/32245	build(deps): bump rustversion from 1.0.15 to 1.0.16 (#32245)
    832d024a9400f4dfa7bdea50a26e454102e1751a	https://github.com/servo/servo/pull/32249	build(deps): bump ryu from 1.0.17 to 1.0.18 (#32249)
    c6597977ffa1520859fe5b8b9573e6908e8c0d5d	https://github.com/servo/servo/pull/32248	build(deps): bump proc-macro2 from 1.0.81 to 1.0.82 (#32248)
    0266094bf951e7dd3fbdb22652a7d16d3318d2ba	https://github.com/servo/servo/pull/32247	build(deps): bump semver from 1.0.22 to 1.0.23 (#32247)
    79b7f53340bb631f8b5c420a11fa18c6c23a2176	https://github.com/servo/servo/pull/32246	build(deps): bump paste from 1.0.14 to 1.0.15 (#32246)
    d5fb4dd0ce93ca04d0804012fcfe1b0b147e5b26	https://github.com/servo/servo/pull/32244	build(deps): bump rustc-demangle from 0.1.23 to 0.1.24 (#32244)
    b7b7799a90623d0bbd766e4d997dcbd5fc901161	https://github.com/servo/servo/pull/32237	build(deps): bump autocfg from 1.2.0 to 1.3.0 (#32237)
    8f30af4221e9bc02f054781023b07f4cc1cee2b8	https://github.com/servo/servo/pull/32234	build(deps): bump zerocopy from 0.7.32 to 0.7.33 (#32234)
    74b15bda84928808762af5519d0b60dc08883343	https://github.com/servo/servo/pull/32235	build(deps): bump getrandom from 0.2.14 to 0.2.15 (#32235)
    1324951e1e9d124d6c3ee6f837f024ccf15ba5db	https://github.com/servo/servo/pull/32236	build(deps): bump num-traits from 0.2.18 to 0.2.19 (#32236)
    46152401aacae6e231d1b4cbe220de4ce261891a	https://github.com/servo/servo/pull/32238	build(deps): bump cc from 1.0.96 to 1.0.97 (#32238)
    3921f32db8dab8bfcddcfcdaba8344443ec6678a	https://github.com/servo/servo/pull/32239	build(deps): bump tokio-util from 0.7.10 to 0.7.11 (#32239)
+   8bc49299c89b15b065d1aa7df00416e8e56b2c49	https://github.com/servo/servo/pull/32243	Revert "script: implement AbortController (#31361)" (#32243)
>>> 2024-05-09T06:08:11Z
    16803bc0f8c0566287f2810e016f337b23df4529	https://github.com/servo/servo/pull/32261	build(deps): bump serde from 1.0.200 to 1.0.201 (#32261)
    eec9c4af10dc3fa598fbb7904f3bc7dee63fef65	https://github.com/servo/servo/pull/32259	build(deps): bump prettyplease from 0.2.19 to 0.2.20 (#32259)
    6aaabe4143adf433f6c3dbdb4e3fcfdf561e4ce0	https://github.com/servo/servo/pull/32260	build(deps): bump num-rational from 0.4.1 to 0.4.2 (#32260)
    06f22fdd987aa261a6971ebe0f955d9b37f9dc56	https://github.com/servo/servo/pull/32258	build(deps): bump errno from 0.3.8 to 0.3.9 (#32258)
    8db471b9d7e84e9e03820977693065d7d7b57fad	https://github.com/servo/servo/pull/32257	build(deps): bump serde_json from 1.0.116 to 1.0.117 (#32257)
    168d43f24a18184afadc6aa8646537289c85860a	https://github.com/servo/servo/pull/32255	webgpu: Refactor webgpu crate (#32255)
+    c4f8599404e52da58e9e4e8f8aef3e7efa4996c9	https://github.com/servo/servo/pull/32173	webgpu: Update to wgpu 0.20 (#32173)
    5298ccb0eb9e05bc9d0ec71b7c1d5610b5164aca	https://github.com/servo/servo/pull/32242	Skip installing 'clang' if 'clang' binary already exists (#32242)
>>> 2024-05-10T06:09:54Z
    b5be89aebc636bfa4e670e3d6e78bc603f23ba8e	https://github.com/servo/servo/pull/32264	Update flake8 to work on python3.12 (#32264)
	aaf3d1bfd92970c33701d7200251a37074dcaed5	https://github.com/servo/servo/pull/32262	clippy: Fix vtable_address_comparisons error (#32262)
>>> 2024-05-11T06:05:05Z
    c2325cd7388a158543932451845b4e920dbc32ce	https://github.com/servo/servo/pull/32268	build(deps): bump ab_glyph from 0.2.25 to 0.2.26 (#32268)
    985aded8571abc282f688181f3d4fe34271bde9e	https://github.com/servo/servo/pull/32267	build(deps): bump glib from 0.19.5 to 0.19.6 (#32267)
>>> 2024-05-12T06:05:00Z
+   2904c32e05f90ee826968d04cfd837f614cd2541	https://github.com/servo/servo/pull/32230	Implement attributes for the `<meter>` element (#32230)
-------
>>> 2024-05-13T06:07:27Z
    3d4fd0e5507fc3b7b776fe4ad08d50335669b787	https://github.com/servo/servo/pull/32270	clippy: Fix last few warnings (#32270)
1f6d358cf9663b1254524d4cc929f0a778e8976c	https://github.com/servo/servo/pull/32271	Update web-platform-tests to revision b'8f48f40aab7f7f8a8118dc1a46972d070622be52' (#32271)
>>> 2024-05-14T06:10:16Z
    1cd30c4c7aceb2d39a140e5dadcb68593059ae97	https://github.com/servo/servo/pull/32281	build(deps): bump bytemuck from 1.15.0 to 1.16.0 (#32281)
    f2c9833244b5312204de9ec6b1ae65fc1dcc6f35	https://github.com/servo/servo/pull/32282	build(deps): bump ttf-parser from 0.21.0 to 0.21.1 (#32282)
    14be8b8534213821070e9acb90af61f7931eee02	https://github.com/servo/servo/pull/32279	build(deps): bump syn from 2.0.61 to 2.0.63 (#32279)
    f039226154f4a7416e2577b35e7516453e95a8af	https://github.com/servo/servo/pull/32280	build(deps): bump font-kit from 0.13.0 to 0.13.1 (#32280)
a483cb5144024cadda593bebcddad293dc927d97	https://github.com/servo/servo/pull/32276	Fix RefCell borrows (#32276)
+   c0494e2e832fed4aef447bb67403d37c3de6d003	https://github.com/servo/servo/pull/32228	servoshell: Support Cursor::None and all winit keys (#32228)
+   385f6f93bf3ff62af3a872aac2ab2fb43893975d	https://github.com/servo/servo/pull/32273	android: use `jemalloc` on Android (#32273)
+   1d66ea2b2795cb7afcac787be1014f28dc7ad029	https://github.com/servo/servo/pull/31505	script: Start rework to better match the specification HTML event loop (#31505)
+   77c50ad3565966861de35cb501100a1c25c505a4	https://github.com/servo/servo/pull/32165	layout: When line-height is not `Normal` use metrics of first font not fallback (#32165)
+   8eeb888010eadfe3def85b9e1006e88a7699deb9	https://github.com/servo/servo/pull/32272	fix: Implement additional logic in DOMString::set_best_representation_of_the_floating_point_number in order to correct some failing tests related to -0 values. (#32272)
>>> 2024-05-15T06:06:28Z
+   00f267e2893a6dbca2c54f9669e2c431b59ecd19	https://github.com/servo/servo/pull/32266	webgpu: Use WGPU poller thread for poll_all_devices (#32266)
+   bb5906eeec24ca5433bc45defbb80ac736225b1f	https://github.com/servo/servo/pull/32284	android: Enable JIT compilation on 64-bit Android. (#32284)
+   6c3cf812307e44c7b239f4d6530f8ec95f59b367	https://github.com/servo/servo/pull/32283	Make MouseButtons Forward & Back navigate (#32283)
>>> 2024-05-17T06:11:53Z
+   903c516fb5c5f32a23ad1839de0e310efe59de47	https://github.com/servo/servo/pull/32288	use au in HoistedSharedFragment (#32288)
    c89fb1f381635ab985101b49270544e3856fa7bb	https://github.com/servo/servo/pull/32294	build(deps): bump toml_datetime from 0.6.5 to 0.6.6 (#32294)
    735064a307767ab6ddbf700668990be9089b51ea	https://github.com/servo/servo/pull/32295	build(deps): bump smol_str from 0.2.1 to 0.2.2 (#32295)
    96d1894574b462848d4f6522b44b9d089b9aacee	https://github.com/servo/servo/pull/32299	Rename NavigationType to NavigationTimingType (#32299)
    7039cccbd960eb586696d2c877343661c7b98284	https://github.com/servo/servo/pull/32301	Set RUSTUP_WINDOWS_PATH_ADD_BIN in CI (#32301)
    575aa37ff33a9c39aa325f46d0dc69c46d5351fa	https://github.com/servo/servo/pull/32292	build(deps): bump svg_fmt from 0.4.2 to 0.4.3 (#32292)
    bcdce3aaacfdfca4475b1d7ab4f9d08b5e9f8a81	https://github.com/servo/servo/pull/32293	build(deps): bump serde_spanned from 0.6.5 to 0.6.6 (#32293)
    03360b86b70dd48d665d2d2702b0bf99c5cc3eab	https://github.com/servo/servo/pull/32291	build(deps): bump serde from 1.0.201 to 1.0.202 (#32291)
    724eef3d396abf2bd23b088fbbba5af3d3ba00a2	https://github.com/servo/servo/pull/32290	build(deps): bump darling from 0.20.8 to 0.20.9 (#32290)
    64cad45813062e1768f7d20575547d392b792161	https://github.com/servo/servo/pull/32289	build(deps): bump rustversion from 1.0.16 to 1.0.17 (#32289)
>>> 2024-05-18T06:06:00Z
    5cac27699748b680e9720b2d5097a60d25b886c9	https://github.com/servo/servo/pull/32305	build(deps): bump either from 1.11.0 to 1.12.0 (#32305)
    eade8f556629c2631071fd685cd3af637efa763e	https://github.com/servo/servo/pull/32307	build(deps): bump linux-raw-sys from 0.4.13 to 0.4.14 (#32307)
    a5409ad72f897f03b4b91863b153b1062f968f76	https://github.com/servo/servo/pull/32306	build(deps): bump syn from 2.0.63 to 2.0.64 (#32306)
    3398fc017b994fff113342baab47718a44a37752	https://github.com/servo/servo/pull/32296	Move non-gfx things out of `gfx_traits` and create a `base` crate (#32296)
+   1017533297889beca40be5f121629347963fbf27	https://github.com/servo/servo/pull/32278	fonts: Add color emoji support for FreeType (#32278)
    c9ab743c85b2f8ba079b129ee4e2204ae5fe82db	https://github.com/servo/servo/pull/32298	android: Trim whitespace around font filenames. (#32298)
>>> 2024-05-19T06:08:03Z
    8868c1372ba615bd5e74c3881d8a60f2f90062b1	https://github.com/servo/servo/pull/32311	clippy: Fix warnings in `components/gfx` (#32311)
+   0cd9c3f2c4433799189f9f283624343c1c24e900	https://github.com/servo/servo/pull/32309	tables: Add a naive implementation of `border-collapse` (#32309)
>>> 2024-05-20T06:09:53Z
    b44d064fae0d96b7564912a10187768f3f4203c4	https://github.com/servo/servo/pull/32313	Update web-platform-tests to revision b'cb53e377321267af4f5a1f05b3b851aab6fa8ede' (#32313)
>>> 2024-05-21T06:08:10Z
    f7affae95e2ff13589ac71aa543365ac8447ca61	https://github.com/servo/servo/pull/32323	build(deps): bump raw-window-handle from 0.6.0 to 0.6.2 (#32323)
    98e3ae52f4849df9be2a7fdc5deb6bb7b03ce4d7	https://github.com/servo/servo/pull/32328	build(deps): bump crc32fast from 1.4.0 to 1.4.2 (#32328)
    a913d6d046d9aa628d80674faecdbe4c8685d1c2	https://github.com/servo/servo/pull/32327	build(deps): bump miniz_oxide from 0.7.2 to 0.7.3 (#32327)
    8e914d6f38428b151f8234d545b0c2b467294e1a	https://github.com/servo/servo/pull/32321	build(deps): bump syn from 2.0.64 to 2.0.65 (#32321)
    2b61a35381d07c859c01cd46cceea7c4109deff7	https://github.com/servo/servo/pull/32326	build(deps): bump cc from 1.0.97 to 1.0.98 (#32326)
    e43d9f477a71381d6a215604564c7bfdb87b5ded	https://github.com/servo/servo/pull/32325	build(deps): bump proc-macro2 from 1.0.82 to 1.0.83 (#32325)
    c768c047d0b334cab37fc6880c867a5dcbf885fc	https://github.com/servo/servo/pull/32324	build(deps): bump anyhow from 1.0.83 to 1.0.86 (#32324)
    14f4a9cc55a35ca52d964f7eb6877daf84047715	https://github.com/servo/servo/pull/32322	build(deps): bump thiserror from 1.0.60 to 1.0.61 (#32322)
    ca331a35dfd2ca431ede339fc6d85b66bdeb3af7	https://github.com/servo/servo/pull/32320	build(deps): bump crossbeam-channel from 0.5.12 to 0.5.13 (#32320)
    7548a80ac790c5dc95a7848d1549f1b6a2f46e03	https://github.com/servo/servo/pull/32319	build(deps): bump libc from 0.2.154 to 0.2.155 (#32319)
+   be5b527ea34c8be1bfa53d4a4eaf2729e100db28	https://github.com/servo/servo/pull/32303	fonts: Store web fonts in the per-Layout `FontContext` (#32303)
    8d2d955bbb23826b75faf866e4dcccabb8d7f4e8	https://github.com/servo/servo/pull/32216	Upgrade jni to 0.21.1 (#32216)
    53c0726ef431d32c6f71a1a1eee23019782bd68b	https://github.com/servo/servo/pull/32316	script: Have `Document` own `Layout` (#32316)
    2af6fe0b30a275e5fd8a43eca4126d82639fbaa9	https://github.com/servo/servo/pull/32315	compositor: Move WebRender-ish messages and types to `webrender_traits` (#32315)
    c2076580f352f3c61f90969e03d78ada609935eb	https://github.com/servo/servo/pull/32314	Add unit test to EmbedderCoordinates (#32314)
>>> 2024-05-22T06:10:20Z
+   5d5ac4ec646d702efa4a0ae3e29a192512756cc9	https://github.com/servo/servo/pull/32333	Implement 'visibility: collapse' on table parts (#32333)
    add18db67ed7cf48433d13d8fa1f0b1d85c2c8a8	https://github.com/servo/servo/pull/32337	--- (#32337)
    9f245d3a238a8c79cfad492f101a5e675cd959e6	https://github.com/servo/servo/pull/32336	--- (#32336)
    c51c1f91cb7648179abf37de9d02ab9a3f2e1cbf	https://github.com/servo/servo/pull/32335	--- (#32335)
+   5b13604bd8dbbd26275243d2882761b158291647	https://github.com/servo/servo/pull/32331	Implement 'empty-cells' for layout 2020 (#32331)
+   9d57c0de7758eb609306b8f11d93cead6c148786	https://github.com/servo/servo/pull/32011	feat: add status tooltips (#32011)
    67e556e3becd73a547e09c1c1de8f4b3873d3648	https://github.com/servo/servo/pull/32318	fonts: Depend directly on `freetype-sys` (#32318)
+   1bcb4787d264f3d45b0fe9a3419dda999c32a2ae	https://github.com/servo/servo/pull/32330	ci: enable sccache for Rust compilation. (#32330)
>>> 2024-05-23T06:12:26Z
    6451b1a21b67a368bc2856cebfeafbc0295caf7d	https://github.com/servo/servo/pull/32348	--- (#32348)
+   794110ebe58ad72d809291e9feb3f2cc92819941	https://github.com/servo/servo/pull/32304	webgpu: Move errorscopes to WGPU thread (#32304)
    9f32809671c8c8e79d59c95194dcc466452299fc	https://github.com/servo/servo/pull/32332	fonts: Clean up messaging during web fonts loads (#32332)
+   d47c8ff2aeebe5854a7c8484a33d285268347fee	https://github.com/servo/servo/pull/32341	Fix mach bootstrap --skip-platform (#32341)
>>> 2024-05-24T06:10:57Z
    fc08bd1aa79e1211323d91681308456778d3abc9	https://github.com/servo/servo/pull/32363	build(deps): bump gstreamer-app-sys from 0.22.0 to 0.22.5 (#32363)
    61a616e98e86c34e897b864769914d584fb628e5	https://github.com/servo/servo/pull/32364	build(deps): bump gstreamer from 0.22.4 to 0.22.5 (#32364)
    400498bab97f29a112c77614dd5f6d46ce6ddf8a	https://github.com/servo/servo/pull/32361	build(deps): bump gstreamer-webrtc-sys from 0.22.0 to 0.22.5 (#32361)
    f4488f2a86fb929071228d6959bd62252fc70962	https://github.com/servo/servo/pull/32360	build(deps): bump glib-macros from 0.19.5 to 0.19.7 (#32360)
    c259389a16e8f3147b1e815fadaf0c5b9c8cc5fe	https://github.com/servo/servo/pull/32359	build(deps): bump gstreamer-sys from 0.22.2 to 0.22.5 (#32359)
    57e7816560e8966640e3e8825f32432b76c3182b	https://github.com/servo/servo/pull/32358	build(deps): bump gstreamer-audio-sys from 0.22.0 to 0.22.5 (#32358)
    6ea2beceabe143d2cbeba8b6f45c76d57a401884	https://github.com/servo/servo/pull/32357	build(deps): bump gstreamer-audio from 0.22.4 to 0.22.5 (#32357)
    8d178844e0edf2776e036570f1a6863229437c6b	https://github.com/servo/servo/pull/32356	build(deps): bump glib from 0.19.6 to 0.19.7 (#32356)
    342f1e3f6abd419095398c109ca80522b6762431	https://github.com/servo/servo/pull/32355	build(deps): bump gstreamer-player-sys from 0.22.0 to 0.22.5 (#32355)
+   ff166ea1e3086adb2b5019b31bf51c921e7f151b	https://github.com/servo/servo/pull/32352	mach: fix crash when sending notifications on Windows Server 2019 (#32352)
+   14286d913d5a88647fad2255f06bec0763914e55	https://github.com/servo/servo/pull/32346	fonts: Remove web fonts when their stylsheet is removed (#32346)
    a772ecf786bda74cd5202b9ca6fb2d487cc61b94	https://github.com/servo/servo/pull/32147	Uprade stylo to include servo/style#33 (#32147)
>>> 2024-05-25T06:12:14Z
    373481e4204df664cd4251b81aa25da2511ccf88	https://github.com/servo/servo/pull/32380	build(deps): bump bytemuck_derive from 1.6.0 to 1.6.1 (#32380)
    4c09b11274e15ddd529c20b2245dbc683d229137	https://github.com/servo/servo/pull/32379	build(deps): bump parking_lot from 0.12.2 to 0.12.3 (#32379)
    327ccc7f28ecb272390fb6c71a987362d280b5f7	https://github.com/servo/servo/pull/32369	build(deps): bump gstreamer-video from 0.22.4 to 0.22.5 (#32369)
    f97753df6d994ff468141081511b484a29728906	https://github.com/servo/servo/pull/32378	dependabot: Group all GStreamer dependencies together for upgrades (#32378)
    bc976cb0541f917fb7df48f09f4886bfc748ce32	https://github.com/servo/servo/pull/32368	build(deps): bump syn from 2.0.65 to 2.0.66 (#32368)
    fdd814ef7d02dde0b4baa7aa96b4a52354118ee0	https://github.com/servo/servo/pull/32374	build(deps): bump gstreamer-webrtc from 0.22.0 to 0.22.5 (#32374)
    85c1070889b48cbb1f3938a0458996eb2d1cae99	https://github.com/servo/servo/pull/32376	build(deps): bump gstreamer-base-sys from 0.22.0 to 0.22.5 (#32376)
    af82ac65dec1c6ac67b6ca598917e327e30fa782	https://github.com/servo/servo/pull/32375	build(deps): bump gstreamer-video-sys from 0.22.1 to 0.22.5 (#32375)
    891a4ffd8086edab7682fc916e9d1581f0492f2e	https://github.com/servo/servo/pull/32370	build(deps): bump gstreamer-sdp-sys from 0.22.0 to 0.22.5 (#32370)
    805ad72e04ab97486f637a54e1166735b870222d	https://github.com/servo/servo/pull/32371	build(deps): bump gstreamer-gl-sys from 0.22.0 to 0.22.5 (#32371)
    9690964f8fa9675b2d7a2fc9e25e81ad24e9ce5f	https://github.com/servo/servo/pull/32373	build(deps): bump gstreamer-gl-egl-sys from 0.22.0 to 0.22.5 (#32373)
    69cdfe92d7b13c83473be1d5f92d89fd275d0bb4	https://github.com/servo/servo/pull/32367	build(deps): bump libz-sys from 1.1.16 to 1.1.18 (#32367)
+   60a81a7032c36a3c702650e783b3c4797cd45222	https://github.com/servo/servo/pull/32366	fonts: Add support for the CSS font matching algorithm (#32366)
    45ef2c4abf5366644963f5b18763dce2d975bcc7	https://github.com/servo/servo/pull/32362	build(deps): bump gstreamer-gl-x11-sys from 0.22.0 to 0.22.5 (#32362)
    b1031d68c73544778bfc088db6242c7496b7eb57	https://github.com/servo/servo/pull/32339	Move webgl_channel into base crate (#32339)
>>> 2024-05-26T06:03:43Z
    a7bf099cb1694157e2085b9cc3d1e81dc687e2c7	https://github.com/servo/servo/pull/32381	Update web-platform-tests to revision b'f2cdcb7e9550e74d07ed6cf17bbcb9643aeedb99' (#32381)
    512e67f6d12d2a4de301866384dadc3860086749	https://github.com/servo/servo/pull/32372	build(deps): bump itertools from 0.12.1 to 0.13.0 (#32372)
>>> 2024-05-27T06:08:23Z
-->

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
    ._fig._min {
        width: min-content;
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