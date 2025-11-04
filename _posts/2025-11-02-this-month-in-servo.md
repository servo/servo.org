---
layout:     post
tags:       blog
title:      "This month in Servo: ??????????"
date:       2025-11-02
summary:    Who even knows?
categories:
---

Servo now supports several new web platform features:

- **CompressionStream** and **DecompressionStream** (@kkoyung, #39658)
- **fetchLater** (@TimvdLippe, #39547), with `dom_abort_controller_enabled`

Servo now supports `new KeyboardEvent({keyCode})` and `({charCode})` (@atbrakhi, #39590), which is enough to get [**Speedometer 3.0**](https://browserbench.org/Speedometer3.0/) working on macOS.

## Embedding and ecosystem

Our HTML-compatible **XPath** implementation now lives in its [own](https://github.com/servo/servo/tree/cd4c032908211fa2c26df550f6766080d1d28969/components/xpath) [crate](https://doc.servo.org/xpath/), and it’s no longer limited to the Servo DOM (@simonwuelker, #39546).
We don’t have any specific plans to release this as a standalone library just yet, but please let us know if you have a use case that would benefit from this!

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

## Donations

Thanks again for your generous support!
We are now receiving **??? USD/month** (+?.?% over September) in recurring donations.

This helps us cover the cost of our **[speedy](https://ci0.servo.org) [CI](https://ci1.servo.org) [and](https://ci2.servo.org) [benchmarking](https://ci3.servo.org) [servers](https://ci4.servo.org)**, one of our latest **[Outreachy interns](https://www.outreachy.org/alums/2025-06/#:~:text=Servo)**, and funding **[maintainer work]({{ '/blog/2025/09/17/your-donations-at-work-funding-jdm/' | url }})** that helps more people contribute to Servo.
Keep an eye out for [further CI improvements](https://github.com/servo/servo/issues/38141) in the coming months, including [faster pull request checks](https://github.com/servo/servo/pull/39900) and [ten-minute WPT builds](https://github.com/servo/ci-runners/issues/21).

Servo is also on [thanks.dev](https://thanks.dev), and already **?** (±? from September) that depend on Servo are sponsoring us there.
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
