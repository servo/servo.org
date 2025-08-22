---
layout:     post
tags:       blog
title:      "This month in Servo: and more!"
date:       2025-08-15
summary:    ao!! wrrrrao!!
categories:
---

Servo has smashed its record again in July, with **367 pull requests** landing in our nightly builds!
This includes several new web platform features:

- **APNG** and **WebP animated images**, in addition to GIF (@rayguo17, #37637)
- **&lt;source width>** and **&lt;source height>** (@leo030303, @xiaochengh, #38152)
- **‘image-rendering’ property** now affects **‘border-image’** (@lumiscosity, @Loirooriol, #38346)
- **TextDecoderStream** (@minghuaw, #38112)
- **replace() method** on **CSSStyleSheet** (@stevennovaryo, #38244)
- **texImage3D() method** on **WebGL2RenderingContext** (@wusyong, #37718)
- **convertToBlob()** and **transferToImageBitmap() methods** on **OffscreenCanvas** (@tharkum, #37786, #37880)
- **adoptedStyleSheets property** on **Document** and **ShadowRoot**, with `--pref dom_adoptedstylesheet_enabled` (@stevennovaryo, #38163)
- **ImageBitmap** no longer requires `--enable-experimental-web-platform-features` (@tharkum, #38050)

Notable changes for Servo library consumers:

- **Stylo 0.6.0** was released, **fixing build errors** caused by an undeclared dependency on `markupsafe` (@nicoburns, @delan, stylo#215, [stylo#218](https://github.com/servo/stylo/issues/218)).
To work around this in Stylo 0.5.0, install the dependency: `pip install markupsafe`

- [**notify_scroll_event()** on WebView](https://doc.servo.org/servo/struct.WebView.html#method.notify_scroll_event) now **scrolls down as the `y` value increases** (@mrobinson, @Loirooriol, #37752), consistent with the web platform.
This is a **breaking change to the Servo API**.

<figure>
  <details style="position:relative">
    <img src="{{ '/img/blog/2025-08-diffies.webp' | url }}" style="position:absolute;margin:0;inset:0;pointer-events:none" loading="lazy" alt="servoshell nightly showing the same things, but animated">
    <summary style="display:block"><img src="{{ '/img/blog/2025-08-diffies.jpg' | url }}" style="margin:0" loading="lazy"><div style="position:absolute;inset:0;display:flex;justify-content:center;align-items:center;color:#1192e8;font-size:7em;cursor:pointer;-webkit-text-stroke:1rem color-mix(in oklch,#1192e8,black 20%);user-select:none" alt="servoshell nightly showing APNG and WebP animated images, ‘image-rendering’ applying to a ‘border-image’, a WebGL 2 example using texImage3D(), ‘text-decoration’ applying to a link with spaces, and an example of adoptedStyleSheets being controlled by a color input">▶</div></summary>
  </details>
</figure>

## Engine changes

Like many browsers, Servo has two kinds of zoom: **page zoom** affects the size of the viewport, while **pinch zoom** does not (@shubhamg13, #38194).
**Page zoom** now correctly triggers reflow (@mrobinson, #38166), and **pinch zoom** is now reset to the viewport meta config when navigating (@shubhamg13, #37315).

**‘text-decoration[-line]’ now applies to whitespace** (@leo030303, @Loirooriol, #38007), and we’ve also fixed several layout bugs around **grid item contents** (@Loirooriol, #37981), **table cell contents** (@Loirooriol, #38290), **quirks mode** (@Loirooriol, #37814, #37831, #37820, #37837), **clientWidth** and **clientHeight** queries of grid layouts (@Loirooriol, #37917), and **‘min-height’** and **‘max-height’** of replaced elements (@Loirooriol, #37758).

As part of our **incremental layout** project, we now **cache the layout results** of replaced boxes (@Loirooriol, #37971, #37897, #37962, #37943, #37985, #38349), **avoid unnecessary reflows** after animations (@coding-joedow, #37954), **invalidate layouts more precisely** (@coding-joedow, #38199, #38057, #38198, #38059), and we’ve added **incremental box tree construction** (@mrobinson, @Loirooriol, @coding-joedow, #37751, #37957) for flex and grid items (@coding-joedow, #37854), table columns, cells, and captions (@Loirooriol, @mrobinson, #37851, #37850, #37849), and a variety of inline elements (@coding-joedow, #38084, #37866, #37868, #37892).

Work on **IndexedDB** continues, notably including support for **key ranges** (@arihant2math, @jdm, #38268, #37684, #38278).

**sessionStorage** is now isolated between webviews, and copied to new webviews with the same `opener` (@janvarga, #37803).

## Browser changes

**servoshell** now has a **.desktop file** and **window name**, so you can now **pin it to your taskbar** on Linux (@MichaelMcDonnell, #38038).
We’ve made it more ergonomic too, fixing both the sluggish **mouse wheel** and **pixel-perfect trackpad scrolling** and the too fast **arrow key scrolling** (@yezhizhen, #37982).

You can now **focus the location bar with Alt+`D`** in addition to Ctrl+`L` on non-macOS platforms (@MichaelMcDonnell, #37794), and **clicking the location bar** now selects the contents (@MichaelMcDonnell, #37839).

When debugging Servo [with the **Firefox devtools**](https://book.servo.org/hacking/using-devtools.html), you can now view requests in the **Network tab** both **after navigating** (@uthmaniv, #37778) and when **responses are served from cache** (@uthmaniv, #37906).
We’re also implementing the **Debugger tab** (@delan, @atbrakhi, [#36027](https://github.com/servo/servo/issues/36027)), including several changes to our script system (@delan, @atbrakhi, #38236, #38232, #38265) and fixing a whole class of bugs where devtools ends up broken (@atbrakhi, @delan, @simonwuelker, @the6p4c, #37686).

## WebDriver changes

**WebDriver automation** support now **goes through servoshell**, rather than through libservo internally, ensuring that WebDriver commands are consistently executed in the correct order (@longvatrong111, @PotatoCP, @mrobinson, @yezhizhen, #37669, #37908, #37663, #37911, #38212, #38314).
We’ve also fixed race conditions in the **Back**, **Forward** (@longvatrong111, @jdm, #37950), **Element Click** (@longvatrong111, #37935), **Switch To Window** (@yezhizhen, #38160), and other commands (@PotatoCP, @longvatrong111, #38079, #38234).

We’ve added support for the **Dismiss Alert**, **Accept Alert**, **Get Alert Text** (@longvatrong111, #37913), and **Send Alert Text** commands for [**simple dialogs**](https://html.spec.whatwg.org/multipage/#simple-dialogs) (@longvatrong111, #38140, #38035, #38142), as well as the **Maximize Window** (@yezhizhen, #38271) and **Element Clear** commands (@PotatoCP, @yezhizhen, @jdm, #38208).
[**Find Element** family of commands](https://w3c.github.io/webdriver/#element-retrieval) can now use the **`"xpath"` location strategy** (@yezhizhen, #37783).
**Get Element Shadow Root** commands can now interact with **closed shadow roots** (@PotatoCP, #37826).

You can now **run the WebDriver test suite** in CI with `mach try wd` or `mach try webdriver` (@PotatoCP, @sagudev, @yezhizhen, #37498, #37873, #37712).

## 2D graphics

**&lt;canvas>** is key to programmable graphics on the web, with Servo supporting WebGPU, WebGL, and 2D canvas contexts.
But the **general-purpose 2D graphics** routines that power Servo’s 2D canvases are potentially useful for a lot more than &lt;canvas>: **font rendering** is bread and butter for Servo, but **SVG rendering** is only minimally supported right now, and **PDF output** is not yet implemented at all.

Those features have one thing in common: they require things that WebRender can’t yet do.
**WebRender** does one thing and does it well: rasterise the layouts of the web, really fast, by [using the GPU as much as possible](https://hacks.mozilla.org/2017/10/the-whole-web-at-maximum-fps-how-webrender-gets-rid-of-jank/).
Font rendering and SVG rendering both involve rasterising arbitrary paths, which currently has to be done outside WebRender, and PDF output is out of scope entirely.

The more code we can share between these tasks, the better we can make that code, and the smaller we can make Servo’s binary sizes ([#38022](https://github.com/servo/servo/issues/38022)).
We’ve started by moving 2D-&lt;canvas>-specific state out of the `canvas` crate (@sagudev, #38098, #38114, #38164, #38214), which has in turn allowed us to modernise it with **new backends based on [Vello](https://github.com/linebender/vello)** (@EnnuiL, @sagudev, [#30636](https://github.com/servo/servo/issues/30636), [#38345](https://github.com/servo/servo/issues/38345)):

- a Vello GPU-based backend (@sagudev, #36821), currently slower than the default backend; to use it, build Servo with `--features vello` and enable it with `--pref dom_canvas_vello_enabled`

- a Vello CPU-based backend (@sagudev, #38282), **already faster than the default backend**; to use it, build Servo with `--features vello_cpu` and enable it with `--pref dom_canvas_vello_cpu_enabled`

## What is a pixel?

Many recent Servo bugs have been related to our handling of **viewport**, **window**, and **screen coordinate spaces** ([#36817](https://github.com/servo/servo/issues/36817), [#37804](https://github.com/servo/servo/issues/37804), [#37824](https://github.com/servo/servo/issues/37824), [#37878](https://github.com/servo/servo/issues/37878), [#37978](https://github.com/servo/servo/issues/37978), [#38089](https://github.com/servo/servo/issues/38089), [#38090](https://github.com/servo/servo/issues/38090), [#38093](https://github.com/servo/servo/issues/38093), [#38255](https://github.com/servo/servo/issues/38255)).
Symptoms of these bugs include **bad hit testing** (e.g. links that can’t be clicked), **inability to scroll** to the end of the page, or **graphical glitches** like disappearing browser UI or black bars.

Windows rarely take up the whole screen, viewports rarely take up the whole window due to window decorations, and when different units come into play, like CSS `px` vs device pixels, a more systematic approach is needed.
We built [**euclid**](https://docs.rs/euclid/0.22.11/euclid/) to solve these problems in a strongly typed way within Servo, but beyond the viewport, we need to convert between euclid types and the geometry types provided by the embedder, the toolkit, the platform, or WebDriver, which creates opportunities for errors.

Embedders are now the single source of truth for **window rects** and **screen sizes** (@yezhizhen, @mrobinson, #37960, #38020), and we’ve fixed incorrect coordinate handling in [**Get Window Rect**](https://w3c.github.io/webdriver/#get-window-rect), [**Set Window Rect**](https://w3c.github.io/webdriver/#set-window-rect) (@yezhizhen, #37812, #37893, #38209, #38258, #38249), **resizeTo()** (@yezhizhen, #37848), **screenX**, **screenY**, **screenLeft**, **screenTop** (@yezhizhen, #37934), and in **servoshell** (@yezhizhen, #37961, #38174, #38307, #38082).
We’ve also improved the Web Platform Tests (@yezhizhen, #37856) and clarified our docs (@yezhizhen, @mrobinson, #37879, #38110) in these areas.

## Donations

Thanks again for your generous support!
We are now receiving **4691 USD/month** (+5.0% <!-- (+1.3% without thanks.dev) --> over June) in recurring donations.
This helps cover the cost of our [self-hosted](https://ci0.servo.org) [CI](https://ci1.servo.org) [runners](https://ci2.servo.org) and one of our [latest Outreachy interns](https://www.outreachy.org/alums/2025-06/#:~:text=Servo)!

Keep an eye out for [further improvements to our CI system](https://github.com/servo/servo/issues/38141) in the coming months, including [**ten-minute WPT builds**](https://github.com/servo/ci-runners/issues/21) and our new proposal for [**dedicated benchmarking runners**](https://github.com/servo/project/issues/160), all thanks to your support.

Servo is also on [thanks.dev](https://thanks.dev), and already **22 GitHub users** (−3 from June) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 4691 / 10000); padding-left: 0.5em;"><strong>4691</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 4691 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="4691" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
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
