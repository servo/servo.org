---
layout:     post
tags:       blog
title:      "March in Servo: tab navigation, and more!"
date:       2026-04-30
summary:    ao!! wrrrrao!!
categories:
---

[**Servo 0.1.0**](https://github.com/servo/servo/releases/tag/v0.1.0) represents Servo’s biggest month ever, with a record **530 commits** and [**our first ever release on crates.io**]({{ '/blog/2026/04/13/servo-0.1.0-release/' | url }})!
For security fixes, see [**§ Security**](#security).

With this release Servo becomes more accessible, thanks to **tab navigation** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#42952](https://github.com/servo/servo/pull/42952), [#43019](https://github.com/servo/servo/pull/43019), [#43058](https://github.com/servo/servo/pull/43058), [#43246](https://github.com/servo/servo/pull/43246), [#43267](https://github.com/servo/servo/pull/43267), [#43067](https://github.com/servo/servo/pull/43067)), **keyboard navigation** with Alt+Shift and the **accesskey** attribute ([@mrobinson](https://github.com/mrobinson), [#43031](https://github.com/servo/servo/pull/43031), [#43144](https://github.com/servo/servo/pull/43144), [#43434](https://github.com/servo/servo/pull/43434)), and **keyboard scrolling** with Space and Shift+Space ([@mrobinson](https://github.com/mrobinson), [#43322](https://github.com/servo/servo/pull/43322)).

We’ve shipped several new web platform features:

- **&lt;input type=range>** ([@BudiArb](https://github.com/BudiArb), [@rayguo17](https://github.com/rayguo17), [@mrobinson](https://github.com/mrobinson), [#41562](https://github.com/servo/servo/pull/41562))
- **&lt;script blocking=render>** ([@TimvdLippe](https://github.com/TimvdLippe), [#43150](https://github.com/servo/servo/pull/43150))
- **&lt;svg width>** and **&lt;svg height>** ([@Loirooriol](https://github.com/Loirooriol), [#43583](https://github.com/servo/servo/pull/43583))
- **‘X-Frame-Options’** ([@TimvdLippe](https://github.com/TimvdLippe), [#43539](https://github.com/servo/servo/pull/43539), [#43708](https://github.com/servo/servo/pull/43708))
- **‘Content-Security-Policy: frame-ancestors’** ([@TimvdLippe](https://github.com/TimvdLippe), [#43630](https://github.com/servo/servo/pull/43630))
- **‘::first-letter’** styling ([@minghuaw](https://github.com/minghuaw), [@xiaochengh](https://github.com/xiaochengh), [@Loirooriol](https://github.com/Loirooriol), [#43027](https://github.com/servo/servo/pull/43027))
- **‘::placeholder’** styling ([@stevennovaryo](https://github.com/stevennovaryo), [#43053](https://github.com/servo/servo/pull/43053))
- **‘::file-selector-button’** styling ([@lukewarlow](https://github.com/lukewarlow), [@AlexVasiluta](https://github.com/AlexVasiluta), [#43498](https://github.com/servo/servo/pull/43498))
- **‘background-blend-mode’** ([@mrobinson](https://github.com/mrobinson), [#43666](https://github.com/servo/servo/pull/43666))
- **‘content’** on **‘::marker’** ([@niyabits](https://github.com/niyabits), [@Loirooriol](https://github.com/Loirooriol), [#43515](https://github.com/servo/servo/pull/43515))
- **‘list-style-type: &lt;string>’** ([@Loirooriol](https://github.com/Loirooriol), [#43111](https://github.com/servo/servo/pull/43111))
- **‘attr(namespace|local)’** and **‘clamp(none)’** ([@Loirooriol](https://github.com/Loirooriol), [#43045](https://github.com/servo/servo/pull/43045))
- [**&lt;system-color>**](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Values/system-color) ([@longvatrong111](https://github.com/longvatrong111), [@mrobinson](https://github.com/mrobinson), [#42529](https://github.com/servo/servo/pull/42529), [#43105](https://github.com/servo/servo/pull/43105), [#43107](https://github.com/servo/servo/pull/43107))
- [**&lt;step-position>**](https://drafts.csswg.org/css-easing/#typedef-step-position) values **‘jump-start’**, **‘jump-end’**, **‘jump-none’**, and **‘jump-both’** ([@yezhizhen](https://github.com/yezhizhen), [#43061](https://github.com/servo/servo/pull/43061))

Plus a bunch of new DOM APIs:

- **CommandEvent** ([@lukewarlow](https://github.com/lukewarlow), [#43190](https://github.com/servo/servo/pull/43190))
- **moveBefore()** on **Node** ([@lukewarlow](https://github.com/lukewarlow), [#41238](https://github.com/servo/servo/pull/41238))
- **relatedTarget** on **MouseEvent** and **PointerEvent** ([@simonwuelker](https://github.com/simonwuelker), [#42989](https://github.com/servo/servo/pull/42989))
- **command** on **HTMLButtonElement** ([@lukewarlow](https://github.com/lukewarlow), [#43190](https://github.com/servo/servo/pull/43190))
- **selectedOptions** on **HTMLSelectElement** ([@jakubadamw](https://github.com/jakubadamw), [#43017](https://github.com/servo/servo/pull/43017))
- **url** on **LargestContentfulPaint** ([@shubhamg13](https://github.com/shubhamg13), [#42901](https://github.com/servo/servo/pull/42901), [#42949](https://github.com/servo/servo/pull/42949))
- **crypto.subtle.digest()** for **TurboSHAKE** ([@kkoyung](https://github.com/kkoyung), [#43551](https://github.com/servo/servo/pull/43551))
- **crypto.subtle.getPublicKey()** for **ECDH**, **ECDSA**, **Ed25519**, **RSASSA-PKCS1-v1_5**, **RSA-PSS**, **RSA-OAEP**, and **X25519** ([@kkoyung](https://github.com/kkoyung), [@Taym95](https://github.com/Taym95), [#43073](https://github.com/servo/servo/pull/43073), [#43093](https://github.com/servo/servo/pull/43093), [#43106](https://github.com/servo/servo/pull/43106), [#43115](https://github.com/servo/servo/pull/43115))

**servoshell** is now installed as `servoshell` or `servoshell.exe`, rather than `servo` or `servo.exe` ([@jschwe](https://github.com/jschwe), [@mrobinson](https://github.com/mrobinson), [#42958](https://github.com/servo/servo/pull/42958)).
`--userscripts` has been removed for now, but anyone who uses it is welcome to reinstate it as a wrapper around [`User­Content­Manager`](https://doc.servo.org/servo/struct.UserContentManager.html)::[`add­_script`](https://doc.servo.org/servo/struct.UserContentManager.html#method.add_script) ([@jschwe](https://github.com/jschwe), [#43573](https://github.com/servo/servo/pull/43573)).
We’ve fixed a bug where link hover status lines are sometimes not legible ([@simartin](https://github.com/simartin), [#43320](https://github.com/servo/servo/pull/43320)), and we’re working on getting servoshell signed for macOS to avoid getting blocked by Gatekeeper ([@jschwe](https://github.com/jschwe), [#42912](https://github.com/servo/servo/pull/42912)).

[After a long effort](https://github.com/servo/servo/issues/11625) by [@valpackett](https://github.com/valpackett), [@dlrobertson](https://github.com/dlrobertson), and more recently [@nortti0](https://github.com/nortti0) and [@sagudev](https://github.com/sagudev) ([#43116](https://github.com/servo/servo/pull/43116), [#43134](https://github.com/servo/servo/pull/43134)), we can now build Servo for **FreeBSD**!
Note that Servo 0.1.0 still has some issues that need to be worked around, but you can get all the details in [#44601](https://github.com/servo/servo/issues/44601).

<figure>

[![]({{ '/img/blog/2026-04-freebsd.png' | url }})]({{ '/img/blog/2026-04-freebsd.png' | url }})
</figure>

A great deal of work went into making the **crates.io release** possible, including renaming `libservo` to just `servo` ([@jschwe](https://github.com/jschwe), [#43141](https://github.com/servo/servo/pull/43141)), making each package self-contained ([@jschwe](https://github.com/jschwe), [#43180](https://github.com/servo/servo/pull/43180), [#43165](https://github.com/servo/servo/pull/43165)), fixing build issues ([@delan](https://github.com/delan), [@jschwe](https://github.com/jschwe), [#43170](https://github.com/servo/servo/pull/43170), [#43458](https://github.com/servo/servo/pull/43458), [#43463](https://github.com/servo/servo/pull/43463)) and crates.io compliance issues ([@jschwe](https://github.com/jschwe), [#43459](https://github.com/servo/servo/pull/43459)), configuring package metadata ([@jschwe](https://github.com/jschwe), [@StaySafe020](https://github.com/StaySafe020), [#43078](https://github.com/servo/servo/pull/43078), [#43264](https://github.com/servo/servo/pull/43264), [#43451](https://github.com/servo/servo/pull/43451), [#43457](https://github.com/servo/servo/pull/43457), [#43654](https://github.com/servo/servo/pull/43654)), and organising our dependency tree ([@jschwe](https://github.com/jschwe), [@yezhizhen](https://github.com/yezhizhen), [@webbeef](https://github.com/webbeef), [@mrobinson](https://github.com/mrobinson), [#42916](https://github.com/servo/servo/pull/42916), [#43243](https://github.com/servo/servo/pull/43243), [#43263](https://github.com/servo/servo/pull/43263), [#43516](https://github.com/servo/servo/pull/43516), [#43526](https://github.com/servo/servo/pull/43526), [#43552](https://github.com/servo/servo/pull/43552), [#43615](https://github.com/servo/servo/pull/43615), [#43622](https://github.com/servo/servo/pull/43622), [#43273](https://github.com/servo/servo/pull/43273), [#43092](https://github.com/servo/servo/pull/43092)).
As a result, you can now take your first step towards [embedding Servo](https://book.servo.org/embedding/overview.html) in a Rust app with:

<figure>

```
$ cargo add servo
```
</figure>

This is another big update, so here’s an outline:

- [**Security**](#security)

- [**Work in progress**](#work-in-progress)

- [**For developers**](#for-developers)

- [**Embedding and automation**](#embedding-and-automation)

- [**More on the web platform**](#more-on-the-web-platform)

- [**Performance and stability**](#performance-and-stability)

## Security

**crypto.subtle.deriveBits()** for **X25519** checking for all-zero secrets, and **verify()** for **HMAC** comparing signatures, are now done **in constant time** ([@kkoyung](https://github.com/kkoyung), [#43775](https://github.com/servo/servo/pull/43775), [#43773](https://github.com/servo/servo/pull/43773)).

**‘Content-Security-Policy’** now handles redirects correctly ([@TimvdLippe](https://github.com/TimvdLippe), [#43438](https://github.com/servo/servo/pull/43438)), and sends violation reports with the correct **blockedURI** and **referrer** ([@TimvdLippe](https://github.com/TimvdLippe), [#43367](https://github.com/servo/servo/pull/43367), [#43645](https://github.com/servo/servo/pull/43645), [#43483](https://github.com/servo/servo/pull/43483)).
The policy in &lt;meta> now combines with the policy sent in HTTP headers, rather than overriding it ([@TimvdLippe](https://github.com/TimvdLippe), [@elomscansio](https://github.com/elomscansio), [#43063](https://github.com/servo/servo/pull/43063)).
When checking nonces, we now reject elements with duplicate attributes ([@dyegoaurelio](https://github.com/dyegoaurelio), [#43216](https://github.com/servo/servo/pull/43216)).

The document containing an **&lt;iframe>** can no longer access the contents of error pages ([@TimvdLippe](https://github.com/TimvdLippe), [#43539](https://github.com/servo/servo/pull/43539)), and CSP violations inside an &lt;iframe> are now correctly reported ([@TimvdLippe](https://github.com/TimvdLippe), [#43652](https://github.com/servo/servo/pull/43652)).

## Work in progress

We’ve landed more work towards supporting **IndexedDB**, under `--pref dom­_indexeddb­_enabled` ([@arihant2math](https://github.com/arihant2math), [@gterzian](https://github.com/gterzian), [@Taym95](https://github.com/Taym95), [@jerensl](https://github.com/jerensl), [#42139](https://github.com/servo/servo/pull/42139), [#42727](https://github.com/servo/servo/pull/42727), [#43096](https://github.com/servo/servo/pull/43096), [#43041](https://github.com/servo/servo/pull/43041), [#42451](https://github.com/servo/servo/pull/42451), [#43721](https://github.com/servo/servo/pull/43721), [#43754](https://github.com/servo/servo/pull/43754), [#42786](https://github.com/servo/servo/pull/42786)),
and towards supporting **IntersectionObserver**, under `--pref dom­_intersection­_observer­_enabled` ([@stevennovaryo](https://github.com/stevennovaryo), [@mrobinson](https://github.com/mrobinson), [#42251](https://github.com/servo/servo/pull/42251)).

We’re continuing to implement **document.execCommand()** for **rich text editing** ([@TimvdLippe](https://github.com/TimvdLippe), [#43177](https://github.com/servo/servo/pull/43177)), under `--pref dom­_exec­_command­_enabled`.
**‘beforeinput’** and **‘input’** events are now fired when executing supported and enabled commands ([@TimvdLippe](https://github.com/TimvdLippe), [#43087](https://github.com/servo/servo/pull/43087)), the **‘defaultParagraphSeparator’** and **‘styleWithCSS’** commands are now supported ([@TimvdLippe](https://github.com/TimvdLippe), [#43028](https://github.com/servo/servo/pull/43028)), and the **‘delete’** command is partially supported ([@TimvdLippe](https://github.com/TimvdLippe), [#43016](https://github.com/servo/servo/pull/43016), [#43082](https://github.com/servo/servo/pull/43082)).

We’re also working on the [**Font Loading API**](https://drafts.csswg.org/css-font-loading/) ([@simonwuelker](https://github.com/simonwuelker), [#43286](https://github.com/servo/servo/pull/43286)), under `--pref dom­_fontface­_enabled`.
**new FontFace()** now accepts ArrayBuffer in its `source` argument ([@simonwuelker](https://github.com/simonwuelker), [#43281](https://github.com/servo/servo/pull/43281)).

All of the features above are enabled in servoshell’s experimental mode.

Work on **accessibility** support for web contents continues under `--pref accessibility­_enabled`.
There was a [**breaking change**](#embedding-and-automation) in the embedding API ([@delan](https://github.com/delan), [@alice](https://github.com/alice), [#43029](https://github.com/servo/servo/pull/43029)), and we’ve landed support for “grafting” the accessibility tree of a document into that of its containing webview ([@delan](https://github.com/delan), [@alice](https://github.com/alice), [#43012](https://github.com/servo/servo/pull/43012), [#43013](https://github.com/servo/servo/pull/43013), [#43556](https://github.com/servo/servo/pull/43556)).
As a result, when you navigate, separate documents can have separate accessibility trees without complicating the embedder.

**&lt;link rel=modulepreload>** is now partially supported ([@Gae24](https://github.com/Gae24), [#42964](https://github.com/servo/servo/pull/42964)), though recursive fetching of descendants is gated by `--pref dom­_allow­_preloading­_module­_descendants` ([@Gae24](https://github.com/Gae24), [#43353](https://github.com/servo/servo/pull/43353)).

For a long time, Servo has had some support for the [**Web Bluetooth API**](https://webbluetoothcg.github.io/web-bluetooth/) under `--pref dom­_bluetooth­_enabled`.
We’ve recently reworked our implementation to adopt [**btleplug**](https://nonpolynomial.com/2023/10/30/how-to-beg-borrow-steal-your-way-to-a-cross-platform-bluetooth-le-library/), the cross-platform Rust-native Bluetooth LE library ([@webbeef](https://github.com/webbeef), [#43529](https://github.com/servo/servo/pull/43529), [#43581](https://github.com/servo/servo/pull/43581)).

We’re now implementing the [**Web Animations API**](https://www.w3.org/TR/web-animations/), starting with AnimationTimeline and DocumentTimeline ([@mrobinson](https://github.com/mrobinson), [#43711](https://github.com/servo/servo/pull/43711)).

We’ve landed more fixes to Servo’s [**async parser**]({{ '/blog/2026/03/31/february-in-servo/#:~:text=Parsing%20web%20pages' | url }}) ([@simonwuelker](https://github.com/simonwuelker), [#42930](https://github.com/servo/servo/pull/42930), [#42959](https://github.com/servo/servo/pull/42959)), under `--pref dom­_servoparser­_async­_html­_tokenizer­_enabled`.
If we can get the feature working more reliably ([#37418](https://github.com/servo/servo/issues/37418)), it could **halve the energy** Servo spends on parsing, **lower latency** for pages that don’t use document.write(), and even **improve the html5ever API** for the ecosystem.

## For developers

Servo’s DevTools feature now has partial support for inspecting **service workers** ([@CynthiaOketch](https://github.com/CynthiaOketch), [#43659](https://github.com/servo/servo/pull/43659)), as well as using the **navigation controls** along the top of the UI ([@brentschroeter](https://github.com/brentschroeter), [@eerii](https://github.com/eerii), [#43026](https://github.com/servo/servo/pull/43026)).

In the **Inspector** tab, we’ve fixed a bug where the UI stops updating when navigating to a new page ([@brentschroeter](https://github.com/brentschroeter), [#43153](https://github.com/servo/servo/pull/43153)).

In the **Console** tab, you can now evaluate JavaScript in **web workers** and **service workers** ([@SharanRP](https://github.com/SharanRP), [#43361](https://github.com/servo/servo/pull/43361), [#43492](https://github.com/servo/servo/pull/43492)).

In the **Debugger** tab, you can now **Step In**, **Step Out**, and **Step Over** ([@eerii](https://github.com/eerii), [@atbrakhi](https://github.com/atbrakhi), [#42907](https://github.com/servo/servo/pull/42907), [#43040](https://github.com/servo/servo/pull/43040), [#43042](https://github.com/servo/servo/pull/43042), [#43135](https://github.com/servo/servo/pull/43135)).
We’ve landed partial support for the **Scopes** panel ([@eerii](https://github.com/eerii), [@atbrakhi](https://github.com/atbrakhi), [#43166](https://github.com/servo/servo/pull/43166), [#43167](https://github.com/servo/servo/pull/43167), [#43232](https://github.com/servo/servo/pull/43232)), the **Call stack** panel ([@atbrakhi](https://github.com/atbrakhi), [@eerii](https://github.com/eerii), [#43015](https://github.com/servo/servo/pull/43015), [#43039](https://github.com/servo/servo/pull/43039)), and showing you information when **hovering over objects**, **arrays**, **functions**, and other values ([@atbrakhi](https://github.com/atbrakhi), [@eerii](https://github.com/eerii), [#43319](https://github.com/servo/servo/pull/43319), [#43356](https://github.com/servo/servo/pull/43356), [#43456](https://github.com/servo/servo/pull/43456), [#42996](https://github.com/servo/servo/pull/42996), [#42936](https://github.com/servo/servo/pull/42936), [#42994](https://github.com/servo/servo/pull/42994)).

We’ve fixed some long-outstanding bugs where the **DevTools UI may stop responding** due to protocol desyncs ([@brentschroeter](https://github.com/brentschroeter), [@eerii](https://github.com/eerii), [#43230](https://github.com/servo/servo/pull/43230), [#43236](https://github.com/servo/servo/pull/43236)), or due to messages from multiple Servo threads being interleaved ([@brentschroeter](https://github.com/brentschroeter), [@eerii](https://github.com/eerii), [#43472](https://github.com/servo/servo/pull/43472)).

For developers of Servo itself, [**mach**](https://book.servo.org/building/building.html#mach) can be a bit opaque at times.
To make mach more transparent and composable, we’ve added `mach print-env` and `mach exec` commands ([@jschwe](https://github.com/jschwe), [#42888](https://github.com/servo/servo/pull/42888)).

We’re also working on a new [**dev container**](https://containers.dev), which will provide an alternative to [our usual procedures](https://book.servo.org/building/building.html) for setting up a Servo build environment ([@jschwe](https://github.com/jschwe), [@sagudev](https://github.com/sagudev), [#43127](https://github.com/servo/servo/pull/43127), [#43131](https://github.com/servo/servo/pull/43131), [#43139](https://github.com/servo/servo/pull/43139)).

## Embedding and automation

Breaking changes:

- [`Servo`](https://doc.servo.org/servo/struct.Servo.html)::`set­_accessibility­_active()` is now [`WebView`](https://doc.servo.org/servo/struct.WebView.html)::[`set­_accessibility­_active()`](https://doc.servo.org/servo/struct.WebView.html#method.set_accessibility_active) ([@delan](https://github.com/delan), [@alice](https://github.com/alice), [#43029](https://github.com/servo/servo/pull/43029)), to make the API harder to misuse (see the docs for more details).

- What was previously named [`WebView`](https://doc.servo.org/servo/struct.WebView.html)::`pinch­_zoom()` has been renamed to [`adjust­_pinch­_zoom()`](https://doc.servo.org/servo/struct.WebView.html#method.adjust_pinch_zoom), and we’ve added a [`pinch­_zoom()`](https://doc.servo.org/servo/struct.WebView.html#method.pinch_zoom) method that lets you read the current pinch zoom level ([@chrisduerr](https://github.com/chrisduerr), [#43228](https://github.com/servo/servo/pull/43228)).

- [`WebView`](https://doc.servo.org/servo/struct.WebView.html)::`set­_delegate()`, `set­_clipboard­_delegate()`, and `set­_gamepad­_provider()` are now [`WebViewBuilder`](https://doc.servo.org/servo/struct.WebViewBuilder.html)::[`delegate()`](https://doc.servo.org/servo/struct.WebViewBuilder.html#method.delegate), [`clipboard­_delegate()`](https://doc.servo.org/servo/struct.WebViewBuilder.html#method.clipboard_delegate), and [`gamepad­_delegate()`](https://doc.servo.org/servo/struct.WebViewBuilder.html#method.gamepad_delegate) ([@mrobinson](https://github.com/mrobinson), [#43205](https://github.com/servo/servo/pull/43205), [#43233](https://github.com/servo/servo/pull/43233)). Note that set­\_gamepad­\_<strong>provider</strong>() is now gamepad­\_<strong>delegate</strong>(), consistent with the `GamepadProvider` rename below.

- [`WebViewDelegate`](https://doc.servo.org/servo/trait.WebViewDelegate.html)::[`show­_bluetooth­_device­_dialog()`](https://doc.servo.org/servo/trait.WebViewDelegate.html#method.show_bluetooth_device_dialog) has been reworked to use the same “request object” pattern as the `request­_*()` methods, giving you a [`Bluetooth­Device­Selection­Request`](https://doc.servo.org/servo/struct.BluetoothDeviceSelectionRequest.html) with clear methods ([@webbeef](https://github.com/webbeef), [#43580](https://github.com/servo/servo/pull/43580)).

- `GamepadProvider` has been renamed to [`GamepadDelegate`](https://doc.servo.org/servo/trait.GamepadDelegate.html), and `gamepad­_provider()` on [`WebView`](https://doc.servo.org/servo/struct.WebView.html) has been renamed to `gamepad­_delegate()` ([@mrobinson](https://github.com/mrobinson), [#43233](https://github.com/servo/servo/pull/43233)).

- The empty default implementation of [`EventLoopWaker`](https://doc.servo.org/servo/trait.EventLoopWaker.html)::[`wake`](https://doc.servo.org/servo/trait.EventLoopWaker.html#tymethod.wake) has been removed, because it almost never makes sense for a new custom impl to leave the method empty ([@chrisduerr](https://github.com/chrisduerr), [@mrobinson](https://github.com/mrobinson), [#43250](https://github.com/servo/servo/pull/43250)).

- [`Opts`](https://doc.servo.org/servo/struct.Opts.html)::`print­_pwm` is now [`DiagnosticsLogging`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html)::[`progressive­_web­_metrics`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html#structfield.progressive_web_metrics) ([@mrobinson](https://github.com/mrobinson), [#43209](https://github.com/servo/servo/pull/43209)).

Removed from our API:

- [`Opts`](https://doc.servo.org/servo/struct.Opts.html)::`nonincremental­_layout` ([@mrobinson](https://github.com/mrobinson), [#43207](https://github.com/servo/servo/pull/43207)) – no replacement. This only really worked in legacy layout.

- [`Opts`](https://doc.servo.org/servo/struct.Opts.html)::`user­_stylesheets` ([@mrobinson](https://github.com/mrobinson), [#43206](https://github.com/servo/servo/pull/43206)) – use [`UserContentManager`](https://doc.servo.org/servo/struct.UserContentManager.html)::[`add­_stylesheet()`](https://doc.servo.org/servo/struct.UserContentManager.html#method.add_stylesheet) instead. This is how servoshell’s `--user-stylesheet` option works.

You can now read and write cookies with [`SiteDataManager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::[`cookies­_for­_url()`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.cookies_for_url) and [`set­_cookie­_for­_url()`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.set_cookie_for_url) ([@longvatrong111](https://github.com/longvatrong111), [#43600](https://github.com/servo/servo/pull/43600)).

[`ClipboardDelegate`](https://doc.servo.org/servo/trait.ClipboardDelegate.html) and [`StringRequest`](https://doc.servo.org/servo/struct.StringRequest.html) are now exposed to the public API, allowing you to implement custom clipboard delegates ([@jdm](https://github.com/jdm), [@chrisduerr](https://github.com/chrisduerr), [#43203](https://github.com/servo/servo/pull/43203), [#43261](https://github.com/servo/servo/pull/43261)).
You can pass your custom delegate to [`WebViewBuilder`](https://doc.servo.org/servo/struct.WebViewBuilder.html)::[`clipboard­_delegate()`](https://doc.servo.org/servo/struct.WebViewBuilder.html#method.clipboard_delegate).

You can now get the [`EmbedderControlId`](https://doc.servo.org/servo/struct.EmbedderControlId.html) associated with an [`InputMethodControl`](https://doc.servo.org/servo/struct.InputMethodControl.html) by calling [`InputMethodControl`](https://doc.servo.org/servo/struct.InputMethodControl.html)::[`id()`](https://doc.servo.org/servo/struct.InputMethodControl.html#method.id) ([@chrisduerr](https://github.com/chrisduerr), [#43248](https://github.com/servo/servo/pull/43248)).

[`PixelFormat`](https://doc.servo.org/servo/enum.PixelFormat.html) now implements [`Debug`](https://doc.rust-lang.org/1.92.0/core/fmt/trait.Debug.html) ([@chrisduerr](https://github.com/chrisduerr), [@mrobinson](https://github.com/mrobinson), [#43249](https://github.com/servo/servo/pull/43249)).

We’ve improved the docs for [`Servo`](https://doc.servo.org/servo/struct.Servo.html), [`ServoBuilder`](https://doc.servo.org/servo/struct.ServoBuilder.html), [`WebViewBuilder`](https://doc.servo.org/servo/struct.WebViewBuilder.html), [`RenderingContext`](https://doc.servo.org/servo/trait.RenderingContext.html) ([@chrisduerr](https://github.com/chrisduerr), [#43229](https://github.com/servo/servo/pull/43229)), [`EmbedderControlId`](https://doc.servo.org/servo/struct.EmbedderControlId.html), [`EmbedderControlRequest`](https://doc.servo.org/servo/enum.EmbedderControlRequest.html), [`EmbedderControlResponse`](https://doc.servo.org/servo/enum.EmbedderControlResponse.html), [`SimpleDialogRequest`](https://doc.servo.org/servo/enum.SimpleDialogRequest.html), [`AlertResponse`](https://doc.servo.org/servo/enum.AlertResponse.html), [`ConfirmResponse`](https://doc.servo.org/servo/enum.ConfirmResponse.html), [`PromptResponse`](https://doc.servo.org/servo/enum.PromptResponse.html), [`EmbedderMsg`](https://doc.servo.org/servo/enum.EmbedderMsg.html) ([@mukilan](https://github.com/mukilan), [#43564](https://github.com/servo/servo/pull/43564)), [`ResourceReaderMethods`](https://doc.servo.org/servo/resources/trait.ResourceReaderMethods.html) ([@jschwe](https://github.com/jschwe), [@mrobinson](https://github.com/mrobinson), [#43769](https://github.com/servo/servo/pull/43769)), [`servo`](https://doc.servo.org/servo/)::[`input­_events`](https://doc.servo.org/servo/input_events/index.html) ([@mukilan](https://github.com/mukilan), [#43681](https://github.com/servo/servo/pull/43681)), and [`WheelDelta`](https://doc.servo.org/servo/struct.WheelDelta.html) ([@yezhizhen](https://github.com/yezhizhen), [@mrobinson](https://github.com/mrobinson), [#43210](https://github.com/servo/servo/pull/43210)).

We fixed a deadlock in **WebDriver** that occurs under heavy use of **[actions](https://w3c.github.io/webdriver/#actions)** from multiple input sources ([@yezhizhen](https://github.com/yezhizhen), [#43202](https://github.com/servo/servo/pull/43202), [#43169](https://github.com/servo/servo/pull/43169), [#43262](https://github.com/servo/servo/pull/43262), [#43275](https://github.com/servo/servo/pull/43275), [#43301](https://github.com/servo/servo/pull/43301)), **‘pointerMove’ actions** with a ‘duration’ are now smoothly interpolated ([@yezhizhen](https://github.com/yezhizhen), [#42946](https://github.com/servo/servo/pull/42946), [#43076](https://github.com/servo/servo/pull/43076)).

**Add Cookie** is now more conformant ([@yezhizhen](https://github.com/yezhizhen), [#43690](https://github.com/servo/servo/pull/43690)), which led to Servo developers landing [a spec patch](https://github.com/w3c/webdriver/pull/1955).
**‘pause’ actions** are now slightly more efficient ([@yezhizhen](https://github.com/yezhizhen), [#43014](https://github.com/servo/servo/pull/43014)), and we’ve fixed a bug where **‘wheel’ actions** fail to interleave with other actions ([@yezhizhen](https://github.com/yezhizhen), [#43126](https://github.com/servo/servo/pull/43126)).

## More on the web platform

**Carets now blink** in text fields ([@mrobinson](https://github.com/mrobinson), [#43128](https://github.com/servo/servo/pull/43128)).
You can [configure or disable](https://doc.servo.org/servo/prefs/struct.Preferences.html#structfield.editing_caret_blink_time) blinking carets with `--pref editing_caret_blink_time=0` or a duration in milliseconds.
**Clicking to move the caret** is more forgiving now ([@mrobinson](https://github.com/mrobinson), [#43238](https://github.com/servo/servo/pull/43238)), and moving the caret by a **word at a time** is more conventional on Windows and Linux, with Ctrl instead of Alt ([@mrobinson](https://github.com/mrobinson), [#43436](https://github.com/servo/servo/pull/43436)).
We’ve also fixed a bug where pressing the arrow keys in text fields both moves the caret (good) and scrolls the page (bad), and fixed a bug where the caret fails to render on empty lines ([@mrobinson](https://github.com/mrobinson), [@freyacodes](https://github.com/freyacodes), [#43247](https://github.com/servo/servo/pull/43247), [#42218](https://github.com/servo/servo/pull/42218)).

**Input** has improved, with more responsive **touchpad scrolling** on Linux ([@mrobinson](https://github.com/mrobinson), [@chrisduerr](https://github.com/chrisduerr), [#43350](https://github.com/servo/servo/pull/43350)).
**Pointer events** and **mouse events** can now be **[captured](https://developer.mozilla.org/en-US/docs/Learn_web_development/Core/Scripting/Event_bubbling#event_capture) across shadow DOM boundaries** ([@simonwuelker](https://github.com/simonwuelker), [#42987](https://github.com/servo/servo/pull/42987)), and we’ve now started working towards shadow-DOM-compatible focus ([@mrobinson](https://github.com/mrobinson), [#43811](https://github.com/servo/servo/pull/43811)).
Pressing **Space** or **Enter** inside text fields no longer causes them to be clicked ([@mrobinson](https://github.com/mrobinson), [#43343](https://github.com/servo/servo/pull/43343)).

The **lang** attribute is now taken into account when shaping, which is important for the correct rendering of Chinese and Japanese text ([@RichardTjokroutomo](https://github.com/RichardTjokroutomo), [@mrobinson](https://github.com/mrobinson), [#43447](https://github.com/servo/servo/pull/43447)).
**‘font-weight’** is now matched more accurately when no available font is an exact match ([@shubhamg13](https://github.com/shubhamg13), [#43125](https://github.com/servo/servo/pull/43125)).

**Navigation** is one of the most complicated parts of HTML: navigating can <a href='javascript:"diffie (reload to continue reading)"'>run some JavaScript that replaces the page</a>, <a href='javascript:alert("diffie")'>just run some JavaScript</a>, or depending on the response, [do nothing at all](http://google.com/generate_204).
**&lt;iframe>** makes navigation doubly complicated: the document containing an &lt;iframe> can observe and interact with the document inside the &lt;iframe> in various ways, often synchronously.
This has been the source of [many](https://github.com/servo/servo/issues/14856) [bugs](https://github.com/servo/servo/issues/23373) [over](https://github.com/servo/servo/issues/24901) [the](https://github.com/servo/servo/issues/31242) [years](https://github.com/servo/servo/issues/31973), but we’ve recently fixed one of those major issues ([@jdm](https://github.com/jdm), [#43496](https://github.com/servo/servo/pull/43496)).

<figure><div style="display: flex; gap: 1em; align-items: center;">

![]({{ '/img/blog/2026-04-javascript-url-special-case.png' | url }})

![]({{ '/img/blog/2026-04-is-initial-about-blank.png' | url }})

</div><figcaption>

`javascript:` URLs are [a massive special case](https://html.spec.whatwg.org/multipage/#the-javascript:-url-special-case) with [many quirks](https://github.com/whatwg/html/issues?q=label%3A%22topic%3A%20javascript%3A%20URLs%22), and &lt;iframe> has [its own big edge cases](https://html.spec.whatwg.org/multipage/#is-initial-about:blank).
</figcaption></figure>

**new Worker()** now supports **JS modules** ([@pylbrecht](https://github.com/pylbrecht), [@Gae24](https://github.com/Gae24), [#40365](https://github.com/servo/servo/pull/40365)), and **CanvasRenderingContext2D** now supports drawing text with **Variation Selectors**, allowing you to control things like emoji presentation and CJK shaping ([@yezhizhen](https://github.com/yezhizhen), [#43449](https://github.com/servo/servo/pull/43449)).

Servo now fires **‘pointerover’**, **‘pointerout’**, **‘pointerenter’**, and **‘pointerleave’** events on web content ([@webbeef](https://github.com/webbeef), [#42736](https://github.com/servo/servo/pull/42736)), **‘scroll’** events on **VisualViewport** ([@stevennovaryo](https://github.com/stevennovaryo), [#42771](https://github.com/servo/servo/pull/42771)), and **‘scrollend’** events on **Document**, **Element**, and **VisualViewport** ([@abdelrahman1234567](https://github.com/abdelrahman1234567), [@mrobinson](https://github.com/mrobinson), [#38773](https://github.com/servo/servo/pull/38773)).
We also fire **‘error’** events when **event handler** attributes contain syntax errors ([@simonwuelker](https://github.com/simonwuelker), [#43178](https://github.com/servo/servo/pull/43178)).

We’ve improved the default appearance of **&lt;summary>** ([@Loirooriol](https://github.com/Loirooriol), [#43111](https://github.com/servo/servo/pull/43111)), **&lt;select>** ([@lukewarlow](https://github.com/lukewarlow), [#43175](https://github.com/servo/servo/pull/43175)), **&lt;input type=file>** ([@lukewarlow](https://github.com/lukewarlow), [@AlexVasiluta](https://github.com/AlexVasiluta), [@lukewarlow](https://github.com/lukewarlow), [#43498](https://github.com/servo/servo/pull/43498), [#43186](https://github.com/servo/servo/pull/43186)), and **&lt;textarea>** and **&lt;input type=text>** and friends ([@mrobinson](https://github.com/mrobinson), [#43132](https://github.com/servo/servo/pull/43132)), plus **‘::marker’** in mixed LTR/RTL content ([@Loirooriol](https://github.com/Loirooriol), [#43201](https://github.com/servo/servo/pull/43201)).
**&lt;select>** also now requires user interaction to open the picker ([@SharanRP](https://github.com/SharanRP), [#43485](https://github.com/servo/servo/pull/43485)).

**&lt;form action>**, **&lt;iframe src>**, **open(url)** on **XMLHttpRequest**, **new EventSource(url)**, and **new Worker(url)** now correctly resolve the URL with the page encoding ([@SharanRP](https://github.com/SharanRP), [@jdm](https://github.com/jdm), [@jayant911](https://github.com/jayant911), [@Veercodeprog](https://github.com/Veercodeprog), [@sabbCodes](https://github.com/sabbCodes), [#43521](https://github.com/servo/servo/pull/43521), [#43554](https://github.com/servo/servo/pull/43554), [#43572](https://github.com/servo/servo/pull/43572), [#43537](https://github.com/servo/servo/pull/43537), [#43634](https://github.com/servo/servo/pull/43634), [#43588](https://github.com/servo/servo/pull/43588)).

**‘direction’** now works on grid containers ([@nicoburns](https://github.com/nicoburns), [#42118](https://github.com/servo/servo/pull/42118)), **SVG images** can now be used in **‘border-image’** ([@shubhamg13](https://github.com/shubhamg13), [#42566](https://github.com/servo/servo/pull/42566)), **‘linear-gradient()’** now dithers to reduce banding ([@Messi002](https://github.com/Messi002), [#43603](https://github.com/servo/servo/pull/43603)), **‘letter-spacing’** no longer applies to invisible zero-width formatting characters ([@simonwuelker](https://github.com/simonwuelker), [#42961](https://github.com/servo/servo/pull/42961)), and **‘:active’** now matches disabled or non-focusable elements too, as long as they are being clicked ([@webbeef](https://github.com/webbeef), [#42935](https://github.com/servo/servo/pull/42935)).

**DOMContentLoaded** timings in **Performance­Navigation­Timing** are more accurate ([@simonwuelker](https://github.com/simonwuelker), [#43151](https://github.com/servo/servo/pull/43151)). **Performance­Paint­Timing** and **Largest­Contentful­Paint** are more accurate too, taking &lt;iframe> into account ([@shubhamg13](https://github.com/shubhamg13), [#42149](https://github.com/servo/servo/pull/42149)), and checking for and ignoring things like broken images and transparent backgrounds ([@shubhamg13](https://github.com/shubhamg13), [#42833](https://github.com/servo/servo/pull/42833), [#42975](https://github.com/servo/servo/pull/42975), [#43475](https://github.com/servo/servo/pull/43475)).

We’ve improved the conformance of **JS modules** ([@Gae24](https://github.com/Gae24), [#43585](https://github.com/servo/servo/pull/43585)), **&lt;button command>** ([@lukewarlow](https://github.com/lukewarlow), [#42883](https://github.com/servo/servo/pull/42883)), **&lt;font size>** ([@shubhamg13](https://github.com/shubhamg13), [#43103](https://github.com/servo/servo/pull/43103)), **&lt;link media>** and **&lt;link type>** ([@TimvdLippe](https://github.com/TimvdLippe), [#43043](https://github.com/servo/servo/pull/43043)), **&lt;option selected>** ([@SharanRP](https://github.com/SharanRP), [#43582](https://github.com/servo/servo/pull/43582)), **&lt;script integrity>** and **&lt;style integrity>** ([@Gae24](https://github.com/Gae24), [#42931](https://github.com/servo/servo/pull/42931)), **EventSource** ([@mishop-15](https://github.com/mishop-15), [#42179](https://github.com/servo/servo/pull/42179)), **SubtleCrypto** ([@kkoyung](https://github.com/kkoyung), [#42984](https://github.com/servo/servo/pull/42984), [#43315](https://github.com/servo/servo/pull/43315), [#43533](https://github.com/servo/servo/pull/43533), [#43519](https://github.com/servo/servo/pull/43519)), **Worker** ([@simonwuelker](https://github.com/simonwuelker), [#43329](https://github.com/servo/servo/pull/43329)), **HTMLVideoElement** ([@shubhamg13](https://github.com/shubhamg13), [#43341](https://github.com/servo/servo/pull/43341)), **dataset** on **Element** ([@TimvdLippe](https://github.com/TimvdLippe), [#43046](https://github.com/servo/servo/pull/43046)), and **querySelector()** and **querySelectorAll()** ([@simonwuelker](https://github.com/simonwuelker), [#42991](https://github.com/servo/servo/pull/42991)).

We’ve fixed bugs related to **error reporting** ([@simonwuelker](https://github.com/simonwuelker), [@xZaisk](https://github.com/xZaisk), [@yezhizhen](https://github.com/yezhizhen), [@eyupcanakman](https://github.com/eyupcanakman), [#43191](https://github.com/servo/servo/pull/43191), [#43323](https://github.com/servo/servo/pull/43323), [#43101](https://github.com/servo/servo/pull/43101), [#43560](https://github.com/servo/servo/pull/43560)), **event loops** ([@jayant911](https://github.com/jayant911), [#43523](https://github.com/servo/servo/pull/43523)), **focus** ([@jakubadamw](https://github.com/jakubadamw), [#43431](https://github.com/servo/servo/pull/43431)), **quirks mode** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [@lukewarlow](https://github.com/lukewarlow), [#42960](https://github.com/servo/servo/pull/42960), [#43368](https://github.com/servo/servo/pull/43368)), **&lt;iframe>** ([@TimvdLippe](https://github.com/TimvdLippe), [@jdm](https://github.com/jdm), [#43539](https://github.com/servo/servo/pull/43539), [#43732](https://github.com/servo/servo/pull/43732)), the **‘animationstart’** and **‘animationend’** events ([@simonwuelker](https://github.com/simonwuelker), [#43454](https://github.com/servo/servo/pull/43454)), the **‘touchmove’** event ([@yezhizhen](https://github.com/yezhizhen), [#42926](https://github.com/servo/servo/pull/42926)), **CanvasRenderingContext2D** ([@simonwuelker](https://github.com/simonwuelker), [#43218](https://github.com/servo/servo/pull/43218)), **Worker** ([@bruno-j-nicoletti](https://github.com/bruno-j-nicoletti), [#43213](https://github.com/servo/servo/pull/43213)), **‘:active’** on &lt;input> ([@mrobinson](https://github.com/mrobinson), [#43722](https://github.com/servo/servo/pull/43722)), **‘overflow: scroll’** on ‘::before’ and ‘::after’ ([@stevennovaryo](https://github.com/stevennovaryo), [#43231](https://github.com/servo/servo/pull/43231)), **‘position: absolute’** ([@yoursanonymous](https://github.com/yoursanonymous), [@Loirooriol](https://github.com/Loirooriol), [#43084](https://github.com/servo/servo/pull/43084)), and **&lt;img>** and **&lt;svg>** without width or height attributes ([@Loirooriol](https://github.com/Loirooriol), [#42666](https://github.com/servo/servo/pull/42666)).
Fixing that last bug led to Servo developers finding two [spec](https://github.com/w3c/csswg-drafts/issues/12612) [issues](https://github.com/w3c/csswg-drafts/issues/13149)!

We’ve landed partial support for using **CSS [counters](https://drafts.csswg.org/css-lists/#counter)** in ‘list-style-type’ on ‘display: list-item’ and ‘content’ on ‘::marker’, but the counter values themselves are not calculated yet, so all list items still read as `0.` or similar.
In any case, you can use a &lt;counter-style-name> or ‘symbols()’ in ‘list-style-type’, and ‘counter()’ and ‘counters()’ in ‘content’ ([@Loirooriol](https://github.com/Loirooriol), [#43111](https://github.com/servo/servo/pull/43111)).

We’ve also landed partial support for **&lt;marquee>** and the **HTMLMarqueeElement** interface, including basic layout, but the contents are not animated yet ([@mrobinson](https://github.com/mrobinson), [@lukewarlow](https://github.com/lukewarlow), [#43520](https://github.com/servo/servo/pull/43520), [#43610](https://github.com/servo/servo/pull/43610)).

Servo now exposes several attributes that have no direct effect, but are needed for web compatibility ([@lukewarlow](https://github.com/lukewarlow), [#43500](https://github.com/servo/servo/pull/43500), [#43499](https://github.com/servo/servo/pull/43499), [#43502](https://github.com/servo/servo/pull/43502), [#43518](https://github.com/servo/servo/pull/43518)):

- **noHref** on **HTMLAreaElement**
- **hreflang**, **type**, **charset** on **HTMLAnchorElement**
- **useMap** on **HTMLInputElement** and **HTMLObjectElement**
- **longDesc** on **HTMLIFrameElement** and **HTMLFrameElement**

## Performance and stability

We’ve fixed **sluggish scrolling** on long documents like [this page on docs.rs](https://docs.rs/iced-x86/1.21.0/iced_x86/code_asm/struct.CodeAssembler.html) ([@webbeef](https://github.com/webbeef), [@yezhizhen](https://github.com/yezhizhen), [#43074](https://github.com/servo/servo/pull/43074), [#43138](https://github.com/servo/servo/pull/43138)), and reduced the **memory usage of BoxFragment** by **10%** ([@stevennovaryo](https://github.com/stevennovaryo), [#43056](https://github.com/servo/servo/pull/43056)).
**about:memory** now has a **Force GC** button ([@webbeef](https://github.com/webbeef), [#42798](https://github.com/servo/servo/pull/42798)), and no longer reports all processes as content processes in multiprocess mode ([@webbeef](https://github.com/webbeef), [#42923](https://github.com/servo/servo/pull/42923)).

**Web fonts** are no longer fetched more than once, and they no longer cause reflow when they fail to load ([@minghuaw](https://github.com/minghuaw), [#43382](https://github.com/servo/servo/pull/43382), [#43595](https://github.com/servo/servo/pull/43595)).
We’re also working towards better caching for shaping results ([@mrobinson](https://github.com/mrobinson), [@lukewarlow](https://github.com/lukewarlow), [@Loirooriol](https://github.com/Loirooriol), [#43653](https://github.com/servo/servo/pull/43653)).
**Event handler** attribute lookup is more efficient now ([@Narfinger](https://github.com/Narfinger), [#43337](https://github.com/servo/servo/pull/43337)), and we’ve made **DOM tree walking** more efficient in many cases ([@Narfinger](https://github.com/Narfinger), [#42781](https://github.com/servo/servo/pull/42781), [#42978](https://github.com/servo/servo/pull/42978), [#43476](https://github.com/servo/servo/pull/43476)).

**crypto.subtle.encrypt()**, **decrypt()**, **sign()**, **verify()**, **digest()**, **importKey()**, **unwrapKey()**, **decapsulateKey()**, and **decapsulateBits()** are more efficient now ([@kkoyung](https://github.com/kkoyung), [#42927](https://github.com/servo/servo/pull/42927)), thanks to a recent [spec](https://github.com/w3c/webcrypto/issues/422) [update](https://github.com/w3c/webcrypto/pull/426).

More of Servo now **uses cheaper crossbeam channels** instead of IPC channels, unless Servo is running in multiprocess mode, or **avoids IPC altogether** ([@Narfinger](https://github.com/Narfinger), [@jschwe](https://github.com/jschwe), [@Taym95](https://github.com/Taym95), [#42077](https://github.com/servo/servo/pull/42077), [#43309](https://github.com/servo/servo/pull/43309), [#42966](https://github.com/servo/servo/pull/42966)).
We’ve also reduced clones, allocations, conversions, comparisons, and borrow checks in many parts of Servo ([@simonwuelker](https://github.com/simonwuelker), [@kkoyung](https://github.com/kkoyung), [@mrobinson](https://github.com/mrobinson), [@Narfinger](https://github.com/Narfinger), [@yezhizhen](https://github.com/yezhizhen), [@TG199](https://github.com/TG199), [#43212](https://github.com/servo/servo/pull/43212), [#43055](https://github.com/servo/servo/pull/43055), [#43066](https://github.com/servo/servo/pull/43066), [#43304](https://github.com/servo/servo/pull/43304), [#43452](https://github.com/servo/servo/pull/43452), [#43717](https://github.com/servo/servo/pull/43717), [#43780](https://github.com/servo/servo/pull/43780), [#43088](https://github.com/servo/servo/pull/43088), [#43226](https://github.com/servo/servo/pull/43226)).

**DOM data structures** (`#[dom_struct]`) can refer to one another, with the help of [garbage collection](https://research.mozilla.org/2014/08/26/javascript-servos-only-garbage-collector/).
But when DOM objects are being destroyed, those references can become invalid for a brief moment, depending on the order the GC finalizers run in.
This can be unsound if those references are accessed, which is a very easy mistake to make if the type has an `impl Drop`.
To help prevent that class of bug, we’re reworking our DOM types so that none of them have `#[dom_struct]` and `impl Drop` at the same time ([@willypuzzle](https://github.com/willypuzzle), [#42937](https://github.com/servo/servo/pull/42937), [#42982](https://github.com/servo/servo/pull/42982), [#43018](https://github.com/servo/servo/pull/43018), [#43071](https://github.com/servo/servo/pull/43071), [#43222](https://github.com/servo/servo/pull/43222), [#43288](https://github.com/servo/servo/pull/43288), [#43544](https://github.com/servo/servo/pull/43544), [#43563](https://github.com/servo/servo/pull/43563), [#43631](https://github.com/servo/servo/pull/43631)).

We’ve fixed a crash caused by an IPC resource leak when making **many requests over time** ([@yezhizhen](https://github.com/yezhizhen), [#43381](https://github.com/servo/servo/pull/43381)), and some bugs found by **ThreadSanitizer** and **-\-debug-mozjs** ([@jdm](https://github.com/jdm), [@Loirooriol](https://github.com/Loirooriol), [#42976](https://github.com/servo/servo/pull/42976), [#42963](https://github.com/servo/servo/pull/42963), [#43487](https://github.com/servo/servo/pull/43487)).
We’ve also fixed crashes in **CanvasRenderingContext2D** ([@yezhizhen](https://github.com/yezhizhen), [#43449](https://github.com/servo/servo/pull/43449)), **Crypto** ([@rogerkorantenng](https://github.com/rogerkorantenng), [#43501](https://github.com/servo/servo/pull/43501)), **devtools** ([@simonwuelker](https://github.com/simonwuelker), [#43133](https://github.com/servo/servo/pull/43133)), **event handler** attributes ([@simonwuelker](https://github.com/simonwuelker), [#43178](https://github.com/servo/servo/pull/43178)), **Promise** ([@Narfinger](https://github.com/Narfinger), [@jdm](https://github.com/jdm), [#43470](https://github.com/servo/servo/pull/43470)), and **WebDriver** ([@Tarmil](https://github.com/Tarmil), [@yezhizhen](https://github.com/yezhizhen), [#42739](https://github.com/servo/servo/pull/42739), [#43381](https://github.com/servo/servo/pull/43381)).

We’ve continued our long-running effort to **use the Rust type system** to make certain kinds of dynamic borrow failures impossible ([@Narfinger](https://github.com/Narfinger), [@Gae24](https://github.com/Gae24), [@Uiniel](https://github.com/Uiniel), [@TimvdLippe](https://github.com/TimvdLippe), [@yezhizhen](https://github.com/yezhizhen), [@sagudev](https://github.com/sagudev), [@PuercoPop](https://github.com/PuercoPop), [@pylbrecht](https://github.com/pylbrecht), [@arabson99](https://github.com/arabson99), [@jayant911](https://github.com/jayant911), [#42957](https://github.com/servo/servo/pull/42957), [#43108](https://github.com/servo/servo/pull/43108), [#43130](https://github.com/servo/servo/pull/43130), [#43215](https://github.com/servo/servo/pull/43215), [#43183](https://github.com/servo/servo/pull/43183), [#43219](https://github.com/servo/servo/pull/43219), [#43245](https://github.com/servo/servo/pull/43245), [#43220](https://github.com/servo/servo/pull/43220), [#43252](https://github.com/servo/servo/pull/43252), [#43268](https://github.com/servo/servo/pull/43268), [#43184](https://github.com/servo/servo/pull/43184), [#43277](https://github.com/servo/servo/pull/43277), [#43278](https://github.com/servo/servo/pull/43278), [#43284](https://github.com/servo/servo/pull/43284), [#43302](https://github.com/servo/servo/pull/43302), [#43312](https://github.com/servo/servo/pull/43312), [#43348](https://github.com/servo/servo/pull/43348), [#43327](https://github.com/servo/servo/pull/43327), [#43362](https://github.com/servo/servo/pull/43362), [#43365](https://github.com/servo/servo/pull/43365), [#43383](https://github.com/servo/servo/pull/43383), [#43432](https://github.com/servo/servo/pull/43432), [#43259](https://github.com/servo/servo/pull/43259), [#43439](https://github.com/servo/servo/pull/43439), [#43473](https://github.com/servo/servo/pull/43473), [#43481](https://github.com/servo/servo/pull/43481), [#43480](https://github.com/servo/servo/pull/43480), [#43479](https://github.com/servo/servo/pull/43479), [#43525](https://github.com/servo/servo/pull/43525), [#43535](https://github.com/servo/servo/pull/43535), [#43543](https://github.com/servo/servo/pull/43543), [#43549](https://github.com/servo/servo/pull/43549), [#43570](https://github.com/servo/servo/pull/43570), [#43571](https://github.com/servo/servo/pull/43571), [#43569](https://github.com/servo/servo/pull/43569), [#43579](https://github.com/servo/servo/pull/43579), [#43584](https://github.com/servo/servo/pull/43584), [#43657](https://github.com/servo/servo/pull/43657), [#43713](https://github.com/servo/servo/pull/43713)).

Thanks to a wide range of people, many of whom were contributing to Servo for their first time, we’ve also landed a bunch of architectural improvements ([@elomscansio](https://github.com/elomscansio), [@mukilan](https://github.com/mukilan), [#43646](https://github.com/servo/servo/pull/43646)), cleanups ([@simartin](https://github.com/simartin), [@SharanRP](https://github.com/SharanRP), [@TG199](https://github.com/TG199), [@sabbCodes](https://github.com/sabbCodes), [@niyabits](https://github.com/niyabits), [@eerii](https://github.com/eerii), [@atbrakhi](https://github.com/atbrakhi), [#43276](https://github.com/servo/servo/pull/43276), [#43285](https://github.com/servo/servo/pull/43285), [#43532](https://github.com/servo/servo/pull/43532), [#43778](https://github.com/servo/servo/pull/43778), [#43771](https://github.com/servo/servo/pull/43771), [#43566](https://github.com/servo/servo/pull/43566), [#43567](https://github.com/servo/servo/pull/43567), [#43587](https://github.com/servo/servo/pull/43587), [#43140](https://github.com/servo/servo/pull/43140), [#43316](https://github.com/servo/servo/pull/43316)), and refactors ([@sabbCodes](https://github.com/sabbCodes), [@arabson99](https://github.com/arabson99), [@jayant911](https://github.com/jayant911), [@StaySafe020](https://github.com/StaySafe020), [@saydmateen](https://github.com/saydmateen), [@eerii](https://github.com/eerii), [@TimvdLippe](https://github.com/TimvdLippe), [@elomscansio](https://github.com/elomscansio), [@CynthiaOketch](https://github.com/CynthiaOketch), [#43614](https://github.com/servo/servo/pull/43614), [#43641](https://github.com/servo/servo/pull/43641), [#43619](https://github.com/servo/servo/pull/43619), [#43642](https://github.com/servo/servo/pull/43642), [#43623](https://github.com/servo/servo/pull/43623), [#43656](https://github.com/servo/servo/pull/43656), [#43644](https://github.com/servo/servo/pull/43644), [#43672](https://github.com/servo/servo/pull/43672), [#43664](https://github.com/servo/servo/pull/43664), [#43676](https://github.com/servo/servo/pull/43676), [#43684](https://github.com/servo/servo/pull/43684), [#43679](https://github.com/servo/servo/pull/43679), [#43678](https://github.com/servo/servo/pull/43678), [#43655](https://github.com/servo/servo/pull/43655), [#43675](https://github.com/servo/servo/pull/43675), [#43731](https://github.com/servo/servo/pull/43731), [#43729](https://github.com/servo/servo/pull/43729), [#43728](https://github.com/servo/servo/pull/43728), [#43740](https://github.com/servo/servo/pull/43740), [#43751](https://github.com/servo/servo/pull/43751), [#43748](https://github.com/servo/servo/pull/43748), [#43747](https://github.com/servo/servo/pull/43747), [#43752](https://github.com/servo/servo/pull/43752), [#43745](https://github.com/servo/servo/pull/43745), [#43724](https://github.com/servo/servo/pull/43724), [#43723](https://github.com/servo/servo/pull/43723), [#43765](https://github.com/servo/servo/pull/43765), [#43767](https://github.com/servo/servo/pull/43767), [#43181](https://github.com/servo/servo/pull/43181), [#43269](https://github.com/servo/servo/pull/43269), [#43270](https://github.com/servo/servo/pull/43270), [#43279](https://github.com/servo/servo/pull/43279), [#43437](https://github.com/servo/servo/pull/43437), [#43597](https://github.com/servo/servo/pull/43597), [#43607](https://github.com/servo/servo/pull/43607), [#43602](https://github.com/servo/servo/pull/43602), [#43616](https://github.com/servo/servo/pull/43616), [#43609](https://github.com/servo/servo/pull/43609), [#43612](https://github.com/servo/servo/pull/43612), [#43647](https://github.com/servo/servo/pull/43647), [#43651](https://github.com/servo/servo/pull/43651), [#43662](https://github.com/servo/servo/pull/43662), [#43714](https://github.com/servo/servo/pull/43714), [#43774](https://github.com/servo/servo/pull/43774)).

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

<script>
    (function makeVideoPlayersClickable() {
        addEventListener("toggle", event => {
            const details = event.target.closest("details");
            if (!details?.open) {
                return;
            }
            const video = details.querySelector("video");
            if (!video) {
                return;
            }
            if (video.fastSeek) {
                video.fastSeek(0);
            } else {
                video.currentTime = 0;
            }
            video.play();
        }, true);
    })();
</script>
