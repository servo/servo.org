---
layout:     post
tags:       blog
title:      "October in Servo: video captions and inert content"
date:       2026-11-19
summary:    Plus WebAudio nodes, image inputs, and more!
categories:
---

<style>
code {
  white-space: nowrap;
}
</style>

[**Servo 0.8.0**](https://github.com/servo/servo/releases/tag/v0.8.0) contains all of the changes we landed in October, spanning 588 commits (a new record)!

<figure>
    <a href="{{ '/img/blog/.png' | url }}"><img src="{{ '/img/blog/.png' | url }}" alt="a black and white cat named Gary showing off new visual web platform features"></a>
</figure>

Servo now renders text track cues over `&lt;video>` elements (@TimvdLippe, #48809)!
This allows subtitles and captions to work as expected in many cases.

<figure>
    <video src="{{ '/img/blog/2026-11-cat-caption.mp4' | url }}" autoplay muted loop>Servo 0.8 showing a video playing with captions that change over time</video>
</figure>

We've shipped new web platform features:
* the **spelling-error** and **grammar-error** values for **text-decoration-line** (@yezhizhen, #48883)
* the [**progress()**](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Values/progress) CSS math function (@Loirooriol, #48474)
* `&lt;input type=image>` (@SilvioPilato, #48265)
* the **:focus-visible** pseudoclass (@TimvdLippe, #49255)
* the **beforeinput** event (@dzfrias, #48519)
* the **&lt;wbr>** element (@mrobinson, #48755)
* the **auto** and **stable** values for the **text-wrap-style** property (@nicoburns, #48958)re
* **inert** trees and the **interactivity** property (@skyz1, @TimvdLippe, #48967)

Plus a bunch of new DOM APIs:
* the **DelayNode** and **ConvolverNode** WebAudio nodes (@kevlu93, @TimvdLippe, #48658, #47957)
* the **timeout** property of **XMLHTTPRequest** in worker globals (@CynthiaOketch, #48854, #49023)
* the **hspace** and **vspace** attributes on **&lt;img>** (@TimvdLippe, #48605)
* the **hspace**, **vspace**, **width**, and **height** attributes on **&lt;input>** (@TimvdLippe, #49031)
* the **target** property of **HTMLBaseElement** (@sabbCodes, #48985)
* the **CloseWatcher** interface, and the **closedBy** and **requestClose()** members of **HTMLDialogElement** (@skyz1, @lukewarlow, @TimvdLippe, #48955)

## Security


## Real world compat

Flutter web content works much better now that we fixed a serious performance problem with typed arrays (@jdm, #48640).

<!-- TODO figure, https://rydmike.com/flexcolorscheme/themesplayground-latest/ -->

We’re interested to hear how well your favourite websites run in Servo! Report successes in [this Zulip thread](https://servo.zulipchat.com/#narrow/channel/263398-general/topic/Servo.20web.20compat.20success.20stories/with/612898341) or [this Github discussion](https://github.com/servo/servo/discussions/49037), and failures [in our GitHub issues](https://github.com/servo/servo/issues).

## Work in progress

**WebGL2** support received lots of attention this month, with fixes to **getParameter()**, **drawBuffers()**, **readBuffers()**, **vertexAttribIPointer()**, **DEPTH_STENCIL_ATTACHMENT**, **getUniformLocation()**, **vertexAttrib4x()**, **pixelStorei()**, **texStorage2D()**, **texStorage3D()**, **texImage3D()**, **getInternalformatParameter()**, **blitFramebuffer()**, and **texSubImage2D()** (@mxmgorin, #48651, #48620, #48678, #48689, #48751, #48681, #48911, #48972, #48590, #49201, #49289, #48560, #48571).
The feature remains gated behind the `dom_webgl2_enabled` preference.

Reading and writing mapped **WebGPU** buffers got a significant speed increase (@sagudev, @jdm, #48372).
WebGPU can be enabled with the `dom_webgpu_enabled` preference.

JS script compilation can now occur off the main thread when the `dom_script_asynch` preference is enabled (@Gae24, #45687).
Right now this only applies to non-module scripts.

Initial support for the **backdrop-filter** property has merged (@shubhamg13, #48829).
This can be enabled with the `layout_css_backdrop_filter_enabled` preference.

ServiceWorkers now fire the `statechange` event when changing states during initialization (@gterzian, #48749).
ServiceWorkerContainer can listen for `message` and `messageerror` events (@gterzian, #48680).
Service Workers remain gated behind the `dom_serviceworker_enabled` preference.

The Geolocation API has been implemented (@webbeef, #48406).
No platform-specific backends to provide the device geolocation data have merged yet, so it remains disabled behind the `dom_geolocation_enabled` preference.

DOM interfaces for MathML elements now exist, gated behind the `mathml_core_enabled` preference (@tannal, #48631).
There is no MathML-specific layout implemented yet.

A new, native SVG implementation is in progress (@mu-mostafa98, @jdm, #48467).
This work is still in the early stages, but is intended to replace Servo's dependency on the `resvg` crate to better integrate with page styling and animations.

IndexedDB cursors now support the `update()` and `delete()` methods (@kuntal-devrat, #48402).
The feature can be enabled with the `dom_indexeddb_enabled` preference.

## Embedding API

The Android Compose migration is complete, and embedders now only need to interact with the `Servo` library component (@veyndan, #48592, #48601, #48595, #48574, #48609, #48778, #48780, #49266).
Embedders no longer need to trigger the soft keyboard display; this is controlled by a parameter to the `Servo` component (@veyndan, #48757).

There's a new API method to report the network status of the embedder: [NetworkManager](https://doc.servo.org/servo/struct.NetworkManager.html)::[set_online_state](https://doc.servo.org/servo/struct.NetworkManager.html#method.set_online_state) (@xbwwj, #47568).
This data is exposed via the [**onLine**](https://developer.mozilla.org/en-US/docs/Web/API/Navigator/onLine) property of the **Navigator** interface in web content.

Embedders can now disable all support for developer tools, which can reduce the size of the final binary (@janeoa, #47255).
This is controlled by the `devtools` feature and enabled by default; it is also part of the new `default_tooling` feature.

Users of the C API can set preferences that accept f64 and f64 array parameters (@fran6co, #49325), as well as the HiDPI scale factor for each WebView (@fran6co, #49327).
WebViews can also be resized via the C API (@fran6co, #49326).

The `layout_grid_enabled` preference has been removed, since CSS Grid now defaults to enabled (@Loirooriol, #48718).
Several preferences were renamed (@nicoburns, #48915):
* `layout_columns_enabled` -> `layout_css_columns_enabled`
* `layout_container_queries_enabled` -> `layout_css_container_queries_enabled`
* `layout_variable_fonts_enabled` -> `layout_css_font_variations_enabled`
* `layout_writing_mode_enabled` -> `layout_css_writing_mode_enabled`

## For users and developers

Double and triple clicking on selected text will extend the selection to the current word and line, respectively (@mrobinson, @SimonSapin, #48767).

Range inputs can now be dragged with the mouse (@webbeef, #48342).

The developer tools continue to improve:
* Object prototypes are reported correctly in the JS console (@sahilnyk, #48208)
* Shadow roots can be inspected in the layout inspector (@Siddhi-sahu, #49088)
* CORS preflight requests are reported to the network panel (@willypuzzle, #49151)

We improved exception error messages related to the XMLHttpRequest, History, Range, Selection, Element, CharacterData, and DOMTokenList interfaces, and namespaces and attributes (@gabrielecabrini, #49146, #49145, #48786, #49102).

Media elements that start playing outside of a document will no longer be garbage collected until playback finishes (@sabbCodes, @jdm, #49367, #48979).

## Performance and stability

Pinch zoom operations no longer have to rebuild a full display list, making zooming on complex pages much smoother (@stevennovaryo, @mrobinson, #43561).

We improved performance in many small and focused ways by doing less work during restyling and layout (@SimonSapin, @webbeef, @nicoburns, @mrobinson, #49137, #49100, #48485, #48968), reducing GC interactions (@mrobinson, #48984, #49140, #49195), and delaying work on disconnected trees (@SimonSapin, #49098).
We also fixed instances of quadratic layout with deep nesting (@nicoburns, #49148) and missing caching (@mrobinson, @Loirooriol, #49164, #49073).

We fixed some intermittent GC panics when notifying ResizeObservers (@mrobinson, #49189), introspecting keyframes (@MohamedAli00949, #48546), setting timers (@jdm, #48548), using writable streams (@jdm, #48656), scrolling iframes after removing them (@mrobinson, #49230).

We also fixed numerous other panics and crashes in scrollable and incremental layout (@mrobinson, #49230, #49283), moving nodes around (@mrobinson, #49226), using WebGPU from opaque origins (@gabrielecabrini, #49207), stringifying some WebIDL types (@mrobinson, #49374), using readable streams (@Narfinger, @mrobinson, #49311), clicking disabled file controls (@mrobinson, #49379), rendering giant SVGs (@sabbCodes, #49264), unminifying JS (@jdm, #48567), measuring text (@mxmgorin, #48621), rendering text tracks (@TimvdLippe, @mrobinson, #48827), preparing dialogs (@lukewarlow, #49431), and running delayed tasks in destroyed documents (@mrobinson, @jdm, #49399, #48714).

Many small-to-medium improvements to reduce allocations were merged (@yezhizhen, @Narfinger, @Taym95, @mrobinson, @Loirooriol, @CynthiaOketch, @sabbCodes, @mxmgorin, #48549, #48558, #48568, #48598, #48615, #48565, #48646, #48654, #48569, #48562, #48588, #48650, #48702, #48675, #48589, #48720, #48721, #47720, #48745, #48703, #48750, #48770, #48789, #48754, #48828, #48838, #48836, #48841, #48843, #48867, #48882, #48842, #48881, #48840, #48899, #48924, #48904, #48949, #48953, #48980, #49028, #48885, #49035, #49038, #49084, #49131, #49125, #48951, #49154, #49160, #49198, #49202, #49194, #49219, #49258, #49275, #49295, #49298, #49300, #49320, #49323, #49313, #49373, #49380, #48969, #48991), and we also reduced memory usage by shrinking some types (@Narfinger, @webbeef, #48954, #48082, #48906).

Memory leaks received a lot of attention this month, covering everything from network requests, to JS modules, to timer tasks, and more (@mrobinson, @SimonSapin, @jschwe, #48952, #48957, #49032, #49049, #49092, #49134, #49139, #49132, #48747, #48752).

We continue to work towards preventing certain sources of memory leaks with static analysis and the Rust type system (@Gae24, @Narfinger, @jdm, #48147, #48360, #48832, #48887, #48913, #48903, #48965, #48905, #48834, #48855, #49083, #49082, #49081, #49096, #49135, #49130).

## More on the web platform

## New contributors

A special thanks to the following people for landing their first patch in Servo:

* 

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
