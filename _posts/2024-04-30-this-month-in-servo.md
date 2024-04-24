---
layout:     post
tags:       blog
title:      "This month in Servo: and more!"
date:       2024-04-30
summary:    ao!! wrrrrao!!
categories:
---

<!--
- sponsors
    - $1164/month opencollective, including $1000/month from one anonymous donor
        - need to calculate manually or scrape :(
        - 5+5+5+25+10+5+10+5+5+5+10+1+25+5+5+3+5+5+10+5+5+5
    - $184/month github
        - 100+5+1+15+1+5+5+5+5+1+5+5+1+10+5+5+5+5
        - “monthly estimated income” stat is consistent with this
- api
    - video without autoplay (@eerii, media#419, servo#32001)
    - files setter on HTMLInputElement (@shanehandley, #31934)
    - onSubmittedWorkDone method on GPUQueue (@sagudev, #31772)
    - HTMLTableElement removeRow(-1) (@shanehandley, #32009)
    - ElementInternals and attachInternals (@pshaughn, @cathiechen, #25705, #31980)
- css
    - basic support for ‘list-style-position’ (@mrobinson, @Loirooriol, #32114)
    - ‘baseline-source’ (@MunishMummadi, #31904, #31913)
    - ‘ex’ units (@mrobinson, #31966)
    - ‘background-attachment: fixed’ (@mrobinson, #32068)
    - <object> with image data url (@mrobinson, #32069)
    - ‘clear’ on <br> (@mrobinson, #32094)
- rendering
    - white-space:pre-wrap intrinsic sizing (@Loirooriol, #31930)
    - fix scrolling to top when transforms change (@mrobinson, #31892)
    - fix http 400 from nginx, though host is still broken (@philip-lamb, #32024, #32093)
    - fixes for margin collapsing (@Loirooriol, #32059, #32060)
    - fix for ‘min-height’ and ‘max-height’ on floats (@Loirooriol, #32057)
    - fix for emoji font fallback on macos, except for color (@mrobinson, #32122)
    - fix for selecting the correct weight/style in indexed fonts (ttc) on linux (@mukilan, @mrobinson, #32127)
- wpt
- upgrades
    - stylo (@Loirooriol, #31932, #31991, #32032, #32066, #32089)
- font system rework (@mrobinson, #32033, #32038, #32100, #32101)
    - platform-independent font data loading (@mrobinson, #32034)
- qt
- book
- dev
    - prebuilt spidermonkey (@wusyong, @sagudev, mozjs#450, #31824)
    - multiple webviews (@wusyong, @delan, @atbrakhi, #31417, #32067)
    - layout thread (@mrobinson, #31937, #32081)
    - webgpu cts flakiness (#31952)
    - macos flakiness (@mrobinson, #32005)
    - nix-shell without etc/shell.nix (@delan, #32035)
- outreachy
    - & ‘baseline-source’ (@MunishMummadi, #31904, #31913)
    - & video without autoplay (@eerii, media#419, servo#32001)
- conferences
-->

<!--
fromDate = "2024-03-29";
toDate = "2024-04-23";

>>> top deltas (servo, pp):
margin-padding-clear (3.1pp to 96.6%)
linebox (2.5pp to 93.6%)
normal-flow (2.5pp to 94.0%)
floats-clear (1.8pp to 91.4%)
positioning (1.6pp to 90.1%)
css2 (1.4pp to 78.6%)
css (1.0pp to 65.0%)
all (0.8pp to 57.0%)
floats (0.8pp to 89.2%)
csstext (0.8pp to 49.3%)
csstable (0.4pp to 63.1%)
cssflex (0.1pp to 54.0%)
abspos (0.0pp to 91.0%)
box-display (0.0pp to 84.4%)
cssom (0.0pp to 65.4%)
csspos (-0.2pp to 46.9%)

>>> top cuts in legacy regression (%):
all (-Infinity% from 0.0pp to -0.2pp)
-->

<!--
From https://github.com/servo/servo
 * branch                    HEAD       -> FETCH_HEAD
>>> 2024-03-29T06:14:21Z
    2d5a1cd02ee0c3196875dc52ca55a150a63cc29f	https://github.com/servo/servo/pull/31926	build(deps): bump tokio from 1.36.0 to 1.37.0 (#31926)
?o  4d5bcdc057f178b0bc3de1ef155788b70adb07d8	https://github.com/servo/servo/pull/31929	fix: remove unused imports (#31929)
    72628303fbdfef6bc939904febe6849e8f6066f8	https://github.com/servo/servo/pull/31920	Update servo's testharnessreport (#31920)
    32e82d03828d85ce7b5d5dc4291d62b619def453	https://github.com/servo/servo/pull/31925	build(deps): bump memchr from 2.7.1 to 2.7.2 (#31925)
?o  7ce78f5a74f59ed8a23393a1efcfd26f5264ff17	https://github.com/servo/servo/pull/31915	clippy: Fix some warnings in `script/dom` (#31915)
?o  9303c901594f77e4f9ad8e317e391bc49975d776	https://github.com/servo/servo/pull/31924	clippy: refactor struct literals to use shorthands (#31924)
?o  0728378424e3a28a260207ff43a9c2b3af58df56	https://github.com/servo/servo/pull/31923	clippy: remove unneeded return statements (#31923)
?o  7349ce5b6a4c522d966f5e79f1b097a82db3a575	https://github.com/servo/servo/pull/31922	clippy: Fix manual_map warnings (#31922)
    5d518ca8dc25157aa19aec3d2dacef21ef0c0294	https://github.com/servo/servo/pull/31848	layout: Use `Au` in `ResolvedMargins` and `CollapsedMargin` (#31848)
?o  66ad79501431cf0a5c83b15b7e443c87d780376e	https://github.com/servo/servo/pull/31921	clippy: Fix mem_replace_with_default warnings (#31921)
?o  7100465d1a7251d3d353228d965d1ef2278ac01f	https://github.com/servo/servo/pull/31901	clippy: Fix various clippy warnings in `components/scripts/dom/bindings` (#31901)
?o  18054d0737cc90a0ccf3c1c1c05a76508d374f17	https://github.com/servo/servo/pull/31909	clippy: Fix another set of clippy problems in `components/script/dom` (#31909)
?o  af358f51dbfb80ec8b7bbae4c2da983049420500	https://github.com/servo/servo/pull/31912	clippy: Fix another batch of clippy warnings in `components/scripts` (#31912)
?o  3ddb47e902901514285c89f9a3b53581ca750933	https://github.com/servo/servo/pull/31914	clippy: Fix more clippy warnings in `components/scripts/dom` (#31914)
?o  5aae820f6d68c3e437135eddcb830ac185ec684f	https://github.com/servo/servo/pull/31905	clippy: Fix a few clippy problems in `components/scripts/dom` (#31905)
?o  1bc63801e79273bd976530af498a43f0b9c7c93b	https://github.com/servo/servo/pull/31917	fix redundant closures in component/script/dom (#31917)
?o  f18317078601afad18188f1bad0a33e59ba8303c	https://github.com/servo/servo/pull/31911	clippy: Fix all errors in `components/script` (#31911)
?o  eccb60e548bf522c07546e3abfd55c9442181c6b	https://github.com/servo/servo/pull/31899	deref on an immutable reference (#31899)
>>> 2024-03-30T06:07:58Z
?o  92d9081366d12e79f84353cfa5e6500e3d586d6f	https://github.com/servo/servo/pull/31943	fix: remove unused imports in components/script (#31943)
+++ b7d089930ea075a580a20bede881c677a0ba0fb0	https://github.com/servo/servo/pull/31937	layout: Remove LayoutRPC and query layout via the `Layout` trait (#31937)
+++ 07391e346b0ff3e89485ddc7e8f3c448ef1de4f4	https://github.com/servo/servo/pull/31930	Obey `white-space: pre-wrap` when intrinsically sizing an IFC (#31930)
?o  b0196ad3734149c98cfad89df0864fca3bdf92ce	https://github.com/servo/servo/pull/31894	clippy: Fix a variety of warnings in components/script/dom (#31894)
?o  4a68243f65c4fc32a4d12faa21d9c36e02a05f52	https://github.com/servo/servo/pull/31933	clippy: Fix needless_lifetimes warnings (#31933)
?o  a8976ff00a9a3fd7ed11bcabc765aa2f2aeff0dc	https://github.com/servo/servo/pull/31936	clippy: Fix option_as_ref_deref warnings (#31936)
?o  c3b6d40f90c30e74bec135306e7cfc034123e3df	https://github.com/servo/servo/pull/31935	clippy: Fix len_zero warnings (#31935)
?o  49c6b2668f99c6dac54802a0cc92f9d01457cb6a	https://github.com/servo/servo/pull/31913	wpt: Enable tests in `/css/css-inline/baseline-source/` (#31913)
?o  c4739675d8bf83a83d8e26d5d7527180f003e7d5	https://github.com/servo/servo/pull/31928	clippy: Fix needless_borrow warnings in components/script (#31928)
>>> 2024-03-31T06:12:01Z
+++ fff9ef87e6dcd7ccc17f9c6e9a483b70654e1a41	https://github.com/servo/servo/pull/31932	Update Stylo to 2023-10-16 (#31932)
?o  a7ad92d9a3411e97244b3e1bbd4d939a3af83a32	https://github.com/servo/servo/pull/31946	clippy: Fix `from_over_into` warnings (#31946)
?o  e3d6b66d5fa0d6b076012d282012264906e55ea6	https://github.com/servo/servo/pull/31947	clippy: Fix `match_like_matches` warnings (#31947)
>>> 2024-04-01T06:18:38Z
?o  00c4d798c9619e068119db02910ed80ad9df937b	https://github.com/servo/servo/pull/31955	clippy: Fix a few problems in `components/script/dom` (#31955)
?o  9401102691db1388dfd2e4d7da5ffb69e8c28beb	https://github.com/servo/servo/pull/31958	updated components/layout_thread/lib.rs (#31958)
?o  673eaa569a5d1229a0dfa56861ebe6c8126e7e63	https://github.com/servo/servo/pull/31910	clippy: Fix various clippy problems in `components/scripts/dom` (#31910)
?o  9243e8cf71da1a440e79d9202cab34dec8d7519a	https://github.com/servo/servo/pull/31939	clippy: Fix some issues issues in `ports/servoshell` (#31939)
?o  bd287df0d4846c494df6a18fa558eb19a9e9fdfd	https://github.com/servo/servo/pull/31954	fixed various clippy warnings (#31954)
?o  c3360df9189271eee039f0a74d73e0c2b48a4796	https://github.com/servo/servo/pull/31950	Fixed some clippy warnings in components/script (#31950)
    8c8d68e415bbea24593476d32f4bb7c46016bca3	https://github.com/servo/servo/pull/31951	Update web-platform-tests to revision b'16f18d8135a80e89f2e910ca7548999fa2f7937e' (#31951)
>>> 2024-04-02T06:14:30Z
?o  da3991c8f37251e04ba67dd7e71c3129327dddae	https://github.com/servo/servo/pull/31971	clippy: Fix search_is_some warnings (#31971)
    71f4c5c9166d5957e0edbe1734856cc4d2721cb9	https://github.com/servo/servo/pull/31970	build(deps): bump syn from 2.0.55 to 2.0.57 (#31970)
    4227f2f8a1c0446cca88b68738d297bfffbdebc9	https://github.com/servo/servo/pull/31969	build(deps): bump pin-project-lite from 0.2.13 to 0.2.14 (#31969)
    5008b6c42076eff36178391fd50eb30f259ff075	https://github.com/servo/servo/pull/31967	build(deps): bump xml-rs from 0.8.19 to 0.8.20 (#31967)
?o  0a40a800fde3b3812ba3fd2bdee7dd7271d7ecec	https://github.com/servo/servo/pull/31965	clippy: Fix filter_next warnings (#31965)
?o  c7b73e1ef4dc54ea74d63d3cec0cf7fe0fab218a	https://github.com/servo/servo/pull/31964	clippy: Fix let_and_return warnings (#31964)
?o  0da2508e4d643e7a47ec3b83f9e97b06a3eb3bad	https://github.com/servo/servo/pull/31962	clippy: Allow `too_many_arguments` for all functions (#31962)
+++ 8c1a72f13052ece57fcff4e424dbab58afa9b37e	https://github.com/servo/servo/pull/31934	Update webidl and implement setter for the files property of a file input (#31934)
+++ 8c25336e9af0a1ca32107622d94993f9c834d46c	https://github.com/servo/servo/pull/31952	Override timeout in WebGPU CTS to always be "long" (#31952)
?o  2f5a4354e71a054e219efd99f1a0266ad655b841	https://github.com/servo/servo/pull/31960	clippy: fixed various clippy warnings in `components/scripts`  (#31960)
?o  fd8235e40959622932fd01fe3ade530b7a7e5722	https://github.com/servo/servo/pull/31961	clippy: Fix a few problems in `components/script` (#31961)
?o  52a74287fc3f13f855cdf24c8610cf902a49686b	https://github.com/servo/servo/pull/31959	clippy: Fix a few problems in `components/scripts` (#31959)
>>> 2024-04-03T06:13:49Z
?o  cc082efbfd5b86c0da53c36b0020dfdaced012e7	https://github.com/servo/servo/pull/31974	clippy: Allow `too_many_arguments` for existing functions (#31974)
?o  f613159cbadc57aa79a2bc9925514feab0c61b36	https://github.com/servo/servo/pull/31972	clippy:partialeq_to_none (#31972)
?o  2a517f786bad16a8e5d6e3d1f427a27285e034db	https://github.com/servo/servo/pull/31904	Implementation of baseline-source (#31904)
>>> 2024-04-04T06:10:04Z
+++ 1ed6b96684697cb2816cb7e09158de2e357bc496	https://github.com/servo/servo/pull/31824	Update mozjs (#31824)
?o  31e0b33e73fbbe262dd3f442f90f76fd56065a1d	https://github.com/servo/servo/pull/31986	clippy: Fix `vec_box` warnings in `components/script` (#31986)
?o  fcc7a1be53a2b27af3ae847e6cd773886846da63	https://github.com/servo/servo/pull/31984	clippy: Fix `toplevel_ref_arg` warning in `components/script` (#31984)
?o  37cf4cf207426f9c3b13feb617a14a6c25164894	https://github.com/servo/servo/pull/31945	clippy: Fix several warnings in `components/script/dom/bindings` (#31945)
?o  03b752289ee2edaa886e3113d55ba0fd9d7ced76	https://github.com/servo/servo/pull/31987	clippy: fix warnings in components/compositing (#31987)
    3c249b0d5bb1565e32e5abcf4c0c496462b8ae26	https://github.com/servo/servo/pull/31988	build(deps): bump syn from 2.0.57 to 2.0.58 (#31988)
?o  b228d7869d7cccf7b270657cc3f610f05d157ec8	https://github.com/servo/servo/pull/31983	clippy: Fix option_map_or_none warnings (#31983)
+++ 66878fb834fe7de6d76ebd01b1c9a8d92b04e546	https://github.com/servo/servo/pull/31417	Initial internal support for multiple webviews (#31417)
    18b37e676bcd50f754cd189444080fc547c9d48a	https://github.com/servo/servo/pull/31979	script: Reduce the use of `unsafe` in LayoutDom (#31979)
+++ 8aaff613342568c13e9141758b770788694d2f84	https://github.com/servo/servo/pull/31892	compositing: Send entire scene's scroll offsets when sending WebRender display lists (#31892)
>>> 2024-04-05T06:06:10Z
+++ f902a9fecf42da54e99f18ab87e6bde7427a10b3	https://github.com/servo/servo/pull/32001	Show poster over first video frame if available (#32001)
    c7542b273bc58c616ac1a26bbf911921591eaeff	https://github.com/servo/servo/pull/31998	build(deps): bump servo-media-gstreamer from `c04bb30` to `45756be` (#31998)
    770130a563d1e7bc5da15a6d692c9d0f0763519c	https://github.com/servo/servo/pull/31997	build(deps): bump servo-media from `c04bb30` to `45756be` (#31997)
+++ fe8b23d14a006de5569f967d6d6a78a46d48f367	https://github.com/servo/servo/pull/31966	layout: Add a `FontMetricsProvider` for resolving font-relative units (#31966)
    24c3a2df1eb63a75274eb219128f305aabc236c2	https://github.com/servo/servo/pull/31994	script: Make layout DOM wrappers not generic on layout data (#31994)
?o  df457c43c8f78d18e4e6fbc19910e35f82249b63	https://github.com/servo/servo/pull/31989	Fixed some clippy warning by adding default implementations (#31989)
+++ 62a916ce5c7e3de2c33b52c79a57b1f739c420f5	https://github.com/servo/servo/pull/31772	webgpu: Implement onSubmittedWorkDone (#31772)
    08ef158d4e1c38935eb18dc57de2b953368e0771	https://github.com/servo/servo/pull/31985	script: Split style and layout data in DOM nodes (#31985)
>>> 2024-04-06T06:10:20Z
    1ffa61aabf3b4872ee94f5b01f80fec67b7d6b8c	https://github.com/servo/servo/pull/32006	build(deps): bump ab_glyph from 0.2.23 to 0.2.24 (#32006)
?o  275fad8b78d1eac481f4913f1972e3cc1dc229d3	https://github.com/servo/servo/pull/31953	Clippy: Fix the error of variants having the same prefix. (#31953)
+++ 9ee45425e90812d48801640b195efab76ef68ac4	https://github.com/servo/servo/pull/32005	ci: Retry `hdiutil create` with randomize backoff (#32005)
    77b2e88fb7a2d3e672b5d223ba2ae8f2d15de853	https://github.com/servo/servo/pull/31996	gfx: Do not apply scale to `CoreText` font metrics (#31996)
    14bf1c5434cd4cd9412a601a556e6c757c466b92	https://github.com/servo/servo/pull/31999	build(deps): bump h2 from 0.3.25 to 0.3.26 (#31999)
>>> 2024-04-07T06:09:26Z
    05f1bbf0a92f2cd8495813cff03af227177de858	https://github.com/servo/servo/pull/32010	Update web-platform-tests to revision b'b73a0a32890ff293961eb55bb90ba57a5a711f48' (#32010)
>>> 2024-04-08T06:06:38Z
+++ ddbec46e1fe6716e2cba5e073f62014c22539589	https://github.com/servo/servo/pull/32009	fix: Handle table.deleteRow with no rows (#32009)
?o  e0e34086501068af22f6df00ec9d0d2707a5494c	https://github.com/servo/servo/pull/32007	Fixed some clippy warnings by replacing 'match' with 'if' (#32007)
>>> 2024-04-09T06:10:10Z
    b79e2a0b6575364de01b1f89021aba0ec3fcf399	https://github.com/servo/servo/pull/32021	build(deps): bump cc from 1.0.89 to 1.0.92 (#32021)
    09b20c87b8785f3a4c33f7d506f7533a09d797e5	https://github.com/servo/servo/pull/32022	build(deps): bump getrandom from 0.2.12 to 0.2.14 (#32022)
    309f54a8f8b1053adbe3642e2d6b2c40ef9904e8	https://github.com/servo/servo/pull/32019	build(deps): bump gstreamer-audio from 0.22.0 to 0.22.4 (#32019)
    6b006c015de6e647e1ce0de8c1e78403726e2082	https://github.com/servo/servo/pull/32017	build(deps): bump glib-macros from 0.19.3 to 0.19.4 (#32017)
    20faebace6823513aa92c6fa45f23d259641addb	https://github.com/servo/servo/pull/32016	build(deps): bump downcast-rs from 1.2.0 to 1.2.1 (#32016)
    641699dbd919249b9d0d639ee729f8951b5e8a64	https://github.com/servo/servo/pull/32018	build(deps): bump gstreamer-video from 0.22.1 to 0.22.4 (#32018)
    3d431d9e0f15e47239c68e1a232babf6f94ce8db	https://github.com/servo/servo/pull/32014	build(deps): bump warp from 0.3.6 to 0.3.7 (#32014)
    04a537a2da71734a1b7c23feb7147d025786bdfe	https://github.com/servo/servo/pull/32015	build(deps): bump half from 2.4.0 to 2.4.1 (#32015)
    e38b34a6298f3144e13ff41a5ab2021a35010923	https://github.com/servo/servo/pull/31684	Gamepad: Remove GamepadList and fix dropped connection event on startup (#31684)
>>> 2024-04-10T06:08:25Z
    245269c64942f88bdd26d5962adc5440f2751aa3	https://github.com/servo/servo/pull/32029	build(deps): bump gstreamer from 0.22.3 to 0.22.4 (#32029)
    267320c127a97fa51907e8365970100ed9856d69	https://github.com/servo/servo/pull/32031	build(deps): bump glib from 0.19.3 to 0.19.4 (#32031)
    7f4608b200c11535b1491ffee0cb82bc9d1faa8f	https://github.com/servo/servo/pull/32030	build(deps): bump rustversion from 1.0.14 to 1.0.15 (#32030)
    9e1831876b3871be5b5735593c169b9b296b7803	https://github.com/servo/servo/pull/32028	build(deps): bump backtrace from 0.3.69 to 0.3.71 (#32028)
+++ 586a70887d982f5ec98dd308c3b1cf36ff44773f	https://github.com/servo/servo/pull/31991	Bump Stylo to servo/stylo#28 (#31991)
?o  581913f77eeca88171607c117a6ea32127f5693b	https://github.com/servo/servo/pull/32023	clippy: fix warnings in components/script (#32023)
    8d513cf4c78c9bb984d204f190ad3f9916f925a3	https://github.com/servo/servo/pull/32012	feat: use set_poll, set_wait, set_exit of control_flow (#32012)
    0a8b461dbcd6c2be91e3c8496a0df5f61a4f9750	https://github.com/servo/servo/pull/32013	build(deps): bump uluru from 3.0.0 to 3.1.0 (#32013)
    810d76460c3e00521f1b02a46f770de5f509ef3f	https://github.com/servo/servo/pull/32020	build(deps): bump bumpalo from 3.15.4 to 3.16.0 (#32020)
    dd9f62adcc2db74e473ba1d385c2005b9c0fd25f	https://github.com/servo/servo/pull/31981	chore: Clean up use of `gfx` and `constellation` types (#31981)
>>> 2024-04-11T06:06:45Z
    d9f067e998671d16a0274c2a7c8227fec96a4607	https://github.com/servo/servo/pull/32041	build(deps): bump combine from 4.6.6 to 4.6.7 (#32041)
    29a73968780edd884f8879aac6b36e511bf30807	https://github.com/servo/servo/pull/32042	build(deps): bump anyhow from 1.0.81 to 1.0.82 (#32042)
    927faec82e7e80cc55326a1dd70a1c43a2f782a6	https://github.com/servo/servo/pull/32044	build(deps): bump cfg-expr from 0.15.7 to 0.15.8 (#32044)
    797b3f9618cc580a3b73ec56688ea23e896904f3	https://github.com/servo/servo/pull/32043	build(deps): bump encoding_rs from 0.8.33 to 0.8.34 (#32043)
    fb3b3032aee3a0c12d65018b35c03fd3f23b02fc	https://github.com/servo/servo/pull/32040	build(deps): bump quote from 1.0.35 to 1.0.36 (#32040)
+++ 5acfce5b89d3795a2080e1d2ffd8479e9b10e12b	https://github.com/servo/servo/pull/32032	Upgrade Stylo to 2023-12-01 (#32032)
?o  89a48205197a059c05f1ec6f07c14d82fb94d16b	https://github.com/servo/servo/pull/32025	Fixed some clippy warnings in components (#32025)
>>> 2024-04-12T06:11:16Z
+++ 10ec8565eaa0e9e86d3a6506ab1e83d5a41f51c8	https://github.com/servo/servo/pull/32024	Fixes for HTTP header compliance. (#32024)
?o  62a25fdcc4165ecafc6f40adc8a3e2c47838e4a3	https://github.com/servo/servo/pull/32051	clippy: Fix question_mark warning (#32051)
?o  9db9dddb882e4456c3e41146d646d34200610fda	https://github.com/servo/servo/pull/32053	clippy: Fix iter_cloned_collect warning (#32053)
?o  b3d992439647733ca76608969795adfd639146ed	https://github.com/servo/servo/pull/32056	clippy: Fix `redundant_*` warnings (#32056)
?o  e3ad76d99403903d6081afd15e563dd2c08d89df	https://github.com/servo/servo/pull/32052	clippy: Fix needless_late_init warning (#32052)
?o  e8e909b78c4c165ac9bcf74f834a5c7aae12f52d	https://github.com/servo/servo/pull/32049	clippy: Fix needless_lifetimes warning (#32049)
    0a860bd92874f0eb4ab3756b14feb5eab68e9885	https://github.com/servo/servo/pull/32055	build(deps): bump pathfinder_simd from 0.5.2 to 0.5.3 (#32055)
    cd642f2e6b1416609c8c152fbfaa3ce8081f5122	https://github.com/servo/servo/pull/32054	build(deps): bump jobserver from 0.1.28 to 0.1.29 (#32054)
+++ 4e4a4c0a28fb571991470f26ea82b8a897153788	https://github.com/servo/servo/pull/31980	Implement form-associated custom elements and their ElementInternals (#31980)
    2eb959a159874fa62a0844b31791698b74f3c959	https://github.com/servo/servo/pull/32045	Update core-graphics (#32045)
>>> 2024-04-13T06:08:15Z
    b74664d2428d1a0b3136952e4b10c54960fc7dfa	https://github.com/servo/servo/pull/32063	build(deps): bump allocator-api2 from 0.2.16 to 0.2.18 (#32063)
+++ bc7cced03c982cc32c941fec40e66fb5814470cb	https://github.com/servo/servo/pull/32060	Element collapsing thru should collapse with its children (#32060)
+++ 95654b789cce4acb1bb7b755053c4ae6b1cdc07e	https://github.com/servo/servo/pull/32059	Treat indefinite percentages as auto for margin collapse (#32059)
+++ efa0d457574f02dfbe2403f501a4626acdcb64db	https://github.com/servo/servo/pull/32038	Remove `FontContextHandle` (#32038)
+++ e9591ce62f210d374463bdf1a6d956e19cca81f0	https://github.com/servo/servo/pull/32057	Obey min-height and max-height on floated elements (#32057)
?o  88d4aff5958229f692bfa8c83be0bf731a36e25e	https://github.com/servo/servo/pull/32058	clippy: Fix `comparison_*` warnings (#32058)
    509b858f15e4d78b019c5da654f29072e96de0ee	https://github.com/servo/servo/pull/32050	mach: Remove unused `--angle` command line argument (#32050)
>>> 2024-04-14T06:29:46Z
    5083f3c4fb6d9cf3a149809d883b4cebdc6a939b	https://github.com/servo/servo/pull/32071	Update web-platform-tests to revision b'daa07cf3c47652ed67e637f2a39bbc34f91cfe10' (#32071)
+++ a5e97525a0b924c8031cd277dfdf85ea9e17a6bc	https://github.com/servo/servo/pull/32066	Upgrade Stylo to 2024-01-16 (#32066)
    93bb276602e8abd5baaec88d295a047ca449bf1d	https://github.com/servo/servo/pull/32065	Update some dependencies (#32065)
>>> 2024-04-15T06:05:22Z
>>> 2024-04-16T06:06:39Z
+++ 8bcb316c92d680d4873152e5ec15a63bb4f33220	https://github.com/servo/servo/pull/32068	layout: Add support for `background-attachment: fixed` (#32068)
+++ f3790415974bd1318ff2c2a66ab9b169c5b4c2fe	https://github.com/servo/servo/pull/32069	layout: Add support for `<object>` with image data URLs (#32069)
    a77c15ee1613d1682affea55a3e821e42ccf71f0	https://github.com/servo/servo/pull/32087	build(deps): bump proc-macro2 from 1.0.79 to 1.0.80 (#32087)
    1311c2634499c9a3819471dbfc15f94ca7f02c56	https://github.com/servo/servo/pull/32085	build(deps): bump ab_glyph from 0.2.24 to 0.2.25 (#32085)
    2f0c6c41d563b154e86d1f43542895ae78636bdb	https://github.com/servo/servo/pull/32084	build(deps): bump cc from 1.0.92 to 1.0.94 (#32084)
    c2b40b5632fc0362dee4f5bcd1ea8ceb573bad7a	https://github.com/servo/servo/pull/32082	build(deps): bump jobserver from 0.1.29 to 0.1.30 (#32082)
    1898394cb363114e67ba2ea1ae8cff2802062c8f	https://github.com/servo/servo/pull/32037	Keep 1st collapsible space after a preserved one (#32037)
+++ 5083dc7d170b1c1b9c27a278400ec2e7b5ae17cd	https://github.com/servo/servo/pull/32067	Add minibrowser update on window resize event (#32067)
>>> 2024-04-17T06:09:15Z
+++ 6b2fa91357ea289d03e206018389c43ffd836047	https://github.com/servo/servo/pull/32034	gfx: Remove `FontTemplateData` (#32034)
    689c14471430bb331ff0d46d5be7e16b81a1de54	https://github.com/servo/servo/pull/32099	build(deps): bump clipboard-win from 5.3.0 to 5.3.1 (#32099)
    2d7f764d7f39f4280d9c6f3555a23563fa638395	https://github.com/servo/servo/pull/32098	build(deps): bump prettyplease from 0.2.17 to 0.2.19 (#32098)
    544fb0c4baf0ffd0ce0777a3c2901365179e8fd1	https://github.com/servo/servo/pull/32097	build(deps): bump syn from 2.0.58 to 2.0.59 (#32097)
    c7ad74a9af321a238d6cb37c5a58659c7be30c57	https://github.com/servo/servo/pull/32096	build(deps): bump serde_json from 1.0.115 to 1.0.116 (#32096)
+++ 7a507a4d5b35e572916bb387a5d2fb0c642660fa	https://github.com/servo/servo/pull/32093	Backout `Host`-header related change from #32024. (#32093)
+++ f5bdfdfe94d05dfb7a98063304fe5b9b01229aba	https://github.com/servo/servo/pull/32089	Upgrade Stylo to 2024-03-01 (#32089)
    0678136b17d2e5f761a632db49d2177073b4ceea	https://github.com/servo/servo/pull/32083	build(deps): bump chrono from 0.4.37 to 0.4.38 (#32083)
    4cc1ecd2a1d0233b30451e06f00ad291524fabd5	https://github.com/servo/servo/pull/32088	build(deps): bump either from 1.10.0 to 1.11.0 (#32088)
>>> 2024-04-18T06:09:20Z
+++ 5393d30a8eb92f0a62ca37bb1486927fdf3604ff	https://github.com/servo/servo/pull/32101	Simplify `FontHandle` and rename it to `PlatformFont` (#32101)
    e9e46f4c0bf54c9ed1ba70c33cc9bcfe33c5e1c7	https://github.com/servo/servo/pull/32105	build(deps): bump proc-macro2 from 1.0.80 to 1.0.81 (#32105)
    03a64cf06c72292bb318bad6634a32200a007b73	https://github.com/servo/servo/pull/32104	build(deps): bump serde from 1.0.197 to 1.0.198 (#32104)
+++ 4ec61c2cdc46d73a3047f4f7e2454465e022420c	https://github.com/servo/servo/pull/32094	layout: Add support for `clear` on `<br>` elements (#32094)
+++ 83dec920dd5cd0cd3907a794e79c826b6521c054	https://github.com/servo/servo/pull/32100	Rename `FontTemplateInfo` to `FontTemplateAndWebRenderFontKey` (#32100)
+++ ab2b001265d9e9ec92542812bf301c6642f0595b	https://github.com/servo/servo/pull/32035	Nix: allow nix-shell without explicit path to shell.nix (#32035)
>>> 2024-04-19T06:06:21Z
?o  21ea6d21f0f3bcb2e736082e397ef99cf9ecd051	https://github.com/servo/servo/pull/32113	clippy: Fix `explicit_auto_deref` warnings in `components/script` (#32113)
    5ac756fd090cb72a53f482c62170a66794e56e78	https://github.com/servo/servo/pull/32111	build(deps): bump syn from 2.0.59 to 2.0.60 (#32111)
?o  2a967119c7608d110bbdc57eaee5ab683b77ac78	https://github.com/servo/servo/pull/32110	clippy: Fix `map_flatten` warning in `components/script` (#32110)
?o  f89c53bd51ab3dbbdaa32f23c63afc506eefad14	https://github.com/servo/servo/pull/32108	clippy: Fix clone_on_copy warnings (#32108)
>>> 2024-04-20T06:07:51Z
    bcf538dbc87eb7b8d77aba43f86b5965b5c07b44	https://github.com/servo/servo/pull/32116	build(deps): bump rustls from 0.21.10 to 0.21.11 (#32116)
    96c9a2a8bb9d33ce86c2654e8232eb632a89e888	https://github.com/servo/servo/pull/31948	layout: Have `current_block_direction_position` in `PlacementState` use `Au` (#31948)
?o  007a72fe4de1901feec920e7ca995bbe8f56ef48	https://github.com/servo/servo/pull/32107	Fixed some clippy warnings in components (#32107)
    f70413baba624751c76df97d269bdb9fa0bf3495	https://github.com/servo/servo/pull/32048	script: Add an implementation of `Default` for `Documents` (#32048)
?o  df4c56efa493651cbaa413b90b4cbf2ff92c0c21	https://github.com/servo/servo/pull/32109	clippy: Fix collapsible_if warning (#32109)
>>> 2024-04-21T06:05:58Z
>>> 2024-04-22T06:08:44Z
    025a98773223412edd8a0032a44c60ee84d69eee	https://github.com/servo/servo/pull/32124	docs: update README instructions for updating WPT (#32124)
    a7838ae7ccb5e2d8b02f047ce9e5263195b366ab	https://github.com/servo/servo/pull/32119	layout: Have `TextRun::glyph_run_is_preserved_newline` take into account `TextRunSegment` offset (#32119)
    fa92b0f65f5cbc016474eae16ef5c387edd27f89	https://github.com/servo/servo/pull/32123	test: add WPT user-timing tests (#32123)
    f3c2edb743ca44ad6aacdb5dd4e2319f6bb1a77c	https://github.com/servo/servo/pull/32121	Update web-platform-tests to revision b'015f19c5b653f51f2e38ebe97ec0ff62523f57de' (#32121)
>>> 2024-04-23T06:09:11Z
    7ca920927c7e5f25e59557f825c4774381750e01	https://github.com/servo/servo/pull/32135	build(deps): bump thiserror from 1.0.58 to 1.0.59 (#32135)
    a0640c8524b471462af8a352d87c38fa63337914	https://github.com/servo/servo/pull/32130	Address issues uncovered by rust-1.78 beta (#32130)
    f65010c97d50f0e2172c9d4477cc702099d44263	https://github.com/servo/servo/pull/32136	build(deps): bump cc from 1.0.94 to 1.0.95 (#32136)
    60fcb033fffa954a66d8f406d2551ac370df0b00	https://github.com/servo/servo/pull/32133	build(deps): bump rustix from 0.38.32 to 0.38.33 (#32133)
    8a4b419e3a081ee85158d6aec9f6312163c40ed0	https://github.com/servo/servo/pull/32134	build(deps): bump jobserver from 0.1.30 to 0.1.31 (#32134)
+++ 7d63c7607f12e6ef89e748b360e8e9265eae577b	https://github.com/servo/servo/pull/32081	script_layout: Remove script to layout messages (#32081)
+++ 97376e6d96abcbdfd30f3a91ec5aee7ce2add178	https://github.com/servo/servo/pull/32114	layout: Add a basic support for `list-style-position: outside` (#32114)
+++ 363651c7f756e7b47281bbe22fda21b7ccfda7e3	https://github.com/servo/servo/pull/32122	fonts: Fix emoji font selection on macOS (#32122)
+++ 821893b2eecfc72918ab8154c3cb61cd45d53857	https://github.com/servo/servo/pull/32127	fonts: Rework platform font initialization (#32127)
    25b182c372427e798954b814b0f1a0875ab43f98	https://github.com/servo/servo/pull/32120	fix(user-timing): fix clearing marks/measures by name (#32120)
    f9e154af5543063e4a168b92948d1009c73f2bf3	https://github.com/servo/servo/pull/32125	Fix InsertRule to use the right CssRuleTypes (#32125)
?o  67f239d1bab9e866539ea4ef76a1d40bcbeb7d53	https://github.com/servo/servo/pull/32126	clippy: fix several lint warns (#32126)
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
    }
    ._figr {
        float: right;
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
