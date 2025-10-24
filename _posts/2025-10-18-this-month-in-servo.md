---
layout:     post
tags:       blog
title:      "This month in Servo: and more!"
date:       2025-10-18
summary:    ao!! wrrrrao!!
categories:
---

<!--
- donations 5654.03/month
    - opencollective 2212.40/month
    - github 3284.00/month
    - thanks.dev 157.63/month 28 donors
-->

September was another busy month for Servo, with a bunch of new features landing in our nightly builds:

- the **Trusted Types** API is now stable (@TimvdLippe, #39281, #39263)
- **strokeText()** on CanvasRenderingContext2D (@sagudev, #39183)
- **invertSelf()** on DOMMatrix (@lumiscosity, #39148)
- **getType()** and **supports()** on ClipboardItem (@Gae24, #39296)
- **getAll()** and **getAllKeys()** on IDBObjectStore (@arihant2math, #38885)
- **scrollParent** property on HTMLElement (@mrobinson, @Loirooriol, #39110)
- **sizes** property on HTMLImageElement (@tharkum, #39466)

<figure>
    <img src="{{ '/img/blog/2025-10-diffie.jpg' | url }}" alt="servoshell nightly showing new support for the strokeText() method on CanvasRenderingContext2D">
</figure>

**Viewport meta** tags are now enabled on mobile devices only, fixing a bug where they were enabled on desktop (@shubhamg13, #39133).
You can still enable them if needed with `--pref viewport_meta_enabled` (@shubhamg13, #39207).

Servo now supports **‘[Content-Encoding](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Content-Encoding): [zstd](https://en.wikipedia.org/wiki/Zstd)’** (@webbeef, #36530), and we’ve fixed a bug causing spurious credentials prompts when a HTTP 401 has no ‘WWW-Authenticate’ header (@simonwuelker, #39215).
We’ve also made a bunch of progress on **AbortController** (@TimvdLippe, #39290, #39295, #39374, #39406) and **&lt;link rel=preload>** (@TimvdLippe, @jdm, #39033, #39034, #39052, #39146, #39167).

**‘Content-Security-Policy: sandbox’** now **disables scripting** unless **‘allow-scripts’** is given (@TimvdLippe, #39163), and **crypto.subtle.exportKey()** can now export HMAC keys in `raw` format (@arihant2math, #39059).

The **scrollIntoView()** method on Element now works with shadow DOM (@mrobinson, @Loirooriol, #39144), and recurses to parent iframes if they are same origin (@Loirooriol, @mrobinson, #39475, #39397, #39153).

Several types of **DOM exceptions can now have error messages** (@arihant2math, @rodio, @excitablesnowball, #39056, #39394, #39535), and we’ve also fixed a bug where links often need to be clicked twice (@yezhizhen, #39326), and fixed bugs affecting &lt;img> attribute changes (@tharkum, #39483), the ‘:defined’ selector (@mukilan, #39325, #39390), invertSelf() on DOMMatrix (@lumiscosity, #39113), and the ‘href’ setter on Location (@arihant2math, @sagudev, #39051).

One complex part of Servo isn’t even written in Rust, it’s written in Python!
[**codegen.py**](https://github.com/servo/servo/blob/25d3c5a157e781db8813071a5ba647463546d0cd/components/script_bindings/codegen/codegen.py), which describes how to generate Rust code with bindings for every known DOM interface from the WebIDL, is now **fully type annotated** (@jerensl, @mukilan, #39070, #38998).

## Embedding and automation

Servo now requires **Rust 1.86** to build (@sagudev, #39185).

**Keyboard scrolling** is now automatically implemented by Servo (@delan, @mrobinson, #39371, #39469), so embedders [no longer](https://github.com/servo/servo/pull/39371/files#diff-24ced12025398fd76b233d19f4507362ae8b3848157577d8041effc4c4a229ae) need to translate **arrow keys**, **Home**, **End**, **Page Up**, and **Page Down** to WebView API calls.
This change also improves the behaviour of those keys, scrolling the element or &lt;iframe> that was focused or most recently clicked (or a nearby ancestor).

<code>[DebugOptions](https://doc.servo.org/servo_config/opts/struct.DebugOptions.html)::convert_mouse_to_touch</code> (`-Z convert-mouse-to-touch`) has been removed (@mrobinson, #39352), with no replacement.
Touch event simulation continues to be available in servoshell as `--simulate-touch-events`.

<code>[DebugOptions](https://doc.servo.org/servo_config/opts/struct.DebugOptions.html)::webrender_stats</code> (`-Z wr-stats` in servoshell) has been removed (@mrobinson, #39331); instead call <code>[toggle_webrender_debugging](https://doc.servo.org/servo/struct.WebView.html#method.toggle_webrender_debugging)([Profiler](https://doc.servo.org/servo/enum.WebRenderDebugOption.html#variant.Profiler))</code> on a WebView (or press **Ctrl**+**F12** in servoshell).

<code>[DebugOptions](https://doc.servo.org/servo_config/opts/struct.DebugOptions.html)::trace_layout</code> (`-Z trace-layout`) has been removed (@mrobinson, #39332), since it had no effect.

We’ve improved the docs for <code>[WebViewDelegate](https://doc.servo.org/servo/trait.WebViewDelegate.html)::[notify_history_changed](https://doc.servo.org/servo/trait.WebViewDelegate.html#method.notify_history_changed)</code> (@Narfinger, @mrobinson, @yezhizhen, #39134).

When automating servoshell with **WebDriver**, commands **targeting elements** now correctly **scroll into view** if needed (@PotatoCP, @yezhizhen, #38508, #39265), allowing **Element Click**, **Element Send Keys**, **Element Clear**, and **Take Element Screenshot** to work properly when the element is outside the viewport.

**WebDriver mouse inputs** now work correctly with **HiDPI scaling** on more platforms (@mrobinson, #39472), and we’ve improved the reliability of **Take Screenshot**, **Take Element Screenshot** (@yezhizhen, #39499, #39539, #39543), **Switch To Frame** (@yezhizhen, #39086), **Switch To Window** (@yezhizhen, #39241), and **New Session** (@yezhizhen, #39040).

These improvements have enabled us to run the **WebDriver conformance tests** in CI by default (@PotatoCP, #39087), and also mean we’re closer than ever to running [WebDriver-based Web Platform Tests](https://web-platform-tests.org/writing-tests/testdriver.html).

## servoshell

You can now **enable experimental web platform features** with the click of a button (@jdm, #39125), instead of passing the command line option.

**Favicons** now update correctly when you **navigate back and forward** (@webbeef, #39575), not just when you load a new page.

servoshell’s **command line argument parsing** has been reworked (@Narfinger, #37194, #39316), which should fix the confusing behaviour of some options.

On mobile devices, servoshell now resizes the webview correctly when the available space changes (@blueguy1, @yjx, @yezhizhen, #39507).

On macOS, telling servoshell to [**take a screenshot**](https://w3c.github.io/webdriver/#screen-capture) no longer hides the window (@mrobinson, #39500).
This does not affect taking a screenshot in headless mode (`--headless`), where there continues to be no window at all.

## Performance

Servo currently runs in **single-process mode** unless you opt in to `--multiprocess` mode, and we’ve landed a few perf improvements in that default mode.
For one, in single-process mode, script can now **communicate with the embedder directly** for reduced latency (@jschwe, #39039).
We also create one thread pool for the image cache now, rather than one pool per origin (@rodio, #38783).

Many components of Servo that *would* be [separated by a process boundary](https://book.servo.org/architecture/overview.html#architecture) in multiprocess mode, now use [crossbeam channels](https://docs.rs/crossbeam-channel/0.5.15/crossbeam_channel/) in single-process mode, rather than using [IPC channels](https://docs.rs/ipc-channel/0.20.2/ipc_channel/) in both modes (@jschwe, #39073, #39076, #39345, #39347, #39348, #39074).
[IPC channels](https://docs.rs/ipc-channel/0.20.2/ipc_channel/) are required when communicating with another process, but they’re more expensive, because they require serialising and deserialising each message, plus resources from the operating system.

We’ve started working on an optimisation for string handling in Servo’s DOM layer (@Narfinger, #39480, #39481, #39504).
Strings in our DOM have historically been represented as [ordinary Rust strings](https://doc.rust-lang.org/std/string/struct.String.html), but they often come from SpiderMonkey, where they use [a variety of representations](https://searchfox.org/firefox-main/rev/8e5d58cfed616cb90586c614e53d8ab1ffc8af27/js/src/vm/StringType.h#83), none of which are entirely compatible.
SpiderMonkey strings would continue to need conversion to Servo strings, but the idea we’re working towards is to **make the conversion lazy**, in the hope that many strings will never end up being converted at all.

We now use a faster hash algorithm for internal hashmaps that are not security-critical (@Narfinger, #39106, #39166, #39202, #39233, #39244, #39168).
These changes also switch that faster algorithm from [FNV](https://en.wikipedia.org/wiki/Fowler%E2%80%93Noll%E2%80%93Vo_hash_function) to an [even simpler polynomial hash](https://docs.rs/rustc-hash/2.1.1/rustc_hash/), following in the footsteps of [Rust](https://github.com/rust-lang/rust/pull/37229) and [Stylo](https://bugzilla.mozilla.org/show_bug.cgi?id=1477628).

We’ve also landed a few more self-contained perf improvements:
- speeding up accesses to the event loop (@Narfinger, #39274, #39275)
- avoviding new display lists while loading CSS images (@coding-joedow, #39201)
- reducing memory usage (@ritoban23, #39351)
- reducing binary size (@lumiscosity, @Narfinger, #39437, #39567)

## Donations

Thanks again for your generous support!
We are now receiving **5654 USD/month** (+1.8% over August) in recurring donations.

This helps us cover the cost of our **[speedy](https://ci0.servo.org) [CI](https://ci1.servo.org) [and](https://ci2.servo.org) [benchmarking](https://ci3.servo.org) [servers](https://ci4.servo.org)**, one of our latest **[Outreachy interns](https://www.outreachy.org/alums/2025-06/#:~:text=Servo)**, and funding **[maintainer work]({{ '/blog/2025/09/17/your-donations-at-work-funding-jdm/' | url }})** that helps more people contribute to Servo.
Keep an eye out for [further CI improvements](https://github.com/servo/servo/issues/38141) in the coming months, including [faster pull request checks](https://github.com/servo/servo/pull/39900) and [ten-minute WPT builds](https://github.com/servo/ci-runners/issues/21).

Servo is also on [thanks.dev](https://thanks.dev), and already **28 GitHub users** (±13 from August) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 5654 / 10000); padding-left: 0.5em;"><strong>5654</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 5654 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="5654" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

Use of donations is decided transparently via the Technical Steering Committee’s public **[funding request process](https://github.com/servo/project/blob/main/FUNDING_REQUEST.md)**, and active proposals are tracked in [servo/project#187](https://github.com/servo/project/issues/187).
For more details, head to our [Sponsorship page]({{ '/sponsorship/' | url }}).

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
