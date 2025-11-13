---
layout:     post
tags:       blog
title:      "This month in Servo: ??????????"
date:       2025-11-02
summary:    Who even knows?
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

In **servoshell** for **Android**, you can now enable **experimental mode** with <!-- TODO how many? --> just a few taps (@jdm, #40054), use the **software keyboard** (@jdm, #40009), deliver **touch events** to web content (@mrobinson, #40240), and dismiss the location field (@jdm, #40049).
**Pinch zoom** is now fully supported in both Servo and **servoshell**, taking into account the locations of pinch inputs (@mrobinson, @atbrakhi, #40083) and allowing keyboard scrolling when zoomed in (@mrobinson, @atbrakhi, #40108).

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

You can now **take screenshots** of webviews with <code>[WebView](https://doc.servo.org/servo/struct.WebView.html)::[take_screenshot](https://doc.servo.org/servo/struct.WebView.html#method.take_screenshot)</code> (@mrobinson, @delan, #39583).

Historically Servo has struggled with situations causing **100% CPU usage** or **unnecessary work on every tick** of the event loop, whenever a page is considered “active” or “animating” ([#25305](https://github.com/servo/servo/issues/25305), [#3406](https://github.com/servo/servo/issues/3406)).
We had since throttled animations (@mrobinson, #37169) and reflows (@mrobinson, @Loirooriol, #38431), but only to fixed rates of 120 Hz and 60 Hz respectively.

But starting this month, you can run Servo with **vsync**, thanks to the **<code>[RefreshDriver](https://doc.servo.org/servo/trait.RefreshDriver.html)</code> trait** (@coding-joedow, @mrobinson, #39072), which allows embedders to tell Servo *when* to start rendering each frame.
The [default driver](https://doc.servo.org/compositing/refresh_driver/struct.TimerRefreshDriver.html) continues to run at 120 Hz, but you can define and install your own with <code>[ServoBuilder](https://doc.servo.org/servo/struct.ServoBuilder.html)::[refresh_driver](https://doc.servo.org/servo/struct.ServoBuilder.html#method.refresh_driver)</code>.

### Breaking changes

Servo’s embedding API has had a few **breaking changes**:

- <code>[Opts](https://doc.servo.org/servo_config/opts/struct.Opts.html)::wait_for_stable_image</code> was **removed**; to wait for a stable image, call <code>[WebView](https://doc.servo.org/servo/struct.WebView.html)::[**take_screenshot**](https://doc.servo.org/servo/struct.WebView.html#method.take_screenshot)</code> instead (@mrobinson, @delan, #39583).

- <code>[MouseButtonAction](https://doc.servo.org/servo/enum.MouseButtonAction.html)::Click</code> was **removed**; use <code>[**Down**](https://doc.servo.org/servo/enum.MouseButtonAction.html#variant.Down)</code> followed by <code>[**Up**](https://doc.servo.org/servo/enum.MouseButtonAction.html#variant.Up)</code>. [Click events](https://developer.mozilla.org/en-US/docs/Web/API/Element/click_event) need to be *derived* from mouse button downs and ups to ensure that they are fired correctly (@mrobinson, #39705).

- **Scrolling is now *derived*** from mouse wheel events. When you have mouse wheel input to forward to Servo, you should now call <code>[WebView](https://doc.servo.org/servo/struct.WebView.html)::[notify_input_event](https://doc.servo.org/servo/struct.WebView.html#method.notify_input_event)</code> *only*, not <code>[notify_scroll_event](https://doc.servo.org/servo/struct.WebView.html#method.notify_scroll_event)</code> (@mrobinson, @atbrakhi, #40269).

- <code>[WebView](https://doc.servo.org/servo/struct.WebView.html)::set_pinch_zoom</code> was renamed to <code>[pinch_zoom](https://doc.servo.org/servo/struct.WebView.html#method.pinch_zoom)</code>, to better reflect that **pinch zoom** is always **relative** (@mrobinson, @atbrakhi, #39868).

We’ve improved **page zoom** in our webview API (@atbrakhi, @mrobinson, @shubhamg13, #39738), which includes some **breaking changes**:

- <code>[WebView](https://doc.servo.org/servo/struct.WebView.html)::set_zoom</code> was renamed to <code>[set_page_zoom](https://doc.servo.org/servo/struct.WebView.html#method.set_page_zoom)</code>, and it now takes an **absolute** zoom value. This makes it idempotent, but it means if you want relative zoom, you’ll have to multiply the zoom values yourself.
- Use the new <code>[WebView](https://doc.servo.org/servo/struct.WebView.html)::[page_zoom](https://doc.servo.org/servo/struct.WebView.html#method.page_zoom)</code> method to get the current zoom value.
- <code>[WebView](https://doc.servo.org/servo/struct.WebView.html)::reset_zoom</code> was removed; use `set_page_zoom(1.0)` instead.

Some **breaking changes** were also needed to give embedders a more powerful way to **share input events with webviews** (@mrobinson, #39720).
Often both your app and the pages in your webviews may be interested in knowing when users press a key.
Servo handles these situations by asking the embedder for all potentially useful input events, then echoing some of them back:

1. Embedder calls <code>[WebView](https://doc.servo.org/servo/struct.WebView.html)::[notify_input_event](https://doc.servo.org/servo/struct.WebView.html#method.notify_input_event)</code> to tell Servo about an input event, then web content (and Servo) can handle the event.
2. Servo calls <code>[WebViewDelegate](https://doc.servo.org/servo/trait.WebViewDelegate.html)::notify_keyboard_event</code> to tell the embedder about keyboard events that were neither [canceled by scripts](https://dom.spec.whatwg.org/#dom-event-preventdefault) nor handled by Servo itself. The event details is included in the arguments.

Embedders had **no way of knowing *when*** non-keyboard input events, or keyboard events that were canceled or handled by Servo, have **completed all of their effects in Servo**.
This was good enough for servoshell’s overridable key bindings, but not for WebDriver, where commands like [Perform Actions](https://w3c.github.io/webdriver/#perform-actions) need to reliably wait for input events to be handled.
To solve these problems, we’ve replaced <code>notify_keyboard_event</code> with <code>[notify_input_event_handled](https://doc.servo.org/servo/trait.WebViewDelegate.html#method.notify_input_event_handled)</code>:

1. Embedder calls <code>[WebView](https://doc.servo.org/servo/struct.WebView.html)::[notify_input_event](https://doc.servo.org/servo/struct.WebView.html#method.notify_input_event)</code> to tell Servo about an input event, then web content (and Servo) can handle the event. **This now returns an <code>[InputEventId](https://doc.servo.org/servo/struct.InputEventId.html)</code>**, allowing embedders to remember input events that they still care about for step 2.
2. **Servo calls <code>[WebViewDelegate](https://doc.servo.org/servo/trait.WebViewDelegate.html)::[notify_input_event_handled](https://doc.servo.org/servo/trait.WebViewDelegate.html#method.notify_input_event_handled)</code>** to tell the embedder about **every input event, when Servo has finished handling it**. The event details are **not included** in the arguments, but you can use the <code>[InputEventId](https://doc.servo.org/servo/struct.InputEventId.html)</code> to look up the details in the embedder.

## Perf and stability

Servo now does **zero unnecessary layout work** when **updating canvases** and **animated images**, thanks to a new “UpdatedImageData” layout mode (@mrobinson, @mukilan, #38991).

We’ve fixed crashes when clicking on web content on Android (@mrobinson, #39771), and when running Servo on platforms where JIT is forbidden (@jschwe, @sagudev, #40071, #40130).

## Donations

<!--
- 5753.87/month donations
    - 2243.24/month opencollective
    - 3353.00/month github
    - 157.63/month 28 donors thanks.dev
-->

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
