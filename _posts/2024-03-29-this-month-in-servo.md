---
layout:     post
tags:       blog
title:      "This month in Servo: and more!"
date:       2024-03-29
summary:    ao!! wrrrrao!!
categories:
---

Remember how last month, we surpassed our legacy layout engine in the CSS test suites?
This month, we’re proud to share that Servo has **surpassed legacy in the whole suite of Web Platform Tests** as well!
This includes some big strides in **CSS tables** (+30.4pp to 62.9%), **CSS2 margin-padding-clear** (+13.2pp to 93.6%), and **CSS2 box-display** (+10.0pp to 84.4%).

More on how we got there in a bit, but first let’s talk about new API support:

- as of 2024-02-27, we support **block layout for &lt;div align> and &lt;center>** (@Loirooriol, #31423)
- as of 2024-02-29, we support the **font property on CanvasRenderingContext2D** (@syvb, #31436)
- as of 2024-02-29, we support **[synthetic](https://developer.mozilla.org/en-US/docs/Web/CSS/font-synthesis-small-caps) ‘font-variant: small-caps’** (@mrobinson, #31435)
- as of 2024-03-02, we support **&lt;meta http-equiv="Refresh">** (@syvb, #31468)
- as of 2024-03-08, **tables are enabled by default** (@Loirooriol, #31470)
- as of 2024-03-08, we support the **‘box-shadow’ property** (@mrobinson, #31453)
- as of 2024-03-12, we support **‘conical-gradient’ and ‘repeating-conical-gradient’** (@mrobinson, #31597)
- as of 2024-03-15, we support the **&lt;style disabled> attribute** (@Loirooriol, #31682)
- as of 2024-03-16, we have basic support for the **getClientRects() method on Element** (@mrobinson, #31696)
- as of 2024-03-18, we support **console.count() and console.countReset()** (@syvb, #31635)
- as of 2024-03-20, we support the **‘text-shadow’ property** (@mrobinson, #31734)
- as of 2024-03-20, we support **‘text-decoration: line-through’ on macOS** (@mrobinson, #31756)
- as of 2024-03-23, we support **StaticRange and AbstractRange** (@nipunG314, @cathiechen, #25466, #31756)
- as of 2024-03-27, we support **WOFF2 web fonts** (@mrobinson, #31879)
- as of 2024-03-27, we support the obsolete **&lt;pre width> attribute** (@bplaat, #31792)

<figure class="_figr"><a href="http://invalid"><img src="http://invalid" width="640" height="720"
    alt="[TODO table of demos for new layout features, including synthetic small-caps, box-shadow, conical-gradient, text-shadow, line-through?, transformed &lt;img>]"></a>
<figcaption>[TODO caption]</figcaption></figure>

**Tables are enabled by default** as of 2024-03-08 (@Loirooriol, #31470), you can now **transform &lt;iframe> and &lt;img>** (and other inline replaced elements) without wrapping them in a container (@mrobinson, #31833), and **‘text-align: justify’ now takes ‘text-indent’ into account** (@mrobinson, #31777).

We’ve also landed improvements to style invalidation (@mrobinson, #31857), inline layout (@mrobinson, @atbrakhi, @Loirooriol, #31519, #31636, #31641, #31681, #31660, #31896), and table layout (@Loirooriol, @mrobinson, #31430, #31421, #31455, #31487, #31480, #31484, #31506, #31535, #31536, #31578, #31596, #31586, #31613, #31606, #31661, #31619, #31650, #31704, #31803, #31862, #31705, #31831).

Servo now stops loading videos and other media after encountering decode errors (@frereit, #31748), and our docs and dev tooling have been updated to ensure **support for WebM and AV1** (@delan, #31687).

Our dependency upgrades surge forward, with **WebRender now fully caught up with upstream** (@mrobinson, @mukilan, #31486), **Stylo** bumped from June 2023 to September 2023 (@Loirooriol, #31437, #31609), and **SpiderMonkey updated to 115.9** (@sagudev, #31757).

## servoshell and debug logging

servoshell has had a good amount of love this month, with a new **loading spinner** (@frereit, #31713) and a **rendering glitch under the location bar now fixed** (@delan, #31774).
**Logging in servoshell is no longer mixed with libservo** (@delan, #31439), with the RUST_LOG prefix now being `servoshell::` instead of `servo::`.

Speaking of RUST_LOG, you can now **filter event logging in servoshell and the constellation at runtime** (@delan, #31657, #31659), with the new RUST_LOG prefixes `servoshell<winit@`, `servoshell<servo@`, `servoshell>servo@`, `constellation<compositor@`, `constellation<script@`, and `constellation<layout@`.
For example:

- to trace all events in the constellation from layout, plus all events from the compositor other than ReadyToPresent:<br>
  `RUST_LOG='constellation<layout@,constellation<compositor@,constellation<compositor@ReadyToPresent=off'`
- to trace only winit window moved events in servoshell, plus all ordinary servoshell logs at trace level:<br>
  `RUST_LOG='servoshell,servoshell<=off,servoshell>=off,servoshell<winit@WindowEvent(Moved)'`

To learn more about the RUST_LOG syntax, see the [env_logger docs](https://docs.rs/env_logger/0.10.2/env_logger/#enabling-logging), and for the full list of event log targets, see [ports/servoshell/tracing.rs](https://github.com/servo/servo/blob/2d5a1cd02ee0c3196875dc52ca55a150a63cc29f/ports/servoshell/tracing.rs) and [components/constellation/tracing.rs](https://github.com/servo/servo/blob/2d5a1cd02ee0c3196875dc52ca55a150a63cc29f/components/constellation/tracing.rs).

<figure class="_fig"><a href="http://invalid"><img src="http://invalid" width="1280" height="720"
    alt="[TODO comparison of event tracing with and without runtime filtering, maybe as two gifs side by side]"></a>
<figcaption>[TODO caption]</figcaption></figure>

<aside class="_note">

To keep things from getting too noisy, @delan likes to use the event logging config below:

<code style="word-wrap: break-word;">RUST_LOG='warn,servoshell<,servoshell>,constellation<,servoshell<winit@DeviceEvent=off,servoshell<winit@MainEventsCleared=off,servoshell<winit@NewEvents(WaitCancelled)=off,servoshell<winit@RedrawEventsCleared=off,servoshell<winit@RedrawRequested=off,servoshell<winit@UserEvent=off,servoshell<winit@WindowEvent(CursorMoved)=off,servoshell<winit@WindowEvent(AxisMotion)=off,servoshell<servo@EventDelivered=off,servoshell<servo@ReadyToPresent=off,servoshell>servo@Idle=off,servoshell>servo@MouseWindowMoveEventClass=off,constellation<compositor@ForwardEvent(MouseMoveEvent)=off,constellation<unknown@LogEntry=off,constellation<compositor@ReadyToPresent=off,constellation<script@LogEntry=off,servoshell<winit@WindowEvent(Moved)=off'</code>
</aside>

## Embedding and dev changes

Servo had a pervasive but confusing concept of webviews or pipelines being “visible”, which actually controls whether script runs timers at a heavily limited rate and the compositor pauses animations.
We’ve replaced this with the more concrete (but inverted) concept of a webview being “throttled” (@delan, #31816), including in our embedding API, where `WebViewVisibilityChanged` has been replaced with `SetWebViewThrottled` (@delan, #31815).

<!--
wpt analysis

>>> top deltas (servo, pp):
csstable (30.4pp to 62.9%)
margin-padding-clear (13.2pp to 93.6%)
box-display (10.0pp to 84.4%)
css (8.5pp to 64.6%)
floats-clear (8.4pp to 89.6%)
css2 (7.0pp to 77.2%)
normal-flow (4.9pp to 91.5%)
all (4.4pp to 56.9%)
floats (4.1pp to 89.2%)
linebox (2.5pp to 91.1%)
csstext (2.4pp to 48.9%)
cssflex (1.0pp to 54.0%)
cssom (0.5pp to 65.4%)
positioning (0.0pp to 88.5%)
csspos (-1.3pp to 47.1%)
abspos (-7.2pp to 91.0%)

>>> top cuts in legacy regression (%):
css (-Infinity% from 0.0pp to -3.2pp)
csstable (-709.5% from 4.2pp to -25.6pp)
normal-flow (-544.4% from 0.9pp to -4.0pp)
css2 (-388.2% from 1.7pp to -4.9pp)
box-display (-149.3% from 6.7pp to -3.3pp)
margin-padding-clear (-137.5% from 9.6pp to -3.6pp)
all (-100.0% from 1.6pp to 0.0pp)
-->

## Outreachy

Servo is also **participating in Outreachy** for the first time since 201x!
Outreachy is a three-month paid (7000 USD) remote internship program that runs twice a year, with a special focus on open source software.
To select interns for Outreachy, there was a *contribution period* that is now coming to a close, during which contributors have landed a wide range of improvements.

<!--
$ > 2024.json tools/list-pull-requests.sh servo/servo '2024-.*'
$ < 2024.json jq -s '["clippy", "rustdoc"] as $keywords | sort_by(.merged_at) | map({number, title, author: .user.login}) | map(select([.number] | inside('"$(< _posts/2024-03-29-this-month-in-servo.md | rg '^ *[*][*][*]' | rg -o '[(]#[0-9]+[)]' | rg -o '[0-9]+' | jq -sc | tee /dev/stderr)"'))) | map(select(.author != "mrobinson"))' | node -e 'pulls = require("fs").readFileSync("/dev/stdin",{encoding:"utf-8"}); pulls = JSON.parse(pulls); rules = [{key:"tooling",patterns:[/Add RUSTC env to clippy command/]},{key:"generated code",patterns:[/generated code/i]},{key:"clippy",patterns:[/clippy/i,/clipping:/]},{key:"rustdoc",patterns:[/rustdoc/i,/rusdoc:/]}]; rules.map(rule => { console.log(`\n>>> ${rule.key}`); predicate = pull => rule.patterns.some(pattern => pattern.test(pull.title)); filteredPulls = pulls.filter(predicate); pulls = pulls.filter(pull => !predicate(pull)); report(filteredPulls); }); console.log("\n>>> rest"); report(pulls); function report(filteredPulls) { console.log(filteredPulls.map(pull => `${pull.author} (#${pull.number}) ${pull.title}`).join("\n")); console.log([...new Set([...filteredPulls.map(pull => `@${pull.author}`), ...filteredPulls.map(pull => `#${pull.number}`)]), ].join(", ")); }'
[31567,31566,31549,31517,31521,31512,31508,31592,31587,31585,31565,31568,31583,31582,31534,31551,31537,31563,31562,31560,31608,31548,31564,31617,31611,31612,31610,31627,31623,31625,31647,31643,31640,31626,31632,31628,31700,31654,31669,31694,31685,31668,31721,31670,31719,31718,31710,31712,31769,31759,31717,31758,31738,31745,31755,31708,31644,31735,31793,31797,31737,31778,31776,31770,31813,31811,31802,31711,31791,31799,31800,31801,31823,31784,31822,31819,31842,31818,31837,31827,31888,31877,31876,31834,31865,31853,31863,31864,31852,31843,31850,31844,31849,31907,31908,31906,31891,31900,31898,31893,31867,31890,31878]

>>> tooling
DONE eerii (#31694) Add RUSTC env to clippy command
@eerii, #31694

>>> generated code
DONE eerii (#31721) clippy: Fix warnings in generated code
DONE eerii (#31711) Remove repeated imports from generated code
DONE eerii (#31844) clippy: Fix remaining warnings in generated code
@eerii, #31721, #31711, #31844

>>> clippy
mnaibei (#31508) Fix several clippy warnings in components/hyper_serde
mnaibei (#31512) Fix several clippy warnings in components/bluetooth
sandeepB3 (#31549) Fix clippy warnings in `components/rand`
eerii (#31566) clippy: fix warnings in components/bluetooth
eerii (#31567) clippy: fix warnings on modules outside components
eerii (#31560) clippy: fix warnings in components/gfx
eerii (#31562) clippy: fix warnings in components/config*
eerii (#31563) clippy: fix warnings in components/canvas
zawwz (#31551) Fix clippy warnings in components/shared/net/request.rs
eerii (#31568) clippy: fix warnings in various modules in components
eerii (#31565) clippy: fix warnings in components/shared
eerii (#31564) clippy: fix warnings in components/net
mnaibei (#31548) Fix more clippy warnings in `components/shared/net`
eerii (#31612) clippy: Fix warnings in `components/layout`
eerii (#31610) clippy: Fix warnings in `components/constellation`
eerii (#31611) clippy: Fix warnings in `components/layout_2020`
eerii (#31627) clippy: Fix warnings in `components/shared`
mnaibei (#31623) Fix clippy warnings in `components/third_party`
eerii (#31628) clippy: Fix assorted warnings in `components/`
eerii (#31626) clippy: Fix warnings in `components/net`
richarddushime (#31700) clippy: Fix warnings in `components/script`
RustAndMetal (#31710) clippy: Fix some warnings in `gfx`, `layout_2020`, and `script`
six-shot (#31719) clippy: Fix some warnings in the `script` crate
six-shot (#31735) clippy: Fix some warnings in `components/script`
oluwatobiss (#31758) clippy: Fix dereferenced warning in `components/script`
richarddushime (#31717) clippy: Fix many warnings in `components/script`
six-shot (#31759) clippy: Fix clippy Problems in components/scripts
jahielkomu (#31769) clippy: Fix warnings in `components/script/textinput.rs`
oluwatobiss (#31770) clippy: Fix dereferenced warnings in `components/script`
oluwatobiss (#31776) clippy: Fix `needless_return` warnings in `components/script`
six-shot (#31778) clippy: Fix some clippy problems in `components/script`
oluwatobiss (#31793) clippy: Fix `redundant_field_names` warnings in `components/script`
Aaryakhandelwal (#31801) Clippy: Fixed clippy warnings in components/script/dom
Aaryakhandelwal (#31800) Clippy: Fixed warnings in htmlimageelement.rs
six-shot (#31799) clipping: Fix some warnings in `components/script/dom`
eerii (#31791) clippy: fix `result_unit_err` warnings
oluwatobiss (#31811) clippy: Fix `needless_borrowed_reference` warnings in `components/script`
oluwatobiss (#31813) clippy: Fix `needless_borrow` warnings in `components/script`
Aaryakhandelwal (#31819) Clippy: Fixed the .clone() warnings in components/script
jahielkomu (#31784) Fix some clippy warnings in `components/script/webdriver_handlers.rs`
oluwatobiss (#31823) clippy: Fix `unnecessary_cast` warnings in `components/script`
oluwatobiss (#31837) clippy: Fix `explicit_auto_deref` warnings in `components/script`
Aaryakhandelwal (#31818) Clippy: Fixed some clippy warnings
six-shot (#31842) clippy: fix redundant closure
oluwatobiss (#31827) clippy: Fix `default_constructed_unit_structs` warnings in `components`
ektuu (#31849)  clippy: Fix some warnings in `components/script`
Aaryakhandelwal (#31850) clippy: Use `matches!` and dereferencing in match statements in `components/script`
six-shot (#31843) clippy: Fix some clippy warnings in `components/script`
oluwatobiss (#31852) clippy: Fix `collapsible_if` warnings in `components/script`
Aaryakhandelwal (#31864) clippy: Fix warnings about dereferencing immutable references in `components/script`
Aaryakhandelwal (#31863) clippy: Fix the `unneeded return` statement warnings in `components/script`
oluwatobiss (#31853) clippy: Fix `collapsible_else_if` warnings in `components/script`
ektuu (#31865) clippy: Fix some warnings in `components/script`
ektuu (#31834)  clippy: Map to an error type instead of using allowing `result_unit_err` in `components/url`
oluwatobiss (#31876) clippy: Fix `single_match` warnings in `components/script`
oluwatobiss (#31877) clippy: Fix `clone_on_copy` warnings in `components/script`
ektuu (#31888) clippy: Fix some warnings in `components/script`
jahielkomu (#31878) clippy: Fix some warnings in `components/script/timers.rs`
six-shot (#31890) clippy: Fix various warnings in `components/script/dom`
Aaryakhandelwal (#31867) clippy: Fix warnings in `components/script/dom/request.rs`
six-shot (#31893) clippy:Fix clippy problems in components/scripts/binding
oluwatobiss (#31898) clippy: Fix `unnecessary_lazy_evaluations` warnings in `components`
oluwatobiss (#31900) clippy: Fix `op_ref` warnings in `components/script`
six-shot (#31891) clippy: Fix clippy problems in `components/script/dom`
oluwatobiss (#31906) clippy: Fix `option_map_unit_fn` warnings in `components/script`
azharcodeit (#31908) clippy: Remove `let` bindings in `components/script/dom`
six-shot (#31907) clippy:fix various clippy problems in components/scripts
@mnaibei, @sandeepB3, @eerii, @zawwz, @richarddushime, @RustAndMetal, @six-shot, @oluwatobiss, @jahielkomu, @Aaryakhandelwal, @ektuu, @azharcodeit, #31508, #31512, #31549, #31566, #31567, #31560, #31562, #31563, #31551, #31568, #31565, #31564, #31548, #31612, #31610, #31611, #31627, #31623, #31628, #31626, #31700, #31710, #31719, #31735, #31758, #31717, #31759, #31769, #31770, #31776, #31778, #31793, #31801, #31800, #31799, #31791, #31811, #31813, #31819, #31784, #31823, #31837, #31818, #31842, #31827, #31849, #31850, #31843, #31852, #31864, #31863, #31853, #31865, #31834, #31876, #31877, #31888, #31878, #31890, #31867, #31893, #31898, #31900, #31891, #31906, #31908, #31907

>>> rustdoc
Aaryakhandelwal (#31582) Fix rustdoc errors in `components/shared`
sandeepB3 (#31587) Fix rustdoc warnings in `components/layout_2020`
maureenblack (#31592) Fix rustdoc warnings in `components/layout 2020/positioned.rs`
mnaibei (#31617) Fix rustdoc errors in `components/script/dom`
oluwatobiss (#31625) rustdoc: Fix `StackingContextFragment` error in `components/layout_2020/display_list`
azharcodeit (#31632) rustdoc: Fix warnings in `components/script/dom`
Aaryakhandelwal (#31640) rustdoc: Fix warnings in `components/layout_2020`
oluwatobiss (#31643) rusdoc: Fix `idl` warning in components/script/dom/bindings
Aaryakhandelwal (#31647) rustdoc: Fix warnings in `components/layout_2020`
jahielkomu (#31654) rustdoc: Fix errors in `components` and `ports`
Rhea-Eve (#31712) rustdoc: Fix two warnings in `components/layout_2020`
ektuu (#31644) rustdoc: Fix some typos in `components/layout_2020/table/mod.rs`
Aaryakhandelwal (#31708) rustdoc: Fix warning in `components/layout_2020`
oluwatobiss (#31755) rustdoc: Fix `bare_urls` warning in `components/script`
oluwatobiss (#31745) rustdoc: Fix broken link to `FontFace` in `components/gfx`
azharcodeit (#31738) rustdoc: fix warnings in `components/layout_2020/table`
@Aaryakhandelwal, @sandeepB3, @maureenblack, @mnaibei, @oluwatobiss, @azharcodeit, @jahielkomu, @Rhea-Eve, @ektuu, #31582, #31587, #31592, #31617, #31625, #31632, #31640, #31643, #31647, #31654, #31712, #31644, #31708, #31755, #31745, #31738

>>> rest
DONE eerii (#31521) Move convert_* functions into gpuconvert.rs
DONE eerii (#31517) Use thread pool to decode image
DONE MunishMummadi (#31537) Update phf_codegen and phf_shared to 0.11
DONE azharcodeit (#31534) Fix inheritance.sub.html WPT to work on Servo
DONE six-shot (#31583) Adjust the language used in some of the documentation
DONE eerii (#31585) Make image decoding thread pool the size of the system's CPUs
DONE eerii (#31608) Fix unused import left in #31564
DONE richarddushime (#31668) fonts: Add Noto Sans CJK fonts to the Linux fallback list
DONE MunishMummadi (#31685) gfx: Rename cache_total_advance_and_word_seperators to cache_total_advance_and_word_separators
DONE jahielkomu (#31718) docs: Improve and reformat `HACKING_QUICKSTART.md`
DONE sandeepB3 (#31670) fonts: Consider Tertiary Ideographic Plane to be CJK
DONE Rhea-Eve (#31737) Attempt using version of Stylo with -x-lang enabled
DONE sandeepB3 (#31797) minibrowser: fix unused import: `InnerResponse` warning
DONE richarddushime (#31802) Fix WPT reference no_red_3x3_monospace_table-ref.xht
DONE sandeepB3 (#31822) Fix: removed  mutable compile warnings in script
@eerii, @MunishMummadi, @azharcodeit, @six-shot, @richarddushime, @jahielkomu, @sandeepB3, @Rhea-Eve, #31521, #31517, #31537, #31534, #31583, #31585, #31608, #31668, #31685, #31718, #31670, #31737, #31797, #31802, #31822
-->

The biggest area of improvement was in code health (@eerii, @MunishMummadi, @sandeepB3, #31521, #31537, #31608, #31685, #31670, #31822), where we have now fixed almost all of our rustdoc (@Aaryakhandelwal, @sandeepB3, @maureenblack, @mnaibei, @oluwatobiss, @azharcodeit, @jahielkomu, @Rhea-Eve, @ektuu, #31582, #31587, #31592, #31617, #31625, #31632, #31640, #31643, #31647, #31654, #31712, #31644, #31708, #31755, #31745, #31738) and clippy errors (@mnaibei, @sandeepB3, @eerii, @zawwz, @richarddushime, @RustAndMetal, @six-shot, @oluwatobiss, @jahielkomu, @Aaryakhandelwal, @ektuu, @azharcodeit, #31508, #31512, #31549, #31566, #31567, #31560, #31562, #31563, #31551, #31568, #31565, #31564, #31548, #31612, #31610, #31611, #31627, #31623, #31628, #31626, #31700, #31710, #31719, #31735, #31758, #31717, #31759, #31769, #31770, #31776, #31778, #31793, #31801, #31800, #31799, #31791, #31811, #31813, #31819, #31784, #31823, #31837, #31818, #31842, #31827, #31849, #31850, #31843, #31852, #31864, #31863, #31853, #31865, #31834, #31876, #31877, #31888, #31878, #31890, #31867, #31893, #31898, #31900, #31891, #31906, #31908, #31907).

One contributor went further, cleaning up the codegen for our DOM bindings (@eerii, #31721, #31711, #31844), improving our dev tooling (@eerii, #31694), and even improving our image decoding by replacing per-image threads with a thread pool (@eerii, #31517, #31585)!
Two contributors worked together to support language-specific behaviour in ‘text-transform’ (@MunishMummadi, @Rhea-Eve, stylo#24, #31737), and other contributors also landed improvements to our docs (@six-shot, @jahielkomu, #31583, #31718), CJK font fallback (@richarddushime, @sandeepB3, #31668, #31670), and the Web Platform Tests (@azharcodeit, @richarddushime, #31534, #31802).

<!--
- DONE outreachy
    - DONE thread pool image decoding #31517 #31585
    - DONE font fallback
        - DONE Noto Sans CJK #31668
        - DONE tertiary ideographic plane #31670
    - DONE clippy
        - DONE generated code #31721 #31711 #31844
    - DONE rustdoc
    - DONE docs #31718
- contributors
- wpt
- apis
    - DONE CanvasRenderingContext2D.font #31436
    - DONE meta http-equiv refresh #31468
    - DONE rudimentary getClientRects #31696
    - DONE console.count/countReset #31635
- layout
    - DONE box-shadow #31453 (count!)
    - DONE synthetic/correct small caps #31435
    - DONE line-through on macos #31756
    - DONE text-shadow #31734
    - DONE fix justify with text-indent #31777
    - DONE fix transforming inline replaced elements (iframe, img) #31833
    - tables
        - DONE enabled by default #31470
        - DONE row height distribution #31421
        - DONE correct sizing in flow layout #31455 (count!)
        - DONE intrinsic sizing #31506
    - DONE inline layout
        - DONE min-content spaces before atomic inline #31896
        - DONE white-space pre-wrap hang #31681
        - DONE white-space intrinsic sizing ifc #31660
    - enabled more css tests #31469
    - DONE inline layout docs #31519
    - DONE table layout docs #31535
    - Au #31395 #31621 #31794
- media playback
    - DONE codec support #31687
    - DONE abort load on decode error #31748
- embedding and multiview
    - SKIP feature flag #31541
    - DONE visible to throttled #31815
- servoshell
    - DONE logging #31439
    - DONE gap #31774
    - DONE loading spinner #31713
- android
    - fix rendering in emulators #31727
- upgrades
    - DONE stylo 2023-07-23 #31437
    - DONE stylo 2023-09-01 #31609
    - DONE webrender 0.64 #31486
        - needed to reimpl scrolling/zooming?
        - compositor waiting - affects flakiness #31523
        - compositor shutdown - affects flakiness #31733
    - DONE mozjs spidermonkey 115.9 #31757
- crashes and robustness
    - surfman egl #31431
    - video poster #31447
    - cssom css layers no longer crash #31481
    - animation tick rate in wpt #31561
- dev
    - DONE stylo #31350
    - DONE tracing #31659 #31657
    - rustfmt stable #31441
    - faster taplo (mach fmt) on macos #31452
    - tidy whatwg replacement #31449
    - fixed mach doc by upgrading gstreamer #31465
    - build issues
        - nixos #31515 #31825
        - mozjs zlib #31889 mozjs#460
- book?
-->

<!--
$ tools/list-commits-by-nightly.sh ~/code/servo 2>&1 | tee /dev/stderr | xclip -sel clip
From https://github.com/servo/servo
 * branch                  HEAD       -> FETCH_HEAD
>>> 2024-02-27T06:08:24Z
+++ 304ab9b09c0beace5ac08c073c957060621d4056	https://github.com/servo/servo/pull/31395	layout: make `AxisResult`, `Anchor` & `AbsoluteAxisSolver` use `Au` (#31395)
    +++ a97a04d84c9098f8ca412887bc577936d0f5d972	https://github.com/servo/servo/pull/31423	Support <div align="..."> and <center> in block layout (#31423)
    e5598590baa3a0b283cdf18772bcec26b48aec1a	https://github.com/servo/servo/pull/31419	layout: Add line height from preserved segment breaks in quirks mode (#31419)
    a9a7e8a5cfbd57b7b164a027f5afdcacc298751d	https://github.com/servo/servo/pull/31426	Rename buffer_source_type to buffer_source (#31426)
>>> 2024-02-28T06:11:04Z
+++ faf754dfa655f0b9a28f62bc47a78fbf78ebcaf4	https://github.com/servo/servo/pull/31350	Move Stylo to its own repo (#31350)
    +++ b07505417e629bbb081be9683630f2d7a5f50544	https://github.com/servo/servo/pull/31430	Fix percentages in the padding of a table-cell (#31430)
+++ b9e217c480245637ae59f47d087157c9807c12ba	https://github.com/servo/servo/pull/31431	Upgrade surfman to 0.9.1 (#31431)
>>> 2024-02-29T06:09:43Z
+++ 51b331385488f42b5b3263e6e4e7f4af39e1ecf1	https://github.com/servo/servo/pull/31447	fix invalid video poster image loading from panicking (#31447)
    e2e30bcbb1c1c0c5954ddfceb92f00848c5b30c8	https://github.com/servo/servo/pull/31448	Remove leftover layout_traits references (#31448)
    201cdbab17a450887867b7cb68f83b222099a5e2	https://github.com/servo/servo/pull/26469	webaudio: Throw when setting invalid automationRate on AudioBufferSourceNode (#26469)
    +++ 5c87fe940e74c286d7b7d11257407e4a1ed1917f	https://github.com/servo/servo/pull/31436	layout: Add an implementation of `process_resolved_font_style_query` for Layout 2020 (#31436)
    a89bacb7c591129caebb820fc8199886ced8081b	https://github.com/servo/servo/pull/29812	Update overrideMimeType and final-charset to match xhr spec (#29812)
    +++ 5ba29c20ac3d048efb2ae266d6f876829f0d632e	https://github.com/servo/servo/pull/31435	layout: Turn on synthetic small-caps for layout 2020 (#31435)
+++ 98bd306816f8c3d3e7569032b9b6ace76892d963	https://github.com/servo/servo/pull/31441	mach: Do not use unstable rust for `rustfmt` (#31441)
    2afd5431b17d35400b37bb4093acb2a3a128ee04	https://github.com/servo/servo/pull/31434	build(deps): bump mako from 1.1.2 to 1.2.2 in /python (#31434)
+++ 6a3cd65bf24771805031faddf0e5932e97226663	https://github.com/servo/servo/pull/31439	Move servoshell code into an internal lib crate (#31439)
>>> 2024-03-01T06:17:19Z
    ee122acdf44201e8354fb5abd926b31bf2907296	https://github.com/servo/servo/pull/31459	build(deps): bump syn from 2.0.50 to 2.0.52 (#31459)
    160a4b74825a65ce3942a1285a81d845a9415f3c	https://github.com/servo/servo/pull/31461	build(deps): bump log from 0.4.20 to 0.4.21 (#31461)
    62dcb4a2880a28288b66660d07bef02ba33be55d	https://github.com/servo/servo/pull/31460	build(deps): bump rayon from 1.8.1 to 1.9.0 (#31460)
    b66a319b894b5b558fbd651372c3368eb90da111	https://github.com/servo/servo/pull/31463	build(deps): bump tempfile from 3.10.0 to 3.10.1 (#31463)
    e55c2c05f2ae739026d7c095dd3b5cb132a19b58	https://github.com/servo/servo/pull/31458	build(deps): bump darling from 0.20.6 to 0.20.8 (#31458)
    5f399139ae1749d8f13b7200d120f7adcd057d8a	https://github.com/servo/servo/pull/31454	Fix percentages in CSS tables (#31454)
    +++ 127aa657c2418646052e9b497a6b2229a8a8ae70	https://github.com/servo/servo/pull/31421	layout: Add initial support for row height distribution (#31421)
+++ 31cfaf290daa9a65be47e721301a4aebddd22144	https://github.com/servo/servo/pull/31437	Update Stylo to 2023-07-23 (#31437)
+++ 6eb96290faf5beade356370e056e8011cc741de9	https://github.com/servo/servo/pull/31452	mach: Speed up `taplo` runs on MacOS (#31452)
    9a9abe9152fb3691d9ff97e743bb46c1c4ebea8c	https://github.com/servo/servo/pull/31443	Add `use-system-allocator` to not use jemalloc (#31443)
    cd92a17c5e1b6c7e2cb48ae83021f78a668343e2	https://github.com/servo/servo/pull/31450	ci: Update remaining GitHub actions to versions using Node.js 20 (#31450)
+++ ffc9730a484d3b30c9c1b8ef3366b715e6808bcd	https://github.com/servo/servo/pull/31449	tidy: Fix WHATWG replacement links (#31449)
>>> 2024-03-02T06:17:40Z
    +++ 50fdb822469eddc05070b9bfcd91b11c7a9b8c5b	https://github.com/servo/servo/pull/31455	Fix size of tables in flow layout (#31455)
    c23999941a34ac78ff3e0068a06102b539d8bb73	https://github.com/servo/servo/pull/31477	build(deps): bump indexmap from 2.2.3 to 2.2.5 (#31477)
    fbf023486a532fc156358185481374524d033e6b	https://github.com/servo/servo/pull/31474	build(deps): bump bumpalo from 3.15.2 to 3.15.3 (#31474)
    cbdeb623066554ec80ae0412e26cb4b6862dd973	https://github.com/servo/servo/pull/31472	build(deps): bump hermit-abi from 0.3.6 to 0.3.9 (#31472)
    f4ed89277a370852a72eec01fe944bc847b3a726	https://github.com/servo/servo/pull/31473	build(deps): bump half from 2.3.1 to 2.4.0 (#31473)
    359787029822532c8b3c0f2ca4655c255994e512	https://github.com/servo/servo/pull/31478	build(deps): bump crossbeam-channel from 0.5.11 to 0.5.12 (#31478)
    2f6edda90bb704a0b8110f8456b05f891b2a4167	https://github.com/servo/servo/pull/31475	build(deps): bump image from 0.24.8 to 0.24.9 (#31475)
    691a0f17cb77ecb53bd63cfe241227b85eeb14d5	https://github.com/servo/servo/pull/31471	build(deps): bump socket2 from 0.5.5 to 0.5.6 (#31471)
+++ b785aea2cfe87ef55bbdc011fee19cc93293349e	https://github.com/servo/servo/pull/31465	Update gstreamer crates to 0.22 (#31465)
+++ 2b1d342102ae81a18d0c96eea65821bd6dbd5940	https://github.com/servo/servo/pull/31469	Enable more css tests (#31469)
    +++ 0beec63c86d8cb04f183249c8a2c81b49e17e03e	https://github.com/servo/servo/pull/31468	script: Implement `<meta http-equiv="refresh">` (#31468)
>>> 2024-03-03T06:09:55Z
>>> 2024-03-04T06:20:11Z
    e1172d892016eb38727dc5ec0ea9a58e5f0a9129	https://github.com/servo/servo/pull/31464	build(deps): bump ahash from 0.8.9 to 0.8.10 (#31464)
+++ 06aeeeb1f3574706e6992426063306a3f10716d8	https://github.com/servo/servo/pull/31481	Add CSSOM support for CSS layers (#31481)
    845f503c349cbfc5589169512495c989a001a160	https://github.com/servo/servo/pull/31482	Sync WPT with upstream (03-03-2024) (#31482)
>>> 2024-03-05T06:14:26Z
    2bafcf9f182bf907c4a4391f931a7364bd7b804f	https://github.com/servo/servo/pull/31497	Update manifest (#31497)
    15b4545db97772d7d1d5ee54840a6988919957df	https://github.com/servo/servo/pull/31492	build(deps): bump libloading from 0.8.1 to 0.8.2 (#31492)
    450601d294b39a6cad08e8ea85a4956ea31f625b	https://github.com/servo/servo/pull/31495	build(deps): bump ahash from 0.8.10 to 0.8.11 (#31495)
    8d1d7c6882bb6cc400692a4a77059c4ddd7ad2b1	https://github.com/servo/servo/pull/31494	build(deps): bump regex-automata from 0.4.5 to 0.4.6 (#31494)
    53f9a3fe12c119989940100f99acc3fc86a02068	https://github.com/servo/servo/pull/31493	build(deps): bump cc from 1.0.83 to 1.0.89 (#31493)
    7126b974934346443b271f4da266d010fb25aca8	https://github.com/servo/servo/pull/31490	build(deps): bump http from 0.2.11 to 0.2.12 (#31490)
    +++ f7f8c24072b486de38fcdb0550faacebdefd96f9	https://github.com/servo/servo/pull/31487	layout: Properly propagate text decoration values in tables (#31487)
    +++ e76770202c059202889bdb3555e9efb817b6f68e	https://github.com/servo/servo/pull/31480	Fix column and row measures (#31480)
    +++ a977729a9ec953b3fc62f7039242f1917be4237f	https://github.com/servo/servo/pull/31484	Treat indefinite percentages as auto offsets in relative positioning (#31484)
    3e6b92df13efad486452f3fc559d9ec632affa3a	https://github.com/servo/servo/pull/31485	Fix "unused import" warning (#31485)
>>> 2024-03-06T06:14:09Z
    a483e2806cc5cce1ae1ee85868d2b44b26ea2f7d	https://github.com/servo/servo/pull/31507	Enable accidentally skipped tests (#31507)
    +++ abda22ed63c22b53c47990b9d68acd5752566571	https://github.com/servo/servo/pull/31506	Fix intrinsic sizing of tables (#31506)
    f32937aaeb13ed292d111def36e11f3e58fbb36b	https://github.com/servo/servo/pull/31510	build(deps): bump pin-project from 1.1.4 to 1.1.5 (#31510)
    3552bb2464cbaa57facbcb9ad2bcb266bc5a87f6	https://github.com/servo/servo/pull/31501	clippy: Fix several warnings in components/devtools (#31501)
    da873779b496c9a1236cd92388efb1316f97e3d6	https://github.com/servo/servo/pull/31511	build(deps): bump js-sys from 0.3.68 to 0.3.69 (#31511)
    40aad8cfde56e9de59b9fd6c70d60c5bdd3b1051	https://github.com/servo/servo/pull/31509	build(deps): bump wasm-bindgen from 0.2.91 to 0.2.92 (#31509)
    8f3e1bcabea3e16bc2721f4de5ee867fc1ba201b	https://github.com/servo/servo/pull/31502	Enable `css-text` explicitly in include.ini (#31502)
    57dbb7a6f61d2dd1291461429898dced668adced	https://github.com/servo/servo/pull/31489	build(deps): bump mio from 0.8.10 to 0.8.11 (#31489)
    2da7ac5578e3b387a51989e5f70829304cb3ce32	https://github.com/servo/servo/pull/31488	build(deps): bump walkdir from 2.4.0 to 2.5.0 (#31488)
>>> 2024-03-08T06:12:11Z
    *** 6c7fe31db13e31be339a6657931171db589307c7	https://github.com/servo/servo/pull/31567	clippy: fix warnings on modules outside components (#31567)
    *** 3b19189896dfa82ce90ac37654bbb585d7ff7efa	https://github.com/servo/servo/pull/31566	clippy: fix warnings in components/bluetooth (#31566)
    *** 64d013d473105da64ad7671419e805ac0550fc98	https://github.com/servo/servo/pull/31549	Fix clippy warnings in `components/rand` (#31549)
+++ e4ac047a9cd686b69f2d4e0939c6a2ec39650742	https://github.com/servo/servo/pull/31561	compositor: Limit animation tick interval when in WPT mode (#31561)
+++ dfefd7a30d824eb74acd2a2b44fcb437c1dbc140	https://github.com/servo/servo/pull/31541	Add multiview feature flag in libservo and servoshell (#31541)
    9f86979dc78f8b16bbbf8d6a4e221e7474f7e7f0	https://github.com/servo/servo/pull/31555	build(deps): bump chrono from 0.4.34 to 0.4.35 (#31555)
    5ecfba9da502fb2179d214011feb9f12a300636a	https://github.com/servo/servo/pull/31554	build(deps): bump gilrs-core from 0.5.10 to 0.5.11 (#31554)
    bbf2840b3f44049e56de41a9af286ae9aee7be79	https://github.com/servo/servo/pull/31553	build(deps): bump libloading from 0.8.2 to 0.8.3 (#31553)
    33906e47474bf53a272abe7cdcfa591194f2ab3e	https://github.com/servo/servo/pull/31525	build(deps): bump svg_fmt from 0.4.1 to 0.4.2 (#31525)
    35914422ecad910a703c6453b642d59039a09af3	https://github.com/servo/servo/pull/31552	build(deps): bump bumpalo from 3.15.3 to 3.15.4 (#31552)
    *** 3837fe00ad71f9541416c23037dabf2c1bc458dd	https://github.com/servo/servo/pull/31517	Use thread pool to decode image (#31517)
+++ 6005049d88766b415f38f62930d3edf79b8befe8	https://github.com/servo/servo/pull/31523	compositor: Improve the way we wait for frames (#31523)
    3098c3d1215dddef50456e862a029e76237fa826	https://github.com/servo/servo/pull/31522	update readme (#31522)
    +++ 602a5092c0f766ff536282feb0f31291fc4f5fec	https://github.com/servo/servo/pull/31453	layout: Add support for box-shadow to Layout 2020 (#31453)
    +++ 007a31c1b521118b49572b1790eff312817106d5	https://github.com/servo/servo/pull/31470	Enable CSS Tables by default (#31470)
    d076b118c4cab419716ef63591bb3de173facab5	ci: Fix packaging step on Windows !#31538
    ea38d8ad6f3ef2ac93536caa21908562549d30a7	https://github.com/servo/servo/pull/31499	Add basic support for enumerating computed styles (#31499)
    628314682956d683046548dca492df85be0e6572	https://github.com/servo/servo/pull/31532	build(deps): bump web-sys from 0.3.68 to 0.3.69 (#31532)
    *** a8170966ec4ba970043ca67c09160bc7fff71f9d	https://github.com/servo/servo/pull/31521	Move convert_* functions into gpuconvert.rs (#31521)
    *** 7ce19f2885328a4824f57374ac7fdd8b66fa3c61	https://github.com/servo/servo/pull/31512	Fix several clippy warnings in components/bluetooth (#31512)
+++ 096bd2977a7e322336bd885d68c7e722a47bfeaf	https://github.com/servo/servo/pull/31519	layout: Add start of documentation for inline layout (#31519)
    dea416eec99b475a2ed1c8ae47fdef4b8eb913de	https://github.com/servo/servo/pull/31513	Fix the measures of a table cell (#31513)
    *** 3a3e76a935f92ce84c24496cfc46207cd46088f6	https://github.com/servo/servo/pull/31508	Fix several clippy warnings in components/hyper_serde (#31508)
+++ 24a088d94c0a6ad87eb0fecebf2db69ffa569c1d	https://github.com/servo/servo/pull/31515	shell.nix: update filterlock hash (#31515)
>>> 2024-03-09T06:16:11Z
    55f908653f6fb02c344459319a7ca87487cfa4bf	https://github.com/servo/servo/pull/31589	compositor: Remove the `is_running_problem_test` setting (#31589)
48f5ee828cd15e2f8be2e3a7aef521a6d13ff32e	https://github.com/servo/servo/pull/31593	fix: resolved warning related to deprecated method chrono::NaiveDateTime::from_timestamp_opt (#31593)
0f4522c36087e44c82b8ad1c0d9a47e6a638aaae	https://github.com/servo/servo/pull/31588	Fixed unresolved links by appropriately linking to parent (#31588)
    *** f64409dbfb66d0ed5ca24d8186662b407a94abc5	https://github.com/servo/servo/pull/31592	Fix rustdoc warnings in `components/layout 2020/positioned.rs` (#31592)
0768bba5b9077e375f850bd917611f01ff7cdd4b	https://github.com/servo/servo/pull/31584	fix: resolved warnings related to deprecated method chrono::NaiveDateTime::timestamp_millis (#31584)
    *** 81e6bd962bb78cd195dc7f4f00ab4f31288ff4a9	https://github.com/servo/servo/pull/31587	Fix rustdoc warnings in `components/layout_2020` (#31587)
    *** 48f9db9bc501c063560472a995ff9d59e158758a	https://github.com/servo/servo/pull/31585	Make image decoding thread pool the size of the system's CPUs (#31585)
    *** 43f44965cda8751e04195bf4c4f298147907843f	https://github.com/servo/servo/pull/31565	clippy: fix warnings in components/shared (#31565)
    *** 3a5ca785d3ecc1fd6cb5a519cf1a91ac61e15c8c	https://github.com/servo/servo/pull/31568	clippy: fix warnings in various modules in components (#31568)
19f1f2a8f4a18b17fc9c4ce80df831a339ce91f0	https://github.com/servo/servo/pull/31569	Extract generated finalizers into generic helper functions. (#31569)
    *** 0327d4638bdb3c95315c143dfcc94d8195fb5fae	https://github.com/servo/servo/pull/31583	Adjust the language used in some of the documentation (#31583)
    +++ 7e8a1503ba6f3c4d99ffed90e65746d63a65ac8d	https://github.com/servo/servo/pull/31535	layout: Add documentation about table layout (#31535)
    *** dd6c929cc6baaea4a385c8c2cc5dc5f3236e8c06	https://github.com/servo/servo/pull/31582	Fix rustdoc errors in `components/shared` (#31582)
    +++ 6b5a5147f8ce927fc8765e0ab5b447faa8744cd4	https://github.com/servo/servo/pull/31536	Obey table cell's box-sizing (#31536)
    +++ 49ae9bb4422b6d72ebbeb67b59e9ac734e8363b5	https://github.com/servo/servo/pull/31578	layout: Fix the pseudo for anonymous tables (#31578)
    *** a5a0e1cb3c339f9314777ebe18c88ca7c933b2c0	https://github.com/servo/servo/pull/31534	Fix inheritance.sub.html WPT to work on Servo (#31534)
    *** 07485798032bf4703e405a1d756435b4135b63f9	https://github.com/servo/servo/pull/31551	Fix clippy warnings in components/shared/net/request.rs (#31551)
    *** 52c4f57085eee5e9a6525fd0a9d380f55e8b1a88	https://github.com/servo/servo/pull/31537	Update phf_codegen and phf_shared to 0.11 (#31537)
    *** 5c4f8cf0df2292537dce26856e8d16d71309a24c	https://github.com/servo/servo/pull/31563	clippy: fix some warnings in components/canvas (#31563)
    *** ef3dad3a610d9d73754e976bece64a2184ed3821	https://github.com/servo/servo/pull/31562	clippy: fix warnings in components/config* (#31562)
    *** 88033bd65435ff502b847ecc783616c4f2ff74bd	https://github.com/servo/servo/pull/31560	clippy: fix warnings in components/gfx (#31560)
    1771f9a9a1d75e39c5ef9ccd06d247f024b0d8fe	https://github.com/servo/servo/pull/31574	Fix broken wiki link in README for Android instructions (#31574)
>>> 2024-03-10T06:09:37Z
    9dff1fecfc3c172cda62b269a08e6ac517a9b3a4	https://github.com/servo/servo/pull/31595	wpt: Start running the WOFF2 tests (#31595)
    +++ fddc7a1390e96c7ee7f97b8638fbb488cceb4715	https://github.com/servo/servo/pull/31596	Align table cell measures in the block axis to Gecko/Blink/WebKit (#31596)
    +++ 1f23ec2b27789c356a6283d9005079b6e9b1e66b	https://github.com/servo/servo/pull/31586	layout: Do not inherit node and fragment flags in anonymous boxes (#31586)
>>> 2024-03-11T06:05:10Z
    *** af3583ade88a747232fee578f1af981064da7109	https://github.com/servo/servo/pull/31608	fix: unused mem import (#31608)
    *** 0bc685ed97c1cb2743ec2f1ef4d58f9298872fe6	https://github.com/servo/servo/pull/31548	Fix more clippy warnings in `components/shared/net` (#31548)
    *** 67b277c992d59dfed7d9177d4a62a1517d28a5b5	https://github.com/servo/servo/pull/31564	clippy: fix warnings in components/net (#31564)
099bb0fa194ad9a27c6e3512163eaaf42d91bbe6	https://github.com/servo/servo/pull/31600	Use get_desired_proto in htmlconstructor (#31600)
f44cefa8166955776c442c7636a159f8e582b469	https://github.com/servo/servo/pull/31580	Add rust-lldb to mozdebug (#31580)
    60e4c1adb4e1ab069ced892c28c027e3e454675c	https://github.com/servo/servo/pull/31599	Update web-platform-tests to revision b'd9a5cc25fc5f520bde022cee67e9e6a6f0b588f9' (#31599)
>>> 2024-03-12T06:07:08Z
    *** d1fd8d55abc5bae468a6f8cca95277d88c9899ce	https://github.com/servo/servo/pull/31617	Fix rustdoc errors in `components/script/dom` (#31617)
    45344dca2b6fc6afcbadc83dd3c87b57fa775524	https://github.com/servo/servo/pull/31601	font_cache: Handle filtering `@font-face` rules in Servo (#31601)
    *** b03411f56771dfb45ec4c8a3d9888caac65abaf9	https://github.com/servo/servo/pull/31611	clippy: Fix warnings in `components/layout_2020` (#31611)
    +++ 1d1f239ecc8bccef7869425f1fb4925fecf0e2c1	https://github.com/servo/servo/pull/31597	layout: Enable rendering of `conical-gradient` and `repeating-conical-gradient` (#31597)
    +++ de7b9bed858aff460b19c75dd3a5337aebc650f9	https://github.com/servo/servo/pull/31613	Take spaces into account in the max-content size of an IFC (#31613)
    *** a6e25d555beec2c454c03f9ca0f5c4047d538b2d	https://github.com/servo/servo/pull/31612	clippy: Fix warnings in `components/layout` (#31612)
    *** 7f1ef4c7fe7d68b08894eb0e944448505178f79d	https://github.com/servo/servo/pull/31610	clippy: Fix warnings in `components/constellation` (#31610)
    11c16adcd184dd5bc98ad946ac05e942d335f0a3	https://github.com/servo/servo/pull/31602	Use libc::malloc_size on apple (#31602)
>>> 2024-03-13T06:14:05Z
+++ 0fda14263a206d99792fcfbec6a5f6dfdb5ff337	https://github.com/servo/servo/pull/31621	layout: make `margin` in `pbm` use app unit (#31621)
0b4b544910030c672020fee7fd1ba2cbad8410ab	https://github.com/servo/servo/pull/31633	Update FUNDING.yml (#31633)
    5febb3031337f7ee989fe3be80a4f3fdf0bf933c	https://github.com/servo/servo/pull/31631	build(deps): bump proc-macro2 from 1.0.78 to 1.0.79 (#31631)
    ed20f4f11a201b5d062b9cad5622a3e214379cea	https://github.com/servo/servo/pull/31630	build(deps): bump anyhow from 1.0.80 to 1.0.81 (#31630)
    67bf31609381f22122549b99a8acce7eb5f44bb2	https://github.com/servo/servo/pull/31629	build(deps): bump thiserror from 1.0.57 to 1.0.58 (#31629)
    *** 21939c2ba89806aa548553f7d3d3b039fa41ae0b	https://github.com/servo/servo/pull/31627	clippy: Fix warnings in `components/shared` (#31627)
    *** 4efebf1e6207a57d7e68f637ee3fe9ce34ee0fd0	https://github.com/servo/servo/pull/31623	Fix clippy warnings in components/third_party (#31623)
    *** 59d89c826766e334500c1f4c17dc4e344fafb5ba	https://github.com/servo/servo/pull/31625	rustdoc: Fix StackingContextFragment error (#31625)
da609076c32abcc3d3267cb663dbae861b2dfba7	https://github.com/servo/servo/pull/31616	Add wpt-report output & continue if filtering failed (#31616)
48fa77df6710a89e156c8cebb7dec10c8cda4ae6	https://github.com/servo/servo/pull/31385	Gamepad: Align closer to spec and implement missing slots (#31385)
31a50feb4a61707d661c6b72fe6479666a5c9832	https://github.com/servo/servo/pull/31622	Add CoC and Security Policy (#31622)
    0ef07866a28e5bbc92def5f84d31f4c8de799467	https://github.com/servo/servo/pull/31620	build(deps): bump bytemuck_derive from 1.5.0 to 1.6.0 (#31620)
>>> 2024-03-14T06:15:04Z
    +++ f3a73dbed39c38c6581fc356d3d4f2d38c906e93	https://github.com/servo/servo/pull/31606	End ongoing IFC when inserting anonymous block-level table (#31606)
    *** 525fc58ed9816d1cf43971c48f65266de9bd424e	https://github.com/servo/servo/pull/31647	rustdoc: Fix warnings in `components/layout_2020` (#31647)
    *** 8cbad332c3fe881f2f2a6628e0abbe01e18ca782	https://github.com/servo/servo/pull/31643	rusdoc: Fix `idl` warning in components/script/dom/bindings (#31643)
    0779af71a051d08edf8a6c1ce2fd7d79acba61a7	https://github.com/servo/servo/pull/31645	build(deps): bump bytemuck from 1.14.3 to 1.15.0 (#31645)
    *** f5a1879bacf56200b08ac87a4a4e122d5c342f3b	https://github.com/servo/servo/pull/31640	rustdoc: Fix warnings in `components/layout_2020` (#31640)
38db1a5ce91c0fe3206bcf6e8e0c0e4a92b11138	https://github.com/servo/servo/pull/31639	rustdoc: Add some basic Safety sections to unsafe functions (#31639)
    +++ 0860deba05956babf77a6acd26ff9cf41431c3f1	https://github.com/servo/servo/pull/31636	Fix vertical alignment at the root of an IFC (#31636)
    *** 63527f56ca53ffad6be4d2552c8f7bb11bc945e2	https://github.com/servo/servo/pull/31626	clippy: Fix warnings in `components/net` (#31626)
    *** 5ea05317757579afa7428f81b5688609341594b1	https://github.com/servo/servo/pull/31632	rustdoc: Fix warnings in `components/script/dom` (#31632)
    716f4a006d3e2c3d920eea82caf82521d4e7f86c	https://github.com/servo/servo/pull/31618	layout: Propagate overflow values from `<body>` to root element (#31618)
    *** 03d64d0675d4d1878232829293e7fdacaec5844e	https://github.com/servo/servo/pull/31628	clippy: Fix assorted warnings in `components/` (#31628)
>>> 2024-03-15T06:15:11Z
    +++ bc4f1c217d28ce972632ab42090d741c76b67e3b	https://github.com/servo/servo/pull/31682	Implement HTMLStyleElement.disabled attribute (#31682)
+++ ad37a54f59f4eef2c8f815a3a59ab7d928b2946f	https://github.com/servo/servo/pull/31486	dependencies: Upgrade to WebRender 0.64 (#31486)
    4597aeae5f9b1d76d6af664afdbb72647908e907	https://github.com/servo/servo/pull/31674	build(deps): bump smallbitvec from 2.5.1 to 2.5.2 (#31674)
    2afc117c44fffb3dc9b82c30bbc121a502349dd7	https://github.com/servo/servo/pull/31672	build(deps): bump system-deps from 6.2.0 to 6.2.1 (#31672)
    +++ ed99128132eeed2aefea4a0e0a87e6eb0b14bd12	https://github.com/servo/servo/pull/31659	constellation: allow event tracing to be configured with RUST_LOG (#31659)
    +++ b30b79a93af92d5a67215a85f14038f64ffef4fb	https://github.com/servo/servo/pull/31661	Cleanup UA styles for anonymous table rows and cells (#31661)
e5fbb3d48781765745f5fcc007e469f048e9ebd7	https://github.com/servo/servo/pull/31658	fonts: Add `FontIdentifier` and `LocalFontIdentifier` (#31658)
b1debf20689949c0acfb06efca70f7fd34dc0854	https://github.com/servo/servo/pull/31656	fix: missing thread name when spawning (#31656)
    +++ 78fe461ff28ea800994686b68878d4825016b5f3	https://github.com/servo/servo/pull/31619	layout: Properly parent table-row and table-row-group (#31619)
    +++ 0e78c8114b2a43df04d75dc1decf01e06992262f	https://github.com/servo/servo/pull/31650	Allow finishing anonymous inline-table at the end of inline elements (#31650)
    +++ 871a9bf677525293d6a3ac46b55660aaee02281b	https://github.com/servo/servo/pull/31641	layout: IFCs should not always be marked as containing floats (#31641)
    +++ eaa800c8dd78eb5c6865bb80778a2f6996915714	https://github.com/servo/servo/pull/31657	servoshell: allow event tracing to be configured with RUST_LOG (#31657)
>>> 2024-03-16T06:14:06Z
8cfc6a1898d02eb1df9c13c3c410747cb1e0b412	https://github.com/servo/servo/pull/31707	Updated comment with 'layout_traits' to 'script_layout_interface' (#31707)
    +++ 82128d38385708d80a29dc3a6808be943dda6f9b	https://github.com/servo/servo/pull/31704	Don't null out the baselines of anonymous tables (#31704)
d211cfc97870f436485b35a357a66ff4824cc3d5	https://github.com/servo/servo/pull/31697	documentation: Add instructions for creating a shallow clone of the Servo repository (#31697)
    30db7a9a5f59032321fb0ed0b5e9e2fbdf567b2a	https://github.com/servo/servo/pull/31703	build(deps): bump tokio-test from 0.4.3 to 0.4.4 (#31703)
    *** 8a6481c3411543a79b7fdc2fdb191dfa85c33111	https://github.com/servo/servo/pull/31700	clippy: Fix warnings in `components/script` (#31700)
    +++ 47a4ce467fd146681e9debc7de7bb0f1f4184b7e	https://github.com/servo/servo/pull/31696	layout: Add basic support for `getClientRects()` queries (#31696)
    3f3820b3dc425c1e7f89a8091318d73fce4f04c9	https://github.com/servo/servo/pull/31702	build(deps): bump tokio-stream from 0.1.14 to 0.1.15 (#31702)
    94b68ccb0c9e465a97ff2948a9da7c84e64d63f1	https://github.com/servo/servo/pull/31701	build(deps): bump h2 from 0.3.24 to 0.3.25 (#31701)
    *** 4cd3c056e520978a0df111aa4f09ab17e363a98c	https://github.com/servo/servo/pull/31654	rustdoc: Fix errors in `components` and `ports` (#31654)
+++ 39f660f520a4aa0f3fad95f02fec5beb2dfc9d07	https://github.com/servo/servo/pull/31681	Allow pre-wrap whitespace to hang at the end of the line (#31681)
ac24cd61395f6a9646efe1da13ba5674eea59e7e	https://github.com/servo/servo/pull/31698	Update new issue URL in SECURITY.md (#31698)
    +++ 99c14c83ed0e2412bb17f0f58251bf4786550c22	https://github.com/servo/servo/pull/31660	Obey white-space when intrinsically sizing an IFC (#31660)
74b5f798cd22fa6b8911cdab2561efcf87cf0041	https://github.com/servo/servo/pull/31693	Add issue templates (#31693)
    *** a8791ddcbcdfd0e8e0f0f87cf5920b6e580ed717	https://github.com/servo/servo/pull/31669	clippy: Fix remaining warnings in `gfx` for MacOS (#31669)
    *** cb3ae70340d413f3487fac2531bf2b4abe18233f	https://github.com/servo/servo/pull/31694	Add RUSTC env to clippy command (#31694)
+++ 3fdbde94cff38ee7aeb624616a4abffa870d2589	https://github.com/servo/servo/pull/31691	Escaped reporting (#31691)
    *** 55250dd8a6317df875ff4931dd090d7a968b88e9	https://github.com/servo/servo/pull/31685	Fix typo: changed seperator to separator (#31685)
+++ 884d02495712d4cc0cafb26443ff5b1bf7e92f5b	https://github.com/servo/servo/pull/31687	Add gstreamer plugins good/ugly for better codec support (#31687)
    *** 68b82e6d6133c8213cdad09b240d7a69227cc82a	https://github.com/servo/servo/pull/31668	fonts: Add Noto Sans CJK fonts to the Linux fallback list (#31668)
>>> 2024-03-17T06:07:23Z
>>> 2024-03-18T06:08:22Z
    *** 99ddab43e8384f72ec9da1730e44c51e95e042a1	https://github.com/servo/servo/pull/31721	clippy: Fix warnings in generated code (#31721)
    1a46529560b26b3d76e614287e3646632e259290	https://github.com/servo/servo/pull/31709	build(deps): bump Stylo from `7dd8840` to `2c775e4` (#31709)
    52c2b1e3a8f57af9885bbc52037fc1cad42f7dae	https://github.com/servo/servo/pull/31715	Sync WPT with upstream (17-03-2024) (#31715)
    +++ d2dcb20beac29eabce02ea59b4944585d5b48a7c	https://github.com/servo/servo/pull/31635	Implement console.count/countReset (#31635)
    f98975bbbe7cd8cf55f172dae96f8cbc79c0e479	https://github.com/servo/servo/pull/31714	Update raw lags path for WPT import (#31714)
>>> 2024-03-19T06:24:09Z
    228f4fb2fcf54e54edc2bbd1dbf8acd5a086c485	https://github.com/servo/servo/pull/31743	build(deps): bump syn from 2.0.52 to 2.0.53 (#31743)
    d6d903c5a11bafe7a23d15c7fd94d87dff6e3ac6	https://github.com/servo/servo/pull/31742	build(deps): bump brotli from 3.4.0 to 3.5.0 (#31742)
    b2d2bfcc5a9fd3fd91d5b64e2cb8667eb27d7777	https://github.com/servo/servo/pull/31744	build(deps): bump new_debug_unreachable from 1.0.4 to 1.0.6 (#31744)
    9562c33ff4ff6b54fe8ccfc1b930182d5a6c769b	https://github.com/servo/servo/pull/31741	build(deps): bump smallbitvec from 2.5.2 to 2.5.3 (#31741)
    32d6c2e5122150cbdd241a83f75c12b7fe724a85	https://github.com/servo/servo/pull/31739	build(deps): bump io-kit-sys from 0.4.0 to 0.4.1 (#31739)
+++ c07484fcb605a9ab0a3f9fba4cb4ddd24d89cb87	https://github.com/servo/servo/pull/31609	 Update Stylo to 2023-09-01 (#31609)
    *** 94c1f2c99229fde82e09ae5d8e06792ea9d90787	https://github.com/servo/servo/pull/31670	fonts: Consider Tertiary Ideographic Plane to be CJK (#31670)
+++ 55bb289b30d960d87eaaad9cfe5698d61566fb7f	https://github.com/servo/servo/pull/31727	android: fix broken rendering in emulators (#31727)
    *** 3ac0ab2e4e711a3097d50c699f3572091fa03fd2	https://github.com/servo/servo/pull/31719	clippy: Fix some warnings in the `script` crate (#31719)
    4bca55e27ad38685067986c8f478bae1b214b43c	https://github.com/servo/servo/pull/31725	android: add support for x86_64 images (#31725)
    *** b2f2ae61dbf2fdf443efd7c55f07bedeed782d0e	https://github.com/servo/servo/pull/31718	Updated inconsistent context for crates (#31718)
    *** f6a975fc58557b6267ead065a6025ba83ae27474	https://github.com/servo/servo/pull/31710	clippy: Fix several warnings (#31710)
    *** 1ab8fa2895bd2339981e0be52591f38ad834ed21	https://github.com/servo/servo/pull/31712	rustdoc: Fix two warnings in `components/layout_2020` (#31712)
>>> 2024-03-20T06:15:08Z
    0cf2caba06a78fe3695c46b468422e975f0bd187	https://github.com/servo/servo/pull/31761	build(deps): bump bitflags from 2.4.2 to 2.5.0 (#31761)
    646fca5c49f260dcfba42f3e6bc8572236035414	https://github.com/servo/servo/pull/31764	build(deps): bump uuid from 1.7.0 to 1.8.0 (#31764)
    *** e3809dfd063dc830bafbf3141f04eb902f440514	https://github.com/servo/servo/pull/31769	Fix clippy warnings in components/script/textinput.rs (#31769)
    *** 865f6e621fde4e6d5b7cf165f2562e9ea18fab23	https://github.com/servo/servo/pull/31759	clippy: Fix clippy Problems in components/scripts (#31759)
    96e5e776d26d2b8657d805647521b37af9d13b13	https://github.com/servo/servo/pull/31763	build(deps): bump gstreamer from 0.22.2 to 0.22.3 (#31763)
    c53e0f97091d8949e610232323381b71a2c45f1e	https://github.com/servo/servo/pull/31762	build(deps): bump glib from 0.19.2 to 0.19.3 (#31762)
    af612f33bdd3e94d902d3854cb0c3123180e4a26	https://github.com/servo/servo/pull/31760	build(deps): bump git2 from 0.18.2 to 0.18.3 (#31760)
    *** 01ca220f83f549d03da566f4becdf826819747ae	https://github.com/servo/servo/pull/31717	clippy: Fix many warnings in `components/script` (#31717)
    *** 676f655647fe261c9a9f005122cbbca0263a2625	https://github.com/servo/servo/pull/31758	clippy: Fix dereferenced warning (#31758)
    *** d0fcbb08981f6defa12b7279d7a4a0f264cbbfde	https://github.com/servo/servo/pull/31738	rustdoc: fix warnings in `components/layout_2020/table` (#31738)
    +++ f175679434328fdd9043197ba35ccf03369769cb	https://github.com/servo/servo/pull/31756	gfx: Derive `line-through` metrics for fonts on MacOS (#31756)
    *** d3b03a20b55533eab2ec7237c3d995788ec742e1	https://github.com/servo/servo/pull/31745	rustdoc: Fix broken link to `FontFace` in `components/gfx` (#31745)
    *** 36d9ab8b283dc18863ee0515acf5fafb2a84f458	https://github.com/servo/servo/pull/31755	rustdoc: Convert url text to anchor link (#31755)
+++ 05d9373bc5dab94d6ae8309c341db6b7d76e5a0e	https://github.com/servo/servo/pull/31733	compositor: Handle synchronous messages while shutting down (#31733)
    +++ 2ec995a56fdba9a5978fd74bee91e298fa9617bd	https://github.com/servo/servo/pull/31734	layout: Enable `text-shadow` (#31734)
    8cf47e6009a9b2e1f9e7f8639f83cc47c247877f	https://github.com/servo/servo/pull/31750	bootstrap: Make unknown distro instructions more helpful (#31750)
    *** 2a02f94d7649d45f09eff9f27263f20c10502ec8	https://github.com/servo/servo/pull/31708	rustdoc: Correct unresolved link to `handle_cell. (#31708)
    *** 03c11f7907dedd7e6c76167172349db6d19844d7	https://github.com/servo/servo/pull/31644	rustdoc: Fix some typos in `components/layout_2020/table/mod.rs` (#31644)
    *** 06a021db552c1d2f8899484f7c1143424c387eef	https://github.com/servo/servo/pull/31735	clippy: Fix some warnings in `components/script` (#31735)
    291fbce434f804c2ce51d2b966bab4c472d9ecf3	https://github.com/servo/servo/pull/31740	build(deps): bump gilrs from 0.10.4 to 0.10.6 (#31740)
+++ c25069161d868169ef684632c8b2c601f9b9d6ee	https://github.com/servo/servo/pull/31695	Add pseudo async Create*PipelineAsync methods (#31695)
>>> 2024-03-21T06:10:43Z
    *** 2789e9887666a05695778bd9d822616985b40dbc	https://github.com/servo/servo/pull/31793	clippy: Fix redundant field names warnings (#31793)
    f55d1d288e4ede7da3090e853a0a0f6aab42c113	https://github.com/servo/servo/pull/31798	build(deps): bump smallvec from 1.13.1 to 1.13.2 (#31798)
    *** efba769fa3997f2917d54a29b2b24872bf607bc5	https://github.com/servo/servo/pull/31797	fixed unused import warning in minibrowser (#31797)
    63d7af54d1d0d651f1996808e59a65dd9490e26e	https://github.com/servo/servo/pull/31790	Ignore stylo crates in dependabot.yml (#31790)
    *** b3dc5c6958f64dcf1a886f293852726d3d0b9d37	https://github.com/servo/servo/pull/31737	Attempt using version of Stylo with -x-lang enabled (#31737)
    *** 058319aa0b9dbf1916dd87f27171bccd051be3e3	https://github.com/servo/servo/pull/31778	clippy: Fix some clippy problems in `components/script` (#31778)
    3651b650c48ba8cf1b8f00f4be9705ac11b68a8c	https://github.com/servo/servo/pull/31788	build(deps): bump rustix from 0.38.31 to 0.38.32 (#31788)
    e16b87db14dbd281e73f90a16d85b8ae0f040db9	https://github.com/servo/servo/pull/31789	build(deps): bump webxr from `614420b` to `88fd368` (#31789)
    c546c675a22f0f7d46c5a9e34584c4c63939f58f	https://github.com/servo/servo/pull/31786	build(deps): bump aho-corasick from 1.1.2 to 1.1.3 (#31786)
    *** 15bf32a4e615c0d663bc04a1b7b7adc038c993c5	https://github.com/servo/servo/pull/31776	clippy: Fix unneeded return statement warnings (#31776)
    d63615354cc02ceea08aaf3727530d4afa5b1876	https://github.com/servo/servo/pull/31773	Make `Cargo.toml` a little friendlier (#31773)
+++ 94d2f2183afaa3410f678447be6b1863537662ee	https://github.com/servo/servo/pull/31774	servoshell: fix gap between minibrowser toolbar and webview (#31774)
    *** 02a0cdd6faf80b77c6b066120bc2927c963affe3	https://github.com/servo/servo/pull/31770	clippy: Fix dereferenced warnings (#31770)
>>> 2024-03-22T06:22:40Z
    +++ 0b863de8468ad2526bd9131243fd18cb3ba8b100	https://github.com/servo/servo/pull/31815	Rework “visible” to “throttled” in embedder-to-constellation + jniapi (#31815)
    49c6f9e463582c8687a9e3674db7fac740bdad68	https://github.com/servo/servo/pull/31814	Update some dependencies (#31814)
    *** 3e63f8d6ee0dbd7934a0cb05753820676b89c61d	https://github.com/servo/servo/pull/31813	clippy: Fix needless borrow warnings (#31813)
    *** 694e86ecffb882f6d5934eb620257e9fceddbca8	https://github.com/servo/servo/pull/31811	clippy: Fix dereferencing a tuple pattern warnings (#31811)
    *** b22281d94f230c455142b73576904fdec2d1140a	https://github.com/servo/servo/pull/31802	Fix WPT reference no_red_3x3_monospace_table-ref.xht (#31802)
    +++ 841bd917840fe976646bab3923c0b54b62683040	https://github.com/servo/servo/pull/31777	layout: Take into account `text-indent` for justification (#31777)
+++ 755701f4f6a961cc76bdef02a96843727e86dd9a	https://github.com/servo/servo/pull/31805	crown: Do not warn about crown for rustdoc or clippy (#31805)
+++ 32a2b060738df8ce343e79ef71563018b8189187	https://github.com/servo/servo/pull/31810	Update fontsan to 0.5.2 (#31810)
    *** 8c7e9a15e1d63f99a887f4c78638017e31eed7a0	https://github.com/servo/servo/pull/31711	Remove repeated imports from generated code (#31711)
f5c4988dcb320bd92555d756790576ae36d74f81	https://github.com/servo/servo/pull/31808	Use C-ABI for JNI functions (#31808)
    *** da696b7e57fd4fbf615b3853ac48cf522e87e098	https://github.com/servo/servo/pull/31791	clippy: fix `result_unit_err` warnings (#31791)
ea62a5e24f5c9a3b7c0588506f7a38de9ddbcd67	https://github.com/servo/servo/pull/31720	Use --locked when building in CI (#31720)
    +++ ecabdc2583f8e82f39600c2b5d1ca81a7219f235	https://github.com/servo/servo/pull/31803	Don't trim leading whitespace of anonymous table cells (#31803)
    *** ce0d4564694eb0d5d8baccd53377e387ea303e95	https://github.com/servo/servo/pull/31799	clipping: Fix some warnings in `components/script/dom` (#31799)
+++ 4b408a37246f02c27ea70f6eec0d2c790be35e00	https://github.com/servo/servo/pull/31757	Update mozjs to use SM 115.9 (#31757)
    *** 7cdff9dd064268796bcc6071646a0496607ed5a3	https://github.com/servo/servo/pull/31800	Clippy: Fixed warnings in htmlimageelement.rs (#31800)
    *** da3288dd00c16f6c4ac18cd3b6ba87a2917978d1	https://github.com/servo/servo/pull/31801	Clippy: Fixed clippy warnings in components/script/dom (#31801)
+++ 5c0199b5687a5c0c1b2fe82235ca609c7d9ea614	https://github.com/servo/servo/pull/31771	Net: fold websocket and http tokio runtime into one (#31771)
>>> 2024-03-23T06:12:59Z
    e22b61c935dcc9bfa1455c86a0a8a68fca6e4ee6	https://github.com/servo/servo/pull/31829	build(deps): bump libz-sys from 1.1.15 to 1.1.16 (#31829)
+++ cb275e086c215b6da741c7918cd9683a134eb24f	https://github.com/servo/servo/pull/31809	Implement StaticRange (#31809)
    *** bae77671f85481503ab563c20ed488cf883436fa	https://github.com/servo/servo/pull/31823	clippy: Fix `unnecessary_cast` warnings in `components/script` (#31823)
    *** 3e9b8089381492edeb0992c93776d39bf1df2607	https://github.com/servo/servo/pull/31784	Fix some clippy warnings in `components/script/webdriver_handlers.rs` (#31784)
    *** 77f5175efcf764edb3bf93a20a10e10ac981308a	https://github.com/servo/servo/pull/31822	removed  mutable compile warnings (#31822)
+++ 99bad9d9b8110f6f7354b6a0e8132e969a38751e	https://github.com/servo/servo/pull/31821	Bump fontsan version (#31821)
    34dd38b4cbe0f35000c45683d0c65daa78a15644	https://github.com/servo/servo/pull/31817	Replace `remutex` with `parking_lot`'s `ReentrantMutex` (#31817)
    +++ 8882507ad06b598fb43d8542c67ad76daeda739c	https://github.com/servo/servo/pull/31816	Rework “visible” to “throttled” in constellation + script + compositor (#31816)
    *** 9b26dca141159ddc75266de9ef5a54f537450921	https://github.com/servo/servo/pull/31819	Fixed the .clone() warnings. (#31819)
+++ 95e69fe4ffce23708608855720961741344bee07	https://github.com/servo/servo/pull/31794	layout: use `Au` in `BoxFragment` (#31794)
>>> 2024-03-24T06:10:23Z
    *** 0a771169b82744ce2427c906c6162546285c6889	https://github.com/servo/servo/pull/31842	fix redundant closure (#31842)
    *** 566fd475d92a6e11f70af18171a2f8bf9b80da68	https://github.com/servo/servo/pull/31818	Clippy: Fixed some clippy warnings (#31818)
    *** 3c05b58221a2b5c879d31d355087a905de6494d8	https://github.com/servo/servo/pull/31837	clippy: Fix `explicit_auto_deref` warnings in `components/script` (#31837)
    3fc157338e20936b8446c4685a477fad4169d92a	https://github.com/servo/servo/pull/31826	remove unused code (#31826)
>>> 2024-03-25T06:05:44Z
+++ 58081579e9a537ba6bd71bcdcb2b066e14e037b8	https://github.com/servo/servo/pull/31841	WebIDL: Remove `JSObject` from `Document::NamedGetter` (#31841)
    *** 1ab38fcd3f01fa0dd35f5275f26158bdf8f4f329	https://github.com/servo/servo/pull/31827	clippy: Fix `default_constructed_unit_structs` warnings in `components` (#31827)
>>> 2024-03-27T06:13:22Z
    *** 92b557867c199472ce42a2f5b99676c485ed2ae1	https://github.com/servo/servo/pull/31888	clippy: fixed some warnings in components/script (#31888)
    +++ 8dece05980a4ec46b06505e511f8b158d4c0fe3b	https://github.com/servo/servo/pull/31879	fonts: Add support for WOFF2 and properly load web fonts from @imports (#31879)
    *** b55d0a20532b915dee395f8c448ac832ed36b7d4	https://github.com/servo/servo/pull/31877	clippy: Fix clone-on-copy warnings (#31877)
+++ 5f7baf31c2097a02d8ddb370d6131d2703413010	https://github.com/servo/servo/pull/31748	dom: Abort media element load on decode errors (#31748)
    4da9d39ccaa57a879cc9d586b7c940d274e8cba7	https://github.com/servo/servo/pull/31883	build(deps): bump autocfg from 1.1.0 to 1.2.0 (#31883)
    2649e4d4b26d8c7a93d1a481fbf92b0f39a90c6d	https://github.com/servo/servo/pull/31886	build(deps): bump chrono from 0.4.35 to 0.4.36 (#31886)
    a05c0a9a31b6283a8c4dd352938afc07a69b2fa6	https://github.com/servo/servo/pull/31885	build(deps): bump itoa from 1.0.10 to 1.0.11 (#31885)
    17e9a534f11723c5219bbb75029b000db946c779	https://github.com/servo/servo/pull/31881	build(deps): bump serde_json from 1.0.114 to 1.0.115 (#31881)
    +++ bf3798bbde8131a5336ad6987adb15d2dd0f5490	https://github.com/servo/servo/pull/31857	layout: More conservatively replace Stylist's Device (#31857)
    *** b71de9256911e1e29006cf1c1a782bda5c4c8968	https://github.com/servo/servo/pull/31876	clippy: Fix single_match warnings (#31876)
    +++ d16f259e1d3c7b8c0c0f4692af41ba2e41085e23	https://github.com/servo/servo/pull/31862	Fix table with rows but no column (#31862)
    *** 68b0be6dc7a22ad743687bc963d4b9806391eaaa	https://github.com/servo/servo/pull/31834	 clippy: Map to an error type instead of using allowing `result_unit_err` in `components/url` (#31834)
    2463017c49373373d6af5e6a9f616abd486cd4d6	https://github.com/servo/servo/pull/31874	tidy: Make sure to run WPT lints when `--all` is passed to tidy (#31874)
    *** 188f3caff168a217b0cff3641cb2dbff232cea1c	https://github.com/servo/servo/pull/31865	clippy: fix some warnings in components/script (#31865)
    58f170c97ab0715d7ca4833f7ec17d80f435d627	https://github.com/servo/servo/pull/31873	Update python detection in codegen (#31873)
    *** f8a2eaea4741408c73efc5c0ad467eae96d2e799	https://github.com/servo/servo/pull/31853	clippy: Fix collapsible_else_if warnings (#31853)
    *** d814d0553981777c01409d545e5c1c335b8eb7f4	https://github.com/servo/servo/pull/31863	fixed the `unneeded return` statement warnings. (#31863)
    *** f7669b5238ce9e2a94495472bf77f67b0e311cd8	https://github.com/servo/servo/pull/31864	fixes dereferencing on an immutable reference (#31864)
+++ 585e0d69cdf00319125fa7260fde9cd16d57b2d8	https://github.com/servo/servo/pull/31713	minibrowser: Add loading spinner  (#31713)
    5f65a09d3a034f10f07384b6ee968f02ba805c83	https://github.com/servo/servo/pull/31858	build(deps): bump bytes from 1.5.0 to 1.6.0 (#31858)
    f4e9e22310508d33725390f55d2154918450e253	https://github.com/servo/servo/pull/31859	build(deps): bump rayon from 1.9.0 to 1.10.0 (#31859)
    44f39921ce2d80ab55dc8016ff719042bd453a5b	https://github.com/servo/servo/pull/31861	build(deps): bump regex from 1.10.3 to 1.10.4 (#31861)
    0dbd60615c330e7ac83fe2d1a6d4e79896fb84d2	https://github.com/servo/servo/pull/31860	build(deps): bump indexmap from 2.2.5 to 2.2.6 (#31860)
    e9483887792362220aa547c46f1644df8f81d0e1	https://github.com/servo/servo/pull/31856	build(deps): bump syn from 2.0.53 to 2.0.55 (#31856)
    5ee4480660f2123d767df4253f4ae173e5495405	https://github.com/servo/servo/pull/31854	build(deps): bump prettyplease from 0.2.16 to 0.2.17 (#31854)
    5bf9ac3e54726cfaa2393327be77667a3166aecd	https://github.com/servo/servo/pull/31855	build(deps): bump fastrand from 2.0.1 to 2.0.2 (#31855)
    +++ e77dc3684236ad6693b8df6131f2ba8f99bbef2f	https://github.com/servo/servo/pull/31705	Pick the first or last baseline as appropriate (#31705)
    *** a53632c0e5fe223ca1c39a088ee46f49bb355243	https://github.com/servo/servo/pull/31852	clippy: Fix collapsible_if warnings (#31852)
    *** 3d10dbae32149515dc839d69bc2ba14f12b45251	https://github.com/servo/servo/pull/31843	clippy: Fix some clippy warnings in `components/script` (#31843)
+++ 97144ddf7104fd2cf8c1947db7f0d432754f37f5	https://github.com/servo/servo/pull/31792	script: Add pre element obsolete width attribute support (#31792)
    *** bd39e03eeb3d369e8189135326c733bbe5a3bb10	https://github.com/servo/servo/pull/31850	changed `match` to 'matches!' (#31850)
    *** 9a76dd9325794346163e858831abb97de4b41e41	https://github.com/servo/servo/pull/31844	clippy: Fix remaining warnings in generated code (#31844)
    *** d8adeb1b44cd99563e29309c31dcc9a008951a63	https://github.com/servo/servo/pull/31849	 clippy: Fix some warnings in `components/script` (#31849)
    +++ dbe3cb8a3c169020ba6e61390c9ae6d4725aa0ae	https://github.com/servo/servo/pull/31831	Don't update row baseline if cell is empty (#31831)
+++ c50df5ccbea192cfd39dd7071dc92c32d6b281cb	https://github.com/servo/servo/pull/31825	nix build: replace `fetchCargoTarball` with `importCargoLock` (#31825)
>>> 2024-03-28T06:16:10Z
    *** 072b892706e9f39a2cb3559c610509cae00ab5cc	https://github.com/servo/servo/pull/31907	clippy:fix various clippy problems in components/scripts  (#31907)
+++ 1c8c287f01757488733f5df501461bf1b74ca163	https://github.com/servo/servo/pull/31880	WebIDL: Replace `NonNull<JSObject>` in `xmlhttprequest` (#31880)
    *** ff95ce5abd5eb108d40ff77fa6319eafbc520dd7	https://github.com/servo/servo/pull/31908	fix: omitted the `let` bindings (#31908)
    *** da76ebabe9359c6f815f16adc81af7f11bb3265c	https://github.com/servo/servo/pull/31906	clippy: Fix option_map_unit_fn warnings (#31906)
    *** a5bcae212a175d89507bffba7c57313b2cc9b3ab	https://github.com/servo/servo/pull/31891	clippy: Fix clippy problems in `components/script/dom` (#31891)
    b476bbafde7193d2831cc9042cf73aec40a864e4	https://github.com/servo/servo/pull/31903	build(deps): bump chrono from 0.4.36 to 0.4.37 (#31903)
    ba11475b24221753b0597ed9aca3b20b1413425b	https://github.com/servo/servo/pull/31902	build(deps): bump regex-syntax from 0.8.2 to 0.8.3 (#31902)
+++ b77ec08ab6e72a607caac61f0518daa6d6009f87	https://github.com/servo/servo/pull/31896	Ignore spaces before atomic inline for the min-content size (#31896)
    *** da518823ff639954c3c47940c97a5a9edc3f5391	https://github.com/servo/servo/pull/31900	clippy: Fix op_ref warnings (#31900)
    *** 773e88197183fa3fedfd72ef65ba31e4e86b9d12	https://github.com/servo/servo/pull/31898	clippy: Fix unnecessary_lazy_evaluations warnings (#31898)
    65db6e3b08daa21bc8cc73614896a1a08005b12d	https://github.com/servo/servo/pull/31895	wpt: Limit the console output sent to the intermittent tracker (#31895)
    *** bb7778774d4bdc6a0f787331e22e36baf027277b	https://github.com/servo/servo/pull/31893	clippy:Fix clippy problems in components/scripts/binding (#31893)
    *** 1f31609952a428ba7c877a7eed3f0ea4df2026f8	https://github.com/servo/servo/pull/31867	clippy: Fix warnings in `components/script/dom/request.rs` (#31867)
    +++ b8c82c1ab00dc8d3738523b60afd9cdcf548e83c	https://github.com/servo/servo/pull/31833	layout: Allow transforming inline replaced elements (#31833)
    *** 15cb9dd5fcdee81c80c5c19b12bb50504754c2ad	https://github.com/servo/servo/pull/31890	clippy: Fix various warnings in `components/script/dom` (#31890)
    *** 29f796a1ded8cf14ebae3b351bc6ec618a5c822f	https://github.com/servo/servo/pull/31878	clippy: Fix some warnings in `components/script/timers.rs` (#31878)
+++ 9b50a6be776ab3223f130deb471d89f6313670d3	https://github.com/servo/servo/pull/31889	Update mozjs to include https://github.com/servo/mozjs/commit/0172cf4b1e7049a70af5bf9f3c953ff48d6744d6 (#31889)
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
