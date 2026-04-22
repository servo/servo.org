---
layout:     post
tags:       blog
title:      "March in Servo: tab navigation, and more!"
date:       2026-04-30
summary:    ao!! wrrrrao!!
categories:
---

[**Servo 0.1.0**](https://github.com/servo/servo/releases/tag/v0.1.0) represents Servo’s biggest month ever, with a record **530 commits** and [**our first ever release on crates.io**]({{ '/blog/2026/04/13/servo-0.1.0-release/' | url }})!

With this release Servo becomes more accessible, thanks to **tab navigation** (@mrobinson, @Loirooriol, #42952, #43019, #43058, #43246, #43267, #43067) and **keyboard scrolling** with Space and Shift+Space (@mrobinson, #43322).

We’ve shipped several new web platform features:

- **‘X-Frame-Options’** (@TimvdLippe, #43539, #43708)
- **‘Content-Security-Policy: frame-ancestors’** (@TimvdLippe, #43630)
- **‘::first-letter’** styling (@minghuaw, @xiaochengh, @Loirooriol, #43027)
- **‘::placeholder’** styling (@stevennovaryo, #43053)
- **‘::file-selector-button’** styling (@lukewarlow, @AlexVasiluta, #43498)
- **‘background-blend-mode’** (@mrobinson, #43666)
- **‘content’** on **‘::marker’** (@niyabits, @Loirooriol, #43515)
- **‘list-style-type: &lt;string>’** (@Loirooriol, #43111)
- **&lt;input type=range>** (@BudiArb, @rayguo17, @mrobinson, #41562)
- **&lt;svg width>** and **&lt;svg height>** (@Loirooriol, #43583)
- the **accesskey** attribute (@mrobinson, #43031, #43144, #43434)
- partial support for **&lt;link rel=modulepreload>** (@Gae24, #42964)
- [**&lt;system-color>**](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Values/system-color) values in CSS (@longvatrong111, @mrobinson, #42529, #43105, #43107)

Plus a bunch of new DOM APIs:

- **CommandEvent** (@lukewarlow, #43190)
- **moveBefore()** on **Node** (@lukewarlow, #41238)
- **relatedTarget** on **MouseEvent** and **PointerEvent** (@simonwuelker, #42989)
- **command** on **HTMLButtonElement** (@lukewarlow, #43190)
- **selectedOptions** on **HTMLSelectElement** (@jakubadamw, #43017)
- **url** on **LargestContentfulPaint** (@shubhamg13, #42901, #42949)
- **crypto.subtle.digest()** for **TurboSHAKE** (@kkoyung, #43551)
- **crypto.subtle.getPublicKey()** for **X25519**, **RSASSA-PKCS1-v1_5**, **RSA-PSS**, and **RSA-OAEP** (@kkoyung, #43073, #43093)

Servo now fires **‘pointerover’**, **‘pointerout’**, **‘pointerenter’**, and **‘pointerleave’** events on web content (@webbeef, #42736), **‘scroll’** events on **VisualViewport** (@stevennovaryo, #42771), and **‘scrollend’** events on **Document**, **Element**, and **VisualViewport** (@abdelrahman1234567, @mrobinson, #38773).

A great deal of work went into making the **crates.io release** possible, including renaming `libservo` to just `servo` (@jschwe, #43141), making each package self-contained (@jschwe, #43180, #43165), fixing build issues (@delan, @jschwe, #43170, #43458, #43463) and crates.io compliance issues (@jschwe, #43459), configuring package metadata (@jschwe, @StaySafe020, #43078, #43264, #43451, #43457, #43654), and organising our dependency tree (@jschwe, @yezhizhen, @webbeef, @mrobinson, #42916, #43243, #43263, #43516, #43526, #43552, #43615, #43622, #43273, #43092).
As a result, you can now take your first step towards [embedding Servo](https://book.servo.org/embedding/overview.html) in a Rust app with:

<figure>

```
$ cargo add servo
```
</figure>

## Embedding API

Breaking changes:

- [`Servo`](https://doc.servo.org/servo/struct.Servo.html)::`set­_accessibility­_active()` is now [`WebView`](https://doc.servo.org/servo/struct.WebView.html)::[`set­_accessibility­_active()`](https://doc.servo.org/servo/struct.WebView.html#method.set_accessibility_active) (@delan, @alice, #43029), to make the API harder to misuse (see the docs for more details).

- What was previously named [`WebView`](https://doc.servo.org/servo/struct.WebView.html)::`pinch­_zoom()` has been renamed to [`adjust­_pinch­_zoom()`](https://doc.servo.org/servo/struct.WebView.html#method.adjust_pinch_zoom), and we’ve added a [`pinch­_zoom()`](https://doc.servo.org/servo/struct.WebView.html#method.pinch_zoom) method that lets you read the current pinch zoom level (@chrisduerr, #43228).

- [`WebView`](https://doc.servo.org/servo/struct.WebView.html)::`set­_delegate()`, `set­_clipboard­_delegate()`, and `set­_gamepad­_provider()` are now [`WebViewBuilder`](https://doc.servo.org/servo/struct.WebViewBuilder.html)::[`delegate()`](https://doc.servo.org/servo/struct.WebViewBuilder.html#method.delegate), [`clipboard­_delegate()`](https://doc.servo.org/servo/struct.WebViewBuilder.html#method.clipboard_delegate), and [`gamepad­_delegate()`](https://doc.servo.org/servo/struct.WebViewBuilder.html#method.gamepad_delegate) (@mrobinson, #43205, #43233). Note that set­\_gamepad­\_<strong>provider</strong>() is now gamepad­\_<strong>delegate</strong>(), consistent with the `GamepadProvider` rename below.

- [`WebViewDelegate`](https://doc.servo.org/servo/trait.WebViewDelegate.html)::[`show­_bluetooth­_device­_dialog()`](https://doc.servo.org/servo/trait.WebViewDelegate.html#method.show_bluetooth_device_dialog) has been reworked to use the same “request object” pattern as the `request­_*()` methods, giving you a [`Bluetooth­Device­Selection­Request`](https://doc.servo.org/servo/struct.BluetoothDeviceSelectionRequest.html) with clear methods (@webbeef, #43580).

- `GamepadProvider` has been renamed to [`GamepadDelegate`](https://doc.servo.org/servo/trait.GamepadDelegate.html), and `gamepad­_provider()` on [`WebView`](https://doc.servo.org/servo/struct.WebView.html) has been renamed to `gamepad­_delegate()` (@mrobinson, #43233).

- The empty default implementation of [`EventLoopWaker`](https://doc.servo.org/servo/trait.EventLoopWaker.html)::[`wake`](https://doc.servo.org/servo/trait.EventLoopWaker.html#tymethod.wake) has been removed, because it almost never makes sense for a new custom impl to leave the method empty (@chrisduerr, @mrobinson, #43250).

- [`Opts`](https://doc.servo.org/servo/struct.Opts.html)::`print­_pwm` is now [`DiagnosticsLogging`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html)::[`progressive­_web­_metrics`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html#structfield.progressive_web_metrics) (@mrobinson, #43209).

Removed from our API:

- [`Opts`](https://doc.servo.org/servo/struct.Opts.html)::`nonincremental­_layout` (@mrobinson, #43207) – no replacement. This only really worked in legacy layout.

- [`Opts`](https://doc.servo.org/servo/struct.Opts.html)::`user­_stylesheets` (@mrobinson, #43206) – use [`UserContentManager`](https://doc.servo.org/servo/struct.UserContentManager.html)::[`add­_stylesheet()`](https://doc.servo.org/servo/struct.UserContentManager.html#method.add_stylesheet) instead. This is how servoshell’s `--user-stylesheet` option works.

You can now read and write cookies with [`SiteDataManager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::[`cookies­_for­_url()`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.cookies_for_url) and [`set­_cookie­_for­_url()`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.set_cookie_for_url) (@longvatrong111, #43600).

[`ClipboardDelegate`](https://doc.servo.org/servo/trait.ClipboardDelegate.html) and [`StringRequest`](https://doc.servo.org/servo/struct.StringRequest.html) are now exposed to the public API, allowing you to implement custom clipboard delegates (@jdm, @chrisduerr, #43203, #43261).
You can pass your custom delegate to [`WebViewBuilder`](https://doc.servo.org/servo/struct.WebViewBuilder.html)::[`clipboard­_delegate()`](https://doc.servo.org/servo/struct.WebViewBuilder.html#method.clipboard_delegate).

You can now get the [`EmbedderControlId`](https://doc.servo.org/servo/struct.EmbedderControlId.html) associated with an [`InputMethodControl`](https://doc.servo.org/servo/struct.InputMethodControl.html) by calling [`InputMethodControl`](https://doc.servo.org/servo/struct.InputMethodControl.html)::[`id()`](https://doc.servo.org/servo/struct.InputMethodControl.html#method.id) (@chrisduerr, #43248).

[`PixelFormat`](https://doc.servo.org/servo/enum.PixelFormat.html) now implements [`Debug`](https://doc.rust-lang.org/1.92.0/core/fmt/trait.Debug.html) (@chrisduerr, @mrobinson, #43249).

We’ve improved the docs for [`Servo`](https://doc.servo.org/servo/struct.Servo.html), [`ServoBuilder`](https://doc.servo.org/servo/struct.ServoBuilder.html), [`WebViewBuilder`](https://doc.servo.org/servo/struct.WebViewBuilder.html), [`RenderingContext`](https://doc.servo.org/servo/trait.RenderingContext.html) (@chrisduerr, #43229), [`EmbedderControlId`](https://doc.servo.org/servo/struct.EmbedderControlId.html), [`EmbedderControlRequest`](https://doc.servo.org/servo/enum.EmbedderControlRequest.html), [`EmbedderControlResponse`](https://doc.servo.org/servo/enum.EmbedderControlResponse.html), [`SimpleDialogRequest`](https://doc.servo.org/servo/enum.SimpleDialogRequest.html), [`AlertResponse`](https://doc.servo.org/servo/enum.AlertResponse.html), [`ConfirmResponse`](https://doc.servo.org/servo/enum.ConfirmResponse.html), [`PromptResponse`](https://doc.servo.org/servo/enum.PromptResponse.html), [`EmbedderMsg`](https://doc.servo.org/servo/enum.EmbedderMsg.html) (@mukilan, #43564), [`ResourceReaderMethods`](https://doc.servo.org/servo/resources/trait.ResourceReaderMethods.html) (@jschwe, @mrobinson, #43769), [`servo`](https://doc.servo.org/servo/)::[`input­_events`](https://doc.servo.org/servo/input_events/index.html) (@mukilan, #43681), and [`WheelDelta`](https://doc.servo.org/servo/struct.WheelDelta.html) (@yezhizhen, @mrobinson, #43210).

## More on the web platform

**Carets now blink** in text fields (@mrobinson, #43128).
You can [configure or disable](https://doc.servo.org/servo/prefs/struct.Preferences.html#structfield.editing_caret_blink_time) blinking carets with `--pref editing_caret_blink_time=0` or a duration in milliseconds.
**Clicking to move the caret** is more forgiving now (@mrobinson, #43238), and moving the caret by a **word at a time** is more conventional on Windows and Linux, with Ctrl instead of Alt (@mrobinson, #43436).
We’ve also fixed a bug where pressing the arrow keys in text fields both moves the caret (good) and scrolls the page (bad), and fixed a bug where the caret fails to render on empty lines (@mrobinson, @freyacodes, #43247, #42218).

**Input** has improved, with more responsive **touchpad scrolling** on Linux (@mrobinson, @chrisduerr, #43350).
**Pointer events** and **mouse events** can now be **[captured](https://developer.mozilla.org/en-US/docs/Learn_web_development/Core/Scripting/Event_bubbling#event_capture) across shadow DOM boundaries** (@simonwuelker, #42987), and we’ve now started working towards shadow-DOM-compatible focus (@mrobinson, #43811).

The **lang** attribute is now taken into account when shaping, which is important for the correct rendering of Chinese and Japanese text (@RichardTjokroutomo, @mrobinson, #43447).
**‘font-weight’** is now matched more accurately when no available font is an exact match (@shubhamg13, #43125).

We’ve improved the default appearance of **&lt;summary>** (@Loirooriol, #43111), **&lt;select>** (@lukewarlow, #43175), **&lt;input type=file>** (@lukewarlow, @AlexVasiluta, @lukewarlow, #43498, #43186), and **&lt;textarea>** and **&lt;input type=text>** and friends (@mrobinson, #43132), plus **‘::marker’** in mixed LTR/RTL content (@Loirooriol, #43201).
**&lt;select>** also now requires user interaction to open the picker (@SharanRP, #43485).

**&lt;form action>**, **&lt;iframe src>**, **open(url)** on **XMLHttpRequest**, **new EventSource(url)**, and **new Worker(url)** now correctly resolve the URL with the page encoding (@SharanRP, @jdm, @jayant911, @Veercodeprog, @sabbCodes, #43521, #43554, #43572, #43537, #43634, #43588).

**‘direction’** now works on grid containers (@nicoburns, #42118), **SVG images** can now be used in **‘border-image’** (@shubhamg13, #42566), **‘linear-gradient()’** now dithers to reduce banding (@Messi002, #43603), **‘letter-spacing’** no longer applies to invisible zero-width formatting characters (@simonwuelker, #42961), and **‘:active’** now matches disabled or non-focusable elements too, as long as they are being clicked (@webbeef, #42935).

We’ve improved the conformance of **JS modules** (@Gae24, #43585), **‘Content-Security-Policy’** (@TimvdLippe, #43367, #43483, #43438, #43645, #43652), **&lt;button command>** (@lukewarlow, #42883), **&lt;font size>** (@shubhamg13, #43103), **&lt;script integrity>** and **&lt;style integrity>** (@Gae24, #42931), **EventSource** (@mishop-15, #42179), **IndexedDB** (@Taym95, @jerensl, #43096, #43041, #42451, #43721, #43754), **IntersectionObserver** (@stevennovaryo, @mrobinson, #42251), **SubtleCrypto** (@kkoyung, #42984, #43315, #43533), **HTMLVideoElement** (@shubhamg13, #43341), **dataset** on **Element** (@TimvdLippe, #43046), and **querySelector()** and **querySelectorAll()** (@simonwuelker, #42991).

We’ve fixed bugs related to **&lt;iframe>** (@TimvdLippe, @jdm, #43539, #43732), the **‘animationstart’** and **‘animationend’** events (@simonwuelker, #43454), **inline layout** in quirks mode (@mrobinson, @Loirooriol, @lukewarlow, #42960), **‘:active’** on &lt;input> (@mrobinson, #43722), **‘overflow: scroll’** on ‘::before’ and ‘::after’ (@stevennovaryo, #43231), the default position of **‘position: absolute’** inside blocks that are nested in an inline layout (@yoursanonymous, @Loirooriol, #43084), and the default size of &lt;img> and &lt;svg> without **width** or **height** attributes (@Loirooriol, #42666).
Fixing that last bug led to Servo developers finding two [spec](https://github.com/w3c/csswg-drafts/issues/12612) [issues](https://github.com/w3c/csswg-drafts/issues/13149)!

We now support the CSS **&lt;system-color> values** ‘AccentColor’, ‘AccentColorText’, ‘ActiveText’, ‘ButtonBorder’, ‘ButtonFace’, ‘ButtonText’, ‘Canvas’, ‘CanvasText’, ‘Field’, ‘FieldText’, ‘GrayText’, ‘Highlight’, ‘HighlightText’, ‘LinkText’, ‘Mark’, ‘MarkText’, ‘SelectedItem’, ‘SelectedItemText’, ‘VisitedText’, ‘ActiveBorder’, ‘ActiveCaption’, ‘AppWorkspace’, ‘Background’, ‘ButtonHighlight’, ‘ButtonShadow’, ‘CaptionText’, ‘InactiveBorder’, ‘InactiveCaption’, ‘InactiveCaptionText’, ‘InfoBackground’, ‘InfoText’, ‘Menu’, ‘MenuText’, ‘Scrollbar’, ‘ThreeDDarkShadow’, ‘ThreeDFace’, ‘ThreeDHighlight’, ‘ThreeDLightShadow’, ‘ThreeDShadow’, ‘Window’, ‘WindowFrame’, and ‘WindowText’ (@longvatrong111, #42529, #43105, #43107).

We’ve landed partial support for using **CSS [counters](https://drafts.csswg.org/css-lists/#counter)** in ‘list-style-type’ on ‘display: list-item’ and ‘content’ on ‘::marker’, but the counter values themselves are not calculated yet, so all list items still read as `0.` or similar.
In any case, you can use a &lt;counter-style-name> or ‘symbols()’ in ‘list-style-type’, and ‘counter()’ and ‘counters()’ in ‘content’ (@Loirooriol, #43111).

We’ve also landed partial support for **&lt;marquee>** and the **HTMLMarqueeElement** interface, including basic layout, but the contents are not animated yet (@mrobinson, @lukewarlow, #43520, #43610).

Servo now exposes several attributes that have no direct effect, but are needed for web compatibility (@lukewarlow, #43500, #43499, #43502, #43518):

- **noHref** on **HTMLAreaElement**
- **hreflang**, **type**, **charset** on **HTMLAnchorElement**
- **useMap** on **HTMLInputElement** and **HTMLObjectElement**
- **longDesc** on **HTMLIFrameElement** and **HTMLFrameElement**

## Performance and stability

**crypto.subtle.encrypt()**, **decrypt()**, **sign()**, **verify()**, **digest()**, **importKey()**, **unwrapKey()**, **decapsulateKey()**, and **decapsulateBits()** are more efficient now (@kkoyung, #42927), thanks to a recent [spec](https://github.com/w3c/webcrypto/issues/422) [update](https://github.com/w3c/webcrypto/pull/426).

**DOM data structures** (`#[dom_struct]`) can refer to one another, with the help of [garbage collection](https://research.mozilla.org/2014/08/26/javascript-servos-only-garbage-collector/).
But when DOM objects are being destroyed, those references can become invalid for a brief moment, depending on the order the GC finalizers run in.
This can be unsound if those references are accessed, which is a very easy mistake to make if the type has an `impl Drop`.
To help prevent that class of bug, we’re reworking our DOM types so that none of them have `#[dom_struct]` and `impl Drop` at the same time (@willypuzzle, #42937, #42982, #43018, #43071, #43222, #43288, #43544, #43563, #43631).

We’ve continued our long-running effort to **use the Rust type system** to make certain kinds of dynamic borrow failures impossible (@Narfinger, @Gae24, @Uiniel, @TimvdLippe, @yezhizhen, @sagudev, @PuercoPop, @pylbrecht, @arabson99, @jayant911, #42957, #43108, #43130, #43215, #43183, #43219, #43245, #43220, #43252, #43268, #43184, #43277, #43278, #43284, #43302, #43312, #43348, #43327, #43362, #43365, #43383, #43432, #43259, #43439, #43473, #43481, #43480, #43479, #43525, #43535, #43543, #43549, #43570, #43571, #43569, #43579, #43584, #43657, #43713).

Thanks to a wide range of people, many of whom were contributing to Servo for their first time, we’ve also landed a bunch of architectural improvements (@elomscansio, @mukilan, #43646), cleanups (@simartin, @SharanRP, @TG199, @sabbCodes, @niyabits, #43276, #43285, #43532, #43778, #43771), and refactors (@sabbCodes, @arabson99, @jayant911, @StaySafe020, @saydmateen, @eerii, @TimvdLippe, @elomscansio, @CynthiaOketch, #43614, #43641, #43619, #43642, #43623, #43656, #43644, #43672, #43664, #43676, #43684, #43679, #43678, #43655, #43675, #43731, #43729, #43728, #43740, #43751, #43748, #43747, #43752, #43745, #43724, #43723, #43765, #43767, #43181, #43269, #43270, #43279, #43437, #43597, #43607, #43602, #43616, #43609, #43612, #43647, #43651, #43662, #43714, #43774).

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
