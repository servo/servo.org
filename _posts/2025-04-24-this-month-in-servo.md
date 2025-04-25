---
layout:     post
tags:       blog
title:      "This month in Servo: ????"
date:       2025-04-24
summary:    Who knows?
categories:
---

## Servo-the-browser (servoshell)

servoshell supports a new command-line argument: **`--enable-experimental-web-platform-features`**. This argument enables incomplete engine features
that are not ready to be turned on by default. This can be useful when a page is not functioning correctly, since it may allow the page to make further progress.
The features enabled by this flag are expected to change over time as new web platform features are implemented in Servo.

We fixed a crash when resizing the browsing area too small (@sebsebmc@gmail.com, #35967).
Dialogs now support **keyboard interaction** to close and cancel them (@chickenleaf, #3567), and the URL bar accepts any **domain-like input** (@k+github@kafji.net, #35756).
We also enabled **sRGB colorspaces** on macOS for better colour fidelity (@IsaacMarovitz, #35683).


<!--
- animated-images
    - https://github.com/servo/servo/pull/36058	(@rayguo17, #36058)	pixels: Extend Image to allow for multiple frames (#36058)
      animated-images
    - https://github.com/servo/servo/pull/36141	(@rayguo17, #36141)	Animation: Aggregate Animated Image Info to Document (#36141)
      animated-images
- canvas
    - https://github.com/servo/servo/pull/35719	(@sagudev, #35719)	canvas: Do not update ImageKey during canvas layout (#35719)
      performance canvas
- cleanup
    - https://github.com/servo/servo/pull/35821	(@Loirooriol, #35821)	layout: Remove `calculate_hypothetical_cross_size()` (#35821)
      layout cleanup
    - https://github.com/servo/servo/pull/35943	(@Loirooriol, #35943)	Remove legacy layout (layout 2013) (#35943)
      cleanup
- crash
    - https://github.com/servo/servo/pull/35725	(@simonwuelker, #35725)	Don't recurse in Node::GetRootNode (#35725)
      performance crash
    - https://github.com/servo/servo/pull/35740	(@webbeef, #35740)	Set a valid default value for the --userscripts command line option (#35740)
      crash
    - https://github.com/servo/servo/pull/35763	(@kongbai1996, @schwenderjonathan@gmail.com, #35763)	Fix the problem that touchmove crashes occasionally. Fix crash when multiple touch cancels occur (#35763)
      touch crash
    - https://github.com/servo/servo/pull/35753	(@jdm, #35753)	script: Mark callback methods with CanGc. (#35753)
      dom crash
    - https://github.com/servo/servo/pull/35742	(@leftmostcat@gmail.com, #35742)	script: Avoid double borrow crash on iframe focus (#35742)
      crash
    - https://github.com/servo/servo/pull/35865	(@boluochoufeng, #35865)	Fix the parsing error of PrefValue::Array, which is used for the parsing of Preferences shell_background_color_rgba field (#35865)
      crash
    - https://github.com/servo/servo/pull/36014	(@aryaajitnair@gmail.com, #36014)	feat: add CanGc argument to Error::to_jsval (#36014)
      dom crash
    - https://github.com/servo/servo/pull/36043	(@aryaajitnair@gmail.com, #36043)	feat: add can_gc argument to to_frozen_array (#36043)
      dom crash
    - https://github.com/servo/servo/pull/35892	(@greg-morenz@droid.cafe, #35892)	Use explicit reborrows with mozjs::MutableHandle (#35892)
      crash
    - https://github.com/servo/servo/pull/36156	(@aryaajitnair@gmail.com, #36156)	feat: add CanGc argument in get_dictionary_property (#36156)
      dom crash
    - https://github.com/servo/servo/pull/36116	(@jdm, #36116)	script: Expose new methods for obtaining a global that require a realm. (#36116)
      dom crash
    - https://github.com/servo/servo/pull/36160	(@greg-morenz@droid.cafe, #36160)	Stop using MutableHandle's DerefMut impl (#36160)
      dom crash
    - https://github.com/servo/servo/pull/36161	(@greg-morenz@droid.cafe, #36161)	Stop using JS::MutableHandle's DerefMut impl (#36161)
      dom crash
    - https://github.com/servo/servo/pull/36158	(@greg-morenz@droid.cafe, #36158)	Stop using `RootedGuard's` DerefMut impl (#36158)
      dom crash
    - https://github.com/servo/servo/pull/36180	(@abonghoderick@gmail.com, #36180)	Propagate CanGc arguments through HTMLCollection constructors (#36180)
      dom crash
    - https://github.com/servo/servo/pull/36111	(@abonghoderick@gmail.com, #36111)	resolve issue #36074 new_js_regex and matches_js_regex need a CanGc argument (#36111)
      dom crash
- csp
    - https://github.com/servo/servo/pull/35876	(@simonwuelker, #35876)	Implement `nonce` attribute to pass more CSP checks (#35876)
      dom csp
- css
    - https://github.com/servo/servo/pull/35670	(@yezhizhen, #35670)	layout: Merge `BoxFragment::used_overflow` into `ComputedValuesExt::effective_overflow` (#35670) (#35670)
      css
    - https://github.com/servo/servo/pull/35682	(@Loirooriol, #35682)	layout: Partial support for keyword sizes on preferred cross size (#35682)
      css
    - https://github.com/servo/servo/pull/35808	(@HastD, #35808)	layout: Make `transform-style: preserve-3d` establish a containing block for all descendants (#35808)
      css
    - https://github.com/servo/servo/pull/35787	(@yezhizhen, #35787)	layout: support CSS will-change (#35787)
      css
    - https://github.com/servo/servo/pull/35574	(@longvatrong111, #35574)	Fix UA style value for textarea (#35574)
      css
- devtools
    - https://github.com/servo/servo/pull/35745	(@simonwuelker, #35745)	Respond to the `connect` message from a devtools client (#35745)
      devtools
    - https://github.com/servo/servo/pull/35792	(@atbrakhi, #35792)	devtools: update targeted firefox version. (#35792)
      devtools
    - https://github.com/servo/servo/pull/35728	(@webbeef, #35728)	Add an about:memory page (#35728)
      devtools
    - https://github.com/servo/servo/pull/35874	(@simonwuelker, #35874)	Register iframes with the devtools (#35874)
      devtools
    - https://github.com/servo/servo/pull/35870	(@stephenmuss, #35870)	Show correctly computed element display type in devtools (#35870)
      devtools
    - https://github.com/servo/servo/pull/35958	(@simonwuelker, #35958)	Hide servo internal shadow roots from the inspector by default (#35958)
      devtools
    - https://github.com/servo/servo/pull/35884	(@atbrakhi, #35884)	devtools: use correct id for browser_id and outer_window_id (#35884)
      devtools
- do
    - https://github.com/servo/servo/pull/36200	(@kongbai1996, #36200)	Fixed the problem that touchmove cannot be disabled when preventDefault is invoked on touchstart. (#36200)
      do touchm
- dom
    - https://github.com/servo/servo/pull/35718	(@xiaochengh, #35718)	script: Implement preparation-time document (#35718)
      dom
    - https://github.com/servo/servo/pull/35713	(@kongbai1996, #35713)	add `cancelable` property to the `TouchEvent` (#35713)
      dom
    - https://github.com/servo/servo/pull/35753	(@jdm, #35753)	script: Mark callback methods with CanGc. (#35753)
      dom crash
    - https://github.com/servo/servo/pull/35769	(@simonwuelker, #35769)	Let layout invalidations happen in the flat tree (#35769)
      layout dom
    - https://github.com/servo/servo/pull/35864	(@kkoyung, #35864)	Implement can-have-its-url-rewritten for history api (#35864)
      dom
    - https://github.com/servo/servo/pull/35789	(@dklassic, #35789)	feat: display file chosen for input file (#35789)
      dom
    - https://github.com/servo/servo/pull/35802	(@simonwuelker, #35802)	Keep a list of slot descendants on each shadow root (#35802)
      performance dom
    - https://github.com/servo/servo/pull/35410	(@Taym95, @gterzian, #35410)	script: implement ReadableByteStreamController (#35410)
      dom stream
    - https://github.com/servo/servo/pull/35871	(@simonwuelker, #35871)	Don't run scripts in documents that don't have a browsing context (#35871)
      dom
    - https://github.com/servo/servo/pull/35849	(@xiaochengh, #35849)	Fix animation frame callback cancellation (#35849)
      dom
    - https://github.com/servo/servo/pull/35877	(@shanehandley, #35877)	script: use passive event listener option on AddEventListenerOptions (#35877)
      dom
    - https://github.com/servo/servo/pull/35876	(@simonwuelker, #35876)	Implement `nonce` attribute to pass more CSP checks (#35876)
      dom csp
    - https://github.com/servo/servo/pull/35923	(@simonwuelker, #35923)	Implement `ElementInternals::shadowRoot` (#35923)
      dom shadowdom
    - https://github.com/servo/servo/pull/35899	(@simonwuelker, #35899)	Enable ShadowDom support by default (#35899)
      dom shadowdom
    - https://github.com/servo/servo/pull/35930	(@simonwuelker, #35930)	Set `is` value when constructing custom elements with the `new` operator (#35930)
      dom
    - https://github.com/servo/servo/pull/35960	(@xiaochengh, #35960)	Check whether an element is custom in the spec-compliant way (#35960)
      dom
    - https://github.com/servo/servo/pull/35883	(@xiaochengh, #35883)	Don't run disconnected callback on already disconnected custom elements (#35883)
      dom
    - https://github.com/servo/servo/pull/35970	(@simonwuelker, #35970)	script: Implement HTMLOptgroupElement::Label (#35970)
      dom
    - https://github.com/servo/servo/pull/35949	(@sebsebmc@gmail.com, #35949)	Bring back DOM GC checkpoint to script_thread (#35949)
      dom
    - https://github.com/servo/servo/pull/35831	(@jdm, #35831)	Refactor common boilerplate out of serialize/transfer implementations (#35831)
      dom
    - https://github.com/servo/servo/pull/35988	(@jdm, #35988)	Move CustomTraceable to script_bindings. (#35988)
      dom split
    - https://github.com/servo/servo/pull/35987	(@jdm, #35987)	Cleanups for future script crate split (#35987)
      dom split
    - https://github.com/servo/servo/pull/35969	(@gterzian, #35969)	Use stream in file read operation (#35969)
      dom stream
    - https://github.com/servo/servo/pull/36014	(@aryaajitnair@gmail.com, #36014)	feat: add CanGc argument to Error::to_jsval (#36014)
      dom crash
    - https://github.com/servo/servo/pull/34964	(@longvatrong111, #34964)	Implement declarative shadow dom (#34964)
      dom shadowdom
    - https://github.com/servo/servo/pull/35878	(@pewsheen, #35878)	feat: fetch notification image resources (#35878)
      dom notification
    - https://github.com/servo/servo/pull/35650	(@gterzian, @Taym95, #35650)	Streams: Implement stream pipe-to (#35650)
      dom stream
    - https://github.com/servo/servo/pull/35551	(@stevennovaryo, #35551)	dom: Implement minimal IntersectionObserver workflow (#35551)
      dom
    - https://github.com/servo/servo/pull/36010	(@simonwuelker, #36010)	Set composed flag for mouse events dispatched by the UA (#36010)
      dom
    - https://github.com/servo/servo/pull/36043	(@aryaajitnair@gmail.com, #36043)	feat: add can_gc argument to to_frozen_array (#36043)
      dom crash
    - https://github.com/servo/servo/pull/36024	(@longvatrong111, #36024)	Make Element::attach_shadow() and ShadowRoot closer to spec (#36024)
      dom shadowdom
    - https://github.com/servo/servo/pull/35993	(@simonwuelker, #35993)	script: Implement `Range::getClientRects` and `Range::getBoundingClientRect` (#35993)
      dom
    - https://github.com/servo/servo/pull/36054	(@stephenmuss, #36054)	Support align attribute on HTMLParagraphElement interface (#36054)
      dom
    - https://github.com/servo/servo/pull/36095	(@jdm, #36095)	crown: Do not check trait item projections. (#36095)
      dom
    - https://github.com/servo/servo/pull/36090	(@elomscansio, #36090)	Fix form validation for readonly inputs and update WPT expectations (#36090)
      dom
    - https://github.com/servo/servo/pull/36103	(@jerensl, #36103)	fix: radio input element don't trigger validity state (#36103)
      dom
    - https://github.com/servo/servo/pull/36106	(@simonwuelker, #36106)	script: Implement `Element::GetHTML` and `ShadowRoot::GetHTML` (#36106)
      dom shadowdom
    - https://github.com/servo/servo/pull/36107	(@jdm, #36107)	script: Ensure promises are considered DOM interfaces when generating bindings. (#36107)
      dom split
    - https://github.com/servo/servo/pull/36104	(@simonwuelker, #36104)	Don't clear children of declarative shadow hosts when imperatively attaching another shadow root (#36104)
      dom shadowdm
    - https://github.com/servo/servo/pull/36082	(@Loirooriol, @mrobinson, #36082)	layout: Cache `IndependentNonReplacedContents::layout()` (#36082)
      dom notification
    - https://github.com/servo/servo/pull/36136	(@mrees@noeontheend.com, #36136)	Fix check in get_array_index_from_id to return early on ASCII char (#36136)
      dom
    - https://github.com/servo/servo/pull/36156	(@aryaajitnair@gmail.com, #36156)	feat: add CanGc argument in get_dictionary_property (#36156)
      dom crash
    - https://github.com/servo/servo/pull/36097	(@jdm, #36097)	script: Support converting JS values to Rc<Promise> with FromJSValConvertible. (#36097)
      dom
    - https://github.com/servo/servo/pull/35989	(@jdm, @mrobinson, #35989)	Make DOMPoint and DOMPointReadOnly serializable (#35989)
      dom
    - https://github.com/servo/servo/pull/36116	(@jdm, #36116)	script: Expose new methods for obtaining a global that require a realm. (#36116)
      dom crash
    - https://github.com/servo/servo/pull/36112	(@elomscansio, @jdm, #36112)	Fix Backspace deleting entire previous line in `<textarea>` (#36112)
      dom
    - https://github.com/servo/servo/pull/36160	(@greg-morenz@droid.cafe, #36160)	Stop using MutableHandle's DerefMut impl (#36160)
      dom crash
    - https://github.com/servo/servo/pull/36048	(@gterzian, #36048)	Use read all bytes when consuming body (#36048)
      dom stream
    - https://github.com/servo/servo/pull/36161	(@greg-morenz@droid.cafe, #36161)	Stop using JS::MutableHandle's DerefMut impl (#36161)
      dom crash
    - https://github.com/servo/servo/pull/36173	(@elomscansio, #36173)	fix(parser): Set shadow’s available to element internals in attach_declarative_shadow (#36173)
      dom shadowdom
    - https://github.com/servo/servo/pull/36144	(@simonwuelker, #36144)	Start implementing the `URLPattern` API (#36144)
      dom
    - https://github.com/servo/servo/pull/36163	(@andrei.volykhin@gmail.com, #36163)	dom: Track "removed" event listener status (#36163)
      dom
    - https://github.com/servo/servo/pull/36192	(@abotella@igalia.com, #36192)	Consume BOM in the `text()` method of fetch bodies (#36192)
      dom
    - https://github.com/servo/servo/pull/36194	(@abotella@igalia.com, #36194)	Fix content-type when creating a `Request` with `FormData` body (#36194)
      dom
    - https://github.com/servo/servo/pull/36158	(@greg-morenz@droid.cafe, #36158)	Stop using `RootedGuard's` DerefMut impl (#36158)
      dom crash
    - https://github.com/servo/servo/pull/36197	(@barigbuenbira@gmail.com, #36197)	fix: prevent missing value error for radio button inputs without a name (#36197)
      dom
    - https://github.com/servo/servo/pull/36218	(@kongbai1996, #36218)	Fixed an incorrect touchmove event triggered when the second finger is pressed. (#36218)
      dom touch
    - https://github.com/servo/servo/pull/36180	(@abonghoderick@gmail.com, #36180)	Propagate CanGc arguments through HTMLCollection constructors (#36180)
      dom crash
    - https://github.com/servo/servo/pull/36111	(@abonghoderick@gmail.com, #36111)	resolve issue #36074 new_js_regex and matches_js_regex need a CanGc argument (#36111)
      dom crash
    - https://github.com/servo/servo/pull/36216	(@jdm, #36216)	Miscellaneous script splitting preparation changes (#36216)
      dom split
    - https://github.com/servo/servo/pull/36226	(@simonwuelker, #36226)	Only invoke resize observer callback when the observed element changed its size (#36226)
      dom
    - https://github.com/servo/servo/pull/36220	(@jdm, #36220)	More miscellaneous script splitting changes (#36220)
      dom split
- embedding
    - https://github.com/servo/servo/pull/35934	(@DevGev, #35934)	compositing: Move `cursor_pos` member and update it in `update_cursor()` (#35934)
      embedding
    - https://github.com/servo/servo/pull/35761	(@yezhizhen, #35761)	Create `config_dir` if none exist for caching (#35761)
      embedding
    - https://github.com/servo/servo/pull/35668	(@delan, #35668)	libservo: Notify delegates of send errors in request objects (#35668)
      embedding
    - https://github.com/servo/servo/pull/35017	(@webbeef, @mrobinson, #35017)	script: Allow opening links in a new `WebView` (#35017)
      embedding
    - https://github.com/servo/servo/pull/35388	(@Legend-Master, #35388)	Allow setting userscripts directly without the need of files (#35388)
      embedding
- flexbox
    - https://github.com/servo/servo/pull/35860	(@Loirooriol, #35860)	layout: Support min/max cross keywords sizes in flexbox (#35860)
      layout flexbox
    - https://github.com/servo/servo/pull/35961	(@Loirooriol, #35961)	layout: Support min/max main keyword sizes in flexbox (#35961)
      layout flexbox
    - https://github.com/servo/servo/pull/36123	(@mrobinson, #36123)	layout: Ensure compatible positioning context during flexbox block content sizing calculation (#36123)
      layout flexbox
- layout
    - https://github.com/servo/servo/pull/35705	(@mrobinson, #35705)	fonts: Remove the per-FontGroup cached fallback font (#35705)
      layout
    - https://github.com/servo/servo/pull/35769	(@simonwuelker, #35769)	Let layout invalidations happen in the flat tree (#35769)
      layout dom
    - https://github.com/servo/servo/pull/35821	(@Loirooriol, #35821)	layout: Remove `calculate_hypothetical_cross_size()` (#35821)
      layout cleanup
    - https://github.com/servo/servo/pull/35860	(@Loirooriol, #35860)	layout: Support min/max cross keywords sizes in flexbox (#35860)
      layout flexbox
    - https://github.com/servo/servo/pull/35882	(@Loirooriol, #35882)	layout: Only prevent fixed table layout when `inline-size` is `auto` (#35882)
      layout table
    - https://github.com/servo/servo/pull/35826	(@Loirooriol, #35826)	layout: Handle keyword sizes when computing the hypothetical cross size (#35826)
      layout
    - https://github.com/servo/servo/pull/35904	(@Loirooriol, #35904)	layout: Fix interaction of margin and stretch size on block-level boxes (#35904)
      layout
    - https://github.com/servo/servo/pull/35275	(@Loirooriol, #35275)	layout: Remove special height logic of replaced element with auto width (#35275)
      layout
    - https://github.com/servo/servo/pull/35965	(@Loirooriol, #35965)	layout: Allow lazy resolution of automatic minimum sizes (#35965)
      layout
    - https://github.com/servo/servo/pull/35947	(@Loirooriol, #35947)	Improve logic for establishing a stacking context (#35947)
      layout
    - https://github.com/servo/servo/pull/35926	(@chocolate-pie, @Loirooriol, #35926)	layout: Add support for basic transform css properties (#35926)
      layout
    - https://github.com/servo/servo/pull/36030	(@Loirooriol, #36030)	layout: Fix intrinsic contributions of indefinite `stretch` keyword (#36030)
      layout
    - https://github.com/servo/servo/pull/36051	(@Loirooriol, #36051)	layout: Stop ignoring containing block padding for the static position (#36051)
      layout
    - https://github.com/servo/servo/pull/36015	(@Loirooriol, #36015)	layout: Obey sizing keywords in `layout_for_block_content_size()` (#36015)
      layout
    - https://github.com/servo/servo/pull/35961	(@Loirooriol, #35961)	layout: Support min/max main keyword sizes in flexbox (#35961)
      layout flexbox
    - https://github.com/servo/servo/pull/36045	(@Loirooriol, #36045)	layout: Don't consider a definite `stretch` size as intrinsic (#36045)
      layout
    - https://github.com/servo/servo/pull/35908	(@kenzieradityatirtarahardja18@gmail.com, @kenzieradityatirtarahardja.18@gmail.com, #35908)	Make input element display-inside always flow-root (#35908)
      layout
    - https://github.com/servo/servo/pull/36064	(@kenzieradityatirtarahardja18@gmail.com, @kenzieradityatirtarahardja.18@gmail.com, #36064)	Max assign outer block size to cell measures (#36064)
      layout
    - https://github.com/servo/servo/pull/36056	(@Loirooriol, #36056)	layout: Implement the `fit-content()` sizing function (#36056)
      layout
    - https://github.com/servo/servo/pull/36123	(@mrobinson, #36123)	layout: Ensure compatible positioning context during flexbox block content sizing calculation (#36123)
      layout flexbox
    - https://github.com/servo/servo/pull/36210	(@chocolate-pie, #36210)	layout: Implement support for `image-set()` notation (#36210)
      layout
    - https://github.com/servo/servo/pull/36202	(@mrobinson, #36202)	layout: Simplify and generalize the usage of pseudo-elements (#36202)
      layout
- macOS
    - https://github.com/servo/servo/pull/35683	(@IsaacMarovitz, #35683)	servoshell: Use sRGB colorspace on macOS (#35683)
      servoshell macOS
- notification
    - https://github.com/servo/servo/pull/35878	(@pewsheen, #35878)	feat: fetch notification image resources (#35878)
      dom notification
    - https://github.com/servo/servo/pull/36082	(@Loirooriol, @mrobinson, #36082)	layout: Cache `IndependentNonReplacedContents::layout()` (#36082)
      dom notification
- ohos
    - https://github.com/servo/servo/pull/35790	(@jschwe, #35790)	Rename ohos app bundle (#35790)
      ohos
- performance
    - https://github.com/servo/servo/pull/35638	(@mrobinson, #35638)	libservo: Stop double-buffering `OffscreenRenderingContext` (#35638)
      performance
    - https://github.com/servo/servo/pull/35725	(@simonwuelker, #35725)	Don't recurse in Node::GetRootNode (#35725)
      performance crash
    - https://github.com/servo/servo/pull/35781	(@jschwe, #35781)	Reduce allocations in layout_block_level_children_in_parallel (#35781)
      performance
    - https://github.com/servo/servo/pull/35785	(@kongbai1996, #35785)	Optimize IPC for non-cancelable touch events (#35785)
      performance
    - https://github.com/servo/servo/pull/35816	(@Loirooriol, #35816)	layout: Assert that `hypothetical_cross_size` is already correct (#35816)
      performance
    - https://github.com/servo/servo/pull/35802	(@simonwuelker, #35802)	Keep a list of slot descendants on each shadow root (#35802)
      performance dom
    - https://github.com/servo/servo/pull/35719	(@sagudev, #35719)	canvas: Do not update ImageKey during canvas layout (#35719)
      performance canvas
- servosheell
    - https://github.com/servo/servo/pull/35673	(@chickenleaf, #35673)	servoshell: Allow keyboard interaction with dialogs (enter / escape) (#35673)
      servosheell
- servoshell
    - https://github.com/servo/servo/pull/35756	(@k+github@kafji.net, #35756)	Allow domain-like as URL location input (#35756)
      servoshell
    - https://github.com/servo/servo/pull/36022	(@rego@igalia.com, @Loirooriol, #36022)	Add --enable-experimental-web-platform-features command line (#36022)
      servoshell
    - https://github.com/servo/servo/pull/35683	(@IsaacMarovitz, #35683)	servoshell: Use sRGB colorspace on macOS (#35683)
      servoshell macOS
    - https://github.com/servo/servo/pull/35967	(@sebsebmc@gmail.com, #35967)	bugfix: servoshell: prevent 0 pixel dimensions for render area (#35967)
      servoshell
- shadowdm
    - https://github.com/servo/servo/pull/36104	(@simonwuelker, #36104)	Don't clear children of declarative shadow hosts when imperatively attaching another shadow root (#36104)
      dom shadowdm
- shadowdom
    - https://github.com/servo/servo/pull/35923	(@simonwuelker, #35923)	Implement `ElementInternals::shadowRoot` (#35923)
      dom shadowdom
    - https://github.com/servo/servo/pull/35899	(@simonwuelker, #35899)	Enable ShadowDom support by default (#35899)
      dom shadowdom
    - https://github.com/servo/servo/pull/34964	(@longvatrong111, #34964)	Implement declarative shadow dom (#34964)
      dom shadowdom
    - https://github.com/servo/servo/pull/36024	(@longvatrong111, #36024)	Make Element::attach_shadow() and ShadowRoot closer to spec (#36024)
      dom shadowdom
    - https://github.com/servo/servo/pull/36106	(@simonwuelker, #36106)	script: Implement `Element::GetHTML` and `ShadowRoot::GetHTML` (#36106)
      dom shadowdom
    - https://github.com/servo/servo/pull/36173	(@elomscansio, #36173)	fix(parser): Set shadow’s available to element internals in attach_declarative_shadow (#36173)
      dom shadowdom
- split
    - https://github.com/servo/servo/pull/35988	(@jdm, #35988)	Move CustomTraceable to script_bindings. (#35988)
      dom split
    - https://github.com/servo/servo/pull/35987	(@jdm, #35987)	Cleanups for future script crate split (#35987)
      dom split
    - https://github.com/servo/servo/pull/36107	(@jdm, #36107)	script: Ensure promises are considered DOM interfaces when generating bindings. (#36107)
      dom split
    - https://github.com/servo/servo/pull/36216	(@jdm, #36216)	Miscellaneous script splitting preparation changes (#36216)
      dom split
    - https://github.com/servo/servo/pull/36220	(@jdm, #36220)	More miscellaneous script splitting changes (#36220)
      dom split
- stream
    - https://github.com/servo/servo/pull/35410	(@Taym95, @gterzian, #35410)	script: implement ReadableByteStreamController (#35410)
      dom stream
    - https://github.com/servo/servo/pull/35969	(@gterzian, #35969)	Use stream in file read operation (#35969)
      dom stream
    - https://github.com/servo/servo/pull/35650	(@gterzian, @Taym95, #35650)	Streams: Implement stream pipe-to (#35650)
      dom stream
    - https://github.com/servo/servo/pull/36048	(@gterzian, #36048)	Use read all bytes when consuming body (#36048)
      dom stream
- table
    - https://github.com/servo/servo/pull/35882	(@Loirooriol, #35882)	layout: Only prevent fixed table layout when `inline-size` is `auto` (#35882)
      layout table
- touch
    - https://github.com/servo/servo/pull/35763	(@kongbai1996, @schwenderjonathan@gmail.com, #35763)	Fix the problem that touchmove crashes occasionally. Fix crash when multiple touch cancels occur (#35763)
      touch crash
    - https://github.com/servo/servo/pull/36218	(@kongbai1996, #36218)	Fixed an incorrect touchmove event triggered when the second finger is pressed. (#36218)
      dom touch
- touchm
    - https://github.com/servo/servo/pull/36200	(@kongbai1996, #36200)	Fixed the problem that touchmove cannot be disabled when preventDefault is invoked on touchstart. (#36200)
      do touchm
- upgrade
    - https://github.com/servo/servo/pull/35782	(@Loirooriol, #35782)	Upgrade Stylo to 2025-03-01 (#35782)
      upgrade
    - https://github.com/servo/servo/pull/34714	(@asun0204@163.com, @Loirooriol, #34714)	Bump Stylo to from a93e7ef to 4add86f (#34714)
      upgrade
    - https://github.com/servo/servo/pull/35925	(@nicoburns, #35925)	Upgrade Stylo to 2025-03-01 (#35925)
      upgrade
    - https://github.com/servo/servo/pull/35755	(@simonwuelker, #35755)	Migrate to the 2024 edition (#35755)
      upgrade
    - https://github.com/servo/servo/pull/35990	(@nicoburns, #35990)	Upgrade Stylo to 2025-03-15 (#35990)
      upgrade
    - https://github.com/servo/servo/pull/36169	(@virtualritz@protonmail.com, #36169)	Made MAX_TASK_NS u128. Also removed a superfluous into(). Both were required to fix #36122 with nightly 1.85.0 (4d91de4e4 2025-02-17). (#36169)
      upgrade
- ux
    - https://github.com/servo/servo/pull/35794	(@jschwe, #35794)	servoshell: Minor fixes to cli help. (#35794)
      ux
- webdriver
    - https://github.com/servo/servo/pull/35737	(@jdm, #35737)	Various fixes for webdriver conformance tests (#35737)
      webdriver
- webview
    - https://github.com/servo/servo/pull/35701	(@mrobinson, @delan, #35701)	compositor: Make `PipelineDetails` and pending paint metrics per-WebView (#35701)
      webview
    - https://github.com/servo/servo/pull/35716	(@delan, @mrobinson, #35716)	compositor: Make input event handling per-WebView (#35716)
      webview
-->

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