---
layout:     post
tags:       blog
title:      "This month in Servo: and more!"
date:       2024-11-11
summary:    ao!! wrrrrao!!
categories:
---

<!--
- api features
    - 2024-10-11 toString() method on DOMMatrix and DOMMatrixReadOnly 33792
    - 2024-10-25 ‘transition-behavior: allow-discrete’ 33991
    - 2024-10-27 ‘transition: allow-discrete’ 34005
- layout
    - keyword sizes (‘min-content’, ‘max-content’, ‘fit-content’, ‘stretch’)
        - 2024-10-09 floats 33666
        - 2024-10-11 atomic inlines 33737
        - 2024-10-23 absolute/fixed positioned elements 33950
        - 2024-10-27 intrinsic contributions 33854
    - flex container intrinsic size with inline margins 33780
- fonts
    - async FontKey and FontInstanceKey 33600
    - first font instance creation 33638
    - memory mapping system fonts on macOS and freetype platforms 33747 mukilan
- perf
    - unmultiply_inplace 33553 33584 33582
    - flexbox layout tracing 33647
- architecture
    - single cross-process compositor api 33619 33660
    - servoshell drop --no-minibrowser code path 33677
- webgpu
    - fixed bugs where we present old images 33613
- devtools
    - console firefox 131+ 33661
    - remove iframes from tab list 34032
- outreachy
    - clippy 31500
    - cangc 33683 33684
    - downcasting refactor 33804
- contributors
    - wpt summary 33587
    - `full` and `wpt` no longer test layout 2013. 34048

>>> 2024-09-28T06:11:36Z
c1931ee2cbeb16710388ee7c88e0c209ef1df801	https://github.com/servo/servo/pull/33500	Simplify the data: protocol handler (#33500)	
    a56c837122e76b243e7fadf3b48215af23f199c6	https://github.com/servo/servo/pull/33574	build(deps): bump syn from 2.0.77 to 2.0.79 (#33574)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    a45ff16c47c83152dd47232b3b08fd9fd6d2e57f	https://github.com/servo/servo/pull/33571	build(deps): bump flate2 from 1.0.33 to 1.0.34 (#33571)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    e1b7f2e95ea61d5827ccb37ea8d4bdbbc2349571	https://github.com/servo/servo/pull/33570	build(deps): bump autocfg from 1.3.0 to 1.4.0 (#33570)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    40627334d7abf1649b7791e7f40ffdb3b2213574	https://github.com/servo/servo/pull/33569	build(deps): bump cc from 1.1.21 to 1.1.22 (#33569)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
057dd1e9eb46749f3e38bf7fbbf05392d8fbe1fd	https://github.com/servo/servo/pull/33558	Make ComputedValuesExt expose keywords for the sizing properties (#33558)	
c7ef974968c32d58e6fdd3213965c0f88ee6e4a5	https://github.com/servo/servo/pull/33562	fetch: header tweaks to improve compliance with fetch spec (#33562)	
    f96a62f0cea059677a4f51012bcdf96384485525	https://github.com/servo/servo/pull/33566	Bump sccache-action to v0.0.6 (#33566)	
c519a2cdb68683e2c9b05e54cfd10e022228fb2c	https://github.com/servo/servo/pull/33565	Fix typo on protocol handlers (#33565)	
78370fa6d082f60cd6fe41a24e98fa52e90dbf1c	https://github.com/servo/servo/pull/33563	Fix mach run bustage (#33563)	
+   02953d2fb69413f358210770d10d77efc6d015bd	https://github.com/servo/servo/pull/33553	Move unmultiply_inplace to pixels crate (#33553)	
>>> 2024-09-29T06:07:04Z
f57ae6005684e0fcc6d3edf96141c6400ac54d45	https://github.com/servo/servo/pull/33573	Let protocol handlers decide if they are fetchable (#33573)	
5d269a9036a6c0888627778e9102967e58b1ae6a	https://github.com/servo/servo/pull/33577	Simplify the computation of CAPMIN (#33577)	
d110d8710a7e5e61891810ee7263292b4901a5c8	https://github.com/servo/servo/pull/33575	Don't recompute percentage contribution for table row (#33575)	
>>> 2024-09-30T06:08:52Z
58f34ad7a3db8c633871d568bfcef8b094217e3e	https://github.com/servo/servo/pull/33581	Create HttpStatus to safely deal with HTTP responses status. (#33581)	
    013473f1d5a18f7d99183593ef370045dc58c978	https://github.com/servo/servo/pull/33580	Sync WPT with upstream (29-09-2024) (#33580)	Samson <16504129+sagudev@users.noreply.github.com>
>>> 2024-10-01T06:07:04Z
+   022a95a2cd55617538f2dc841de3a76ef12ad8d9	https://github.com/servo/servo/pull/33582	Optimized unmultiply_inplace to remove fp ops (#33582)	
    9864a02232600e143c5cc3467d62e2542cd3b84a	https://github.com/servo/servo/pull/33594	build(deps): bump cc from 1.1.22 to 1.1.23 (#33594)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    e98f59946e783a7d7fd5aede3af46f85829cbb32	https://github.com/servo/servo/pull/33593	build(deps): bump png from 0.17.13 to 0.17.14 (#33593)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    f85ac40a381b48aee5feced5596e96cb2ef24ef9	https://github.com/servo/servo/pull/33592	build(deps): bump tempfile from 3.12.0 to 3.13.0 (#33592)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    d4ea1ae1d120a7b83c0ebfa8cce68de4f980cba8	https://github.com/servo/servo/pull/33590	build(deps): bump once_cell from 1.19.0 to 1.20.1 (#33590)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    3b08efa516fd1041b83b8bc592693b383a039e62	https://github.com/servo/servo/pull/33591	build(deps): bump regex from 1.10.6 to 1.11.0 (#33591)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
96006daf6e6665dac48ef60e16ccaec3b6988744	https://github.com/servo/servo/pull/33502	use rerun-if-changed in script/build.rs (#33502)	Martin Robinson <mrobinson@igalia.com>
+   1ddfde96ce15687dea84be4e55cee3d381177804	https://github.com/servo/servo/pull/33584	Add a benchmark for for `unmultiply_inplace` in `pixels` (#33584)	
>>> 2024-10-02T05:58:46Z
e534c7d4610807fb1a93f17085ec6ada61a4a342	https://github.com/servo/servo/pull/33588	ohos: Allow passing arguments to servoshell (#33588)	
d7da0563d36d8a6dafecb348ce94ff883242f7cb	https://github.com/servo/servo/pull/33612	Remove unneeded comments about suppressed errors. (#33612)	
c76524e63bee4c00f7b3be26c021e314526f8b3a	https://github.com/servo/servo/pull/33108	Fix panic in webstorage/symbol-props.window.js (#33108)	
    f3e61885023c9ebd0e0505ba5663f74bea546043	https://github.com/servo/servo/pull/33610	build(deps): bump clap from 4.5.18 to 4.5.19 (#33610)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    d83e5a6e3a544b097cb84690c47fe8005476a1dd	https://github.com/servo/servo/pull/33608	build(deps): bump httparse from 1.9.4 to 1.9.5 (#33608)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    d63d975a2e76558defe8b0055f72e2443a6a5f6f	https://github.com/servo/servo/pull/33607	build(deps): bump cc from 1.1.23 to 1.1.24 (#33607)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    a67e921bfa6b56f77976d7b79b71a99981b42c8e	https://github.com/servo/servo/pull/33606	build(deps): bump unicode-properties from 0.1.2 to 0.1.3 (#33606)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
e0aa288dacbaecfb9df7f4d2ef5ff36bd34c748d	https://github.com/servo/servo/pull/33579	Refactor sizing logic for table measures (#33579)	
+   abad89a49c1fbad584627deaa7440f50a5cc9912	https://github.com/servo/servo/pull/33600	fonts: Make `FontKey` and `FontInstanceKey` generation asynchronous (#33600)	
05ecb8eddb3989ffcee51df5c2c86887fee8b7e8	https://github.com/servo/servo/pull/33521	webgpu: renovate gpucanvascontext and webgpu presentation to match the spec (#33521)	
    0b2549f4cbf84279580e7792f261da0965d97225	https://github.com/servo/servo/pull/33545	build(deps): bump fdeflate from 0.3.4 to 0.3.5 (#33545)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
5b8f3015c0193008d322b6d87656a5867dfac40e	https://github.com/servo/servo/pull/33598	Add OpenHarmony to supported platforms in Readme. (#33598)	
    5ee8e2e55b9726015b0cd3d21f4f4f9b084a5b67	https://github.com/servo/servo/pull/33596	CI: increase self-hosted runner timeout from 30 to 120 seconds (#33596)	
>>> 2024-10-03T06:15:38Z
c7a4e4f627f0bf331cedc1700ddeb92ffcba4e78	https://github.com/servo/servo/pull/33611	net: Refactor `Decoder` (#33611)	
    c682172440e2010ddd7e225463e81ddb175ebd81	https://github.com/servo/servo/pull/33623	build(deps): bump async-stream from 0.3.5 to 0.3.6 (#33623)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
+   6d4438808a95f78a2a35e749a8c65e5265b64602	https://github.com/servo/servo/pull/33587	do WPT reports as GitHub job summery (#33587)	Martin Robinson <mrobinson@igalia.com>
    56f0abeb8961bb0481c44cb7cf9f7fedd51d2938	https://github.com/servo/servo/pull/33618	clippy: Fix warnings in components/devtools/actors/inspector (#33618)	
88dad77483e05560dead8e8d64252e756cea1422	https://github.com/servo/servo/pull/33597	Compositor: add document id to NewWebRenderFrame variant (#33597)	
>>> 2024-10-04T06:12:51Z
    e1eca71cd175dc8662ecf33f7a782eb3d0fe2364	https://github.com/servo/servo/pull/33641	build(deps): bump hilog-sys from 0.1.1 to 0.1.2 (#33641)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    1170124678c0d091681816b6f58993ee14da6935	https://github.com/servo/servo/pull/33640	build(deps): bump async-compression from 0.4.12 to 0.4.13 (#33640)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
9fcfe09e5185f05af02f617c4a2bd934c29344dc	https://github.com/servo/servo/pull/33621	ohos: Add toast prompt (#33621)	
+   f2f5614ad64927aa82aa8937ae14a6086df49d2b	https://github.com/servo/servo/pull/33619	compositor: Create a single cross-process compositor API (#33619)	
    986c3a38a3ae257499c78ce21a50f689faa10c3b	https://github.com/servo/servo/pull/33632	Permitted functions to have too many arguments in components/script/dom (#33632)	
    43d559a1c2510c9244b1592e5ac33f2e8e8732a7	https://github.com/servo/servo/pull/33631	replaced `.map` with `.and_then` and removed `.flatten()` (#33631)	
634dbd2d7861225181c58416ecda11d04498377e	https://github.com/servo/servo/pull/33627	Replace `ShouldNotImplDomObject` with `NoDomObjectInDomObject` (#33627)	
    cd803c83419fe90960eac4dfefec062202837ad8	https://github.com/servo/servo/pull/33625	clippy: Fix warning in components/compositing (#33625)	
    163e47766841725201f683495f4506f35fc9614c	https://github.com/servo/servo/pull/33630	Less `allow(crown::unrooted_must_root)` in bindings (#33630)	
>>> 2024-10-05T05:57:21Z
20eb9278439b011db278deac65a5e364c4c6d6b3	https://github.com/servo/servo/pull/33635	chore: Update wgpu again (#33635)	Martin Robinson <mrobinson@igalia.com>
    57d96653eb46fbb66bd11f54d9129cebcda6ac43	https://github.com/servo/servo/pull/33652	build(deps): bump addr2line from 0.24.1 to 0.24.2 (#33652)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    73a0aef7a4ae4fdd677223683d47742d70f8595b	https://github.com/servo/servo/pull/33651	build(deps): bump object from 0.36.4 to 0.36.5 (#33651)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    37cd910e7993d385636301eebd642cb4e51b9ae8	https://github.com/servo/servo/pull/33650	build(deps): bump gimli from 0.31.0 to 0.31.1 (#33650)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    4850caeec49b22e9c4e9618185408882ad76832c	https://github.com/servo/servo/pull/33648	clippy: Fix too_many_arguments warnings (#33648)	
+   2234bc56a54c488d39762060b4dbd3e613c8174b	https://github.com/servo/servo/pull/33638	fonts: Eliminate overhead of first font instance creation (#33638)	
    ec05be6300075bcb9fb22df0c1eb941075e9d454	https://github.com/servo/servo/pull/33646	clippy: Fix `too_many_arguments` in `components/layout_thread_2020` (#33646)	
    48f8ff62363e466905279f34c32770e4af17b3cb	https://github.com/servo/servo/pull/33645	Revert "compositor: Create a single cross-process compositor API (#33619)" (#33645)	
    826e31eaa58bbc6c6542c2e1cb5f7d37a07d2e98	https://github.com/servo/servo/pull/33642	build(deps): bump unicode-bidi from 0.3.15 to 0.3.17 (#33642)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    f55e7778883fba0d02ee7a08a737d701403dcd78	https://github.com/servo/servo/pull/33643	clippy: Fix let binding in components/fonts/font_context.rs (#33643)	
    03b8034f6805a2ffdd0d44f59461dc3948c62565	https://github.com/servo/servo/pull/33633	clippy: Fix several warnings in `components/script` and `components/webgpu` (#33633)	
+   6e043cd09ed76c0bb4fa92cea2693dc70f42ba52	https://github.com/servo/servo/pull/33613	webgpu: Introduce PresentationId to ensure updates with newer presentation (#33613)	
>>> 2024-10-07T05:58:26Z
    f8933a57353aeca14a6cbc60b3cb0cf98cab6c5d	https://github.com/servo/servo/pull/33668	Sync WPT with upstream (06-10-2024) (#33668)	Josh Matthews <josh@joshmatthews.net>
ea84f7b135fa4341908b2000aefe18a6907f2994	https://github.com/servo/servo/pull/33659	Enable `stretch` keyword (#33659)	
    0a5540f6a49d3873a5a3c54dd0bc2336cf0b2974	https://github.com/servo/servo/pull/33653	clippy: Fix warnings in `components/script` & `components/webgpu` (#33653)	
ad8ba49d2cca9de554a9baa3c81188da91b7ec13	https://github.com/servo/servo/pull/33658	Skip anonymous blocks for percentage resolution (#33658)	
+   719b5aba24e25b41e87751ca1ad1b130229528ae	https://github.com/servo/servo/pull/33647	tools: Improve instrumentation and add it for some layout (#33647)	
>>> 2024-10-08T06:08:00Z
    d200557434458322260c99747db601c849940ce8	https://github.com/servo/servo/pull/33697	build(deps): bump futures-io from 0.3.30 to 0.3.31 (#33697)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    b4ef1340af893ce351d18d944e3a63f718ed3ce2	https://github.com/servo/servo/pull/33699	build(deps): bump ab_glyph from 0.2.28 to 0.2.29 (#33699)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
7bcc288cd92364ccec376383cdc9d3e56f7e556f	https://github.com/servo/servo/pull/33688	layout: Avoid double negation in `CellLayout::is_empty_for_empty_cells()` (#33688)	
    628ca03a800d4a562bc9d46279e0b7929317c49c	https://github.com/servo/servo/pull/33695	build(deps): bump proc-macro2 from 1.0.86 to 1.0.87 (#33695)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    028026bebe992431ede7c57b7e3065616d859026	https://github.com/servo/servo/pull/33689	Fixed some clippy warnings in components/script and components/devtools (#33689)	
53d24bb9ea5e3689dd928c1254af55fb2d90f164	https://github.com/servo/servo/pull/33657	fix: disable automatic reseeding (#33657)	
    2642f3ce338f5750c5cbc8878a29f8dffe832921	https://github.com/servo/servo/pull/33686	fix default implementation warning in components\script\dom\identityhub.rs (#33686)	
433f48741b03f1ddf25008265138a9d21569e123	https://github.com/servo/servo/pull/33667	Fix `align-content` set to `start` or `end` on flexbox (#33667)	
+   6aaca118a90913b34551840cf02489ad29ee75ff	https://github.com/servo/servo/pull/33677	Drop support for '--no-minibrowser' mode (#33677)	
    38251fe5e79e66cd4f3753b87a14f5240b665ed1	https://github.com/servo/servo/pull/33664	clippy: Fix collapsible_match warning in components/shared (#33664)	
>>> 2024-10-09T06:09:25Z
    a2b27012a5e7e312345afc2d79ba995af9f5e68b	https://github.com/servo/servo/pull/33724	clippy: Use `flat_map` instead of `map` in `components/devtools` (#33724)	
    589f0d701845f10753881af6d827138bf0354b74	https://github.com/servo/servo/pull/33740	Fix clippy warning: slow zero-filling initialization (#33740)	
    476ebb92fbf9cd5e54b778cbe853be8d87bc0d10	https://github.com/servo/servo/pull/33727	clippy: Fix `type_complexity` warning in `components/script/dom` (#33727)	
    5079552f93a126f6a940b39751787a60b894215d	https://github.com/servo/servo/pull/33700	build(deps): bump cc from 1.1.24 to 1.1.28 (#33700)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    3c805cd588f47ab05eb15d6e472c8fa8771ebdf6	https://github.com/servo/servo/pull/33735	build(deps): bump clap from 4.5.19 to 4.5.20 (#33735)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    5c6ac23a7a3b8f161f5602d8ee1181352be04563	https://github.com/servo/servo/pull/33734	build(deps): bump once_cell from 1.20.1 to 1.20.2 (#33734)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    217a9e191752f6e657b71d83b8c71d1cd70d7be6	https://github.com/servo/servo/pull/33733	build(deps): bump futures-executor from 0.3.30 to 0.3.31 (#33733)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    bc84dfbae5d73d9951337411d92885cfdc08d6b9	https://github.com/servo/servo/pull/33729	Fix: Add missing transmute annotations in Castable trait (#33729)	
    e8e51b13735c2ff3e36b80743848dc7e92140731	https://github.com/servo/servo/pull/33730	Clippy: fix clone_on_copy in components\script\dom\cryptokey (#33730)	
    609a6ef0f46f2777c4c3edf0dabef5d233f0044a	https://github.com/servo/servo/pull/33728	fix(clippy): add missing annotations for transmute usage in root.rs (#33728)	
+   c1b744b2b2c37cdb119a3d3f761822d22f938339	https://github.com/servo/servo/pull/33666	Implement keyword sizes on floats (#33666)	
    39133a547846ead67be0d8ad7dac026cb318dd2d	https://github.com/servo/servo/pull/33692	Replace CanGc::note() calls with arguments in `components/script/dom` (#33692)	
    38c5ebbf8e52aebe5155c80fa1ea4da81838d7de	https://github.com/servo/servo/pull/33685	clippy: Fix warning in `components/script/dom` (#33685)	Martin Robinson <mrobinson@igalia.com>
    9862df877ddf66ac44355204781fd8bd76c39dff	https://github.com/servo/servo/pull/33705	Fix clamp-like pattern warning in font.rs (#33705)	
    77f7b43548ca8450e663ce456c59a44c723235ec	https://github.com/servo/servo/pull/33690	clippy: Fix large size difference between variants of `ScriptToCompositorMsg` (#33690)	Martin Robinson <mrobinson@igalia.com>
76cdb0173e853ec28cd7b8b7802b002303fc84b8	https://github.com/servo/servo/pull/33696	Remove dead (and incorrect) logic about vertical overconstrainment (#33696)	
    72eeebe311c65fcdee2c2f4679a9b0121146429b	https://github.com/servo/servo/pull/33707	Fix large enum variant warning in serviceworker_manager.rs (#33707)	
dcedfab44fed6b0b330bc60b09f86cb6f094a71c	https://github.com/servo/servo/pull/33711	Attempt to link to MPL-2.0 license page in Windows installer (#33711)	
    fd8ed6c44dfec60557fef7f0d77cc2c9c1fe8a04	https://github.com/servo/servo/pull/33698	build(deps): bump futures-util from 0.3.30 to 0.3.31 (#33698)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    4a53dd9708049776d0def353714052ce4d001e21	https://github.com/servo/servo/pull/33703	build(deps): bump pin-project from 1.1.5 to 1.1.6 (#33703)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    ad409e644484a03815953d848262aa02fcd898c8	https://github.com/servo/servo/pull/33704	build(deps): bump bytemuck_derive from 1.7.1 to 1.8.0 (#33704)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
457d8a8a5c720fbf5624a95d86ac53f2aee342e8	https://github.com/servo/servo/pull/33531	Bring `http_network_or_cache_fetch` closer to the spec (#33531)	
fc0d4d8157c71c512817886bc3b8d1adad5d46a9	https://github.com/servo/servo/pull/33628	crypto: Begin SubtleCrypto implementation (#33628)	
66bc430b24a0cb1fe2d51e2b5983ea8833ba22b9	https://github.com/servo/servo/pull/33713	Sorted Bindings.conf alphabetically (#33713)	
    d3c0785d64f0186a31f38308d31c6eee4b577210	https://github.com/servo/servo/pull/33706	Various CanGc fixes in components/script/dom  (#33706)	
7d931e673af2780f3f62d52cb17324ec2cc68c71	https://github.com/servo/servo/pull/33665	script: Include constructors and static methods in generated DOM traits (#33665)	
946fa9cdee68bb834a3b75821e8e7f94cf86d31c	https://github.com/servo/servo/pull/33719	ohos: pin version of setup-ohos-sdk action to fix CI (#33719)	
>>> 2024-10-10T06:03:33Z
    0c4720140fe71eed8760fa7ab1d39e024fc56d27	https://github.com/servo/servo/pull/33757	Fixed some clippy warnings in components/script/dom (#33757)	
    9a8e7f4867c2e6c54dec9cba3b3766f52ba8117f	https://github.com/servo/servo/pull/33771	clippy: Fix warnings in components/script/dom (#33771)	
    67edd5683be8ece49db2049ffd09f9b508b73dd9	https://github.com/servo/servo/pull/33766	build(deps): bump dwrote from 0.11.1 to 0.11.2 (#33766)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    f6ec73bc1d2304020011f508e23d7bfd5db3283c	https://github.com/servo/servo/pull/33764	build(deps): bump bindgen from 0.69.4 to 0.69.5 (#33764)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
+   9195344b75b4e5fd1cd86671b10df46a956f0fea	https://github.com/servo/servo/pull/33660	compositor: Create a single cross-process compositor API (#33619) (#33660)	
30cbf01280dc3aa03caeaba11f55808f7ba59cf3	https://github.com/servo/servo/pull/33758	Rename first_contained_child & last_contained_child to first_partially_contained_child & last_partially_contained_child (#33758)	
5ba8054b69e3f9867cecde89a18bf0f134d6f276	https://github.com/servo/servo/pull/33614	refactor `CGClassConstructHook` to use handwritten constructors (#33614)	
3eee02869a8a9673a52d807c737e4c203d32b1b7	https://github.com/servo/servo/pull/33715	Fix test timing for all tests using xr_promise_test (#33715)	
+   af61b1a1074037a36b803357fb03ea72ee01ae66	https://github.com/servo/servo/pull/33661	DevTools: Fix console in Firefox 131 (#33661)	
a6da1daa126705fcb7393d605e4844640e4fefe0	https://github.com/servo/servo/pull/33745	Cleanup FontContext privacy (#33745)	
    4d200a43483296aa57f2c2ddf37bfdbaede346bc	https://github.com/servo/servo/pull/33749	Use `--break-system-packages` when running pip in the WPT export job (#33749)	
    c430645606396a300b57a4d9c909db959486ca4c	https://github.com/servo/servo/pull/33755	ci: pin the ubuntu runner version in lint job. (#33755)	
    623bcde11132ccd9bcd9b46a1f21a4a55aafe2b0	https://github.com/servo/servo/pull/33744	Fix Clippy warning: Replace map().flatten() with and_then() in http_loader.rs (#33744)	
7df18aecfe18c6e30adae5632035bb687a537388	https://github.com/servo/servo/pull/33681	Upgrade Android Gradle (#33681)	
ff6523c37e132605c0945bdc49f15b75b0566d2e	https://github.com/servo/servo/pull/33717	Fix handling of `__Secure-` and `__Host-` Cookie prefixes (#33717)	
>>> 2024-10-11T05:56:24Z
    88f1d9dd5e09442e1a1806d231dc074b37633716	https://github.com/servo/servo/pull/33782	clippy: Refactor `script/dom/globalscope.rs` to avoid overly complex types (#33782)	
    2b71130a8a95d0c723532d2486493b5db0c9e1b1	https://github.com/servo/servo/pull/33800	Various CanGc fixes (#33800)	
+   c00c6e728ddb82d6cb646eb924a73c4b43a798a4	https://github.com/servo/servo/pull/33792	Implement DOMMatrix `stringifier` (#33792)	
fc2c77be8363759657b50992b93d08d40f8fbf1b	https://github.com/servo/servo/pull/33794	Use NaN-safe comparisons in DOMQuad::GetBounds (#33794)	
f15da16da403b4b5510e7722b555ee0c0c1f3de4	https://github.com/servo/servo/pull/33796	Update DOMMatrix::is2D when modifying elements (#33796)	
+   0553789d4839c4bf750f386f3f07a71b4a21f38e	https://github.com/servo/servo/pull/33747	fonts: Instantiate system fonts using system font loaders (#33747)	Mukilan Thiyagarajan <mukilan@igalia.com>
    4564ce2fcc970d213dc8c109ab8f02a959254046	https://github.com/servo/servo/pull/33793	build(deps): bump wasm-bindgen from 0.2.93 to 0.2.95 (#33793)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
+   091b8ecda0e509cfc49f546294f23180303892d0	https://github.com/servo/servo/pull/33780	layout: Handle inline margins in `layout_for_block_content_size()` (#33780)	
    81ce12b23aab15ecaede17b79ae96c5aac07a28e	https://github.com/servo/servo/pull/33788	build(deps): bump async-compression from 0.4.13 to 0.4.14 (#33788)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
1668b12ded143ee670b80417d38bc3cf5cb46167	https://github.com/servo/servo/pull/33783	Replace some `Point2D::new(0, 0)` instances with `Point2D::zero()` (#33783)	
b58cee48cefef80417babd76ec087e1219a914b8	https://github.com/servo/servo/pull/33775	doc(resources): `Preferences`, `HstsPreloadList`, `RippyPNG` (#33775)	Martin Robinson <mrobinson@igalia.com>
fd19409f31c038b5b89c7ed4b73ebabcfd241355	https://github.com/servo/servo/pull/33751	Upgrade to `egui@0.29.1` and `winit@0.30.5` (#33751)	Martin Robinson <mrobinson@igalia.com>
6b3a316e1bc31aaf4938bc093b5b4c72a7fadf86	https://github.com/servo/servo/pull/33746	Remove most usage of ReentrantMutex in font code (#33746)	
    a591778a25b85e236aff9a7966754ac16ce0864f	https://github.com/servo/servo/pull/33709	Improve `Au(0)` constructions (#33709)	
    c6d305fbb32dcda968b5f7501796137252d9d643	https://github.com/servo/servo/pull/33781	fix clippy warnings in codegen (#33781)	
    f9a06d62a2757eefc729f2126a0d50afa919399f	https://github.com/servo/servo/pull/33774	More CanGc fixes: Range, Event, gpu error, Header (#33774)	
+   8c56cbdab207239e4f05b253970e16e75b0a3958	https://github.com/servo/servo/pull/33737	Implement keyword sizes on atomic inlines (#33737)	
52cddb45bdba037b6016e7183ee68036bc36fbe5	https://github.com/servo/servo/pull/33754	Use `content_box_sizes_and_padding_border_margin_deprecated()` in `FlexItem::new()` (#33754)	
    6f87c38cda290a46148102b124a82fe786c0bcbe	https://github.com/servo/servo/pull/33762	clippy: Rename various methods and members to conform to naming guidelines (#33762)	
2805d3ce149fac5786b96d83cdbb2d50583bc75d	https://github.com/servo/servo/pull/33773	Fix writing mode in `content_box_sizes_and_padding_border_margin()` (#33773)	
bd27e64cd846c72db90937c7e0fafa64712ec5df	https://github.com/servo/servo/pull/33750	fix possible IndexError (#33750)	
7cd73ef4a7634b3e8f716451681b708d1dcc6acb	https://github.com/servo/servo/pull/33769	use `ThreadSafeJSContext` instead of `ContextForRequestInterrupt` (#33769)	
61a930402d5ac1f03530d7506960b8a04cfb974a	https://github.com/servo/servo/pull/33770	Update Servo user agent strings (#33770)	
>>> 2024-10-11T11:46:23Z
febe7de0bfa2ae3aa8add6670d712db3145c6438	https://github.com/servo/servo/pull/33801	ohos: publish nightly builds (#33801)	
>>> 2024-10-12T05:57:02Z
    e5e1ef9fb6eb0c225ad69b3a7009a82aac08ba60	https://github.com/servo/servo/pull/33816	Replace CanGc::note() calls with arguments in `components/script` (#33816)	
a86dcfc6e7e163ebc084d69fedc32a368ef7e202	https://github.com/servo/servo/pull/33802	Unify logic for laying out floats and atomic inlines (#33802)	
    0eb8d22d88626ec576e01a2254cbbf70366533ee	https://github.com/servo/servo/pull/33815	build(deps): bump webxr from `845ae9c` to `e3249c3` (#33815)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    3b4a1ab8dd5fd6f613d5778dd8f8c172e6187bdc	https://github.com/servo/servo/pull/33814	build(deps): bump web-sys from 0.3.70 to 0.3.72 (#33814)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    afbfad2f63e26cae1641a777dd3d92a8bc9abb11	https://github.com/servo/servo/pull/33813	build(deps): bump cc from 1.1.28 to 1.1.29 (#33813)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    1167c8245acb9a03aec202e57cbbfaa65377e525	https://github.com/servo/servo/pull/33810	build(deps): bump glow from 0.14.1 to 0.14.2 (#33810)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    d89d1490aec906ff2b0a86e71477b84caf7f752e	https://github.com/servo/servo/pull/33812	build(deps): bump js-sys from 0.3.70 to 0.3.72 (#33812)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    e09362cd3cd00b7d7818dbc25d4a1525e652c7dd	https://github.com/servo/servo/pull/33809	clippy: Fix issues in `components/fonts` and `ports/servoshell` (#33809)	Martin Robinson <mrobinson@igalia.com>
    20a15619f0461bb44e8dfc3e81ff20d9d2d4fd9d	https://github.com/servo/servo/pull/33808	CanGc fixes starting from imagedata.rs (#33808)	Josh Matthews <josh@joshmatthews.net>
+   27b25e869bc6d8d1b42da655895c27dc3c08f211	https://github.com/servo/servo/pull/33804	content: Replace uses of `downcast`+`is_some`/`is_none` with `is` (#33804)	
c5899e596dd068360efe3b290203ac7f4c9c3e5a	https://github.com/servo/servo/pull/33798	Implement DOMRect::FromRect (#33798)	
    8843a0e400745787faf4a23213cbfdf7e2158c73	https://github.com/servo/servo/pull/33790	clippy: Fix `type_complexity` warnings in `components/script/dom` (#33790)	
2a6cfbaaf90a2c0f821473ea59c05ea1332d3f1d	https://github.com/servo/servo/pull/33803	Throw NotSupported error and update expected results for XRSession::UpdateRenderState (#33803)	
>>> 2024-10-14T06:06:27Z
    717baff17b651606e3e7bf53ba20dc00ae996a38	https://github.com/servo/servo/pull/33818	Fixed same_enum_variation clippy warnings in components/script/dom (#33818)	
    fc0835bae3dc28b17e6002e0594d6112517ff61d	https://github.com/servo/servo/pull/33827	CanGc fixes in focusevent.rs oscillartornode.rs response.rs resizeobserversize.rs animationevent.rs (#33827)	
    92f12ff7cda3d3da667d2358ab3867b1dcc5b9a2	https://github.com/servo/servo/pull/33822	Propagate CanGc through dommatrix, dommatrixreadonly, and testbindings (#33822)	
bdd5fb2e5b12a442a553b708c36adfed5cbf76c3	https://github.com/servo/servo/pull/33825	Use document encoding when parsing url in href setter (#33825)	
    76776bf082982e213f7ae14fdd2885b316716b96	https://github.com/servo/servo/pull/33826	Update web-platform-tests to revision b'c7076ab2397dd3dcf0bb93dc304d05be04cd2a47' (#33826)	
ded518dfd0a22d6e6b8bec8a59e8498f18124616	https://github.com/servo/servo/pull/33824	Remove some fixed fixmes (#33824)	
f0285fc7e5c2d834f18f551b10fb46989c565cdf	https://github.com/servo/servo/pull/33823	CI: pin ubuntu 22.04 in WPT Import (#33823)	
efaba0472a424256fa008d288b870f499b42f2ab	https://github.com/servo/servo/pull/33739	CI: Bump setup-ohos-sdk to v0.1.4 (#33739)	
    5c0a0d29d0731147f367195ec3b568768c114455	https://github.com/servo/servo/pull/33821	clippy: Fix warnings in `components/script` & `components/script/dom` (#33821)	
    a55f9a37ecc81a0b18731b0e1985c7efa10b01a9	https://github.com/servo/servo/pull/33820	CanGc fixes starting from blob.rs, mediastream.rs, custom_event.rs (#33820)	
bd8006afc5b29530bc4eb1d310490a345b8283fc	https://github.com/servo/servo/pull/33819	Update wgpu (#33819)	
>>> 2024-10-15T06:10:13Z
    2f1862aaf5771c3a8416d524c4a6dca1cac4d99e	https://github.com/servo/servo/pull/33842	build(deps): bump cc from 1.1.29 to 1.1.30 (#33842)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    81e8e582df814aa64ff4409e43778196f19ac83b	https://github.com/servo/servo/pull/33841	build(deps): bump profiling from 1.0.15 to 1.0.16 (#33841)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    f6ebb8eaf1e12af4623e903de39e6ddebb4c7757	https://github.com/servo/servo/pull/33839	build(deps): bump bytemuck from 1.18.0 to 1.19.0 (#33839)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    223e01ed9ea3036542cfc54722119b6e7929b158	https://github.com/servo/servo/pull/33838	build(deps): bump wasm-bindgen-futures from 0.4.43 to 0.4.45 (#33838)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    aedad3272652efe8b2a6f76a046fb2398874c033	https://github.com/servo/servo/pull/33837	build(deps): bump async-compression from 0.4.14 to 0.4.15 (#33837)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
b9ed45942d7b22d658955e9bcdd3db0bad1bba99	https://github.com/servo/servo/pull/33806	Avoid recomputing inline_content_sizes() when not needed (#33806)	Martin Robinson <mrobinson@igalia.com>
821bed1d11c289dfd14026f4edb431a223c9e4d6	https://github.com/servo/servo/pull/33817	Fix headless mode on Windows (#33817)	
9508b83af6589d661de620dabb6c2bd08c453325	https://github.com/servo/servo/pull/33480	fix intermittency of child-document-raf-order test (#33480)	
    cfd15dd14df2e8e6374e25c0a579be0404dbb28b	https://github.com/servo/servo/pull/33828	CanGc fixes originating from `gamepadevent.rs` & `stereopannernode.rs` (#33828)	
2322b22a6bb62b73fe283e52265af6fbe67d2751	https://github.com/servo/servo/pull/33834	CI: temporarily disable self-hosted runners for nightly.yml (#33834)	
0d3fad156a026c1e3f8595361faa71cf4295cd9a	https://github.com/servo/servo/pull/33833	Add python3-setuptools to ubuntu apt install line (#33833)	
>>> 2024-10-16T06:08:12Z
ed959d7a1a2a584803f689ce8d92f7d0c3c0d48b	https://github.com/servo/servo/pull/33830	Implement fetch metadata headers (#33830)	
    a2f81d69c1971f07c2af8633756953ddd70a1bb5	https://github.com/servo/servo/pull/33852	CanGc fixes (#33852)	
    5b8fbb023dfba890c7744e826a077776516131c6	https://github.com/servo/servo/pull/33850	build(deps): bump rustversion from 1.0.17 to 1.0.18 (#33850)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
564478ef0da52d98d93fd6acf2526f9ece9b107f	https://github.com/servo/servo/pull/33844	Remove SizeKeyword, merge it into Size (#33844)	
    c37fb2e45300a58e97fcc7d2f00ecf7db1f0fc72	https://github.com/servo/servo/pull/33835	clippy: Fix `type_complexity` warning in `components/script/dom` (#33835)	
    b088a8b8f1aa6f42bdb9061ec58a30249149e7ec	https://github.com/servo/servo/pull/33840	Fix Clippy warning: remove unneeded late initialization of string (#33840)	
    46d6c0c883750de2f57bba8da3eb199b01a9761f	https://github.com/servo/servo/pull/33843	CanGc fixes in components/script/dom (#33843)	
    1e39787573e180801ed70c3f708ebb22631eeeb9	https://github.com/servo/servo/pull/33836	CanGc fixes and checks in multiple files (#33836)	
>>> 2024-10-17T06:10:55Z
fc569260d201dd947aff1d9aa2e824c95fa26f2a	https://github.com/servo/servo/pull/33874	ci: Fix the WPT export job again by removing `--break-system-packages` (#33874)	
    066d3103bb82c75d6a50138aa5564e1ff9aca468	https://github.com/servo/servo/pull/33870	build(deps): bump async-compression from 0.4.15 to 0.4.16 (#33870)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    133c763e650a60928c288b379cec2e30c142c489	https://github.com/servo/servo/pull/33869	build(deps): bump napi-derive-ohos from 0.0.9 to 1.0.0 (#33869)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    ccac50fc91e61c36698c97beacde8138dfd3de7c	https://github.com/servo/servo/pull/33867	build(deps): bump proc-macro2 from 1.0.87 to 1.0.88 (#33867)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
036e74524a72920ffca6deb4d6a850cf04b31736	https://github.com/servo/servo/pull/33863	net: Start reducing number of IPCs channels used for fetch with a `FetchThread` (#33863)	
21152673282b7ac03cee5d97d46fe368b379a297	https://github.com/servo/servo/pull/33731	Add missing XRWebGLBinding constructor spec steps (#33731)	
    cde6931f4bcb6832d3fbd37c3930b63e759cc279	https://github.com/servo/servo/pull/33860	clippy: Fix warnings in `components/script/dom` (#33860)	
    a646c850c6f7dcaf64ad286342b654ffdbebd274	https://github.com/servo/servo/pull/33853	clippy: Fix warnings in `components/script/dom` & `components/servo` (#33853)	Mukilan Thiyagarajan <mukilan@igalia.com>
    b0a33d6b0212be325f3c5551869be80904c24892	https://github.com/servo/servo/pull/33865	Some CanGc Fixes (#33865)	
    2b9527262c5700473af6fb2b193f84596bedc0de	https://github.com/servo/servo/pull/33862	CanGc fixes in components/script/dom (#33862)	
5148b444be5490d0fd9123d7248216856efd568d	https://github.com/servo/servo/pull/33861	Minor cleanup for `Size` after #33844 (#33861)	
2e0fbfcb951c570cd7fa6f65b9b1c659dc4fba9c	https://github.com/servo/servo/pull/33857	Fix GC borrow hazard in XRInputSourceArray (#33857)	
fa1f7e5839a35019d5ac2f105a45b555292b74fd	https://github.com/servo/servo/pull/33845	Gate all use of `tracing` behind Cargo feature (#33845)	
103d3aa7bb6341957c31a1aae4f925068e39e951	https://github.com/servo/servo/pull/33848	Avoid wrapping line at the start of text run with `text-wrap-mode: nowrap` (#33848)	
    0a71c736f08fafb68d453133379dcc458fe4ac85	https://github.com/servo/servo/pull/33849	clippy: fix clippy warnings in `components/script` (#33849)	
    30abb99287790c2653821cc469ecd891b89ab57c	https://github.com/servo/servo/pull/33748	clippy: Add safety documentation and clean up unsafe methods (#33748)	
>>> 2024-10-18T06:07:54Z
41fd39a128134228e9bf66ffbc6e24fb4063b711	https://github.com/servo/servo/pull/33885	doc(resources): Add documentation to undocumented `embedder_traits::resources::Resource` variants (#33885)	Josh Matthews <josh@joshmatthews.net>
    f826698d6e5483f18d13a9f104e0645ee31bb8d9	https://github.com/servo/servo/pull/33891	CanGc fixes in components/script/dom (#33891)	
    9c893c7f4def4ffa635587ea85d5e4c3ba6ecac3	https://github.com/servo/servo/pull/33888	More CanGc fixes (#33888)	
    720d6321707722062647914885e398d4eb1e53c9	https://github.com/servo/servo/pull/33889	build(deps): bump serde_json from 1.0.128 to 1.0.129 (#33889)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    f6a77b905f36958688a3885094fdca02cb5e3815	https://github.com/servo/servo/pull/33886	build(deps): bump rustfix from 0.8.5 to 0.8.6 (#33886)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    781a9613798e567a157ea16244a8147c5b4ed3db	https://github.com/servo/servo/pull/33884	build(deps): bump libc from 0.2.159 to 0.2.160 (#33884)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
4a58616770214ead82da015f375fc5df59ad648c	https://github.com/servo/servo/pull/33882	Fix type mismatches in Router::add_route calls (#33882)	
    595aab10dccb3603bf60ff25eb45c4715a75ecb9	https://github.com/servo/servo/pull/33878	fix clippy warning in components/script (#33878)	
    cd7b66be58e289faa5a605856500bb1ebd0773bf	https://github.com/servo/servo/pull/33880	CanGc fixes in components/script/dom (#33880)	
72ff89620bbcc03b1534a092f65e526909df3a4a	https://github.com/servo/servo/pull/33873	Handle multibyte characters in img srcset (#33873)	
    2d796a27192c86e03cde078a506a0a8c07ca41b6	https://github.com/servo/servo/pull/33868	build(deps): bump uuid from 1.10.0 to 1.11.0 (#33868)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
>>> 2024-10-19T06:08:05Z
a008b6fc73fa0ad36686aa1a523defee07191e84	https://github.com/servo/servo/pull/33875	Fix GC borrow hazard in ResizeObserver::broadcast_active_resize_observations (#33875)	
73880ee1d0659ffa097a28a6314ef2826db0e30f	https://github.com/servo/servo/pull/33907	Remove BoxFragment::overconstrained (#33907)	
09fc988d3ab00c54abaaa95ac12d081502ea63d8	https://github.com/servo/servo/pull/33906	Fix resolved value of insets to use margin box instead of content box (#33906)	
    e667d2fa1b9650b2574bf5da481665c3858cd3ec	https://github.com/servo/servo/pull/33905	build(deps): bump serde_json from 1.0.129 to 1.0.130 (#33905)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
70845698f241f634badb9d2482535123edc3b58e	https://github.com/servo/servo/pull/33846	update test expectations for update-rendering (#33846)	
    b85093ad7461122447298d91acd19040c31c42a9	https://github.com/servo/servo/pull/33902	Prevent moving CanGc values between threads/tasks (#33902)	
a58da5aa832a67c827021592fe0397a532491c4c	https://github.com/servo/servo/pull/33538	Update to surfman&webxr without sparkle and use glow 0.15 (#33538)	
    f73ae0414bd7381c5a97b141c706a76634d142fc	https://github.com/servo/servo/pull/33901	build(deps): bump anyhow from 1.0.89 to 1.0.90 (#33901)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    1bda5a6eabfb6f9ae9dbad2b914a60c040a34d6d	https://github.com/servo/servo/pull/33899	build(deps): bump libc from 0.2.160 to 0.2.161 (#33899)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    0cb30153a6494c2ebe708e43686f6680281453ed	https://github.com/servo/servo/pull/33896	build(deps): bump gstreamer from 0.22.7 to 0.22.8 (#33896)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    1ae90dcd95125133a266781828b0bfc47a681bbf	https://github.com/servo/servo/pull/33894	clippy: Fix a variety of clippy warnings in `fonts`, `layout_2020` and the DOM code (#33894)	Martin Robinson <mrobinson@igalia.com>
    af6154cf630bd498f8b5afbd8a321eb4a45463b6	https://github.com/servo/servo/pull/33892	More files with CanGc fixes (#33892)	
    fde8d72acabb6f8314efe0e66312c02a488a7613	https://github.com/servo/servo/pull/33893	Various CanGc fixes in 8 files (#33893)	
    6b87ecc291b08559cd2bbda8e4902f70a0fd0c7c	https://github.com/servo/servo/pull/33895	Some CanGc fixes in components/script/dom (#33895)	
e33bae6d0a172de3e652b9b515bda97c6c4f5af2	https://github.com/servo/servo/pull/33866	Use `ROUTER::add_typed_route` instead of `ROUTER::add_route` everywhere (#33866)	
    ff374c1428bbcca76c9ba6f565e7e5ccdbf4fc10	https://github.com/servo/servo/pull/33881	clippy: Rename `RequestId::new()` to `RequestId::next()` and fix one more issue in `servo/lib.rs` (#33881)	
    14cfcda3b3dc8a0421b9dcc5bca8b93a91734bad	https://github.com/servo/servo/pull/33890	build(deps): bump orbclient from 0.3.47 to 0.3.48 (#33890)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>	Mukilan Thiyagarajan <mukilan@igalia.com>
>>> 2024-10-20T06:08:59Z
    d0d02cd56cb646da1f2193e57561b78d5e4b6bdf	https://github.com/servo/servo/pull/33923	Update web-platform-tests to revision b'5a9d9349a312e12a950d5f4703cd41609a06f242' (#33923)	
c242822eebb75bcf0b0e10102d3cc49e9044a658	https://github.com/servo/servo/pull/33904	Fix GC borrow hazard in HTMLImageElement::finish_reacting_to_environment_change (#33904)	
    2af81fb09732fac71c38f4e261e29803f490b0ea	https://github.com/servo/servo/pull/33913	build(deps): bump serde_json from 1.0.130 to 1.0.131 (#33913)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    3eebb60b363f259d00a65318536bca95ba882539	https://github.com/servo/servo/pull/33914	build(deps): bump unicase from 2.7.0 to 2.8.0 (#33914)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    caaa786a8ab67085a963c3d7917871866798e486	https://github.com/servo/servo/pull/33915	build(deps): bump compiletest_rs from 0.11.0 to 0.11.1 (#33915)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    ba68a8f67ceb4893b6ee6896ba7b7213bea1d393	https://github.com/servo/servo/pull/33916	build(deps): bump cc from 1.1.30 to 1.1.31 (#33916)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
76bedf28e09703abd99f8cf8e7099459ea79cb83	https://github.com/servo/servo/pull/33911	replace sparkle with glow in components/script (#33911)	
a13900c4f8ec32a51b7bbdd166664fc6befb0f4b	https://github.com/servo/servo/pull/33912	Update dependabot.yml to only contain one group key (#33912)	
fa9cb79fc8c94b475ba6675d47847e378d0cc909	https://github.com/servo/servo/pull/33910	remove sparkle from components/servo (#33910)	
>>> 2024-10-21T06:08:40Z
    4d11b2dc84d53b90ca5f2b729ffa1a5db2da45e9	https://github.com/servo/servo/pull/33931	CanGc fixes from constantsourcenode.rs & window.rs (#33931)	
c75f6627ba0e314d5fb4c4c9230e93cbb1b188e3	https://github.com/servo/servo/pull/33767	Upgrade Stylo to 2024-10-04 (#33767)	
    65c866285f69d4c26ae46e604bcc05dda1641df7	https://github.com/servo/servo/pull/33924	Multiple CanGc fixes in components/script/dom (#33924)	
    ee9e1fbbd6f64d95392e0d501ee423bceeb15f7f	https://github.com/servo/servo/pull/33897	build(deps): bump gstreamer-video from 0.22.6 to 0.22.8 (#33897)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    a14b65f30bb3701d7df467406d342752617721ca	https://github.com/servo/servo/pull/33917	Replace CanGc::note() with arguments passed by callers (#33917)	Wulan Seruniati Salim <lauwwulan1806@gmail.com>
    a57b6a3f79314910543024c951d365e55efa154e	https://github.com/servo/servo/pull/33921	CanGc fixes through focusevent.rs & hashchangeevent.rs (#33921)	
>>> 2024-10-22T06:11:00Z
    ebfea9b352ef0ec00ad5213055392668e841a0e9	https://github.com/servo/servo/pull/33958	CanGc fixes in several files (#33958)	
    1bf68567b8608d87e1817066f1dacb27edc5602a	https://github.com/servo/servo/pull/33952	build(deps): bump syn from 2.0.79 to 2.0.82 (#33952)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
aeed5ca3b42e88f0c4d4d5d8448eaadf060204cf	https://github.com/servo/servo/pull/33959	Replaced mem::replace with mem::take for old_min_size (#33959)	
    b4d93dace5ffa93abb5c77bb6b8db6a370edf231	https://github.com/servo/servo/pull/33954	build(deps): bump serde_json from 1.0.131 to 1.0.132 (#33954)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    799735a9fa7850a3bade71caf4708ae6ef62b35b	https://github.com/servo/servo/pull/33955	build(deps): bump async-compression from 0.4.16 to 0.4.17 (#33955)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    99f89f403ad243b9afc010b3c4a524e2a07aa4cc	https://github.com/servo/servo/pull/33953	build(deps): bump flume from 0.11.0 to 0.11.1 (#33953)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    571cba4a8131bcd1f0850e8b9c5572fcd9d3a195	https://github.com/servo/servo/pull/33941	CI: Fail the lint job when cargo-clippy reports some warnings (#33941)	Mukilan Thiyagarajan <mukilan@igalia.com>
dc03d1f3e2820e85959c03fcbb71656fa1faddaa	https://github.com/servo/servo/pull/33937	Mark CompileFunction as a potential GC operation. (#33937)	
    9acb25521e433bdea49866e4ecb6a9f4e90b0663	https://github.com/servo/servo/pull/33920	CanGc changes from fontfaceset.rs (#33920)	Josh Matthews <josh@joshmatthews.net>
    66695d2f7ee25782d3edfca32b74ff14bc9faa84	https://github.com/servo/servo/pull/33943	clippy: Fix warnings in subtlecrypto.rs (#33943)	
2319764a1eaa1a3e15a2a393e5570afe4cffbca1	https://github.com/servo/servo/pull/33922	Refactor positioned layout (#33922)	
fee927475b6bd13e80a4bdc1712cb3aa04805099	https://github.com/servo/servo/pull/33939	Remove some unused preferences (#33939)	
45267c9f280708d1af1d60cb1bc3fad4cd71157d	https://github.com/servo/servo/pull/33795	crypto: Implement encrypt/decrypt for AES-CBC + JWK support (#33795)	
    397c5adf79dd278d70d27d80cd6deccea2d97bc8	https://github.com/servo/servo/pull/33936	clippy: fix explicit lifetime warning in components\layout_2020\style_ext.rs:320:20 (#33936)	
    c550a70f5c4feda7a1fef22a73038a3e887a5c7f	https://github.com/servo/servo/pull/33935	clippy: fix using clone() warning in components\layout_2020\display_list\mod.rs:1365:25 (#33935)	
>>> 2024-10-23T06:15:56Z
6fdd5ce4cb97579991aeb59d20adc9af941c84e2	https://github.com/servo/servo/pull/33938	Ensure compiled script module object remains rooted while it's being passed around. (#33938)	
    7fbd2a521ee8ec6b21dd67e462da25883ecccabf	https://github.com/servo/servo/pull/33973	CanGc fixes from eventtarget.rs (#33973)	
7b392db02f96fa5f3663c5c9d29eed988efe0030	https://github.com/servo/servo/pull/33963	crypto: Add support for AES-CTR operations (#33963)	
+   1c26c0335e49761a25167e118a10265b17632690	https://github.com/servo/servo/pull/33950	Implement keyword sizes on absolute/fixed positioned elements (#33950)	
    c5ee573c6d076267bc5e8e7a1f697503bbc643da	https://github.com/servo/servo/pull/33969	build(deps): bump bytes from 1.7.2 to 1.8.0 (#33969)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    8c2f4166b68d8bb446e300cfc84e690b26f39748	https://github.com/servo/servo/pull/33970	build(deps): bump tokio from 1.40.0 to 1.41.0 (#33970)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    061636fb0796453bd181cafb341782b3deed0858	https://github.com/servo/servo/pull/33968	build(deps): bump serde from 1.0.210 to 1.0.212 (#33968)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    09c0c65fe81f43400011bd0e61401b480bed1b07	https://github.com/servo/servo/pull/33966	build(deps): bump proc-macro2 from 1.0.88 to 1.0.89 (#33966)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
78d48ae2fb58e4c2e2a27a21d6e90f81c9fe951b	https://github.com/servo/servo/pull/33929	Fix GC borrow hazard in XRSession::UpdateTargetFrameRate (#33929)	
01c9ecfe01a06ca509bdaf1d5a77d1a0d0938b2c	https://github.com/servo/servo/pull/33964	layout: Cache content block size contributions (#33964)	Oriol Brufau <obrufau@igalia.com>
    7015e0fb5f1a63ed13a5b07b056036e6e7adbc16	https://github.com/servo/servo/pull/33960	CanGc fixes in `errorevent.rs` (#33960)	
    575e8855294a9ee2094b110a7c1fea868e69251e	https://github.com/servo/servo/pull/33928	Mark promise creation methods with CanGc (#33928)	
edc304854ff18bc686f8e2adc6cb64cbad181598	https://github.com/servo/servo/pull/33962	Avoid invalid lifetime extension for winit event loop. (#33962)	
8824c907160852db8162bb2bb83281f10f840ffa	https://github.com/servo/servo/pull/33951	Prevent `stretch` from producing a negative size (#33951)	
    afeaff7f1aaa1950e7597a478b5061ccb5b93686	https://github.com/servo/servo/pull/33956	build(deps): bump prettyplease from 0.2.22 to 0.2.24 (#33956)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
>>> 2024-10-24T06:04:52Z
    d74b078c2f7a5d841712b7fe32e93914aad68d18	https://github.com/servo/servo/pull/33981	build(deps): bump anyhow from 1.0.90 to 1.0.91 (#33981)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    ea875f0a51551914f85e56945a663ca0e749cc0e	https://github.com/servo/servo/pull/33985	CanGc fixes from EventTarget::fire_event (#33985)	
    bb4932026cef55aefd95a5a627a944e1ad26c6f2	https://github.com/servo/servo/pull/33984	cangc fixes in node.rs (#33984)	
    3ed778150fbaa2656d38e4cda8325797d14d27c1	https://github.com/servo/servo/pull/33978	Replace CanGC note calls with arguments passed by callers (#33978)	Wulan Seruniati Salim <lauwwulan1806@gmail.com>
    9d75862c7d4d4b591983dc7dfeeb3af6cd24468e	https://github.com/servo/servo/pull/33980	build(deps): bump thiserror from 1.0.64 to 1.0.65 (#33980)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    85888efa073d570ebe351b6892b742fb0d3cdb30	https://github.com/servo/servo/pull/33983	build(deps): bump serde from 1.0.212 to 1.0.213 (#33983)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    f4c179915874f8a2ab0aebd41752ddeaca57320b	https://github.com/servo/servo/pull/33979	build(deps): bump wayland-client from 0.31.6 to 0.31.7 (#33979)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
076b37e6aa10fb0dc4d7696ad391243bea8f876a	https://github.com/servo/servo/pull/33942	Resolved potential GC borrow hazards in ModuleTree::append_handler, ModuleTree::append_dynamic_module_handler, and ModuleTree::fetch_module_descendants' (#33942)	Oriol Brufau <obrufau@igalia.com>
324f42abd71bfe15acc3bf7e56bb8f7d7e4c0c20	https://github.com/servo/servo/pull/33976	Use borrow() to fix GC hazard in stream_chunk (#33976)	
    12e6ec25aa809e3c9b3c99be1cbcc76a5a8e6868	https://github.com/servo/servo/pull/33975	Propagate CanGc when interacting with readable streams. (#33975)	
    f553bda7ebc676c2b7e866fc38b6b52b3fbf4fa2	https://github.com/servo/servo/pull/33971	clippy: Fix warning in `fonts/platform/macos/font_list.rs` (#33971)	
>>> 2024-10-25T06:11:41Z
+   f05f1b3690d78404c74e829f340c075168b1b609	https://github.com/servo/servo/pull/33991	Implement `transition-behavior` (#33991)	
    156840bbadcb01fb0a2f96ab18cbe44f7170701f	https://github.com/servo/servo/pull/34001	build(deps): bump pin-project from 1.1.6 to 1.1.7 (#34001)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    5dd7fe296968c2c1a56b96f5a5d9e4eb561c5a2b	https://github.com/servo/servo/pull/34000	build(deps): bump syn from 2.0.82 to 2.0.85 (#34000)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
52db185568ca4dc49d28211f70b29aedecffaaf0	https://github.com/servo/servo/pull/33967	layout: Avoid layout sometimes when stretching (#33967)	Oriol Brufau <obrufau@igalia.com>
    638b520186f30d66fefa5a687799093dec071306	https://github.com/servo/servo/pull/33998	build(deps): bump pin-project-lite from 0.2.14 to 0.2.15 (#33998)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    7b6a806bed8696a9b3683907130d7bdb2328a64d	https://github.com/servo/servo/pull/33997	build(deps): bump wayland-protocols from 0.32.4 to 0.32.5 (#33997)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    18e9786899a10f7f13454e642b61698711d1a338	https://github.com/servo/servo/pull/33996	build(deps): bump prettyplease from 0.2.24 to 0.2.25 (#33996)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    0efea141cfef2813ad9c58b46769333758990d65	https://github.com/servo/servo/pull/33994	build(deps): bump regex from 1.11.0 to 1.11.1 (#33994)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    cdb09ebfa90288ac788fc5a8308f03bceffd192b	https://github.com/servo/servo/pull/33995	build(deps): bump wayland-cursor from 0.31.6 to 0.31.7 (#33995)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
9ad59d14593ec8255fa2b3151fc1037e2dfc31fb	https://github.com/servo/servo/pull/33988	Consistent resolution of cyclic percentages in min sizing properties (#33988)	
202cb53d5bc2c5dbed376bca9da4ebc531c1e3f0	https://github.com/servo/servo/pull/33987	add allow(non_camel_case_types) to generated pref structs (#33987)	
    12dd79c3e86d4f504fda519fa4aec11fd8721628	https://github.com/servo/servo/pull/33982	build(deps): bump lyon_geom from 1.0.5 to 1.0.6 (#33982)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
>>> 2024-10-27T06:08:47Z
    63b2f813af05a5d1600354b97901a764507951f5	https://github.com/servo/servo/pull/34029	Update web-platform-tests to revision b'73d6bd0d61f0ad5341d0c2303a7638e3aa12a594' (#34029)	
53911f4e5a5ec50dae73a5d4d36a80637e267fee	https://github.com/servo/servo/pull/34019	GC hazard fix in customelementregistry.rs (#34019)	
82c9d413306239a96b5f4ca8fc2612fd55cee501	https://github.com/servo/servo/pull/34020	GC hazard fix in document.rs (#34020)	
    867510b9d8f2f284d9ff2f24a4612663f1b09e9b	https://github.com/servo/servo/pull/34013	build(deps): bump wayland-protocols-plasma from 0.3.4 to 0.3.5 (#34013)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    21906e5d8c43485d8fc277df2576d7d87cc4ac3b	https://github.com/servo/servo/pull/34012	build(deps): bump wayland-protocols-wlr from 0.3.4 to 0.3.5 (#34012)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    8e2a0414e870ffbca620a05ea9a18878e81e6622	https://github.com/servo/servo/pull/34011	build(deps): bump anstyle from 1.0.8 to 1.0.9 (#34011)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
f4ff067387dd44b15a4c5e2f8c075d610021c43f	https://github.com/servo/servo/pull/33990	chore: Update WebGPU CTS (#33990)	
+   faeb31d6c6aed117a76a052e6dd85646398b06b2	https://github.com/servo/servo/pull/33854	Implement keyword sizes for intrinsic contributions (#33854)	
831a65917a1ffa3f24fcc67ea0955a9d15d7d449	https://github.com/servo/servo/pull/34022	ci: pin python to 3.12 for mac workflows (#34022)	
+   5d4b5514aa339d115d0ac9e1131eb7bef1d99a0b	https://github.com/servo/servo/pull/34005	Allow parsing `transition-behavior` value in `transition` shorthand (#34005)	
dfe1c95aa6fe00bb1a251ddc03d760fbb78152d2	https://github.com/servo/servo/pull/34006	Avoid crash in replaced layout, and fix behavior for non-auto aspect-ratio (#34006)	
43c8441f6ce0a9f41fbf4ff020454ef120c8dab0	https://github.com/servo/servo/pull/34008	ServoShell: Don't request redrawing again when processing a RedrawRequested event (#34008)	
600ba602b75bcad884fee75125aaf5a616fb8d91	https://github.com/servo/servo/pull/34009	Limit HtmlOptionsCollection.length setter to 100k elements (#34009)	
    fd6c10048938a21b24a9e67b0cf0e64d5e263614	https://github.com/servo/servo/pull/34003	CanGc fixes in messageport.rs & workerglobalscope.rs (#34003)	
    7ad8822d94f22969af4ebe1130a0050e78fbc21b	https://github.com/servo/servo/pull/34002	cangc fixes in several files + event.rs + rtcpeerconnection.rs (#34002)	
3b5dc069ae338ebf373471e32874ea8f4ba3ade3	https://github.com/servo/servo/pull/33989	dom: Stub out the `IntersectionObserver` interface (#33989)	
    1624530ffe38753e0166cdc6c420c784c3f654d8	https://github.com/servo/servo/pull/33999	build(deps): bump encoding_rs from 0.8.34 to 0.8.35 (#33999)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>	Mukilan Thiyagarajan <mukilan@igalia.com>
>>> 2024-10-28T06:06:59Z
+   10aa485c0c07b146cbeff21dadfe34f5be6364b9	https://github.com/servo/servo/pull/34032	Devtools: Don't display iframes in the tab list (#34032)	
    ccafda9a5965f2f7253e3b554771398b03e93184	https://github.com/servo/servo/pull/34031	Cargo.toml cleanup (#34031)	
    20ce979c4c9669e1cde270afe8fd72aaa7eda9a4	https://github.com/servo/servo/pull/34030	Update some dependencies (#34030)	
>>> 2024-10-29T06:08:16Z
    a501572971d7ec6761aeab1f8f5dba00158bc1a6	https://github.com/servo/servo/pull/34045	build(deps): bump hilog from 0.1.0 to 0.1.1 (#34045)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
1070f7ac12b0d46c71071a604649c0bfca375f5e	https://github.com/servo/servo/pull/34018	Fix invalid rooting for PropertyDescriptor (#34018)	
+   884732dfb25ab8969234c1ec1ef2009b93517974	https://github.com/servo/servo/pull/34048	mach try: Remove `wpt-2013` from `full` and `wpt` (#34048)	
d3e0efbc21cc4480a4779be36c8a4268e3939cbc	https://github.com/servo/servo/pull/34039	Cleanup: Remove reference to closed issue 7193 (#34039)	
    83cd349163f1599b0dce7ec89f5225f242378618	https://github.com/servo/servo/pull/34047	build(deps): bump libm from 0.2.8 to 0.2.10 (#34047)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    5244b0212e766a85caf1eec328acddbe4f9fec66	https://github.com/servo/servo/pull/34044	build(deps): bump napi-derive-ohos from 1.0.0 to 1.0.1 (#34044)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    7374f20537923e251fdfdfe25ba28e98599bc4ae	https://github.com/servo/servo/pull/34043	build(deps): bump napi-derive-backend-ohos from 1.0.0 to 1.0.1 (#34043)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    8f01f1710c231e8fa9f90c152e7bfab43b5634ff	https://github.com/servo/servo/pull/34042	build(deps): bump fdeflate from 0.3.5 to 0.3.6 (#34042)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    56de90a499c448be4bf3704e29ed1a116134af18	https://github.com/servo/servo/pull/34041	build(deps): bump rustix from 0.38.37 to 0.38.38 (#34041)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
216296840ae30060c3e4d16156f5bd30ef9576e8	https://github.com/servo/servo/pull/34036	Replace uses of SCRIPT_THREAD_ROOT with accessor helpers. (#34036)	
1d6ede7b4868c5bd3ea821e0afd5df0bb99911cd	https://github.com/servo/servo/pull/33965	Remove GC hazard when compiling inline event listeners. (#33965)	
a01d66df5388d11aeb6dbd8ac9ccc84302d394bb	https://github.com/servo/servo/pull/34028	webgpu: Move supported context format to content timeline (#34028)	
>>> 2024-10-30T07:43:54Z
bac1101163a436096fe0b71bed79094658bba3b2	https://github.com/servo/servo/pull/34062	Fix CMake issues on OpenHarmony (#34062)	
7fa548f555310cf4e60ad054f6577fabf57938e0	https://github.com/servo/servo/pull/34034	Implement `SubtleCrypto.digest` (#34034)	
01820e2a8a28bcf3b8e1b17863984d8f729ca79b	https://github.com/servo/servo/pull/31746	Improve how intrinsic sizes work for videos (#31746)	Josh Matthews <josh@joshmatthews.net>	Oriol Brufau <obrufau@igalia.com>
43d1601016e03fe83fe9b8a526357de1d5fc4122	https://github.com/servo/servo/pull/34054	Only send mapping back on unmap when MapMode = WRITE (#34054)	
d5554235febb7b12906b01bf7c170ddb1e7d0bb4	https://github.com/servo/servo/pull/34057	layout: Add support for `mix-blend-mode: plus-lighter` (#34057)	
d17321f53d28cbaeed8c1d0ed0d6e317143e6ab6	https://github.com/servo/servo/pull/34004	fix(constellation): pass resolved URL to embedder (#34004)	
    f8e17b68a604ba511c1c92675e44490f257012c1	https://github.com/servo/servo/pull/34061	build(deps): bump libm from 0.2.10 to 0.2.11 (#34061)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    7a72005802f36dfdc19543d4f3b02fea64d1d21d	https://github.com/servo/servo/pull/34059	build(deps): bump mozangle from 0.5.1 to 0.5.2 (#34059)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
    36d9fafde8ab9b8a511a33022c9123f12c433fd3	https://github.com/servo/servo/pull/34058	build(deps): bump serde from 1.0.213 to 1.0.214 (#34058)	dependabot[bot] <49699333+dependabot[bot]@users.noreply.github.com>
000144f52afa9ecc64649ec1914bf5856f3e916c	https://github.com/servo/servo/pull/34055	Remove size_of_test macro from legacy layout and inline it (#34055)	
>>> 2024-10-31T06:08:52Z
62c79514249ac2c493390e75cd66235bd31942f2	https://github.com/servo/servo/pull/34075	Fix timeout in position-absolute-replaced-minmax.html (#34075)	
cf663309782c95166ac56a481c7bde9483284e5f	https://github.com/servo/servo/pull/34072	Fix `test-speedometer` (#34072)	
ade562e4810c534b3dc8189cb60868819d7ee888	https://github.com/servo/servo/pull/34073	Update wgpu to v23 (#34073)	
78ba1613d4b4323c3db4e786ae2c4ae19ba201d8	https://github.com/servo/servo/pull/34063	Improve scrolling speed in servoshell. (#34063)	
635c10a941a960eb2c54938adbdeea75cc66cba7	https://github.com/servo/servo/pull/34052	Enable css-grid WPT tests (#34052)	
1891c5cfafe5e589d6bf828deb8ea1ad14f70f61	https://github.com/servo/servo/pull/34026	Properly transfer min/max constraints on auto-sized replaced elements (#34026)	
f12071f77eef0612c16c0f297c29e95929218576	https://github.com/servo/servo/pull/34070	andrdoid: Fix some compiler warnings (#34070)	
517e8a376ab1d1b7d2bf6c4d8cf0e738101b57cb	https://github.com/servo/servo/pull/34069	Test <video> with width and height attributes but aspect-ratio:auto (#34069)	
850e59f98ec49dfc72ea9b71f8db7b6292f28d12	https://github.com/servo/servo/pull/34038	servoshell: Allow overriding screen resolution with a command-line argument (#34038)	
d877962ee8a5003b0a6eec9fb3d16f1b759a9f9e	https://github.com/servo/servo/pull/34067	readme: Fix typos in Android build instructions (#34067)	
ee68dc2589283d9ef37b578b83258d421ec29bcc	https://github.com/servo/servo/pull/33919	Support persisting unminified external stylesheets (#33919)	
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
