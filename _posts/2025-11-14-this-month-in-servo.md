---
layout:     post
tags:       blog
title:      "October in Servo: better for the web, better for embedders, better for you"
date:       2025-11-14
summary:    Big changes to our webview API, improved macOS and Android builds, and now we’ve shipped AbortController, AbortSignal, and XPath.
categories:
---

Servo now supports several new web platform features:

- **&lt;source>** in **&lt;video>** and **&lt;audio>** (@tharkum, #39717)
- **CompressionStream** and **DecompressionStream** (@kkoyung, #39658)
- **fetchLater()** (@TimvdLippe, #39547)
- **Document.parseHTMLUnsafe()** (@lukewarlow, #40246)
- the **which** property on **UIEvent** (@Taym95, #40109)
- the **relatedTarget** property on **UIEvent** (@TimvdLippe, #40182)
- **self&#x2E;name** and **.onmessageerror** in dedicated workers (@yerke, #40156)
- **name** and **areas** properties on **HTMLMapElement** (@tharkum, #40133)

<figure>
    <img src="{{ '/img/blog/2025-11-diffie.png' | url }}" alt="servoshell nightly showing new support CompressionStream and synthetic bold">
</figure>

**servoshell** for **macOS** now ships as **native Apple Silicon binaries** (@jschwe, #39981).
Building servoshell for macOS amd64 still works for now, but is no longer officially supported by automated testing in CI (see *§ For developers*).

In **servoshell** for **Android**, you can now enable **experimental mode** with just two taps (@jdm, #40054), use the **software keyboard** (@jdm, #40009), deliver **touch events** to web content (@mrobinson, #40240), and dismiss the location field (@jdm, #40049).
**Pinch zoom** is now fully supported in both Servo and **servoshell**, taking into account the locations of pinch inputs (@mrobinson, @atbrakhi, #40083) and allowing keyboard scrolling when zoomed in (@mrobinson, @atbrakhi, #40108).

<figure>
    <div style="display:flex">
        <details style="position:relative;width:50%">
            <video src="{{ '/img/blog/2025-11-experimental.webm' | url }}" style="position:absolute;margin:0;inset:0;pointer-events:none" loading="lazy">servoshell on Android showing GitHub loaded with an internal error, then enabling experimental mode in the settings menu, then reloading the page successfully (click to pause)</video>
            <summary style="display:block"><img src="{{ '/img/blog/2025-11-experimental.jpg' | url }}" style="margin:0" loading="lazy"><div style="position:absolute;inset:0;display:flex;justify-content:center;align-items:center;color:#1192e8;font-size:7em;cursor:pointer;-webkit-text-stroke:1rem color-mix(in oklch,#1192e8,black 20%);user-select:none" alt="servoshell on Android showing GitHub loaded with an internal error, then enabling experimental mode in the settings menu, then reloading the page successfully (click to play)">▶</div></summary>
        </details>
        <details style="position:relative;width:50%">
            <video src="{{ '/img/blog/2025-11-input.webm' | url }}" style="position:absolute;margin:0;inset:0;pointer-events:none" loading="lazy">servoshell on Android showing a page that opens the software keyboard and listens for touch events (click to pause)</video>
            <summary style="display:block"><img src="{{ '/img/blog/2025-11-input.jpg' | url }}" style="margin:0" loading="lazy"><div style="position:absolute;inset:0;display:flex;justify-content:center;align-items:center;color:#1192e8;font-size:7em;cursor:pointer;-webkit-text-stroke:1rem color-mix(in oklch,#1192e8,black 20%);user-select:none" alt="servoshell on Android showing a page that opens the software keyboard and listens for touch events (click to play)">▶</div></summary>
        </details>
    </div>
    <figcaption>servoshell on Android. <strong>Left:</strong> you can now turn on experimental mode in the settings menu. <strong>Right:</strong> we now support the soft keyboard and touch events.</figcaption>
</figure>

**AbortController** and **AbortSignal** are now **enabled by default** (@jdm, @TimvdLippe, #40079, #39943), after implementing **AbortSignal.timeout()** (@Taym95, #40032) and fixing **throwIfAborted()** on **AbortSignal** (@Taym95, #40224).
If this is the first time you’ve heard of them, you might be surprised how important they are for real-world web compat!
[**Over 40%**](https://webstatus.dev/features/aborting) of Google Chrome page loads at least *check* if they are supported, and many popular websites including GitHub and Discord are broken without them.

**XPath** is now **enabled by default** (@simonwuelker, #40212), after implementing **‘@attr/parent’ queries** (@simonwuelker, #39749), **Copy** > **<u>X</u>Path** in the **DevTools Inspector** (@simonwuelker, #39892), completely rewriting the parser (@simonwuelker, #39977), and landing several other fixes (@simonwuelker, #40103, #40105, #40161, #40167, #39751, #39764).

Servo now supports `new KeyboardEvent({keyCode})` and `({charCode})` (@atbrakhi, #39590), which is enough to get [**Speedometer 3.0**](https://browserbench.org/Speedometer3.0/) and [**3.1**](https://browserbench.org/Speedometer3.1/) working on macOS.

<figure>
    <a href="{{ '/img/blog/2025-11-speedometer.png' | url }}"><img src="{{ '/img/blog/2025-11-speedometer-small.png' | url }}" alt="servoshell nightly showing Speedometer 3.1 running successfully on macOS"></a>
</figure>

**ImageData** can now be sent over **postMessage()** and **structuredClone()** (@Gae24, #40084).

## Layout engine

Our layout engine can now render text in **synthetic bold** (@minghuaw, @mrobinson, #39519, #39681, #39633, #39691, #39713), and now selects more appropriate fallback fonts for **Kanji** in **Japanese text** (@arayaryoma, #39608).

**‘initial-scale’** now does the right thing in **&lt;meta name=viewport>** (@atbrakhi, @shubhamg13, @mrobinson, #40055).

We’ve improved the way we handle **‘border-radius’** (@Loirooriol, #39571) and **margin collapsing** (@Loirooriol, #36322).
While they’re fairly unassuming fixes on the surface, both of them allowed us to **find interop issues** in the big incumbent engines (@Loirooriol, [#39540](https://github.com/servo/servo/issues/39540), [#36321](https://github.com/servo/servo/issues/36321)) and **help improve web standards** (@noamr, @Loirooriol, [csswg-drafts#12961](https://github.com/w3c/csswg-drafts/issues/12961), [csswg-drafts#12218](https://github.com/w3c/csswg-drafts/issues/12218)).

In other words, Servo is good for the web, even if you’re not using it yet!

## Embedding and ecosystem

Our HTML-compatible **XPath** implementation now lives in its [own](https://github.com/servo/servo/tree/cd4c032908211fa2c26df550f6766080d1d28969/components/xpath) [crate](https://doc.servo.org/xpath/), and it’s no longer limited to the Servo DOM (@simonwuelker, #39546).
We don’t have any specific plans to release this as a standalone library just yet, but please let us know if you have a use case that would benefit from this!

You can now **take screenshots** of webviews with <code>[WebView](https://doc.servo.org/servo/struct.WebView.html)::<wbr>[take_screenshot](https://doc.servo.org/servo/struct.WebView.html#method.take_screenshot)</code> (@mrobinson, @delan, #39583).

Historically Servo has struggled with situations causing **100% CPU usage** or **unnecessary work on every tick** of the event loop, whenever a page is considered “active” or “animating” ([#25305](https://github.com/servo/servo/issues/25305), [#3406](https://github.com/servo/servo/issues/3406)).
We had since throttled animations (@mrobinson, #37169) and reflows (@mrobinson, @Loirooriol, #38431), but only to fixed rates of 120 Hz and 60 Hz respectively.

But starting this month, you can run Servo with **vsync**, thanks to the **<code>[RefreshDriver](https://doc.servo.org/servo/trait.RefreshDriver.html)</code> trait** (@coding-joedow, @mrobinson, #39072), which allows embedders to tell Servo *when* to start rendering each frame.
The [default driver](https://doc.servo.org/compositing/refresh_driver/struct.TimerRefreshDriver.html) continues to run at 120 Hz, but you can define and install your own with <code>[ServoBuilder](https://doc.servo.org/servo/struct.ServoBuilder.html)::<wbr>[refresh_driver](https://doc.servo.org/servo/struct.ServoBuilder.html#method.refresh_driver)</code>.

### Breaking changes

Servo’s embedding API has had a few **breaking changes**:

- <code>[Opts](https://doc.servo.org/servo_config/opts/struct.Opts.html)::<wbr>wait_for_stable_image</code> was **removed**; to wait for a stable image, call <code>[WebView](https://doc.servo.org/servo/struct.WebView.html)::<wbr>[**take_screenshot**](https://doc.servo.org/servo/struct.WebView.html#method.take_screenshot)</code> instead (@mrobinson, @delan, #39583).

- <code>[MouseButtonAction](https://doc.servo.org/servo/enum.MouseButtonAction.html)::<wbr>Click</code> was **removed**; use <code>[**Down**](https://doc.servo.org/servo/enum.MouseButtonAction.html#variant.Down)</code> followed by <code>[**Up**](https://doc.servo.org/servo/enum.MouseButtonAction.html#variant.Up)</code>. [Click events](https://developer.mozilla.org/en-US/docs/Web/API/Element/click_event) need to be *derived* from mouse button downs and ups to ensure that they are fired correctly (@mrobinson, #39705).

- **Scrolling is now *derived*** from mouse wheel events. When you have mouse wheel input to forward to Servo, you should now call <code>[WebView](https://doc.servo.org/servo/struct.WebView.html)::<wbr>[notify_input_event](https://doc.servo.org/servo/struct.WebView.html#method.notify_input_event)</code> *only*, not <code>[notify_scroll_event](https://doc.servo.org/servo/struct.WebView.html#method.notify_scroll_event)</code> (@mrobinson, @atbrakhi, #40269).

- <code>[WebView](https://doc.servo.org/servo/struct.WebView.html)::<wbr>set_pinch_zoom</code> was renamed to <code>[pinch_zoom](https://doc.servo.org/servo/struct.WebView.html#method.pinch_zoom)</code>, to better reflect that **pinch zoom** is always **relative** (@mrobinson, @atbrakhi, #39868).

We’ve improved **page zoom** in our webview API (@atbrakhi, @mrobinson, @shubhamg13, #39738), which includes some **breaking changes**:

- <code>[WebView](https://doc.servo.org/servo/struct.WebView.html)::<wbr>set_zoom</code> was renamed to <code>[set_page_zoom](https://doc.servo.org/servo/struct.WebView.html#method.set_page_zoom)</code>, and it now takes an **absolute** zoom value. This makes it idempotent, but it means if you want relative zoom, you’ll have to multiply the zoom values yourself.
- Use the new <code>[WebView](https://doc.servo.org/servo/struct.WebView.html)::<wbr>[page_zoom](https://doc.servo.org/servo/struct.WebView.html#method.page_zoom)</code> method to get the current zoom value.
- <code>[WebView](https://doc.servo.org/servo/struct.WebView.html)::<wbr>reset_zoom</code> was removed; use `set_page_zoom(1.0)` instead.

Some **breaking changes** were also needed to give embedders a more powerful way to **share input events with webviews** (@mrobinson, #39720).
Often both your app and the pages in your webviews may be interested in knowing when users press a key.
Servo handles these situations by asking the embedder for all potentially useful input events, then echoing some of them back:

1. Embedder calls <code>[WebView](https://doc.servo.org/servo/struct.WebView.html)::<wbr>[notify_input_event](https://doc.servo.org/servo/struct.WebView.html#method.notify_input_event)</code> to tell Servo about an input event, then web content (and Servo) can handle the event.
2. Servo calls <code>[WebViewDelegate](https://doc.servo.org/servo/trait.WebViewDelegate.html)::<wbr>notify_keyboard_event</code> to tell the embedder about keyboard events that were neither [canceled by scripts](https://dom.spec.whatwg.org/#dom-event-preventdefault) nor handled by Servo itself. The event details is included in the arguments.

Embedders had **no way of knowing *when*** non-keyboard input events, or keyboard events that were canceled or handled by Servo, have **completed all of their effects in Servo**.
This was good enough for servoshell’s overridable key bindings, but not for WebDriver, where commands like [Perform Actions](https://w3c.github.io/webdriver/#perform-actions) need to reliably wait for input events to be handled.
To solve these problems, we’ve replaced <code>notify_keyboard_event</code> with <code>[notify_input_event_handled](https://doc.servo.org/servo/trait.WebViewDelegate.html#method.notify_input_event_handled)</code>:

1. Embedder calls <code>[WebView](https://doc.servo.org/servo/struct.WebView.html)::<wbr>[notify_input_event](https://doc.servo.org/servo/struct.WebView.html#method.notify_input_event)</code> to tell Servo about an input event, then web content (and Servo) can handle the event. **This now returns an <code>[InputEventId](https://doc.servo.org/servo/struct.InputEventId.html)</code>**, allowing embedders to remember input events that they still care about for step 2.
2. **Servo calls <code>[WebViewDelegate](https://doc.servo.org/servo/trait.WebViewDelegate.html)::<wbr>[notify_input_event_handled](https://doc.servo.org/servo/trait.WebViewDelegate.html#method.notify_input_event_handled)</code>** to tell the embedder about **every input event, when Servo has finished handling it**. The event details are **not included** in the arguments, but you can use the <code>[InputEventId](https://doc.servo.org/servo/struct.InputEventId.html)</code> to look up the details in the embedder.

## Perf and stability

Servo now does **zero unnecessary layout work** when **updating canvases** and **animated images**, thanks to a new “UpdatedImageData” layout mode (@mrobinson, @mukilan, #38991).

We’ve fixed crashes when clicking on web content on Android (@mrobinson, #39771), and when running Servo on platforms where JIT is forbidden (@jschwe, @sagudev, #40071, #40130).

## For developers

CI builds for **pull requests** should now take **70% less time**, since they now run on self-hosted CI runners (@delan, #39900).
**Bencher builds** for runtime benchmarking now run on our new [dedicated](https://ci3.servo.org) [servers](https://ci4.servo.org), so our [Speedometer](https://bencher.dev/perf/servo?branches=52e1e9bb-959c-4171-a53d-e06bd694a6c1&testbeds=d742c702-3842-4108-9d0c-2db74e57599a%2Cd5e49dbe-b866-453a-b6ac-1cc2c452b846&benchmarks=0df0380f-9809-45bc-b525-b6ad9d5fbe91%2Cf7c6adb5-e702-42bc-902c-d2154b1e2428&measures=e71c685b-9ce9-4abc-a55d-a1de2ffe04fb&start_time=1733011200000&end_time=1764460800000) and Dromaeo data should now be more accurate and less noisy (@delan, #39272).

We’ve now switched all of our macOS builds to run on arm64 (@sagudev, @jschwe, #38460, #39968).
This helps back our macOS releases with thorough automated testing on the same architecture as our releases, but we can’t run them on self-hosted CI runners yet, so they may be slower for the time being.

Work is underway to set up faster macOS arm64 runners on our own servers (@delan, [ci-runners#64](https://github.com/servo/ci-runners/pull/64)), funded by your donations. Speaking of which!

## Donations

Thanks again for your generous support!
We are now receiving **5753 USD/month** (+1.7% over September) in recurring donations.

This helps us cover the cost of our **[speedy](https://ci0.servo.org) [CI](https://ci1.servo.org) [and](https://ci2.servo.org) [benchmarking](https://ci3.servo.org) [servers](https://ci4.servo.org)**, one of our latest **[Outreachy interns](https://www.outreachy.org/alums/2025-06/#:~:text=Servo)**, and funding **[maintainer work]({{ '/blog/2025/09/17/your-donations-at-work-funding-jdm/' | url }})** that helps more people contribute to Servo.
Keep an eye out for [further CI improvements](https://github.com/servo/servo/issues/38141) in the coming months, including [faster macOS arm64 builds](https://github.com/servo/ci-runners/pull/64) and [ten-minute WPT builds](https://github.com/servo/ci-runners/issues/21).

Servo is also on [thanks.dev](https://thanks.dev), and already **28 GitHub users** (same as September) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; right: calc(100% - 100% * 5753 / 10000); padding-right: 0.5em;"><strong>5753</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 5753 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="5753" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
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

<script>
    (function makeVideoPlayersClickable() {
        addEventListener("toggle", event => {
            const details = event.target.closest("details");
            console.log(details, details.open);
            if (!details?.open) {
                return;
            }
            const video = details.querySelector("video");
            video?.fastSeek(0);
            video?.play();
            console.log(details, video);
        }, true);
    })();
</script>
