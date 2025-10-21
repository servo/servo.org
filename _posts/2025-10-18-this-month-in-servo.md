---
layout:     post
tags:       blog
title:      "This month in Servo: and more!"
date:       2025-10-18
summary:    ao!! wrrrrao!!
categories:
---

**Viewport meta** tags are now enabled on mobile devices only, fixing a bug where they were enabled on desktop (@shubhamg13, #39133).
You can still enable them if needed with `--pref viewport_meta_enabled` (@shubhamg13, #39207).

## For embedders

Servo now requires **Rust 1.86** to build (@sagudev, #39185).

**Keyboard scrolling** is now automatically implemented by Servo (@delan, @mrobinson, #39371), so embedders [no longer](https://github.com/servo/servo/pull/39371/files#diff-24ced12025398fd76b233d19f4507362ae8b3848157577d8041effc4c4a229ae) need to translate **arrow keys**, **Home**, **End**, **Page Up**, and **Page Down** to WebView API calls.
This change also improves the behaviour of those keys, scrolling the element or &lt;iframe> that was focused or most recently clicked (or a nearby ancestor).

<code>[DebugOptions](https://doc.servo.org/servo_config/opts/struct.DebugOptions.html)::convert_mouse_to_touch</code> (`-Z convert-mouse-to-touch`) has been removed (@mrobinson, #39352), with no replacement.
Touch event simulation continues to be available in servoshell as `--simulate-touch-events`.

<code>[DebugOptions](https://doc.servo.org/servo_config/opts/struct.DebugOptions.html)::webrender_stats</code> (`-Z wr-stats` in servoshell) has been removed (@mrobinson, #39331); instead call <code>[toggle_webrender_debugging](https://doc.servo.org/servo/struct.WebView.html#method.toggle_webrender_debugging)([Profiler](https://doc.servo.org/servo/enum.WebRenderDebugOption.html#variant.Profiler))</code> on a WebView (or press **Ctrl**+**F12** in servoshell).

<code>[DebugOptions](https://doc.servo.org/servo_config/opts/struct.DebugOptions.html)::trace_layout</code> (`-Z trace-layout`) has been removed (@mrobinson, #39332), since it had no effect.

We’ve improved the docs for <code>[WebViewDelegate](https://doc.servo.org/servo/trait.WebViewDelegate.html)::[notify_history_changed](https://doc.servo.org/servo/trait.WebViewDelegate.html#method.notify_history_changed)</code> (@Narfinger, @mrobinson, @yezhizhen, #39134).

## servoshell

You can now **enable experimental web platform features** with the click of a button (@jdm, #39125), instead of passing the command line option.

**Favicons** now update correctly when you **navigate back and forward** (@webbeef, #39575), not just when you load a new page.

servoshell’s **command line argument parsing** has been reworked (@Narfinger, #37194, #39316), which should fix the confusing behaviour of some options.

On mobile devices, servoshell now resizes the webview correctly when the available space changes (@blueguy1, @yjx, @yezhizhen, #39507).

On macOS, telling servoshell to [**take a screenshot**](https://w3c.github.io/webdriver/#screen-capture) no longer hides the window (@mrobinson, #39500).
This does not affect taking a screenshot in headless mode (`--headless`), where there continues to be no window at all.

## Donations

Thanks again for your generous support!
We are now receiving **???? USD/month** (+??.?% over August) in recurring donations.

Historically this has helped cover the cost of our [speedy](https://ci0.servo.org) [CI](https://ci1.servo.org) [servers](https://ci2.servo.org) and [Outreachy interns](https://www.outreachy.org/alums/2025-06/#:~:text=Servo).
Thanks to your support, we’re now setting up **[two](https://ci3.servo.org) [new](https://ci4.servo.org) CI servers for benchmarking**, and **[funding the work of our long-time maintainer]({{ '/blog/2025/09/17/your-donations-at-work-funding-jdm/' | url }}) Josh Matthews** (@jdm), with a particular focus on helping more people contribute to Servo.

Keep an eye out for [further CI improvements](https://github.com/servo/servo/issues/38141) in the coming months, including [**ten-minute WPT builds**](https://github.com/servo/ci-runners/issues/21), **macOS arm64 builds**, and **faster pull request checks**.

Servo is also on [thanks.dev](https://thanks.dev), and already **?? GitHub users** (±? from August) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 5552 / 10000); padding-left: 0.5em;"><strong>5552</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 5552 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="5552" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

As always, use of these funds will be decided transparently in the Technical Steering Committee.
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
