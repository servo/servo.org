---
layout:     post
tags:       blog
title:      "This month in Servo: new webview API, relative colors, canvas buffs, and more!"
date:       2025-02-19
summary:    Servo is becoming truly embeddable this year.
categories:
---

Servo now supports several new web API features:

- **:host selector** ([@simonwuelker](https://github.com/simonwuelker), [#34870](https://github.com/servo/servo/pull/34870))
- **&lt;slot> elements** in the DOM ([@simonwuelker](https://github.com/simonwuelker), [#35013](https://github.com/servo/servo/pull/35013), [#35177](https://github.com/servo/servo/pull/35177), [#35191](https://github.com/servo/servo/pull/35191), [#35221](https://github.com/servo/servo/pull/35221), [#35137](https://github.com/servo/servo/pull/35137), [#35222](https://github.com/servo/servo/pull/35222)), with layout support landing next month
- **Relative CSS colors**, like **color(from …)** and **rgb(from …)** ([@Loirooriol](https://github.com/Loirooriol), [#34897](https://github.com/servo/servo/pull/34897))
- **ClipboardEvent** ([@Gae24](https://github.com/Gae24), [#33576](https://github.com/servo/servo/pull/33576), [#35146](https://github.com/servo/servo/pull/35146)), with `--pref dom_clipboardevent_enabled`
- Detecting WGSL extensions via **WGSLLanguageFeatures** ([@sagudev](https://github.com/sagudev), [#34928](https://github.com/servo/servo/pull/34928))
- **pointer_composite_access** WGSL extension ([@sagudev](https://github.com/sagudev), [#35161](https://github.com/servo/servo/pull/35161))
- **blitFramebuffer()** on **WebGL2RenderingContext** ([@jdm](https://github.com/jdm), Istvan, [#26389](https://github.com/servo/servo/pull/26389))
- **media** property on **HTMLStyleElement** ([@webbeef](https://github.com/webbeef), [#35148](https://github.com/servo/servo/pull/35148))

We’ve landed a bunch of **HTMLCanvasElement** improvements:

- **toDataURL()** now supports **image/jpeg** and **image/webp** ([@webbeef](https://github.com/webbeef), [#34861](https://github.com/servo/servo/pull/34861))
- **toBlob()** is now supported ([@webbeef](https://github.com/webbeef), [#34938](https://github.com/servo/servo/pull/34938))
- **transferControlToOffscreen()** is now supported ([@webbeef](https://github.com/webbeef), [#34959](https://github.com/servo/servo/pull/34959))

<figure style="display: flex; justify-content: center;">
  <a href="{{ '/img/blog/january-2025.png' | url }}"><img src="{{ '/img/blog/january-2025.png' | url }}"
    alt="servoshell in dark mode, rendering the MDN article for ‘prefers-color-scheme’ in dark mode, when Windows is set to dark mode"></a>
</figure>

**Streams** are a lot more useful now, with **ReadableStreamBYOBReader** now supporting **read()** ([@Taym95](https://github.com/Taym95), [#35040](https://github.com/servo/servo/pull/35040)), **cancel()**, **close()**, and **releaseLock()** ([@Taym95](https://github.com/Taym95), [#34958](https://github.com/servo/servo/pull/34958)).

Servo now **passes [40.6%](https://wpt.servo.org)** (+7.5pp) of enabled **Shadow DOM** tests, thanks to our landing support for the **:host selector** ([@simonwuelker](https://github.com/simonwuelker), [#34870](https://github.com/servo/servo/pull/34870)) and the **&lt;slot> element** ([@simonwuelker](https://github.com/simonwuelker), [#35013](https://github.com/servo/servo/pull/35013), [#35177](https://github.com/servo/servo/pull/35177), [#35191](https://github.com/servo/servo/pull/35191), [#35221](https://github.com/servo/servo/pull/35221), [#35137](https://github.com/servo/servo/pull/35137), [#35222](https://github.com/servo/servo/pull/35222)), plus improvements to event handling ([@simonwuelker](https://github.com/simonwuelker), [#34788](https://github.com/servo/servo/pull/34788), [#34884](https://github.com/servo/servo/pull/34884)), script ([@willypuzzle](https://github.com/willypuzzle), [#34787](https://github.com/servo/servo/pull/34787)), style ([@simonwuelker](https://github.com/simonwuelker), [@jdm](https://github.com/jdm), [#35198](https://github.com/servo/servo/pull/35198), [#35132](https://github.com/servo/servo/pull/35132)), and the DOM tree ([@simonwuelker](https://github.com/simonwuelker), [@Taym95](https://github.com/Taym95), [#34803](https://github.com/servo/servo/pull/34803), [#34834](https://github.com/servo/servo/pull/34834), [#34863](https://github.com/servo/servo/pull/34863), [#34909](https://github.com/servo/servo/pull/34909), [#35076](https://github.com/servo/servo/pull/35076)).

**Table layout** is significantly better now, particularly in ‘table-layout: fixed’ ([@Loirooriol](https://github.com/Loirooriol), [#35170](https://github.com/servo/servo/pull/35170)), table sizing ([@Loirooriol](https://github.com/Loirooriol), [@mrobinson](https://github.com/mrobinson), [#34889](https://github.com/servo/servo/pull/34889), [#34947](https://github.com/servo/servo/pull/34947), [#35167](https://github.com/servo/servo/pull/35167)), rowspan sizing ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#35095](https://github.com/servo/servo/pull/35095)), interaction with floats ([@Loirooriol](https://github.com/Loirooriol), [#35207](https://github.com/servo/servo/pull/35207)), and ‘border-collapse’ layout ([@Loirooriol](https://github.com/Loirooriol), [#34932](https://github.com/servo/servo/pull/34932), [#34908](https://github.com/servo/servo/pull/34908), [#35097](https://github.com/servo/servo/pull/35097), [#35122](https://github.com/servo/servo/pull/35122), [#35165](https://github.com/servo/servo/pull/35165)) and painting ([@Loirooriol](https://github.com/Loirooriol), [#34933](https://github.com/servo/servo/pull/34933), [#35003](https://github.com/servo/servo/pull/35003), [#35100](https://github.com/servo/servo/pull/35100), [#35075](https://github.com/servo/servo/pull/35075), [#35129](https://github.com/servo/servo/pull/35129), [#35163](https://github.com/servo/servo/pull/35163)).

As a result, Servo now **passes [90.2%](https://wpt.servo.org)** (+11.5pp) of enabled **CSS tables** tests, and of the tests that are in CSS 2, we now [**pass more than Blink and WebKit!**](https://wpt.fyi/results/css/CSS2/tables?sha=d46d9abdea&max-count=1&to=2025-02-01T00%3A00%3A00.000Z&product=servo&product=chrome&product=safari&product=firefox)
We literally stood on the shoulders of giants here, because this would not have been possible without [Blink’s](https://github.com/servo/servo/blob/3122de08f3571a4026e825dd3ef6412cb37abfae/components/layout_2020/table/mod.rs#L8-L11) [robust](https://github.com/servo/servo/blob/3122de08f3571a4026e825dd3ef6412cb37abfae/components/layout_2020/table/layout.rs#L650-L654) [table](https://github.com/servo/servo/blob/3122de08f3571a4026e825dd3ef6412cb37abfae/components/layout_2020/table/layout.rs#L1246-L1248) [impl](https://github.com/servo/servo/blob/3122de08f3571a4026e825dd3ef6412cb37abfae/components/layout_2020/table/layout.rs#L1332-L1333).
Despite their age, [tables](https://github.com/w3c/csswg-drafts/issues/9781) [are](https://github.com/w3c/csswg-drafts/issues/9916) [surprisingly](https://github.com/w3c/csswg-drafts/issues/10132) [underspecified](https://github.com/w3c/csswg-drafts/issues/10133), [so](https://github.com/w3c/csswg-drafts/issues/10881) [we](https://github.com/w3c/csswg-drafts/issues/10885) [also](https://github.com/w3c/csswg-drafts/issues/10937) [needed](https://github.com/w3c/csswg-drafts/issues/11171) [to](https://github.com/w3c/csswg-drafts/issues/11404) [report](https://github.com/w3c/csswg-drafts/issues/11408) [several](https://github.com/w3c/csswg-drafts/issues/11419) [spec](https://github.com/w3c/csswg-drafts/issues/11489) [issues](https://github.com/w3c/csswg-drafts/issues/11504) [along](https://github.com/w3c/csswg-drafts/issues/11515) [the](https://github.com/w3c/csswg-drafts/issues/11568) [way](https://github.com/w3c/csswg-drafts/issues/11570) ([@Loirooriol](https://github.com/Loirooriol)).

## Embedding

Servo aims to be an embeddable web engine, but so far it’s been a lot harder to embed Servo than it should be.

For one, configuring and starting Servo is complicated.
We found that getting Servo running at all, even without wiring up input or handling resizes correctly, took **over 200 lines** of Rust code ([@delan](https://github.com/delan), [@mrobinson](https://github.com/mrobinson), [#35118](https://github.com/servo/servo/pull/35118)).
Embedders (apps) could only control Servo by sending and receiving a variety of “messages” and “events”, and simple questions like “what’s the current URL?” were impossible to answer without keeping track of extra state in the app.

Contrast this with [WebKitGTK](https://webkitgtk.org/), where you can write a minimal kiosk app with a fully-functional webview in **under 50 lines** of C.
To close that gap, we’ve started **reworking our embedding API** towards something more idiomatic and ergonomic, starting with the concept embedders care about most: the *webview*.

Our new webview API is controlled by calling methods on a **[WebView](https://doc.servo.org/servo/struct.WebView.html) handle** ([@delan](https://github.com/delan), [@mrobinson](https://github.com/mrobinson), [#35119](https://github.com/servo/servo/pull/35119), [#35183](https://github.com/servo/servo/pull/35183), [#35192](https://github.com/servo/servo/pull/35192)), including navigation and user input.
Handles will eventually represent the lifecycle of the webview itself; if you have one, the webview is valid, and if you drop them, the webview is destroyed.

Servo needs to call into the embedder too, and here we’ve started replacing the old EmbedderMsg API with a **webview delegate** ([@delan](https://github.com/delan), [@mrobinson](https://github.com/mrobinson), [#35211](https://github.com/servo/servo/pull/35211)), much like the delegates in [Apple’s WebKit API](https://developer.apple.com/documentation/webkit/wkuidelegate?language=objc).
In Rust, a delegate is a `trait` that the embedder can install its own `impl` for.
Stay tuned for more on this next month!

Embedders can now **intercept any request**, not just navigation ([@zhuhaichao518](https://github.com/zhuhaichao518), [#34961](https://github.com/servo/servo/pull/34961)), and you can now identify the webview that caused an **HTTP credentials prompt** ([@pewsheen](https://github.com/pewsheen), [@mrobinson](https://github.com/mrobinson), [#34808](https://github.com/servo/servo/pull/34808)).

Other embedding improvements include:

- Adding a trait to allow for alternative rendering contexts that are better suited to certain applications ([@dklassic](https://github.com/dklassic), [@wusyong](https://github.com/wusyong), [#35052](https://github.com/servo/servo/pull/35052), [#34813](https://github.com/servo/servo/pull/34813), [#34780](https://github.com/servo/servo/pull/34780))
- Simplifying types used by consumers of libservo ([@delan](https://github.com/delan), [@mrobinson](https://github.com/mrobinson), [#35156](https://github.com/servo/servo/pull/35156))
- Making it easier to build Servo without crown ([@jdm](https://github.com/jdm), [#35055](https://github.com/servo/servo/pull/35055))

## Other changes

We’ve reworked Servo’s **preferences system**, making all prefs optional with reasonable defaults ([@mrobinson](https://github.com/mrobinson), [#34966](https://github.com/servo/servo/pull/34966), [#34999](https://github.com/servo/servo/pull/34999), [#34994](https://github.com/servo/servo/pull/34994)).
As a result:

- **The names of all preferences have changed**; see the [Prefs docs](https://doc.servo.org/servo_config/prefs/struct.Preferences.html) for a list
- **Embedders no longer need a `prefs.json`** resource to get Servo running
- Some debug options were converted to preferences ([@mrobinson](https://github.com/mrobinson), [#34998](https://github.com/servo/servo/pull/34998))

Devtools now **highlights console.log() arguments** according to their types ([@simonwuelker](https://github.com/simonwuelker), [#34810](https://github.com/servo/servo/pull/34810)).

Servo’s networking is more efficient now, with the ability to **cancel fetches for navigation** that contain redirects ([@mrobinson](https://github.com/mrobinson), [#34919](https://github.com/servo/servo/pull/34919)) and **cancel fetches for &lt;video> and &lt;media>** when the document is unloaded ([@mrobinson](https://github.com/mrobinson), [#34883](https://github.com/servo/servo/pull/34883)).
Those changes also **eliminate per-request IPC channels** for navigation and cancellation respectively, and in the same vein, we’ve eliminated them for image loading too ([@mrobinson](https://github.com/mrobinson), [#35041](https://github.com/servo/servo/pull/35041)).

We’ve continued **splitting up our massive script crate** ([@jdm](https://github.com/jdm), [#34359](https://github.com/servo/servo/pull/34359), [#35157](https://github.com/servo/servo/pull/35157), [#35169](https://github.com/servo/servo/pull/35169), [#35172](https://github.com/servo/servo/pull/35172)), which will eventually make Servo much faster to build.

A few crashes have been fixed, including when exiting Servo ([@mukilan](https://github.com/mukilan), [#34917](https://github.com/servo/servo/pull/34917)), when using the [internal memory profiler](https://book.servo.org/hacking/profiling.html#memory-profiling) ([@jdm](https://github.com/jdm), [#35058](https://github.com/servo/servo/pull/35058)), and when running ResizeObserver callbacks ([@willypuzzle](https://github.com/willypuzzle), [#35168](https://github.com/servo/servo/pull/35168)).

## For developers

We now run **CI smoketests on OpenHarmony** using a real device ([@jschwe](https://github.com/jschwe), [@mukilan](https://github.com/mukilan), [#35006](https://github.com/servo/servo/pull/35006)), increasing confidence in your changes beyond compile-time errors.

We’ve also tripled our **self-hosted CI runner capacity** ([@delan](https://github.com/delan), [#34983](https://github.com/servo/servo/pull/34983), [#35002](https://github.com/servo/servo/pull/35002)), making concurrent Windows and macOS builds possible without falling back to the much slower GitHub-hosted runners.

Servo can’t yet run WebDriver-based tests on [wpt.fyi](https://wpt.fyi), [wpt.servo.org](https://wpt.servo.org), or CI, because the `servo` executor for the [Web Platform Tests](https://web-platform-tests.org) does not support testdriver.js.
`servodriver` does, though, so we’ve started fixing test regressions with that executor with the goal of eventually switching to it ([@jdm](https://github.com/jdm), [#34957](https://github.com/servo/servo/pull/34957), [#34997](https://github.com/servo/servo/pull/34997)).

## Donations

Thanks again for your generous support!
We are now receiving **3835 USD/month** (−11.4% over December) in recurring donations.
With this money, we’ve been able to expand our capacity for [self-hosted](https://ci0.servo.org) [CI](https://ci1.servo.org) [runners](https://ci2.servo.org) on Windows, Linux, and macOS builds, **halving `mach try` build times** from over an hour to under 30 minutes!

Servo is also on [thanks.dev](https://thanks.dev), and already **21 GitHub users** (+5 over December) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 3835 / 10000); padding-left: 0.5em;"><strong>3835</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 3835 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="3835" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

As always, use of these funds will be decided transparently in the Technical Steering Committee.
For more details, head to our [Sponsorship page]({{ '/sponsorship/' | url }}).

## Conference talks

- [**Why Build a New Browser Engine in Rust?**](https://www.youtube.com/watch?v=s0MIHKv45C0) ([slides](https://servo.org/slides/2025-01-21-barcelona-free-software/)) — [Martin Robinson](https://abandonedwig.info) spoke about Servo’s unique benefits as a Rust-based browser and web engine, and how browser diversity can create a new renaissance for the web platform

<style>
    .content {
        container-type: inline-size;
    }
    ._paired_figure {
        margin: 1em 0;
    }
    @container (min-width: 55em) {
        ._paired_figure {
            display: grid;
            grid-template-columns: auto 33em;
            column-gap: 2em;
            row-gap: 1em;
        }
        ._paired_figure > ._text_before,
        ._paired_figure > ._text_after {
            flex: 1 1 20em;
            grid-column: 1 / 2;
        }
        ._paired_figure > figure:not(#specificity) {
            flex: 0 1 33em;
            grid-row: 1 / 3;
            grid-column: 2 / 3;
            margin: 0;
        }
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
