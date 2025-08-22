---
layout:     post
tags:       blog
title:      "This month in Servo: new image formats, canvas backends, automation, and more!"
date:       2025-08-22
summary:    Another record month, plus devtools improvements and creature comforts for servoshell users.
categories:
---

Servo has smashed its record again in July, with **367 pull requests** landing in our nightly builds!
This includes several new web platform features:

- **APNG** and **WebP animated images**, in addition to GIF ([@rayguo17](https://github.com/rayguo17), [#37637](https://github.com/servo/servo/pull/37637))
- **&lt;source width>** and **&lt;source height>** ([@leo030303](https://github.com/leo030303), [@xiaochengh](https://github.com/xiaochengh), [#38152](https://github.com/servo/servo/pull/38152))
- **‘image-rendering’ property** now affects **‘border-image’** ([@lumiscosity](https://github.com/lumiscosity), [@Loirooriol](https://github.com/Loirooriol), [#38346](https://github.com/servo/servo/pull/38346))
- **TextDecoderStream** ([@minghuaw](https://github.com/minghuaw), [#38112](https://github.com/servo/servo/pull/38112))
- **replace() method** on **CSSStyleSheet** ([@stevennovaryo](https://github.com/stevennovaryo), [#38244](https://github.com/servo/servo/pull/38244))
- **texImage3D() method** on **WebGL2RenderingContext** ([@wusyong](https://github.com/wusyong), [#37718](https://github.com/servo/servo/pull/37718))
- **convertToBlob()** and **transferToImageBitmap() methods** on **OffscreenCanvas** ([@tharkum](https://github.com/tharkum), [#37786](https://github.com/servo/servo/pull/37786), [#37880](https://github.com/servo/servo/pull/37880))
- **adoptedStyleSheets property** on **Document** and **ShadowRoot**, with `--pref dom_adoptedstylesheet_enabled` ([@stevennovaryo](https://github.com/stevennovaryo), [#38163](https://github.com/servo/servo/pull/38163))
- **ImageBitmap** no longer requires `--enable-experimental-web-platform-features` ([@tharkum](https://github.com/tharkum), [#38050](https://github.com/servo/servo/pull/38050))

Notable changes for Servo library consumers:

- **Stylo 0.6.0** was released, **fixing build errors** caused by an undeclared dependency on `markupsafe` ([@nicoburns](https://github.com/nicoburns), [@delan](https://github.com/delan), [stylo#215](https://github.com/servo/stylo/pull/215), [stylo#218](https://github.com/servo/stylo/issues/218)).
To work around this in Stylo 0.5.0, install the dependency: `pip install markupsafe`

- [**notify_scroll_event()** on WebView](https://doc.servo.org/servo/struct.WebView.html#method.notify_scroll_event) now **scrolls down as the `y` value increases** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#37752](https://github.com/servo/servo/pull/37752)), consistent with the web platform.
This is a **breaking change to the Servo API**.

<figure>
  <details style="position:relative">
    <img src="{{ '/img/blog/2025-08-diffies.webp' | url }}" style="position:absolute;margin:0;inset:0;pointer-events:none" loading="lazy" alt="servoshell nightly showing the same things, but animated">
    <summary style="display:block"><img src="{{ '/img/blog/2025-08-diffies.jpg' | url }}" style="margin:0" loading="lazy"><div style="position:absolute;inset:0;display:flex;justify-content:center;align-items:center;color:#1192e8;font-size:7em;cursor:pointer;-webkit-text-stroke:1rem color-mix(in oklch,#1192e8,black 20%);user-select:none" alt="servoshell nightly showing APNG and WebP animated images, ‘image-rendering’ applying to a ‘border-image’, a WebGL 2 example using texImage3D(), ‘text-decoration’ applying to a link with spaces, and an example of adoptedStyleSheets being controlled by a color input">▶</div></summary>
  </details>
</figure>

## Engine changes

Like many browsers, Servo has two kinds of zoom: **page zoom** affects the size of the viewport, while **pinch zoom** does not ([@shubhamg13](https://github.com/shubhamg13), [#38194](https://github.com/servo/servo/pull/38194)).
**Page zoom** now correctly triggers reflow ([@mrobinson](https://github.com/mrobinson), [#38166](https://github.com/servo/servo/pull/38166)), and **pinch zoom** is now reset to the viewport meta config when navigating ([@shubhamg13](https://github.com/shubhamg13), [#37315](https://github.com/servo/servo/pull/37315)).

**‘text-decoration[-line]’ now applies to whitespace** ([@leo030303](https://github.com/leo030303), [@Loirooriol](https://github.com/Loirooriol), [#38007](https://github.com/servo/servo/pull/38007)), and we’ve also fixed several layout bugs around **grid item contents** ([@Loirooriol](https://github.com/Loirooriol), [#37981](https://github.com/servo/servo/pull/37981)), **table cell contents** ([@Loirooriol](https://github.com/Loirooriol), [#38290](https://github.com/servo/servo/pull/38290)), **quirks mode** ([@Loirooriol](https://github.com/Loirooriol), [#37814](https://github.com/servo/servo/pull/37814), [#37831](https://github.com/servo/servo/pull/37831), [#37820](https://github.com/servo/servo/pull/37820), [#37837](https://github.com/servo/servo/pull/37837)), **clientWidth** and **clientHeight** queries of grid layouts ([@Loirooriol](https://github.com/Loirooriol), [#37917](https://github.com/servo/servo/pull/37917)), and **‘min-height’** and **‘max-height’** of replaced elements ([@Loirooriol](https://github.com/Loirooriol), [#37758](https://github.com/servo/servo/pull/37758)).

As part of our **incremental layout** project, we now **cache the layout results** of replaced boxes ([@Loirooriol](https://github.com/Loirooriol), [#37971](https://github.com/servo/servo/pull/37971), [#37897](https://github.com/servo/servo/pull/37897), [#37962](https://github.com/servo/servo/pull/37962), [#37943](https://github.com/servo/servo/pull/37943), [#37985](https://github.com/servo/servo/pull/37985), [#38349](https://github.com/servo/servo/pull/38349)), **avoid unnecessary reflows** after animations ([@coding-joedow](https://github.com/coding-joedow), [#37954](https://github.com/servo/servo/pull/37954)), **invalidate layouts more precisely** ([@coding-joedow](https://github.com/coding-joedow), [#38199](https://github.com/servo/servo/pull/38199), [#38057](https://github.com/servo/servo/pull/38057), [#38198](https://github.com/servo/servo/pull/38198), [#38059](https://github.com/servo/servo/pull/38059)), and we’ve added **incremental box tree construction** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [@coding-joedow](https://github.com/coding-joedow), [#37751](https://github.com/servo/servo/pull/37751), [#37957](https://github.com/servo/servo/pull/37957)) for flex and grid items ([@coding-joedow](https://github.com/coding-joedow), [#37854](https://github.com/servo/servo/pull/37854)), table columns, cells, and captions ([@Loirooriol](https://github.com/Loirooriol), [@mrobinson](https://github.com/mrobinson), [#37851](https://github.com/servo/servo/pull/37851), [#37850](https://github.com/servo/servo/pull/37850), [#37849](https://github.com/servo/servo/pull/37849)), and a variety of inline elements ([@coding-joedow](https://github.com/coding-joedow), [#38084](https://github.com/servo/servo/pull/38084), [#37866](https://github.com/servo/servo/pull/37866), [#37868](https://github.com/servo/servo/pull/37868), [#37892](https://github.com/servo/servo/pull/37892)).

Work on **IndexedDB** continues, notably including support for **key ranges** ([@arihant2math](https://github.com/arihant2math), [@jdm](https://github.com/jdm), [#38268](https://github.com/servo/servo/pull/38268), [#37684](https://github.com/servo/servo/pull/37684), [#38278](https://github.com/servo/servo/pull/38278)).

**sessionStorage** is now isolated between webviews, and copied to new webviews with the same `opener` ([@janvarga](https://github.com/janvarga), [#37803](https://github.com/servo/servo/pull/37803)).

## Browser changes

**servoshell** now has a **.desktop file** and **window name**, so you can now **pin it to your taskbar** on Linux ([@MichaelMcDonnell](https://github.com/MichaelMcDonnell), [#38038](https://github.com/servo/servo/pull/38038)).
We’ve made it more ergonomic too, fixing both the sluggish **mouse wheel** and **pixel-perfect trackpad scrolling** and the too fast **arrow key scrolling** ([@yezhizhen](https://github.com/yezhizhen), [#37982](https://github.com/servo/servo/pull/37982)).

You can now **focus the location bar with Alt+`D`** in addition to Ctrl+`L` on non-macOS platforms ([@MichaelMcDonnell](https://github.com/MichaelMcDonnell), [#37794](https://github.com/servo/servo/pull/37794)), and **clicking the location bar** now selects the contents ([@MichaelMcDonnell](https://github.com/MichaelMcDonnell), [#37839](https://github.com/servo/servo/pull/37839)).

When debugging Servo [with the **Firefox devtools**](https://book.servo.org/hacking/using-devtools.html), you can now view requests in the **Network tab** both **after navigating** ([@uthmaniv](https://github.com/uthmaniv), [#37778](https://github.com/servo/servo/pull/37778)) and when **responses are served from cache** ([@uthmaniv](https://github.com/uthmaniv), [#37906](https://github.com/servo/servo/pull/37906)).
We’re also implementing the **Debugger tab** ([@delan](https://github.com/delan), [@atbrakhi](https://github.com/atbrakhi), [#36027](https://github.com/servo/servo/issues/36027)), including several changes to our script system ([@delan](https://github.com/delan), [@atbrakhi](https://github.com/atbrakhi), [#38236](https://github.com/servo/servo/pull/38236), [#38232](https://github.com/servo/servo/pull/38232), [#38265](https://github.com/servo/servo/pull/38265)) and fixing a whole class of bugs where devtools ends up broken ([@atbrakhi](https://github.com/atbrakhi), [@delan](https://github.com/delan), [@simonwuelker](https://github.com/simonwuelker), [@the6p4c](https://github.com/the6p4c), [#37686](https://github.com/servo/servo/pull/37686)).

## WebDriver changes

**WebDriver automation** support now **goes through servoshell**, rather than through libservo internally, ensuring that WebDriver commands are consistently executed in the correct order ([@longvatrong111](https://github.com/longvatrong111), [@PotatoCP](https://github.com/PotatoCP), [@mrobinson](https://github.com/mrobinson), [@yezhizhen](https://github.com/yezhizhen), [#37669](https://github.com/servo/servo/pull/37669), [#37908](https://github.com/servo/servo/pull/37908), [#37663](https://github.com/servo/servo/pull/37663), [#37911](https://github.com/servo/servo/pull/37911), [#38212](https://github.com/servo/servo/pull/38212), [#38314](https://github.com/servo/servo/pull/38314)).
We’ve also fixed race conditions in the **Back**, **Forward** ([@longvatrong111](https://github.com/longvatrong111), [@jdm](https://github.com/jdm), [#37950](https://github.com/servo/servo/pull/37950)), **Element Click** ([@longvatrong111](https://github.com/longvatrong111), [#37935](https://github.com/servo/servo/pull/37935)), **Switch To Window** ([@yezhizhen](https://github.com/yezhizhen), [#38160](https://github.com/servo/servo/pull/38160)), and other commands ([@PotatoCP](https://github.com/PotatoCP), [@longvatrong111](https://github.com/longvatrong111), [#38079](https://github.com/servo/servo/pull/38079), [#38234](https://github.com/servo/servo/pull/38234)).

We’ve added support for the **Dismiss Alert**, **Accept Alert**, **Get Alert Text** ([@longvatrong111](https://github.com/longvatrong111), [#37913](https://github.com/servo/servo/pull/37913)), and **Send Alert Text** commands for [**simple dialogs**](https://html.spec.whatwg.org/multipage/#simple-dialogs) ([@longvatrong111](https://github.com/longvatrong111), [#38140](https://github.com/servo/servo/pull/38140), [#38035](https://github.com/servo/servo/pull/38035), [#38142](https://github.com/servo/servo/pull/38142)), as well as the **Maximize Window** ([@yezhizhen](https://github.com/yezhizhen), [#38271](https://github.com/servo/servo/pull/38271)) and **Element Clear** commands ([@PotatoCP](https://github.com/PotatoCP), [@yezhizhen](https://github.com/yezhizhen), [@jdm](https://github.com/jdm), [#38208](https://github.com/servo/servo/pull/38208)).
[**Find Element** family of commands](https://w3c.github.io/webdriver/#element-retrieval) can now use the **`"xpath"` location strategy** ([@yezhizhen](https://github.com/yezhizhen), [#37783](https://github.com/servo/servo/pull/37783)).
**Get Element Shadow Root** commands can now interact with **closed shadow roots** ([@PotatoCP](https://github.com/PotatoCP), [#37826](https://github.com/servo/servo/pull/37826)).

You can now **run the WebDriver test suite** in CI with `mach try wd` or `mach try webdriver` ([@PotatoCP](https://github.com/PotatoCP), [@sagudev](https://github.com/sagudev), [@yezhizhen](https://github.com/yezhizhen), [#37498](https://github.com/servo/servo/pull/37498), [#37873](https://github.com/servo/servo/pull/37873), [#37712](https://github.com/servo/servo/pull/37712)).

## 2D graphics

**&lt;canvas>** is key to programmable graphics on the web, with Servo supporting WebGPU, WebGL, and 2D canvas contexts.
But the **general-purpose 2D graphics** routines that power Servo’s 2D canvases are potentially useful for a lot more than &lt;canvas>: **font rendering** is bread and butter for Servo, but **SVG rendering** is only minimally supported right now, and **PDF output** is not yet implemented at all.

Those features have one thing in common: they require things that WebRender can’t yet do.
**WebRender** does one thing and does it well: rasterise the layouts of the web, really fast, by [using the GPU as much as possible](https://hacks.mozilla.org/2017/10/the-whole-web-at-maximum-fps-how-webrender-gets-rid-of-jank/).
Font rendering and SVG rendering both involve rasterising arbitrary paths, which currently has to be done outside WebRender, and PDF output is out of scope entirely.

The more code we can share between these tasks, the better we can make that code, and the smaller we can make Servo’s binary sizes ([#38022](https://github.com/servo/servo/issues/38022)).
We’ve started by moving 2D-&lt;canvas>-specific state out of the `canvas` crate ([@sagudev](https://github.com/sagudev), [#38098](https://github.com/servo/servo/pull/38098), [#38114](https://github.com/servo/servo/pull/38114), [#38164](https://github.com/servo/servo/pull/38164), [#38214](https://github.com/servo/servo/pull/38214)), which has in turn allowed us to modernise it with **new backends based on [Vello](https://github.com/linebender/vello)** ([@EnnuiL](https://github.com/EnnuiL), [@sagudev](https://github.com/sagudev), [#30636](https://github.com/servo/servo/issues/30636), [#38345](https://github.com/servo/servo/issues/38345)):

- a Vello GPU-based backend ([@sagudev](https://github.com/sagudev), [#36821](https://github.com/servo/servo/pull/36821)), currently slower than the default backend; to use it, build Servo with `--features vello` and enable it with `--pref dom_canvas_vello_enabled`

- a Vello CPU-based backend ([@sagudev](https://github.com/sagudev), [#38282](https://github.com/servo/servo/pull/38282)), **already faster than the default backend**; to use it, build Servo with `--features vello_cpu` and enable it with `--pref dom_canvas_vello_cpu_enabled`

## What is a pixel?

Many recent Servo bugs have been related to our handling of **viewport**, **window**, and **screen coordinate spaces** ([#36817](https://github.com/servo/servo/issues/36817), [#37804](https://github.com/servo/servo/issues/37804), [#37824](https://github.com/servo/servo/issues/37824), [#37878](https://github.com/servo/servo/issues/37878), [#37978](https://github.com/servo/servo/issues/37978), [#38089](https://github.com/servo/servo/issues/38089), [#38090](https://github.com/servo/servo/issues/38090), [#38093](https://github.com/servo/servo/issues/38093), [#38255](https://github.com/servo/servo/issues/38255)).
Symptoms of these bugs include **bad hit testing** (e.g. links that can’t be clicked), **inability to scroll** to the end of the page, or **graphical glitches** like disappearing browser UI or black bars.

Windows rarely take up the whole screen, viewports rarely take up the whole window due to window decorations, and when different units come into play, like CSS `px` vs device pixels, a more systematic approach is needed.
We built [**euclid**](https://docs.rs/euclid/0.22.11/euclid/) to solve these problems in a strongly typed way within Servo, but beyond the viewport, we need to convert between euclid types and the geometry types provided by the embedder, the toolkit, the platform, or WebDriver, which creates opportunities for errors.

Embedders are now the single source of truth for **window rects** and **screen sizes** ([@yezhizhen](https://github.com/yezhizhen), [@mrobinson](https://github.com/mrobinson), [#37960](https://github.com/servo/servo/pull/37960), [#38020](https://github.com/servo/servo/pull/38020)), and we’ve fixed incorrect coordinate handling in [**Get Window Rect**](https://w3c.github.io/webdriver/#get-window-rect), [**Set Window Rect**](https://w3c.github.io/webdriver/#set-window-rect) ([@yezhizhen](https://github.com/yezhizhen), [#37812](https://github.com/servo/servo/pull/37812), [#37893](https://github.com/servo/servo/pull/37893), [#38209](https://github.com/servo/servo/pull/38209), [#38258](https://github.com/servo/servo/pull/38258), [#38249](https://github.com/servo/servo/pull/38249)), **resizeTo()** ([@yezhizhen](https://github.com/yezhizhen), [#37848](https://github.com/servo/servo/pull/37848)), **screenX**, **screenY**, **screenLeft**, **screenTop** ([@yezhizhen](https://github.com/yezhizhen), [#37934](https://github.com/servo/servo/pull/37934)), and in **servoshell** ([@yezhizhen](https://github.com/yezhizhen), [#37961](https://github.com/servo/servo/pull/37961), [#38174](https://github.com/servo/servo/pull/38174), [#38307](https://github.com/servo/servo/pull/38307), [#38082](https://github.com/servo/servo/pull/38082)).
We’ve also improved the Web Platform Tests ([@yezhizhen](https://github.com/yezhizhen), [#37856](https://github.com/servo/servo/pull/37856)) and clarified our docs ([@yezhizhen](https://github.com/yezhizhen), [@mrobinson](https://github.com/mrobinson), [#37879](https://github.com/servo/servo/pull/37879), [#38110](https://github.com/servo/servo/pull/38110)) in these areas.

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
