---
layout:     post
tags:       blog
title:      "This month in Servo: and more!"
date:       2024-06-30
summary:    Your text here.
categories:
---

Servo has had some exciting changes land in our nightly builds over the last month:

- as of 2024-05-31, we now support **‘white-space-collapse: break-spaces’** (@mrobinson, @atbrakhi, #32388)
- as of 2024-06-11, we now support **&lt;col span> in &lt;colgroup>** (@Loirooriol, #32467)
- as of 2024-06-14, we now support the **decode method on HTMLImageElement** (@Taym95, #31269)
- as of 2024-06-18, we now support **ResizeObserver** (@gterzian, #31108)
- as of 2024-06-21, we now **render text in input fields** (@mrobinson, #32365)

Servo now builds with **Rust 1.78** (@sagudev, #32217) and we’ve migrated to **Rust 2021** (@mrobinson, #32544), **SpiderMonkey 115.13** (@sagudev, #32510), and **Stylo 2024-05-15** (@Loirooriol, #32334).

WebGPU can now run on **OpenGL ES on Windows and Linux** (@hieudo-dev, #32452), **no longer records errors after losing a device** (@sagudev, #32347), and you can now **select a WebGPU backend with `--pref dom.webgpu.wgpu_backend=`**.

## Fonts and emoji

Every emoji in Unicode has two variants: an **emoji presentation** (color or graphic) and a **text presentation** (monochrome).
You can select one or the other by appending the **variation selectors** [U+FE0F](https://charming.daz.cat/#FE0F) or [U+FE0E](https://charming.daz.cat/#FE0E) respectively, and the default presentation is controlled by the [**Emoji_Presentation**](https://www.unicode.org/reports/tr51/tr51-25.html#Emoji_Properties_and_Data_Files) property.
Most emoji default to emoji presentation, but not all of them, and bugs in handling that property are often why characters like [<span style=font-size:150%;line-height:1rem>™</span>](https://charming.daz.cat/#2122) and [<span style=font-size:150%;line-height:1rem>↔</span>](https://charming.daz.cat/#2194) become emoji when they shouldn’t.

We’ve reworked our font fallback algorithm to enable **emoji in text presentation on Windows** (@mrobinson, #32286) and correctly handle **emoji variation selectors** and **Emoji_Presentation** (@mrobinson, @atbrakhi, @mukilan, #32493).

Webfont performance is improving, with Servo no longer starting a **layout reflow every time a webfont loads** (@mrobinson, #32455) and no longer **leaking resources in WebRender** (@mrobinson, @mukilan, #32545).
We’ve also fixed a bug where spaces near emoji are too wide (@mrobinson, @atbrakhi, #32442), fixed a shaping bug on Windows (@mrobinson, #32499), and improved our fallback font lists (@mrobinson, @jschwe, #32463, #32555).

## Donations

Thanks again for your generous support!
We are now receiving **2229 USD/month** (+36.7% over April) in recurring donations.
We are still receiving donations from **15 people** on LFX, and we’re working on transferring the balance to our new fund, but we will stop accepting donations there soon — **please move your recurring donations to [GitHub](https://github.com/sponsors/servo) or [Open Collective](https://opencollective.com/servo)**.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 2229 / 10000); padding-left: 0.5em;"><strong>2229</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 2229 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="2229" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

As always, use of these funds will be decided transparently in the Technical Steering Committee.
For more details, head to our [Sponsorship page]({{ '/sponsorship/' | url }}).

<!--
fromDate = "2024-05-26"
toDate = "2024-06-26"
>>> top deltas (servo, pp):
csstext (5.3pp to 58.4%)
csstable (2.7pp to 71.2%)
floats-clear (2.4pp to 93.8%)
box-display (2.2pp to 86.6%)
css (1.1pp to 66.4%)
all (0.6pp to 57.6%)
cssom (0.6pp to 65.6%)
css2 (0.5pp to 79.4%)
linebox (0.5pp to 94.3%)
normal-flow (0.4pp to 94.2%)
cssflex (0.3pp to 54.8%)
positioning (0.2pp to 90.3%)
csspos (0.1pp to 48.9%)
abspos (0.0pp to 91.0%)
floats (0.0pp to 90.8%)
margin-padding-clear (0.0pp to 96.7%)

- ai policy
- DONE donations 2229.50/month
    - 1391.50/month opencollective
    - 691.00/month github
    - 147.00/month lfx
- DONE upgrade mozjs 32510 stylo 32334
- DONE ResizeObserver 31108
- DONE HTMLImageElement decode() 31269
- layout
    - DONE input 32365
    - DONE break-spaces 32388
    - inline padding/border 32486
    - abspos tables 32447
    - table column width colspan 32458
    - getComputedStyle width/height 32437
    - offset queries tables/cells 32448
    - DONE <col span> in colgroup 32467
    - collapse with rowspan 32469
    - prepare for shaping across inline boxes 32483
- DONE fonts
    - DONE spaces 32442
    - DONE reflow 32455
    - DONE leak 32545
    - DONE windows 32499
    - DONE ohos 32555
    - DONE fallback 32463 32286 (+ emoji vs, monochrome emoji windows)
    - DONE emoji vs/ep 32493
- meta http-equiv parsing 32508
- devtools 32475 32509
- DONE webgpu
    - DONE gles windows/linux 32452
    - DONE backend pref dom.webgpu.wgpu_backend 32410
    - DONE device lost no errors 32354
- minibrowser fullscreen 32425 status 32518
    - servoshell split 32457
- DONE rust msrv 32217 edition 32544
- panic multiprocess 32571
- android busted 32532 url bar 32422 start of merge into servoshell 32533
- mac busted 32504
- nixos busted 32567
- openharmony 32507
- docs libservo 32429
- compositor transparent 32453 layout direct 32377
- codeowners 32568
- asan build 31429 32511
- ci legacy 32405
-->

<!--
>>> 2024-05-28T06:08:31Z
    93785a8a3a841f272c6f0237f746cf4ee2116915	https://github.com/servo/servo/pull/32385	build(deps): bump proc-macro2 from 1.0.83 to 1.0.84 (#32385)
    e8e8c23a3093ef57e601f7f9168e850fde43663a	https://github.com/servo/servo/pull/32383	build(deps): bump hashbrown from 0.14.3 to 0.14.5 (#32383)
    8322cb9b82766648a7b9077abaa37b1110d69625	https://github.com/servo/servo/pull/32382	build(deps): bump serde from 1.0.202 to 1.0.203 (#32382)
+   453ac11e3d4b91c94599a2afa2c2474e0d064ba2	https://github.com/servo/servo/pull/32334	Upgrade stylo to 2024-05-15 (#32334)
+   43a3c9c319e6406c92254031cd05ca23609102ef	https://github.com/servo/servo/pull/32286	fonts: Improve font fallback (#32286)
+   5f0866379a731628c535593d0022b91cfabfb868	https://github.com/servo/servo/pull/32377	Remove more IPC messages between script and layout (#32377)
>>> 2024-05-29T06:12:54Z
    42061ccafe67ac0440886e48e17a02f8b60525bc	https://github.com/servo/servo/pull/32389	build(deps): bump backtrace from 0.3.71 to 0.3.72 (#32389)
    02893770910bb1db27a5a3df80b0c98eeaa7d215	https://github.com/servo/servo/pull/32386	Move `RenderingContext` to `webrender_traits` (#32386)
    277eb87cc038480d105234aa5f2b70c1c5725178	https://github.com/servo/servo/pull/32384	build(deps): bump clang-sys from 1.7.0 to 1.8.0 (#32384)
>>> 2024-05-30T06:15:06Z
    c0dedf06d68f5fd6fb8c8b4b970fb47ef91d5431	https://github.com/servo/servo/pull/32403	build(deps): bump zerofrom from 0.1.3 to 0.1.4 (#32403)
>>> 2024-05-31T06:10:39Z
+   d92c2915526d8f72cb0b2284c3cb22fc9009406d	https://github.com/servo/servo/pull/32405	ci: Disable legacy layout tests when landing PRs (#32405)
    fb6f6d27888eef9f5d1bdec2dada0a9abea72db4	https://github.com/servo/servo/pull/32391	font_template.rs: apply clippy lints (#32391)
+   60b4b6c9f086a6f4bc1cc439daf3b64cf73d1ca8	https://github.com/servo/servo/pull/32388	layout: Add support for `white-space-collapse: break-spaces` (#32388)
>>> 2024-06-01T06:08:35Z
    1f4341e62842ac76f3ef3ec40cb8114b008b62cc	https://github.com/servo/servo/pull/32418	build(deps): bump tokio from 1.37.0 to 1.38.0 (#32418)
+   3d70243438ac9bc2c95b20ae8d4b6c093086321b	https://github.com/servo/servo/pull/32410	webgpu: Parse and forward backend prefs to wgpu (#32410)
    500a475217d924146493b1494ff2929ee64a21c3	https://github.com/servo/servo/pull/32420	build(deps): bump wayland-client from 0.31.2 to 0.31.3 (#32420)
    2760db0e1aa82ec3e03139a94d12eb6ea07b1b58	https://github.com/servo/servo/pull/32419	build(deps): bump wayland-backend from 0.3.3 to 0.3.4 (#32419)
    cb99fab62d9211e160362d91d99d9729adaba11e	https://github.com/servo/servo/pull/32417	build(deps): bump wayland-scanner from 0.31.1 to 0.31.2 (#32417)
    dc0ba03d6816a3a2f2d9eff55c67af3daf3e96e6	https://github.com/servo/servo/pull/32395	build(deps): bump bytemuck_derive from 1.6.1 to 1.7.0 (#32395)
    5fafc82730260b783126f073bce4fef8e1e9d559	https://github.com/servo/servo/pull/32408	build(deps): bump compiletest_rs from 0.10.2 to 0.11.0 (#32408)
    48bcdacfbe8c550fa8a3ffefd6aca4da6dd9bf6b	https://github.com/servo/servo/pull/32398	build(deps): bump icu_segmenter from 1.4.0 to 1.5.0 (#32398)
    bea7020258d6c668516180c854bc2dc4e90f4d96	https://github.com/servo/servo/pull/32393	clippy: Fix warnings in `components/layout_2020/flow/text_run.rs` (#32393)
    0ccf129be027b39c1f9628f8a1be7283b5905d57	https://github.com/servo/servo/pull/32392	clippy: Fix warnings in `components/webgpu/wgpu_thread.rs` (#32392)
    5a7891fbed9f13fc8c9f633ba225640a0fea718f	https://github.com/servo/servo/pull/32414	Bump deps that only failed due to CI issues (#32414)
>>> 2024-06-02T06:08:47Z
    dd2de1836bcb7fe3287ce98dd8e6436620fe2a93	https://github.com/servo/servo/pull/32426	Update web-platform-tests to revision b'17375f41ccf41e081764d2786ec535dede108c47' (#32426)
+   b28314d33e74c2166bfee278fad7e40616308a86	https://github.com/servo/servo/pull/32217	Update to Rust 1.78 (#32217)
>>> 2024-06-03T06:06:40Z
+   2ca6c4b52be217d0c99986d0cb8a393571d195b7	https://github.com/servo/servo/pull/32429	Document library crates only in mach doc (#32429)
>>> 2024-06-04T06:09:14Z
    e73cf039001034adac85d9fcf21d212b8a5671c1	https://github.com/servo/servo/pull/32434	build(deps): bump polling from 3.7.0 to 3.7.1 (#32434)
    e9966e0186503d87b9bfacd1617238fc4d4c05d1	https://github.com/servo/servo/pull/32433	build(deps): bump proc-macro2 from 1.0.84 to 1.0.85 (#32433)
    f8985c5521cdf72a9137a7fa847043e5a789dfe0	https://github.com/servo/servo/pull/32424	base: Remove `ucd` dependency (#32424)
    48ab8d8847eadd0c94f43307860e880d4802a075	https://github.com/servo/servo/pull/32415	layout: Add a `InlineFormattingContextBuilder` (#32415)
    00b77ce73cc743c56551c43dbbe66362a5f9eb36	https://github.com/servo/servo/pull/32431	mach: Read .servobuild as utf-8 (#32431)
>>> 2024-06-05T06:06:04Z
+   5f538b89e0c9fd18b0982593236319f932b522b3	https://github.com/servo/servo/pull/32437	Fix getComputedStyle for width and height (#32437)
    804c74e6e51476aa9481179e90a007728f83331c	https://github.com/servo/servo/pull/32439	build(deps): bump unicode-width from 0.1.12 to 0.1.13 (#32439)
    d3eb74d7bfee440bb061e633bfea1628d786c68e	https://github.com/servo/servo/pull/32440	build(deps): bump hyper from 0.14.28 to 0.14.29 (#32440)
    8548172bc2ff4e69aa8032fedb0d21d16a3de269	https://github.com/servo/servo/pull/32438	build(deps): bump etagere from 0.2.10 to 0.2.11 (#32438)
    c24183096f8714ea28d592f34db6997d45a22a33	https://github.com/servo/servo/pull/32435	build(deps): bump wayland-cursor from 0.31.1 to 0.31.3 (#32435)
>>> 2024-06-08T06:02:56Z
    b178a2b6e2312a74f4a72781789c45a31ac164a7	https://github.com/servo/servo/pull/32462	build(deps): bump xkeysym from 0.2.0 to 0.2.1 (#32462)
    333630ae705bab3f3e309ac817c439f7fffd74c3	https://github.com/servo/servo/pull/32461	build(deps): bump cc from 1.0.98 to 1.0.99 (#32461)
    ceb6bc6743d3641960d7e42a943efafcb81fbf2e	https://github.com/servo/servo/pull/32460	build(deps): bump dtoa-short from 0.3.4 to 0.3.5 (#32460)
+   d10d01757d3a69f0f7ac1635a72981c52708f8aa	https://github.com/servo/servo/pull/32458	Don't shrink table columns when handling cells with greater spanning (#32458)
+   674edb4df06413cbfcb78b22457ae287647641ca	https://github.com/servo/servo/pull/32447	layout: Properly size absolutely positioned tables (#32447)
    764021751dc13fdc5db68c9f18cce69938dadb05	https://github.com/servo/servo/pull/32456	Add a workaround for actions/runner-images#10001 (#32456)
    bd14541b99fa8c324d7118d6d86149ae10a8e1a1	https://github.com/servo/servo/pull/32446	build(deps): bump xml5ever from 0.18.0 to 0.18.1 (#32446)
    ff73a5158a7cdf0093d9b0d2992e868ca32cd3c3	https://github.com/servo/servo/pull/32444	build(deps): bump etagere from 0.2.11 to 0.2.12 (#32444)
    cc0199140081e738260c0457bf12fa6b6a1b408b	https://github.com/servo/servo/pull/32445	build(deps): bump tar from 0.4.40 to 0.4.41 (#32445)
+   6eaccbc297dee9c1189a008ad846efa6b5a245f2	https://github.com/servo/servo/pull/32442	layout: Don't default to fallback fonts for spaces (#32442)
    49e15269c906fbb708bd0018a55757d5e8d22d9c	https://github.com/servo/servo/pull/32423	Remove unused items in gfx (#32423)
>>> 2024-06-09T06:02:32Z
>>> 2024-06-10T06:04:47Z
    855f32013f3d2b7bda218a10795a553730bd9ad8	https://github.com/servo/servo/pull/32464	Update web-platform-tests to revision b'68f7e630c2646830a3ee274e21a3efcb001fbd65' (#32464)
+   4f5184b6e2aefb3bb53848a174076ed86aebc631	https://github.com/servo/servo/pull/32452	webgpu: Enable gles support (#32452)
>>> 2024-06-11T06:02:47Z
    98057799aca2e82945419562ac634de942b1cc50	https://github.com/servo/servo/pull/32472	build(deps): bump regex-automata from 0.4.6 to 0.4.7 (#32472)
    59806309c9ead5e3a116926cb59eb5b71c5c16d5	https://github.com/servo/servo/pull/32470	build(deps): bump regex-syntax from 0.8.3 to 0.8.4 (#32470)
+   f4c9b310d509155ec207f99426d9ba22dd8a06fd	https://github.com/servo/servo/pull/32448	layout: Take into account `display: table` etc in offset* queries (#32448)
+   35bbcc0d9519411dd1112dece8df19ddca51276c	https://github.com/servo/servo/pull/32455	script: Remove explicit reflow for web font loads (#32455)
+   e6ea4a9c298c02138938c27851ccf9cca0523f67	https://github.com/servo/servo/pull/32422	Android: fix url resolution (#32422)
+   6f414df867cb8aea02dbc7009000096c17eeb3ab	https://github.com/servo/servo/pull/32467	Fix and unify 'span' attribute for table columns (#32467)
    712f751d48ee7ec49f61484f5682a575ec49c402	https://github.com/servo/servo/pull/32466	gfx: font_list: Fix OpenHarmony build (#32466)
+   a91faa7207b203033c7cb6ea62e6541cec07cf58	https://github.com/servo/servo/pull/32453	Fix missing alpha value when using CompositeTarget::Fbo (#32453)
>>> 2024-06-12T06:02:11Z
+   b4e41d872789206a618ff729dc6f9fa8065cabd0	https://github.com/servo/servo/pull/32469	Fix table track offsets when there is `visibility: collapse` (#32469)
    3c06536cb67984d1f4822ea4cbf6618016b0e4ec	https://github.com/servo/servo/pull/32476	clippy: fix some leftover warnings in components/net (#32476)
    55d067091c3ff472524ae23650b60baf2fa63026	https://github.com/servo/servo/pull/32481	build(deps): bump regex from 1.10.4 to 1.10.5 (#32481)
    c4528a5da83973ab502d055914a11fe8e80b150e	https://github.com/servo/servo/pull/32480	build(deps): bump surfman from 0.9.3 to 0.9.4 (#32480)
    20c99a13c00150c4857bf9a9aa0b4c4ec8b4fe90	https://github.com/servo/servo/pull/32479	build(deps): bump httparse from 1.9.1 to 1.9.2 (#32479)
    10fd7e6e17b033ca1392defaa3ad10d8aa914f6f	https://github.com/servo/servo/pull/32473	build(deps): bump httparse from 1.8.0 to 1.9.1 (#32473)
>>> 2024-06-13T06:06:30Z
    0a641816bf8f402800d7ecec12d2d64505975c16	https://github.com/servo/servo/pull/32482	clippy fixes regarding clone_from (#32482)
    fd472ebd0edc8eb91155b20e95ea9acfa6e77573	https://github.com/servo/servo/pull/32465	Add cargo-deny to mach-tidy to check license compliance. (#32465)
+   370fbf0331d73ae95ea29e67305aa86065c3604b	https://github.com/servo/servo/pull/32475	DevTools: Display tabs and processes (#32475)
+   699f6960f5d58005f426bf349ad2e61101fb7747	https://github.com/servo/servo/pull/32425	minibrowser: Disables urlbar when in fullscreen (#32425)
>>> 2024-06-14T06:01:54Z
+   bae9f6d84424accb9db8d82ebf1ef087b7b400f6	https://github.com/servo/servo/pull/32483	layout: Linebreak the entire InlineFormattingContext at once (#32483)
    43a7dd5da08d01234805c1298469f883a362f55d	https://github.com/servo/servo/pull/32478	build(deps): bump url from 2.5.0 to 2.5.1 (#32478)
    d4ead7f85e6507a167a5dc84acbcfa47ec977e17	https://github.com/servo/servo/pull/32491	build(deps): bump memchr from 2.7.2 to 2.7.3 (#32491)
    c755c1415772084c641793889cdcb6de2525f2b2	https://github.com/servo/servo/pull/32489	build(deps): bump backtrace from 0.3.72 to 0.3.73 (#32489)
    801a15a9a1b059b442f61be4e06aa761c0cf7e09	https://github.com/servo/servo/pull/32490	build(deps): bump httparse from 1.9.2 to 1.9.3 (#32490)
+   3ccc79c5e7241ba43f26048badd8bafcf62b2230	https://github.com/servo/servo/pull/32463	fonts: Merge Noto fallback lists (#32463)
    996715fe10590450743c7f8854bc07a4eb52b852	https://github.com/servo/servo/pull/32468	Signed-off-by: Rexiel Scarlet <37258415+Rexcrazy804@users.noreply.github.com> (#32468)
+   1d048f4f6a147ab1f81893f370df3447b18075ec	https://github.com/servo/servo/pull/31269	Implement HTMLImageElement decode (#31269)
    43df0a48ee3b7786c86d6f000e5f6acc990b61de	https://github.com/servo/servo/pull/32484	mach: Use `cargo rustc` instead of `cargo build` (#32484)
>>> 2024-06-15T06:01:23Z
    8eed3b442b214f678b80dbcc7dca07eeaa1e26ff	https://github.com/servo/servo/pull/32495	Update WebIDL.py (#32495)
+   19067366df28c9131dcbc436bc96a27e64e0a194	https://github.com/servo/servo/pull/32504	Fix cross-compiling servoshell on Mac hosts (#32504)
    33701464900ef00dc9a11a0304b753b8ae66464e	https://github.com/servo/servo/pull/32502	Sign off commits by WPT importer (#32502)
    d297ae0af594efd8265b3801d94e7febbc404374	https://github.com/servo/servo/pull/32503	ci: Rename "try_labels.yml" to "try-label.yml" (#32503)
    30c4831c1150b0b9b6ef2fad520281ca698520be	https://github.com/servo/servo/pull/32501	build(deps): bump mozjs from 8603cb to df2365fa (#32501)
    1e1f4de8e443d5371453d8b2e3d4ce2848520910	https://github.com/servo/servo/pull/32498	build(deps): bump memchr from 2.7.3 to 2.7.4 (#32498)
+   ff4cd4af960b2f0c506cf3a53336d4ffe56ac988	https://github.com/servo/servo/pull/32457	Split servoshell into Desktop and common part (#32457)
>>> 2024-06-16T06:03:10Z
    7982f0dc27cad98057a0a953cca76e2b86aa37ed	https://github.com/servo/servo/pull/32500	build: Fix build warnings on Windows (#32500)
+   6b6872831ccc83e37dc9a8b1842c125606943d69	https://github.com/servo/servo/pull/32508	htmlmetaelement: improve parsing of meta http-equiv (#32508)
>>> 2024-06-17T06:04:38Z
+   8b35c4094a44e3d47ebfa5c7ff11b15ec6b22b05	https://github.com/servo/servo/pull/31429	Add `--with-asan` (#31429)
+   f0191c0a75a2a8ed82e13eeaa5f0c38ce0131cb2	https://github.com/servo/servo/pull/32510	Bump mozjs (#32510)
    d439faf6fb0704a47e07004ccb745c4e00778420	https://github.com/servo/servo/pull/32512	Update web-platform-tests to revision b'ed9e9309618bdf76de06ff85757edbc8e1d7da82' (#32512)
>>> 2024-06-18T06:03:22Z
+   79cd87a3c3faf1be7ecfd99cb489c8094be7ea3f	https://github.com/servo/servo/pull/32532	Fix android build on Fedora 40. (#32532)
    be290533c4c6c14547e1d5d3435f089ffd1972de	https://github.com/servo/servo/pull/32528	build(deps): bump derive_more from 0.99.17 to 0.99.18 (#32528)
+   3d78d60619cb1eda22f4473c91c45cc6a7907244	https://github.com/servo/servo/pull/31108	implement basic infra for ResizeObserver (#31108)
    3c1c395dfc60ca202834f9c708fffda71606bf1a	https://github.com/servo/servo/pull/32527	Restore accidentally deleted suppression file and suppress intentional leak in stylo #32223 (#32527)
    6a3ccb656d4b74d2e3df14b746f21d67c8ba2029	https://github.com/servo/servo/pull/32526	build(deps): bump httparse from 1.9.3 to 1.9.4 (#32526)
    c3648e3eab0272358e846ebb02290b5bb90f18f3	https://github.com/servo/servo/pull/32524	build(deps): bump etagere from 0.2.12 to 0.2.13 (#32524)
    83b4dcf444f2fd98cc31abca2ad422f4727f6c6b	https://github.com/servo/servo/pull/32522	build(deps): bump gilrs-core from 0.5.11 to 0.5.12 (#32522)
    fe5faf0dedff1b767e39daff67b256c4f957ef8f	https://github.com/servo/servo/pull/32521	build(deps): bump rustfix from 0.8.2 to 0.8.4 (#32521)
+   cbc9304c2002fb0d5c8cdade39eddfe117b12053	https://github.com/servo/servo/pull/32354	webgpu: Implement device lost (#32354)
+   3381f2a70442aa6a6c31a0bc4a4c3601299631f5	https://github.com/servo/servo/pull/32507	Add OpenHarmony support to mach and CI (#32507)
+   bea181f5d52c8ac088328f72dc36ef503a5420a9	https://github.com/servo/servo/pull/32511	asan: Add a leak suppression file with known false positives (#32511)
+   2c0d0d57b100ea08824839a2d52beb2b3f1448fc	https://github.com/servo/servo/pull/32499	fonts: Fix loading SFNT tables on Windows (#32499)
    e902d63732e96f71c86bae159786e12b18876b3c	https://github.com/servo/servo/pull/32516	deps: Switch from `winapi` to `windows_sys` in Servo code (#32516)
>>> 2024-06-19T06:02:17Z
+   24906e1c21b69af0d70091c5541cdf133f2591ea	https://github.com/servo/servo/pull/32533	Move android port code to servoshell (#32533)
    6f64a5afadf551540fb533ba209063fca039c6bc	https://github.com/servo/servo/pull/32546	Mark some ResizeObserver tests as flaky (#32546)
    eaf9055745e45eaff0a6a64e3e474f51fe5a8c97	https://github.com/servo/servo/pull/32547	build(deps): bump miniz_oxide from 0.7.3 to 0.7.4 (#32547)
    946e41e59d4693915726be043f27765ebac4a26d	https://github.com/servo/servo/pull/32515	ci: Use a servo.org email address for the servo-wpt-sync GitHub bot (#32515)
+   70982dfa5aaf176a46308aa4075128e8edd53da2	https://github.com/servo/servo/pull/32486	layout: Allocate inline box start space on segment (#32486)
    63889b732f59a0cfe1271c9340aca4d4c565575b	https://github.com/servo/servo/pull/32537	fix: codegen on callback (#32537)
    d4db08113dc945e4094f7e545d4a0119d386f152	https://github.com/servo/servo/pull/32523	build(deps): bump android_logger from 0.13.3 to 0.14.1 (#32523)
    668b8df9dae219657d420c76b6133ef2e4165429	https://github.com/servo/servo/pull/32529	build(deps): bump polling from 3.7.1 to 3.7.2 (#32529)
+   fef1337da0f5bfed27225972e33d8c94d38bfbb3	https://github.com/servo/servo/pull/32545	fonts: Clean up WebRender web fonts when they are no longer used (#32545)
+   bd15a4fbd803d2a7d73f440efd741d98f7cc72a6	https://github.com/servo/servo/pull/32518	servoshell: Reset link status when loading a new document (#32518)
    1d2949f2b3daa3861cdc3e519f4ae6a6e3b8aaf1	https://github.com/servo/servo/pull/32543	CI: Cache cargo-deny (#32543)
+   4a7f3bac7cadff129d15e3b0a6471a7ed3c4aaa4	https://github.com/servo/servo/pull/32544	Use workspace definitions for all crates and update to the 2021 edition (#32544)
    42b09d483fbcc79345844d34b88b3ff4ae7a9735	https://github.com/servo/servo/pull/32540	mach: fix test-tidy to not skip `Cargo.lock` (#32540)
+   57b64d8123535858f96796602906b4d02c7d4e4a	https://github.com/servo/servo/pull/32493	fonts: Respect emoji variation selector when selecting fonts (#32493)
>>> 2024-06-20T05:57:46Z
    256c55eb8125bb9ec2bcfa78fd0e000c54a48666	https://github.com/servo/servo/pull/32565	build(deps): bump the gstreamer-related group with 22 updates (#32565)
    cd2ab36759dc58acdeb2b8321c38b7345b524a63	https://github.com/servo/servo/pull/32556	Rename `gfx` to `fonts` (#32556)
    9f8118abc7fd9aba49e422cf13b5243e3b582fdc	https://github.com/servo/servo/pull/32564	servoshell: Clean up keyboard event conversion a little (#32564)
    6a48c72a6285783e0b8192a18bcff3e626d7149b	https://github.com/servo/servo/pull/32563	dependabot: Combine more GStreamer / GLib-related crates (#32563)
    c4c86af49619423015ea7b429c8aa0ff722ca046	https://github.com/servo/servo/pull/32562	build(deps): bump idna from 1.0.0 to 1.0.1 (#32562)
    9615abac7eadf45af451a4f7fe079c20dafae41e	https://github.com/servo/servo/pull/32560	build(deps): bump bytemuck from 1.16.0 to 1.16.1 (#32560)
    7aecd6f12669afb283285b89ed8095eb704342fa	https://github.com/servo/servo/pull/32559	build(deps): bump gio-sys from 0.19.5 to 0.19.8 (#32559)
    137ded3e30616557eed3b368d4bf3f79ef3cc980	https://github.com/servo/servo/pull/32558	build(deps): bump gobject-sys from 0.19.5 to 0.19.8 (#32558)
    7edf9e3d79f938094eb6811001b78ccb7006288f	https://github.com/servo/servo/pull/32557	build(deps): bump the gstreamer-related group with 3 updates (#32557)
    e74075255bfef3f55acdfb4866fc2e0a9f5a9583	https://github.com/servo/servo/pull/32539	layout: Flatten inline box storage in InlineFormattingContexts (#32539)
    48035141966c907ee7cdd0cd73d55da0d3f866a0	https://github.com/servo/servo/pull/32551	mach: fix test-tidy to handle missing merge commit (#32551)
>>> 2024-06-21T05:58:30Z
+   44064b14392838fd7da148000b58c9a3cc07d4e7	https://github.com/servo/servo/pull/32365	layout: Add very basic support for showing text in input boxes (#32365)
    3d6accbbe3a33ea5e3c621ae3c291a0f35fcba73	https://github.com/servo/servo/pull/32573	android: Remove serde-json build-dependency (#32573)
+   ee2acaeacf2bdb522815358b8c9b87a09208f118	https://github.com/servo/servo/pull/32571	config: fix panic in PrefValue to [f64; 4] conversion (#32571)
+   64b872ec0d7c0f6e53dadb01968576569d91f8d0	https://github.com/servo/servo/pull/32568	add codeowners file, set gterzian as owner for components/script (#32568)
+   7957d11b5d8ffff1475a08f449d18bd0415f80ef	https://github.com/servo/servo/pull/32555	ohos: Add fallback font for serif (#32555)
+   cc1c31ef3f018946c8a7c2244fcc1d062600e11c	https://github.com/servo/servo/pull/32567	crown: remove references to workspace manifest (#32567)
    bf99cf7f30e9c7ea0e879068773155ce18dfd0c0	https://github.com/servo/servo/pull/32520	Proper GPUDevice cleanup (#32520)
>>> 2024-06-22T06:02:49Z
    130eef300bb71febf715683211323c1b551f5313	https://github.com/servo/servo/pull/32579	build(deps): bump syn from 2.0.66 to 2.0.67 (#32579)
    56d475999359e35934e889deb4566ea06c195d92	https://github.com/servo/servo/pull/32577	build(deps): bump proc-macro2 from 1.0.85 to 1.0.86 (#32577)
    a084813a1ff2cf4ccc37f5f539563e45ff9e53d4	https://github.com/servo/servo/pull/32578	build(deps): bump displaydoc from 0.2.4 to 0.2.5 (#32578)
+   5eb88134488872f4ef1e5f0fcccf18bef47d83cf	https://github.com/servo/servo/pull/32509	DevTools: Implement watcher actor (#32509)
    26c585a0c5d6e459e8f02517cb1231a1b7a9345f	https://github.com/servo/servo/pull/32349	use app unit in box_fragement (#32349)
    66edef806579fd0b386f4ceba473e6a9f7d0ca34	https://github.com/servo/servo/pull/32487	layout: Simplify `Contents` a little (#32487)
>>> 2024-06-23T06:01:40Z
>>> 2024-06-24T05:59:57Z
    8121c9883477cf4350e8dd8abdc3776548c11ea3	https://github.com/servo/servo/pull/32584	Add suppression comments + Suppress lazy_static (#32584)
    62b230e85d18cb3193dd5283aa3073cb161e5e6b	https://github.com/servo/servo/pull/32581	Update web-platform-tests to revision b'f46bf6aa167e2838a8b93501a1a998ffde90d879' (#32581)
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