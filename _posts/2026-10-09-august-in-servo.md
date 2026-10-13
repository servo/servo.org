---
layout:     post
tags:       blog
title:      "August in Servo: ???????"
date:       2026-10-09
summary:    who even knows?
categories:
---

[**Servo 0.6.0**](https://github.com/servo/servo/releases/tag/v0.6.0) contains all of the changes we landed in August, which came out to **417 commits**!

The big news is that we've turned on support for **CSS Grid** by default (@nicoburns, #45621).
This has had a huge positive impact on the visual appearance of many websites.

TODO: figure

Another visible change is that **text selection** with the mouse now works!
This is the result of lots of work across our script and layout code to ensure it respects the actual geometry of the page content (@mrobinson, @SimonSapin, #47022, #47025, #47329, #47358, #46982, #47425, #47438, #47437, #47581, #47070, #47048, #47048).

TODO: figure

This release also contains significant improvements to navigation, document loading, and session history, which are some of the [gnarliest](https://html.spec.whatwg.org/multipage/browsing-the-web.html#navigation-and-session-history) parts of the HTML specification.

Session history traversals (i.e. navigating backwards or forwards in history) now wait for any outstanding traversal to complete (@mrobinson, #47293, #47485).
Meanwhile, any navigation to `about:blank` is now skipped if the initial about:blank document is present (@jdm, #47074).

`about:blank` documents no longer use the asynchronous HTML parser (@jdm, #47050), and no longer report a `readyState` of `LOADING` (@mrobinson, #47450).
Opening auxiliary windows will wait to dispatch the load event until the initial `about:blank` document has been replaced (@jdm, @mrobinson, #47442, #46975).

Whoever knew that [loading `about:blank`](https://hsivonen.fi/about-blank/) was [so complicated](https://html.spec.whatwg.org/multipage/document-sequences.html#windows%3Awindow)?

## Security

## Real world compat

Panning gestures initiated by touch inputs now lock to the dominant axis (@yezhizhen, #46983).
This results in more predictable panning when interacting with pages in Servo.

We fixed a crash affecting ([gumroad.com.au](https://gumroad.com.au)) (@lumiscosity, #47266).



## Work in progress

Accessibility support in Servo continues to make great strides; it can be enabled with the `--pref accessibility_enabled` command line argument.
Servo now reports positions and sizes for items in the content accessibility tree (@philocalyst, @alice, @mrobinson, #46996), allowing macOS VoiceOver to work more reliably.
We also report many [ARIA roles](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles) for web content elements to accessibility toolkits (@mukilan, #47318).
<details>
<summary>Full list of supported roles</summary>
<ul>
<li>alert
<li>banner
<li>blockquote
<li>caption
<li>code
<li>complementary
<li>contentinfo
<li>definition
<li>deletion
<li>directory
<li>document
<li>emphasis
<li>feed
<li>figure
<li>generic
<li>insertion
<li>list
<li>log
<li>main
<li>math
<li>navigation
<li>none
<li>note
<li>paragraph
<li>presentation
<li>rowgroup
<li>search
<li>status
<li>strong
<li>term
<li>time
<li>timer
</ul>
</details>

We made a lot of progress on the **`LargestContentfulPaint`** performance metric, implemented behind the `largest_contentful_paint_enabled` preference.
Servo now supports the `element` attribute, (@shubhamg13, #46553), URLs for video element posters (@shubhamg13, #43376), accurate size information (@shubhamg13, #43378), painting text nodes (@shubhamg13, #47212), and a conformant `loadTime` attribute (@shubhamg13, #47475).

There was preparatory work for a future [**AudioWorklet**](https://developer.mozilla.org/en-US/docs/Web/API/AudioWorklet)** implementation (@niyabits, #46856, #47016, #47016, #47199, #47199).
See Niya's [blog post](https://text.tchncs.de/niya/wrapping-up-my-work-on-servos-audioworklet) about her Outreachy project for more details!

We've implemented the **CookieStore** interface behind the `--pref dom_cookiestore_enabled` command line argument (@Taym95, #47044).

## Embedding API

**Breaking change:** [`WebView`](https://doc.servo.org/servo/struct.WebView.html)::`toggle_sampling_profiler` has been removed (@lumiscosity, #47014).
To perform sampling profiling on Servo, follow the instructions in [the book](https://book.servo.org/contributing/profiling.html).

**Breaking change:** The variants of [`MouseButton`](https://doc.servo.org/servo/enum.MouseButton.html) have been renamed to `Primary`, `Secondary`, and `Auxiliary` (@mrobinson, @SimonSapin, #47327).

We've added several new Cargo features reflecting common usage patterns:
* `default_web_features`, to include optional web platform features in the build (e.g. WebXR and WebGPU) (@jschwe, #44032)
* `bundled`, to include required resources in the binary (@jschwe, #44032)
* `brotli-compression-stream`, enabling support for `brotli` content in the `CompressionStream`/`DecompressionStream` web APIs (@Narfinger, @jdm, #47197)
* `webcrypto`, to enable support for the Crypto and WebCrypto web APIs (@Narfinger, #47198)
* `webgl`, to enable support for WebGL (@janeoa, #47200)

## For users and developers

Debug builds on Windows can now complete successfully (@jschwe, #47372).

**servoshell** for **Android** has had many rough edges filed off as part of modernizing it for the Compose UI (@veyndan, #47656, #47491, #47494, #47697, #46955, #47644, #47652, #47276, #47277, #47299, #47439) and converting its implementation to Kotlin (@veyndan, #46926, #46925, #46951, #46965).
Library consumers are no longer responsible for implementing pause and resume support (@veyndan, #47555).

**servoshell** for **OpenHarmony** now supports external keyboards with US keyboard layouts (@jschwe, #47359).

Setting the `device_pixel_ratio_override` preference is no longer ignored on Android and OpenHarmony (@jschwe, #47081).

Building Servo now requires at least **Clang 19** on all platforms (@jschwe, #47421).
Additionally, the `cargo-ohos` tool is now required for building for OpenHarmony (@jschwe, #47334).

## Performance and stability

There were many small changes this month that removed unnecessary allocations (@Narfinger, @jschwe, @yezhizhen, #47264, #47147, #47066, #47249, #47249, #47285, #47307, #47343, #47361, #47395, #47427, #47454, #47474, #47506, #47479, #47530, #47541, #47566, #47509, #47622), as well reduced GC interactions leading to better JS performance (@jdm, @Narfinger, @webbeef, @TimvdLippe, @mrobinson, #47513, #47250, #47158, #47165, #47049, #47251, #47510).

On platforms that memory map font data (such as OpenHarmony and macOS), we can now save time that would otherwise be spent loading font files from disk (@jschwe, #47029).

There were were also a number of improvements in final binary size (@jschwe, @kkoyung, @Narfinger, @jschwe, #47211, #47214, #47210, #46950).

We fixed crashes related to media playback (@calvaris, #46891), the 2d canvas renderer (@yezhizhen, #46915), and resolving fonts variants (@simonwuelker, #47356).

We've continued our long-running effort to use the Rust type system to make Servo's integration with SpiderMonkey safer and more reliable (@jdm, @treetmitterglad, @Narfinger, @Gae24, #47398, #47296, #47051, #47005, #47323, #47297, #47322, #47368, #47446, #47317).

We're also working on statically preventing [a footgun](https://github.com/servo/servo/issues/39139) that can lead to uncollectible GC cycles (@Gae24, #47355, #47650).

Historically, `about:memory` has reported all memory usage by Rust implementations of JS APIs as one undifferentiated `js/malloc-heap` number.
We now break it down by memory usage of nodes in document trees (@pylbrecht, #46931) and interfaces that are not part of the DOM (@jdm, #47531).

We've added an **experimental threadboost** mechanism (@jschwe, @mrobinson, #46843, #47027) that has been observed to improve Speedometer results by **50%** and allow canvas rendering to reach 60 FPS.
This is initially enabled for OpenHarmony, but future expansion to other Linux-based platforms is expected.

We upgraded to SpiderMonkey v153, which brings many new security and crash fixes to Servo's JavaScript engine integration (@sagudev, @Gae24, #47489).

## More on the web platform

We upgraded to [resvg 0.48](https://github.com/linebender/resvg/blob/main/CHANGELOG.md#0480-2026-07-31), fixing **many issues with SVG images** with missing width/height attributes that specified a `viewBox` (@nicoburns, #46937).

Upgrading to [Taffy 0.14](https://github.com/DioxusLabs/taffy/blob/main/CHANGELOG.md#0130) fixed a number of CSS grid-related crashes, support for grid names, better intrinsic sizing, and improved performance (@nicoburns, #47031, #47493).
We also fixed some issues in the Taffy grid integration for more accurate baselines (@nicoburns, #47518).

We also upgraded our `stylo` dependency (@jdm, @nicoburns, @TimvdLippe, #47042, #47256, #47405), giving us:
* accurate incremental layout with **clip-path** changes
* support for the **animation-composition** and **color-scheme** properties

Our media playback is improved; we fixed several issues around HTMLMediaElement.canPlayType so Servo now reports that MP4 content is playable (@jdm, #47612, #47641, #47670).

WebAudio content in Servo can now use the **PeriodicWave** node as well as custom oscillator waveforms (@kevlu93, #47492).

We improved the exception error text for numerous web APIs (@jdm, @eachra-bawn, #46960, #47124, #47168, #47580, #47430, #47127).

We also fixed issues related to many other APIs, including:
* matching other browsers' treatment of **Access-Control-Allow-Headers** (@yezhizhen, #47600)
* WebCrypto **CryptoKey** usage checks (@kkoyung, #47112, #47141, #47178) and key lengths (@kkoyung, #47452, #47453)
* the missing **TextEvent** interface (@moamenhesham0, @mrobinson, #47391)
* determining referrers when navigating (@mrobinson, #47487)
* evaluating javascript: URLs (@mrobinson, #47486)
* choosing navigation targets (@mrobinson, #47516)
* interacting with cross origin `Window` and `Location` object (@mrobinson, #47549)
* adjusting selections in `contenteditable` (@mrobinson, #47393, #47581, #47581)
* many edge cases around determining dirty roots for incremental layout (@mrobinson, #46906)
* resolving ties in web font matching (@simonwuelker, #47449)
* implement support for the `full-width`, `math-auto`, and `full-size-kana` values for **text-transform** (@SimonSapin, #47160, #47160, #47225), and improved `capitlize` (@mrobinson, #46910)
* Range.**getClientBoundingRect()**/**getClientRects**() for empty ranges (@yezhizhen, #47143)
* the **Get Element Tag Name** WebDriver command (@yezhizhen, #47216)
* supporting the **touch-action** CSS property (@yezhizhen, #47043)



## New contributors

A special thanks to the following people for landing their first patch in Servo:

TODO

Interested in helping build a web browser?
Take a look at our [curated list](https://starters.servo.org) of issues that are good for new contributors!

## Donations

Thanks again for your generous support!
We are now receiving **8128 USD/month** (+3% from July) in recurring donations.
This helps us cover the cost of our **[speedy](https://ci0.servo.org) [CI](https://ci1.servo.org) [and](https://ci2.servo.org) [benchmarking](https://ci3.servo.org) [servers](https://ci4.servo.org)**, one of our latest **[Outreachy interns](https://www.outreachy.org/alums/2026-05/#:~:text=Servo)**, and funding **[maintainer work]({{ '/blog/2026/09/15/one-year-of-sponsorship/' | url }})** that helps more people contribute to Servo.

Servo is also on [thanks.dev](https://thanks.dev), and already **36 GitHub users** (+1 from July) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

We now have [**sponsorship tiers**]({{ '/blog/2025/11/21/sponsorship-tiers/' | url }}) that allow you or your organisation to donate to the Servo project with public acknowlegement of your support.
If you’re interested in this kind of sponsorship, please contact us at [join@servo.org](mailto:join@servo.org).

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; right: calc(100% - 100% * 7824 / 10000); padding-right: 0.5em;"><strong>8128</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 7824 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="7824" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

Use of donations is decided transparently via the Technical Steering Committee’s public **[funding request process](https://github.com/servo/project/blob/main/FUNDING_REQUEST.md)**, and active proposals are tracked in [servo/project#187](https://github.com/servo/project/issues/187).
For more details, head to our [Sponsorship page]({{ '/sponsorship/' | url }}).

<style>
    kbd {
        background: #00000020;
        margin: 0 0.125rem;
        padding: 0.125rem;
        border-radius: 0.25rem;
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
