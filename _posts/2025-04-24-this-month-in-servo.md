---
layout:     post
tags:       blog
title:      "This month in Servo: ????"
date:       2025-04-24
summary:    Who knows?
categories:
---

We merged the first steps to supporting **animated images** in web content (@rayguo17, #36058 #36141).

Servo's ShadowDOM implementation has made significant progress and we've enabled it by default, allowing Servo to render sites like wpt.fyi correctly (TODO screenshot) (@simonwuelker, @longvatron111, @elomscansio, #35923 #35899 #35930 #36104 #34964 #36024 #36106 #36173 #36010).

There was lots of progress made on additional web API features in the engine:
* we implemented **ReadableByteStreamController and ReadableStream.pipeTo** (@Taym95, @gterzian, #35410 #35650)
* the `nonce` attribute is now used in CSP checks (@simonwuelker, #35876)
* we removed some cases where custom elements callbacks fired incorrect (@xiaochengh, #35960 #35883)
* partial support for `InterSectionObserver` was added (@stevennovaryo, #35551)
* we implemented `Range::getClientRects` and `Range::getBoundingClientRect` (@simonwuelker, #35993)


## Servo-the-browser (servoshell)

servoshell supports a new command-line argument: **`--enable-experimental-web-platform-features`**. This argument enables incomplete engine features
that are not ready to be turned on by default. This can be useful when a page is not functioning correctly, since it may allow the page to make further progress.
The features enabled by this flag are expected to change over time as new web platform features are implemented in Servo.

We fixed a crash when resizing the browsing area too small (@sebsebmc, #35967).
Dialogs now support **keyboard interaction** to close and cancel them (@chickenleaf, #3567), and the URL bar accepts any **domain-like input** (@kafji, #35756).
We also enabled **sRGB colorspaces** on macOS for better colour fidelity (@IsaacMarovitz, #35683).
Finally, we **renamed the OpenHarmony app bundle** (@jschwe, #35790).

## Servo-the-engine (embedding)

We **added a memory usage view** for Servo embedders: visit `about:memory` for a breakdown of identified allocations (@webbeef, #35728).

### TODO: add screenshot of about:memory

Embedders can now **inject userscript sources** into all webviews (@Legend-Master, #35388).
Links can be **opened in a new tab** by pressing the ctr/meta modifier (@webbeef, @mrobinson, #35017).
Delegates will receive **send error notifications** for requests (@delan, #35668).

We fixed a bug causing **flickering cursors** (@DevGev, #35934), and now **create the config directory** if it does not exist (@yezhizhen, #35761).
We also fixed a number of bugs in the webdriver server related to clicking on elements, opening and closing windows, and returning references to exotic objects (@jdm, #35737).

Finally, we made progress towards a per-webview renderer model (@mrobinson, @delan, #35701, #35716).

## Perf and stability

The `OffscreenRenderingContext` is **no longer double buffered**, which can improve rendering performance in embeddings that rely on it.
We also removed a source of **canvas rendering latency** (@sagudev, #35719), and fixed performance cliffs related to the Shadow DOM (@simonwuelker, #35802, #35725).
We improved performance of block level layout by **reducing allocations** (@jschwe, #35781), and reduced the **latency of touch events** when they are non-cancelable (@kongbai1996, #35785).

We also fixed crashes involving multiple touchmove events (@kongbai1996, @jschwe, #35763), and focusing iframes (@leftmostcat, #35742).
The project to decrease the risk of [intermittent GC-related crashes](https://github.com/servo/servo/issues/33140) continues to make progress (@jdm, @Arya-A-Nair, @Dericko681, #35753 #36014 #36043 #36156 #36116 #36180 #36111).
Additionally, we **avoided undefined behaviour** in the Rust bindings to the SpiderMonkey engine (@gmorenz, #35892 #36160 #36161 #36158).

<!--
- cleanup
    - https://github.com/servo/servo/pull/35943	(@Loirooriol, #35943)	Remove legacy layout (layout 2013) (#35943)
      cleanup
- crash
    - https://github.com/servo/servo/pull/35740	(@webbeef, #35740)	Set a valid default value for the --userscripts command line option (#35740)
      crash
    - https://github.com/servo/servo/pull/35865	(@boluochoufeng, #35865)	Fix the parsing error of PrefValue::Array, which is used for the parsing of Preferences shell_background_color_rgba field (#35865)
      crash
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
    - https://github.com/servo/servo/pull/35769	(@simonwuelker, #35769)	Let layout invalidations happen in the flat tree (#35769)
      layout dom
    - https://github.com/servo/servo/pull/35864	(@kkoyung, #35864)	Implement can-have-its-url-rewritten for history api (#35864)
      dom
    - https://github.com/servo/servo/pull/35789	(@dklassic, #35789)	feat: display file chosen for input file (#35789)
      dom
    - https://github.com/servo/servo/pull/35871	(@simonwuelker, #35871)	Don't run scripts in documents that don't have a browsing context (#35871)
      dom
    - https://github.com/servo/servo/pull/35849	(@xiaochengh, #35849)	Fix animation frame callback cancellation (#35849)
      dom
    - https://github.com/servo/servo/pull/35877	(@shanehandley, #35877)	script: use passive event listener option on AddEventListenerOptions (#35877)
      dom
    - https://github.com/servo/servo/pull/35970	(@simonwuelker, #35970)	script: Implement HTMLOptgroupElement::Label (#35970)
      dom
    - https://github.com/servo/servo/pull/35949	(@sebsebmc, #35949)	Bring back DOM GC checkpoint to script_thread (#35949)
      dom
    - https://github.com/servo/servo/pull/35831	(@jdm, #35831)	Refactor common boilerplate out of serialize/transfer implementations (#35831)
      dom
    - https://github.com/servo/servo/pull/35988	(@jdm, #35988)	Move CustomTraceable to script_bindings. (#35988)
      dom split
    - https://github.com/servo/servo/pull/35987	(@jdm, #35987)	Cleanups for future script crate split (#35987)
      dom split
    - https://github.com/servo/servo/pull/35878	(@pewsheen, #35878)	feat: fetch notification image resources (#35878)
      dom notification
    - https://github.com/servo/servo/pull/36054	(@stephenmuss, #36054)	Support align attribute on HTMLParagraphElement interface (#36054)
      dom
    - https://github.com/servo/servo/pull/36095	(@jdm, #36095)	crown: Do not check trait item projections. (#36095)
      dom
    - https://github.com/servo/servo/pull/36090	(@elomscansio, #36090)	Fix form validation for readonly inputs and update WPT expectations (#36090)
      dom
    - https://github.com/servo/servo/pull/36103	(@jerensl, #36103)	fix: radio input element don't trigger validity state (#36103)
      dom
    - https://github.com/servo/servo/pull/36107	(@jdm, #36107)	script: Ensure promises are considered DOM interfaces when generating bindings. (#36107)
      dom split
    - https://github.com/servo/servo/pull/36082	(@Loirooriol, @mrobinson, #36082)	layout: Cache `IndependentNonReplacedContents::layout()` (#36082)
      dom notification
    - https://github.com/servo/servo/pull/36136	(@mrees@noeontheend.com, #36136)	Fix check in get_array_index_from_id to return early on ASCII char (#36136)
      dom
    - https://github.com/servo/servo/pull/36097	(@jdm, #36097)	script: Support converting JS values to Rc<Promise> with FromJSValConvertible. (#36097)
      dom
    - https://github.com/servo/servo/pull/35989	(@jdm, @mrobinson, #35989)	Make DOMPoint and DOMPointReadOnly serializable (#35989)
      dom
    - https://github.com/servo/servo/pull/36112	(@elomscansio, @jdm, #36112)	Fix Backspace deleting entire previous line in `<textarea>` (#36112)
      dom
    - https://github.com/servo/servo/pull/36144	(@simonwuelker, #36144)	Start implementing the `URLPattern` API (#36144)
      dom
    - https://github.com/servo/servo/pull/36163	(@andrei.volykhin@gmail.com, #36163)	dom: Track "removed" event listener status (#36163)
      dom
    - https://github.com/servo/servo/pull/36192	(@abotella@igalia.com, #36192)	Consume BOM in the `text()` method of fetch bodies (#36192)
      dom
    - https://github.com/servo/servo/pull/36194	(@abotella@igalia.com, #36194)	Fix content-type when creating a `Request` with `FormData` body (#36194)
      dom
    - https://github.com/servo/servo/pull/36197	(@barigbuenbira@gmail.com, #36197)	fix: prevent missing value error for radio button inputs without a name (#36197)
      dom
    - https://github.com/servo/servo/pull/36218	(@kongbai1996, #36218)	Fixed an incorrect touchmove event triggered when the second finger is pressed. (#36218)
      dom touch
    - https://github.com/servo/servo/pull/36216	(@jdm, #36216)	Miscellaneous script splitting preparation changes (#36216)
      dom split
    - https://github.com/servo/servo/pull/36226	(@simonwuelker, #36226)	Only invoke resize observer callback when the observed element changed its size (#36226)
      dom
    - https://github.com/servo/servo/pull/36220	(@jdm, #36220)	More miscellaneous script splitting changes (#36220)
      dom split
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
- notification
    - https://github.com/servo/servo/pull/35878	(@pewsheen, #35878)	feat: fetch notification image resources (#35878)
      dom notification
    - https://github.com/servo/servo/pull/36082	(@Loirooriol, @mrobinson, #36082)	layout: Cache `IndependentNonReplacedContents::layout()` (#36082)
      dom notification
- shadowdom
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
- table
    - https://github.com/servo/servo/pull/35882	(@Loirooriol, #35882)	layout: Only prevent fixed table layout when `inline-size` is `auto` (#35882)
      layout table
- touch
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