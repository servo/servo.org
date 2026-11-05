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

[**Servo 0.7.0**](https://github.com/servo/servo/releases/tag/v0.7.0) contains all of the changes we landed in September, spanning 527 commits!

<figure>
    <a href="{{ '/img/blog/2026-10-gary-banner.png' | url }}"><img src="{{ '/img/blog/2026-10-gary-banner.png' | url }}" alt="a black and white cat named Gary showing off new visual web platform features"></a>
</figure>

The developer tools console now **eagerly evaluates** JS inputs, allowing faster feedback (@freyacodes, #47527).

We've shipped new web platform features:
* the **:checked** pseudoclass (@skyz1, #47987)
* the **user-select** property (@SimonSapin, @mrobinson, #48137, #48242)
* the **&lt;progress>** element (@rayguo17, #46974)
* CSS [typed arithmetic](https://developer.mozilla.org/en-US/docs/Web/CSS/Guides/Values_and_units/Using_typed_arithmetic) (@Loirooriol, #48338)
* the **alpha()** CSS function (@Loirooriol, #48344)
* the **font-width** property (@Loirooriol, #47914)

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
* **roundRect()** on **CanvasRenderingContext2D** (@yezhizhen, #48293)
* **paintTime** and **presentationTime** on **PerformancePaintTiming** (@shubhamg13, #47926)
* **getCueAsHTML()** on **VTTCue** (@TimvdLippe, #48146)

## Security

We upgraded to **SpiderMonkey v153.3** and **mozangle v0.7**, both of which included fixes for security bugs reported upstream (@sagudev, #48176, #47655, #48259).

## Real world compat

The [egui.rs](https://www.egui.rs/) demo now works as expected with `--pref dom._webegpu_enabled`.

<figure>
    <a href="{{ '/img/blog/2026-10-egui.png' | url }}"><img src="{{ '/img/blog/2026-10-egui.png' | url }}" alt="http://egui.rs rendering in Servo"></a>
</figure>

This [Candy Crush](https://jooyouss.github.io/candy-crush/) game is now playable.

<figure>
    <a href="{{ '/img/blog/2026-10-candycrush.png' | url }}"><img src="{{ '/img/blog/2026-10-candycrush.png' | url }}" alt="A Candy Crush game rendering in Servo"></a>
</figure>

We’re interested to hear how well your favourite websites run in Servo! Report successes in [this Zulip thread](https://servo.zulipchat.com/#narrow/channel/263398-general/topic/Servo.20web.20compat.20success.20stories/with/612898341) or [this Github discussion](https://github.com/servo/servo/discussions/49037), and failures [in our GitHub issues](https://github.com/servo/servo/issues).

## Work in progress

Our accessibility tree (`--pref accessibility_enabled`) now **reports geometry bounds** for inline elements (@alice, #47905) and does much less work when responding to DOM changes (@alice, @mrobinson, #47690).
Additionally, elements with `display: none` are reported as hidden (@alice, #47772).

We had lots of conformance improvements for our **WebGL2 implementation** (`--pref dom_webgl2_enabled`) (@mxmgorin, #48423, #48441, #48470, #48479, #48495, #48473, #48536).

Support for WSIWYG editors (which rely heavily on **`contenteditable`**) is going very well: keyboard inputs are now hooked up when `--pref dom_exec_command_enabled` is present, so many editors are now usable ([example](https://www.tiny.cloud/docs/tinymce/latest/basic-example/)).

**Closed captioning** for video elements is making progress.
Text tracks now fire `enter`, `exit`, and `cuechange` events (@TimvdLippe, #47725).
Media elements now return the full sorted list of text tracks (@TimvdLippe, #47785), and adding cues to a text track now sets that track correctly (@TimvdLippe, #48012).
Text track objects now reflect the attributes of the associated `<track>` element.
Text track URLs are fetched at the correct time (@TimvdLippe, #48325), and active cues are computed correctly (@TimvdLippe, #48305), while text track cues are ordered as expected (@TimvdLippe, #48368).
Additionally, WebVTT parsing can now recover from errors (@TimvdLippe, #48391).

The **Sanitizer API** (`--pref dom_sanitizer_enabled`) now accepts the `javascriptURLs` property (@skyz1, #47867).

**IndexedDB** continues to improve: tables no longer error if unrelated tables contain duplicate index names (`--pref dom_indexeddb_enabled`) (@leowatts, #47936).
Additionally, we implemented **openCursor()** and **openKeyCursor()** on **IDBIndex** (@kuntal-devrat, #48281), as well as **advance()**, **continue()**, and **continuePrimaryKey()** on **IDBCursor** (@kuntal-devrat, #48400).

We implemented the **getTimeline()** and **setTimeline()** methods for the **Animation** interface (`--pref dom_web_animations_enabled`) (@simonwuelker, #48122).

## Embedding API

There's a new API for events originating from accessibility tools: [`Servo`](https://doc.servo.org/servo/struct.Servo.html)::[`forward_accessibility_action`](https://doc.servo.org/servo/struct.Servo.html#method.forward_accessibility_action) (@alice, @mrobinson, #48512).

There is also an API to clear session history: [`WebView`](https://doc.servo.org/servo/struct.WebView.html)::[`clear_session_history`](https://doc.servo.org/servo/struct.WebView.html#method.clear_session_history) (@Narfinger, #47483).

The [`WebView`](https://doc.servo.org/servo/struct.WebView.html)::`set_throttled` API has been removed (@mrobinson, #39923).
Throttling automatically occurs when a WebView is [hidden](https://doc.servo.org/servo/struct.WebView.html#method.hide) and is stopped when [shown](https://doc.servo.org/servo/struct.WebView.html#method.show).

The [`WebViewDelegate`](https://doc.servo.org/servo/trait.WebViewDelegate.html)::`notify_focus_changed` method was removed, along with the [`Servo`](https://doc.servo.org/servo/struct.Servo.html) methods `focus` and `blur` (@mrobinson, #48364).
Embedders must call [`WebView`](https://doc.servo.org/servo/struct.WebView.html)::[`set_focused`](https://doc.servo.org/servo/struct.WebView.html#method.set_focused) whenever a WebView has gained or lost system focus.

The `webgl` feature has been added to the `default_web_features` feature (@janeoa, #47866).
If an embedding does not want to ship with WebGL support they will now need to disable default features.

Multiprocess mode is enabled at build time with the new Cargo feature `multprocess` (@Narfinger, #47360).
To remove support for this feature (reducing binary size by ~2MB), build Servo with default features disabled.

Two new preferences exist to tune garbage collector behaviour: `js_mem_gc_malloc_threshold_base_mb` and `js_mem_gc_urgent_threshold_mb` (@mxmgorin, #47999).
These can help on memory-constrained devices, and more information is available in the SpiderMonkey source ([base](https://searchfox.org/firefox-main/rev/28b7a7bffb5f82828143d9ad63839ad263b598be/js/src/gc/Scheduling.h#425-429), [urgent](https://searchfox.org/firefox-main/rev/28b7a7bffb5f82828143d9ad63839ad263b598be/js/src/gc/Scheduling.h#440-445)).

The JVM compatibility target was raised to 11 on Android (@veyndan, #48414).

## For users and developers

It is now possible to cross-compile the OpenHarmony build from Windows hosts (@jschwe, #48392).

Unhandled promise rejections are reported to the JS console (@TTyChud, #48486), making it easier to narrow down web compatibility issues in Servo.

The OpenHarmony SDK was updated to API level 23 (@Narfinger, #48505).

Pressing Control+A (or Command+A on macOS) now selects all the content in a document (@dzfrias, @mrobinson, #48025).
It is no longer possible to copy text inside of password inputs (@dzfrias, #48404).

Embedder-originating JS (e.g. devtools console or embedding APIs) will always execute, even in documents that disable scripting via sandboxing or CSP (@derdilla, #48394).


## Performance and stability

We improved performance by removing **unnecessary allocations** (@Narfinger, @TimvdLippe, @yezhizhen, #47689, #47839, #47838, #47982, #48006, #48036, #48099, #48204, #48127, #48218, #48357, #48386, #48422, #48440, #48452, #48508), **preallocating more** when building vectors (@jschwe, @Narfinger, @sagudev, @webbeef, #47455, #47613, #48026, #48398), and **avoiding IPC** in single process mode (@leowatts, @Narfinger, @Uiniel, @TTyChud, #47691, #47718, #48002, #48073, #48476, #48435).

We also sped up Servo by reducing interactions with the GC (@TimvdLippe, @Narfinger, #47818, #48257, #48396), and doing less work when modifying selections (@SimonSapin, #47579), dispatching events (@webbeef, #48078), calculating font metrics (@RichardTjokroutomo, #48238), and indexing window frames (@mrobinson, #47832).

We **reduced memory usage** in common cases by reusing buffers (@Narfinger, #47751), clearing more page-specific data (@Radeonares32, @Narfinger, @jschwe, @mrobinson, @mxmgorin, #47651, #47806, #47805, #48166, #48295, #48297, #48016), compacting data structures (@Narfinger, @webbeef, @SimonSapin, @mrobinson, #47776, #48039, #48050, #47742, #48301, #48296, #48105), and sharing more buffers (@jdm, #47998).
We also fixed a memory leak involving `<audio>` and `<video>` elements (@TTyChud, #48371).

We turned on **thread affinity boosting** on Linux, which can improve performance on some CPU architectures (@jschwe, #47058).

We're working on statically preventing [a footgun](https://github.com/servo/servo/issues/39139) that can lead to uncollectible GC cycles and leaking memory (@Gae24, @jdm, @lumiscosity, @SilvioPilato, @sahilnyk, @TTyChud, @kuntal-devrat, @MohamedAli00949, #47941, #48013, #48021, #48035, #48033, #48051, #48072, #48171, #48209, #48248, #48246, #48264, #48285, #48311, #48408, #48053, #48156, #48186, #48223, #48315, #47872, #47698, #47682, #47735, #47816, #47817, #47794, #47909, #47934, #47935, #47954, #48022, #47955, #48058, #48228, #48247, #48261, #48280, #48302, #48316, #48328, #48346, #48355, #48262, #48377, #48304, #48378, #48388, #48432).

We fixed panics in **WebRTC** (@MunishMummadi, #4772), **execCommand()** on **Document** (@TimvdLippe, #47784), `<video>` (@calvaris, #46148), `<iframe>` (@jdm, #48465), **SharedWorker** (@mrobinson, #47940), **ancestorOrigins** on **Document** (@mrobinson, #48009), `about:memory` (@mxmgorin, #47686, #48001), and EGL 1.4 configurations (@mxmgorin, #47803).

We also fixed a very ironic panic triggered by the `about:crash` page that loads when a normal page triggers a panic (@mrobinson, #48055)

The JS console no longer hangs when primitive values as thrown as exceptions (@FatCat560, #47629).
Servo no longer hangs on shutdown in multiprocess mode (@Narfinger, #48523), when certain pages use **IntersectionObserver** (@mxmgorin, #47693), when closing a browsing context with pending WebDriver commands (@yezhizhen, #48131, #48172), or when closing **SharedWorker**s (@nicoburns, #48477).

`about:memory` got more improvements: we measure more memory for SVG rendering (@Narfinger, @mrobinson, #47061), WebAudio (@jdm, #47996), and identify globals that have been leaked (@jdm, #48237).

## More on the web platform

CSS images now **delay the `load` event**, leading to more consistent behaviour for engine users performing visual rendering (@TimvdLippe, #48199).

Interactive selections in documents continued to improve!
They now can span shadow trees (@mrobinson, @SimonSapin, #47931, #47694, #47895), and have consistent heights and positions (@mrobinson, #47937), plus there are new context menu entries to copy and select all (@mrobinson, #48101).
Additionally, image-based content shows when it is part of a selection (@mrobinson, #48149).

`Window.open()` respects sandbox flags that prevent popups (@mrobinson, #47653).

**LargestContentfulPaint** now reports the **loadTime** for image content (@shubhamg13, #48286), ignores cross-origin frames (@shubhamg13, #48094), ignores invisible text (@shubhamg13, #48010), and reports null elements when they are removed from the tree (@shubhamg13, #48125).

**select()** on a text input now focuses the control (@dzfrias, @mrobinson, #48475).

Our WebDriver server now automates setting permissions (@xbwwj, @yezhizhen, #47623), while sending click events and keyboard actions uses fewer delays (@yezhizhen, #48066).

There are more useful error messages for methods on **Document** (@eachra-bawn, #47835) and **CSS**-related interfaces (@eachra-bawn, @jdm, #47746).

We upgraded our [stylo](https://crates.io/crates/stylo) dependency, which improves compatibility with **contrast-color()**, **color-mix()**, **vertical-align**, **list-style**, **place-items**, **at-rule()**, **calc()**, **alpha()**, **attr()**, **content: attr()**, and **named-feature()** (@Loirooriol, #46987, #47942).

We also fixed bugs related to **visibilityState** on **Document** (@yezhizhen, #47908), **containsNode()** on **Selection** (@mrobinson, #47938), **setKeyframes** on **KeyframeEffect** (@simonwuelker, #48103), selections when focusing a text input (@mrobinson, #48107), **AudioParam** clamping and automation (@kevlu93, #48351, #48347), **PannerNode** outputs (@kevlu93, #48510), the **muted** attribute on **HTMLMediaElement** (@TimvdLippe, #48403), placeholders in text inputs (@jdm, #47761, #47797), animations when modifying document stylesheets (@SharanRP, #48000), gradient color stops (@BudiArb, #48288), sticky table rows (@TTyChud, #48380), **::first-letter** (@Loirooriol, #48307), **text-wrap-mode** (@mrobinson, #48469), OTF fonts (@wood-ghost, #47904), CSS and nosniff (@sahvx655-wq, #45481), **Sec-Fetch-** headers and redirects (@TimvdLippe, #48203), **moveBefore()** on **Node** (@mrobinson, #47692), **supports()** on **WebCrypto** (@kkoyung, #47768, #47891, #47953, #47984, #48410, #47545), cross-origin windows (@mrobinson, @jdm, #47632, #48411, #48038), origins of `about:blank` and `about:srcdoc` (@mrobinson, #47630), `keypress` events (@mrobinson, #48324), text and media documents (@SilvioPilato, #47823), **body()** on **Response** (@TTyChud, #48409), `<details>` with `<summary>` (@TimvdLippe, #48224), editing hidden inputs (@dzfrias, #48165), attribute nodes in XPath (@leowatts, @mrobinson, #47912), absolutely positioned boxes (@mxmgorin, #48081), CSS Grid containers with absolutely positioned nodes (@nicoburns, #47519), **WebDriver** wheel/pointer actions (@yezhizhen, #48143), and **blob:** URLs (@Gae24, #47910).

## New contributors

A special thanks to the following people for landing their first patch in Servo:

* Arnau Camprubí (@Arnau478, #47726)
* Silvio Pilato (@SilvioPilato, #47786)
* Radeonares32 (@Radeonares32, #47651)
* derdilla (@derdilla, #47828)
* pr3pony (@pr3pony, #48030)
* Mario (@Fatcat560, #47629)
* TtyChud (@TTyChud, #48228)
* Devrate Kuntal (@kuntal-devrat, #48247)
* Diego Frias (@dzfrias, #48025)
* LiamillionSS (@LiamillionSS, #48424)

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
