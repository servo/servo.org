---
layout:     post
tags:       blog
title:      "September in Servo: who knows?"
date:       2026-10-26
summary:    ????
categories:
---

<style>
code {
  white-space: nowrap;
}
</style>

[**Servo 0.7.0**](https://github.com/servo/servo/releases/tag/v0.7.0) contains all of the changes we landed in August, which came out to a new record of **566 commits**!

The developer tools console now **eagerly evaluates** JS inputs, allowing faster feedback (@freyacodes, #47527).

We've shipped new web platform features:

Plus a bunch of new DOM APIs:
* **parentRule** on **CSSRule** and **CSSStyleDeclaration** (@skyz1, #47743)
* **version** on **HTMLHtmlElement** (@SilvioPilato, #47786)
* **getComposedRanges()** and **direction** on **Selection** (@mrobinson, #47683)
* **baseURL** on **CSSStyleSheet** (@Gae24, #47783)
* [**CSS modules**](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules#loading_non-javascript_resources)(@Gae24, #47813) and **text modules** (@Gae24, #47863)
* **getContextAttributes()** on **CanvasRenderingContext2D** and **OffscreenCanvasRenderingContext2D** (@Taym95, #47868)
* the **Content-Language** header (@TimvdLippe, #47930)
* **dir** on **Document** (@yezhizhen, #48170)
* **SVGAElement**, **SVGPatternElement**, **SVGTSpanElement**, **SVGTextContentElement**, **SVGTextElement**, **SVGTextPositioningElement** (@mu-mostafa98, #48174)
* the **MLKEM768-X25519** algorithm for **WebCrypto** (@kkoyung, #48240, #48282, #48313, #48350)


## Security

We upgraded to **SpiderMonkey v153.3** and **mozangle v0.7**, both of which included fixes for security bugs reported upstream (@sagudev, #48176, #47655, #48259).

## Real world compat

We’re interested to hear how well your favourite websites run in Servo! Report successes in [this Zulip thread](https://servo.zulipchat.com/#narrow/channel/263398-general/topic/Servo.20web.20compat.20success.20stories/with/612898341) or [this Github discussion](https://github.com/servo/servo/discussions/49037), and failures [in our GitHub issues](https://github.com/servo/servo/issues).

## Work in progress

Our accessibility tree (`--pref accessibility_enabled`) now **reports geometry bounds** for inline elements (@alice, #47905) and does much less work when responding to DOM changes (@alice, @mrobinson, #47690).
Additionally, elements with `display: none` are reported as hidden (@alice, #47772).

We had lots of conformance improvements for our **WebGL2 implementation** (`--pref dom_webgl2_enabled`) (@mxmgorin, #48423, #48441, #48470, #48479, #48495, #48473, #48536).

## Embedding API

There's a new API for integrating with accessibility tools: [`Servo`](https://doc.servo.org/servo/struct.Servo.html)::[`forward_accessibility_action`](https://doc.servo.org/servo/struct.Servo.html#method.forward_accessibility_action).

## For users and developers

It is now possible to cross-compile the OpenHarmony build from Windows hosts (@jschwe, #48392).

## Performance and stability

We improved performance by removing **unnecessary allocations** (@Narfinger, @TimvdLippe, @yezhizhen, #47689, #47839, #47838, #47982, #48006, #48036, #48099, #48204, #48127, #48218, #48357, #48386, #48422, #48440, #48452, #48508), **preallocating more** when building vectors (@jschwe, @Narfinger, @sagudev, @webbeef, #47455, #47613, #48026, #48398), and **avoiding IPC** in single process mode (@leowatts, @Narfinger, @Uiniel, @TTyChud, #47691, #47718, #48002, #48073, #48476, #48435).

We also sped up Servo by reducing interactions with the GC (@TimvdLippe, @Narfinger, #47818, #48257) and doing less work when modifying selections (@SimonSapin, #47579), dispatching events (@webbeef, #48078), calculating font metrics (@RichardTjokroutomo, #48238), and indexing window frames (@mrobinson, #47832).

We **reduced memory usage** in common cases by reusing buffers (@Narfinger, #47751), clearing more page-specific data (@Radeonares32, @Narfinger, @jschwe, @mrobinson, @mxmgorin, #47651, #47806, #47805, #48166, #48295, #48297, #48016), compacting data structures (@Narfinger, @webbeef, @SimonSapin, @mrobinson, #47776, #48039, #48050, #47742, #48301, #48296, #48105), and sharing more buffers (@jdm, #47998).

We turned on **thread affinity boosting** on Linux, which can improve performance on some CPU architectures (@jschwe, #47058).

We're working on statically preventing [a footgun](https://github.com/servo/servo/issues/39139) that can lead to uncollectible GC cycles and leaking memory (@Gae24, @jdm, @lumiscosity, @SilvioPilato, @sahilnyk, @TTyChud, @kuntal-devrat, @MohamedAli00949, #47941, #48013, #48021, #48035, #48033, #48051, #48072, #48171, #48209, #48248, #48246, #48264, #48285, #48311, #48408, #48053, #48156, #48186, #48223, #48315, #47872, #47698, #47682, #47735, #47816, #47817, #47794, #47909, #47934, #47935, #47954, #48022, #47955, #48058, #48228, #48247, #48261, #48280, #48302, #48316, #48328, #48346, #48355, #48262, #48377, #48304, #48378).

## More on the web platform


## New contributors

A special thanks to the following people for landing their first patch in Servo:

Interested in helping build a web browser?
Take a look at our [curated list](https://starters.servo.org) of issues that are good for new contributors!

## Donations

Thanks again for your generous support!
We are now receiving **8144 USD/month** (+1% from August) in recurring donations.
This helps us cover the cost of our **[speedy](https://ci0.servo.org) [CI](https://ci1.servo.org) [and](https://ci2.servo.org) [benchmarking](https://ci3.servo.org) [servers](https://ci4.servo.org)**, one of our latest **[Outreachy interns](https://www.outreachy.org/alums/2026-05/#:~:text=Servo)**, and funding **[maintainer work]({{ '/blog/2026/09/15/one-year-of-sponsorship/' | url }})** that helps more people contribute to Servo.

Servo is also on [thanks.dev](https://thanks.dev), and already **37 GitHub users** (+1 from August) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

We now have [**sponsorship tiers**]({{ '/blog/2025/11/21/sponsorship-tiers/' | url }}) that allow you or your organisation to donate to the Servo project with public acknowlegement of your support.
If you’re interested in this kind of sponsorship, please contact us at [join@servo.org](mailto:join@servo.org).

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; right: calc(100% - 100% * 8144 / 10000); padding-right: 0.5em;"><strong>8128</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 8144 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
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
