---
layout:     post
tags:       blog
title:      "October in Servo: video captions and inert content"
date:       2026-11-25
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
    <a href="{{ '/img/blog/2026-11-gary.png' | url }}"><img src="{{ '/img/blog/2026-11-gary.png' | url }}" alt="a black and white cat named Gary showing off new visual web platform features"></a>
</figure>

Servo now renders **subtitles and captions** over `<video>` elements ([@TimvdLippe](https://github.com/TimvdLippe), [#48809](https://github.com/servo/servo/pull/48809))!

<figure>
    <video src="{{ '/img/blog/2026-11-cat-caption.mp4' | url }}" autoplay muted loop>Servo 0.8 showing a video playing with captions that change over time</video>
</figure>

We've shipped new web platform features:
* the **spelling-error** and **grammar-error** values for **text-decoration-line** ([@yezhizhen](https://github.com/yezhizhen), [#48883](https://github.com/servo/servo/pull/48883))
* the [**progress()**](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Values/progress) CSS math function ([@Loirooriol](https://github.com/Loirooriol), [#48474](https://github.com/servo/servo/pull/48474))
* **&lt;input type=image>** ([@SilvioPilato](https://github.com/SilvioPilato), [#48265](https://github.com/servo/servo/pull/48265))
* the **:focus-visible** pseudoclass ([@TimvdLippe](https://github.com/TimvdLippe), [#49255](https://github.com/servo/servo/pull/49255), [#49304](https://github.com/servo/servo/pull/49304))
* the **beforeinput** event ([@dzfrias](https://github.com/dzfrias), [#48519](https://github.com/servo/servo/pull/48519))
* the **&lt;wbr>** element ([@mrobinson](https://github.com/mrobinson), [#48755](https://github.com/servo/servo/pull/48755))
* the **auto** and **stable** values for the **text-wrap-style** property ([@nicoburns](https://github.com/nicoburns), [#48958](https://github.com/servo/servo/pull/48958))
* **inert** trees and the **interactivity** property ([@skyz1](https://github.com/skyz1), [@TimvdLippe](https://github.com/TimvdLippe), [#48967](https://github.com/servo/servo/pull/48967))

Plus a bunch of new DOM APIs:
* the **DelayNode** and **ConvolverNode** WebAudio nodes ([@kevlu93](https://github.com/kevlu93), [@TimvdLippe](https://github.com/TimvdLippe), [#48658](https://github.com/servo/servo/pull/48658), [#47957](https://github.com/servo/servo/pull/47957))
* the **timeout** property of **XMLHTTPRequest** in worker globals ([@CynthiaOketch](https://github.com/CynthiaOketch), [#48854](https://github.com/servo/servo/pull/48854), [#49023](https://github.com/servo/servo/pull/49023))
* the **hspace** and **vspace** attributes on **&lt;img>** ([@TimvdLippe](https://github.com/TimvdLippe), [#48605](https://github.com/servo/servo/pull/48605))
* the **hspace**, **vspace**, **width**, and **height** attributes on **&lt;input>** ([@TimvdLippe](https://github.com/TimvdLippe), [#49031](https://github.com/servo/servo/pull/49031))
* the **target** property of **HTMLBaseElement** ([@sabbCodes](https://github.com/sabbCodes), [#48985](https://github.com/servo/servo/pull/48985))
* the **CloseWatcher** interface, and the **closedBy** and **requestClose()** members of **HTMLDialogElement** ([@skyz1](https://github.com/skyz1), [@lukewarlow](https://github.com/lukewarlow), [@TimvdLippe](https://github.com/TimvdLippe), [#48955](https://github.com/servo/servo/pull/48955))

## Real world compat

Flutter web content no longer hangs now that we fixed a serious performance problem with typed arrays ([@jdm](https://github.com/jdm), [#48640](https://github.com/servo/servo/pull/48640)). [Example](https://flutter.syncfusion.com/#/range-selector/default)

<figure>
    <a href="{{ '/img/blog/2026-11-flutter.png' | url }}"><img src="{{ '/img/blog/2026-11-flutter.png' | url }}" alt="a flutter web app showcasing interactive graphs"></a>
</figure>

We’re interested to hear how well your favourite websites run in Servo! Report successes in [this Zulip thread](https://servo.zulipchat.com/#narrow/channel/263398-general/topic/Servo.20web.20compat.20success.20stories/with/612898341) or [this Github discussion](https://github.com/servo/servo/discussions/49037), and failures [in our GitHub issues](https://github.com/servo/servo/issues).

## Work in progress

With respect to accessibility in Servo, we report many more ARIA roles for DOM elements ([@alice](https://github.com/alice), [@mrobinson](https://github.com/mrobinson), [#48839](https://github.com/servo/servo/pull/48839)).
These can be inspected with the `Get Computed Role` WebDriver command ([@lolaodelola](https://github.com/lolaodelola), [#47339](https://github.com/servo/servo/pull/47339)).
Accessibility integration can be turned on with the `accessibility_enabled` preference.

**WebGL2** support received lots of attention this month, with fixes to `getParameter()`, `drawBuffers()`, `readBuffers()`, `vertexAttribIPointer()`, `DEPTH_STENCIL_ATTACHMENT`, `getUniformLocation()`, `vertexAttrib4x()`, `pixelStorei()`, `texStorage2D()`, `texStorage3D()`, `texImage3D()`, `getInternalformatParameter()`, `blitFramebuffer()`, and `texSubImage2D()` ([@mxmgorin](https://github.com/mxmgorin), [#48651](https://github.com/servo/servo/pull/48651), [#48620](https://github.com/servo/servo/pull/48620), [#48678](https://github.com/servo/servo/pull/48678), [#48689](https://github.com/servo/servo/pull/48689), [#48751](https://github.com/servo/servo/pull/48751), [#48681](https://github.com/servo/servo/pull/48681), [#48911](https://github.com/servo/servo/pull/48911), [#48972](https://github.com/servo/servo/pull/48972), [#48590](https://github.com/servo/servo/pull/48590), [#49201](https://github.com/servo/servo/pull/49201), [#49289](https://github.com/servo/servo/pull/49289), [#48560](https://github.com/servo/servo/pull/48560), [#48571](https://github.com/servo/servo/pull/48571)).
The feature remains gated behind the `dom_webgl2_enabled` preference.

Reading and writing mapped **WebGPU** buffers got a significant speed increase ([@sagudev](https://github.com/sagudev), [@jdm](https://github.com/jdm), [#48372](https://github.com/servo/servo/pull/48372)).
WebGPU can be enabled with the `dom_webgpu_enabled` preference.

JS script compilation can now occur off the main thread when the `dom_script_asynch` preference is enabled ([@Gae24](https://github.com/Gae24), [#45687](https://github.com/servo/servo/pull/45687)).
Right now this only applies to non-module scripts.

Initial support for the **backdrop-filter** property has merged ([@shubhamg13](https://github.com/shubhamg13), [#48829](https://github.com/servo/servo/pull/48829)).
This can be enabled with the `layout_css_backdrop_filter_enabled` preference.

ServiceWorkers now fire the `statechange` event when changing states during initialization ([@gterzian](https://github.com/gterzian), [#48749](https://github.com/servo/servo/pull/48749)).
ServiceWorkerContainer can listen for `message` and `messageerror` events ([@gterzian](https://github.com/gterzian), [#48680](https://github.com/servo/servo/pull/48680)).
**Service Workers** remain gated behind the `dom_serviceworker_enabled` preference.

The **Geolocation** API has been implemented ([@webbeef](https://github.com/webbeef), [#48406](https://github.com/servo/servo/pull/48406)).
No platform-specific backends to provide the device geolocation data have merged yet, so it remains disabled behind the `dom_geolocation_enabled` preference.

DOM interfaces for **MathML** elements now exist, gated behind the `mathml_core_enabled` preference ([@tannal](https://github.com/tannal), [#48631](https://github.com/servo/servo/pull/48631)).
There is no MathML-specific layout implemented yet.

A new, native **SVG** implementation is in progress ([@mu-mostafa98](https://github.com/mu-mostafa98), [@jdm](https://github.com/jdm), [#48467](https://github.com/servo/servo/pull/48467)).
This work is still in the early stages, but is intended to replace Servo's dependency on the `resvg` crate to better integrate with page styling and animations.

**IndexedDB** cursors now support the `update()` and `delete()` methods ([@kuntal-devrat](https://github.com/kuntal-devrat), [#48402](https://github.com/servo/servo/pull/48402)).
The feature can be enabled with the `dom_indexeddb_enabled` preference.

Support for **LargestContentfulPaint** performance timing improved, with image URLs ([@shubhamg13](https://github.com/shubhamg13), [#48668](https://github.com/servo/servo/pull/48668)), the `loadTime` value ([@shubhamg13](https://github.com/shubhamg13), [#48676](https://github.com/servo/servo/pull/48676)), ignoring non-paintable elements ([@shubhamg13](https://github.com/shubhamg13), [#48856](https://github.com/servo/servo/pull/48856), [#48898](https://github.com/servo/servo/pull/48898)), video URLs ([@shubhamg13](https://github.com/shubhamg13), [#48931](https://github.com/servo/servo/pull/48931)), and following containing blocks ([@shubhamg13](https://github.com/shubhamg13), [#48551](https://github.com/servo/servo/pull/48551)).
This work is behind the `largest_contentful_paint_enabled` preference.

We added support for a new performance timing metric: **[ContainerTiming](https://w3c.github.io/container-timing/)** ([@jasonwilliams](https://github.com/jasonwilliams), [#46966](https://github.com/servo/servo/pull/46966)).
This can be enabled with the `container_timing_enabled` preference.

Our support for **adoptedStylesheets** improved along with a new implementation of the [ObservableArray](https://webidl.spec.whatwg.org/#idl-observable-array) specification concept ([@jerensl](https://github.com/jerensl), [@arihant2math](https://github.com/arihant2math), [#48506](https://github.com/servo/servo/pull/48506)).
This is currently hidden behind the `dom_adoptedstylesheet_enabled` preference.

## Embedding API

The Android Compose migration is complete, and embedders now only need to interact with the `Servo` library component ([@veyndan](https://github.com/veyndan), [#48592](https://github.com/servo/servo/pull/48592), [#48601](https://github.com/servo/servo/pull/48601), [#48595](https://github.com/servo/servo/pull/48595), [#48574](https://github.com/servo/servo/pull/48574), [#48609](https://github.com/servo/servo/pull/48609), [#48778](https://github.com/servo/servo/pull/48778), [#48780](https://github.com/servo/servo/pull/48780), [#49266](https://github.com/servo/servo/pull/49266)).
Embedders no longer need to trigger the soft keyboard display; this is controlled by a parameter to the `Servo` component ([@veyndan](https://github.com/veyndan), [#48757](https://github.com/servo/servo/pull/48757)).

There's a new API method to report the network status of the embedder: [NetworkManager](https://doc.servo.org/servo/struct.NetworkManager.html)::[set_online_state](https://doc.servo.org/servo/struct.NetworkManager.html#method.set_online_state) ([@xbwwj](https://github.com/xbwwj), [#47568](https://github.com/servo/servo/pull/47568)).
This data is exposed via the [**onLine**](https://developer.mozilla.org/en-US/docs/Web/API/Navigator/onLine) property of the **Navigator** interface in web content.

Embedders can now disable all support for developer tools, which can reduce the size of the final binary ([@janeoa](https://github.com/janeoa), [#47255](https://github.com/servo/servo/pull/47255)).
This is controlled by the `devtools` feature and enabled by default; it is also part of the new `default_tooling` feature.

Users of the C API can set preferences that accept f64 and f64 array parameters ([@fran6co](https://github.com/fran6co), [#49325](https://github.com/servo/servo/pull/49325)), as well as the HiDPI scale factor for each WebView ([@fran6co](https://github.com/fran6co), [#49327](https://github.com/servo/servo/pull/49327)).
WebViews can also be resized via the C API ([@fran6co](https://github.com/fran6co), [#49326](https://github.com/servo/servo/pull/49326)).

The `layout_grid_enabled` preference has been removed, since CSS Grid now defaults to enabled ([@Loirooriol](https://github.com/Loirooriol), [#48718](https://github.com/servo/servo/pull/48718)).
Several preferences were renamed ([@nicoburns](https://github.com/nicoburns), [#48915](https://github.com/servo/servo/pull/48915)):
* `layout_columns_enabled` -> `layout_css_columns_enabled`
* `layout_container_queries_enabled` -> `layout_css_container_queries_enabled`
* `layout_variable_fonts_enabled` -> `layout_css_font_variations_enabled`
* `layout_writing_mode_enabled` -> `layout_css_writing_mode_enabled`

## For users and developers

Double and triple clicking on selected text will extend the selection to the current word and line, respectively ([@mrobinson](https://github.com/mrobinson), [@SimonSapin](https://github.com/SimonSapin), [#48767](https://github.com/servo/servo/pull/48767)).

Clicking a link with the middle mouse button now opens up the link in a new WebView ([@SteveSharonSam](https://github.com/SteveSharonSam), [@mrobinson](https://github.com/mrobinson), [#46000](https://github.com/servo/servo/pull/46000))

Range inputs can be dragged with the mouse ([@webbeef](https://github.com/webbeef), [#48342](https://github.com/servo/servo/pull/48342)).

Command+delete on macOS will delete the preceding line in a text control ([@dzfrias](https://github.com/dzfrias), [#48781](https://github.com/servo/servo/pull/48781)).

The developer tools continue to improve:
* Object prototypes are reported correctly in the JS console ([@sahilnyk](https://github.com/sahilnyk), [#48208](https://github.com/servo/servo/pull/48208))
* Shadow roots can be inspected in the layout inspector ([@Siddhi-sahu](https://github.com/Siddhi-sahu), [#49088](https://github.com/servo/servo/pull/49088))
* CORS preflight requests are reported to the network panel ([@willypuzzle](https://github.com/willypuzzle), [#49151](https://github.com/servo/servo/pull/49151))

We improved exception error messages related to the XMLHttpRequest, History, Range, Selection, Element, CharacterData, and DOMTokenList interfaces, and namespaces and attributes ([@gabrielecabrini](https://github.com/gabrielecabrini), [#49146](https://github.com/servo/servo/pull/49146), [#49145](https://github.com/servo/servo/pull/49145), [#48786](https://github.com/servo/servo/pull/48786), [#49102](https://github.com/servo/servo/pull/49102)).

Media elements that start playing outside of a document will no longer be garbage collected until playback finishes ([@sabbCodes](https://github.com/sabbCodes), [@jdm](https://github.com/jdm), [#49367](https://github.com/servo/servo/pull/49367), [#48979](https://github.com/servo/servo/pull/48979)).

## Performance and stability

Pinch zoom operations no longer have to rebuild a full display list, making **zooming complex pages** much smoother ([@stevennovaryo](https://github.com/stevennovaryo), [@mrobinson](https://github.com/mrobinson), [#43561](https://github.com/servo/servo/pull/43561)).

We improved performance in many small and focused ways by doing **less work** during restyling and layout ([@SimonSapin](https://github.com/SimonSapin), [@webbeef](https://github.com/webbeef), [@nicoburns](https://github.com/nicoburns), [@mrobinson](https://github.com/mrobinson), [#49137](https://github.com/servo/servo/pull/49137), [#49100](https://github.com/servo/servo/pull/49100), [#48485](https://github.com/servo/servo/pull/48485), [#48968](https://github.com/servo/servo/pull/48968)), reducing **GC interactions** ([@mrobinson](https://github.com/mrobinson), [@jschwe](https://github.com/jschwe), [#48984](https://github.com/servo/servo/pull/48984), [#49140](https://github.com/servo/servo/pull/49140), [#49195](https://github.com/servo/servo/pull/49195), [#49425](https://github.com/servo/servo/pull/49425)), and delaying work on disconnected trees ([@SimonSapin](https://github.com/SimonSapin), [#49098](https://github.com/servo/servo/pull/49098)).
We also fixed instances of quadratic layout with deep nesting ([@nicoburns](https://github.com/nicoburns), [#49148](https://github.com/servo/servo/pull/49148)) and missing caching ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#49164](https://github.com/servo/servo/pull/49164), [#49073](https://github.com/servo/servo/pull/49073)).

We fixed some intermittent GC panics when notifying ResizeObservers ([@mrobinson](https://github.com/mrobinson), [#49189](https://github.com/servo/servo/pull/49189)), introspecting keyframes ([@MohamedAli00949](https://github.com/MohamedAli00949), [#48546](https://github.com/servo/servo/pull/48546)), setting timers ([@jdm](https://github.com/jdm), [#48548](https://github.com/servo/servo/pull/48548)), using writable streams ([@jdm](https://github.com/jdm), [#48656](https://github.com/servo/servo/pull/48656)), and scrolling iframes after removing them ([@mrobinson](https://github.com/mrobinson), [#49230](https://github.com/servo/servo/pull/49230)).

We also fixed numerous other **panics and crashes** in scrollable and incremental layout ([@mrobinson](https://github.com/mrobinson), [#49230](https://github.com/servo/servo/pull/49230), [#49283](https://github.com/servo/servo/pull/49283)), moving nodes around ([@mrobinson](https://github.com/mrobinson), [#49226](https://github.com/servo/servo/pull/49226)), using WebGPU from opaque origins ([@gabrielecabrini](https://github.com/gabrielecabrini), [#49207](https://github.com/servo/servo/pull/49207)), stringifying some WebIDL types ([@mrobinson](https://github.com/mrobinson), [#49374](https://github.com/servo/servo/pull/49374)), using readable streams ([@Narfinger](https://github.com/Narfinger), [@mrobinson](https://github.com/mrobinson), [#49311](https://github.com/servo/servo/pull/49311)), clicking disabled file controls ([@mrobinson](https://github.com/mrobinson), [#49379](https://github.com/servo/servo/pull/49379)), rendering giant SVGs ([@sabbCodes](https://github.com/sabbCodes), [#49264](https://github.com/servo/servo/pull/49264)), unminifying JS ([@jdm](https://github.com/jdm), [#48567](https://github.com/servo/servo/pull/48567)), measuring text ([@mxmgorin](https://github.com/mxmgorin), [#48621](https://github.com/servo/servo/pull/48621)), rendering text tracks ([@TimvdLippe](https://github.com/TimvdLippe), [@mrobinson](https://github.com/mrobinson), [#48827](https://github.com/servo/servo/pull/48827)), preparing dialogs ([@lukewarlow](https://github.com/lukewarlow), [#49431](https://github.com/servo/servo/pull/49431)), and running delayed tasks in destroyed documents ([@mrobinson](https://github.com/mrobinson), [@jdm](https://github.com/jdm), [#49399](https://github.com/servo/servo/pull/49399), [#48714](https://github.com/servo/servo/pull/48714)).

Many small-to-medium improvements to **reduce allocations** were merged ([@yezhizhen](https://github.com/yezhizhen), [@Narfinger](https://github.com/Narfinger), [@Taym95](https://github.com/Taym95), [@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [@CynthiaOketch](https://github.com/CynthiaOketch), [@sabbCodes](https://github.com/sabbCodes), [@mxmgorin](https://github.com/mxmgorin), [#48549](https://github.com/servo/servo/pull/48549), [#48558](https://github.com/servo/servo/pull/48558), [#48568](https://github.com/servo/servo/pull/48568), [#48598](https://github.com/servo/servo/pull/48598), [#48615](https://github.com/servo/servo/pull/48615), [#48565](https://github.com/servo/servo/pull/48565), [#48646](https://github.com/servo/servo/pull/48646), [#48654](https://github.com/servo/servo/pull/48654), [#48569](https://github.com/servo/servo/pull/48569), [#48562](https://github.com/servo/servo/pull/48562), [#48588](https://github.com/servo/servo/pull/48588), [#48650](https://github.com/servo/servo/pull/48650), [#48702](https://github.com/servo/servo/pull/48702), [#48675](https://github.com/servo/servo/pull/48675), [#48589](https://github.com/servo/servo/pull/48589), [#48720](https://github.com/servo/servo/pull/48720), [#48721](https://github.com/servo/servo/pull/48721), [#47720](https://github.com/servo/servo/pull/47720), [#48745](https://github.com/servo/servo/pull/48745), [#48703](https://github.com/servo/servo/pull/48703), [#48750](https://github.com/servo/servo/pull/48750), [#48770](https://github.com/servo/servo/pull/48770), [#48789](https://github.com/servo/servo/pull/48789), [#48754](https://github.com/servo/servo/pull/48754), [#48828](https://github.com/servo/servo/pull/48828), [#48838](https://github.com/servo/servo/pull/48838), [#48836](https://github.com/servo/servo/pull/48836), [#48841](https://github.com/servo/servo/pull/48841), [#48843](https://github.com/servo/servo/pull/48843), [#48867](https://github.com/servo/servo/pull/48867), [#48882](https://github.com/servo/servo/pull/48882), [#48842](https://github.com/servo/servo/pull/48842), [#48881](https://github.com/servo/servo/pull/48881), [#48840](https://github.com/servo/servo/pull/48840), [#48899](https://github.com/servo/servo/pull/48899), [#48924](https://github.com/servo/servo/pull/48924), [#48904](https://github.com/servo/servo/pull/48904), [#48949](https://github.com/servo/servo/pull/48949), [#48953](https://github.com/servo/servo/pull/48953), [#48980](https://github.com/servo/servo/pull/48980), [#49028](https://github.com/servo/servo/pull/49028), [#48885](https://github.com/servo/servo/pull/48885), [#49035](https://github.com/servo/servo/pull/49035), [#49038](https://github.com/servo/servo/pull/49038), [#49084](https://github.com/servo/servo/pull/49084), [#49131](https://github.com/servo/servo/pull/49131), [#49125](https://github.com/servo/servo/pull/49125), [#48951](https://github.com/servo/servo/pull/48951), [#49154](https://github.com/servo/servo/pull/49154), [#49160](https://github.com/servo/servo/pull/49160), [#49198](https://github.com/servo/servo/pull/49198), [#49202](https://github.com/servo/servo/pull/49202), [#49194](https://github.com/servo/servo/pull/49194), [#49219](https://github.com/servo/servo/pull/49219), [#49258](https://github.com/servo/servo/pull/49258), [#49275](https://github.com/servo/servo/pull/49275), [#49295](https://github.com/servo/servo/pull/49295), [#49298](https://github.com/servo/servo/pull/49298), [#49300](https://github.com/servo/servo/pull/49300), [#49320](https://github.com/servo/servo/pull/49320), [#49323](https://github.com/servo/servo/pull/49323), [#49313](https://github.com/servo/servo/pull/49313), [#49373](https://github.com/servo/servo/pull/49373), [#49380](https://github.com/servo/servo/pull/49380), [#48969](https://github.com/servo/servo/pull/48969), [#48991](https://github.com/servo/servo/pull/48991)).
We also **reduced memory usage** by shrinking some types ([@Narfinger](https://github.com/Narfinger), [@webbeef](https://github.com/webbeef), [#48954](https://github.com/servo/servo/pull/48954), [#48082](https://github.com/servo/servo/pull/48082), [#48906](https://github.com/servo/servo/pull/48906)).

**Memory leaks** received a lot of attention this month, covering everything from network requests, to JS modules, to timer tasks, and more ([@mrobinson](https://github.com/mrobinson), [@SimonSapin](https://github.com/SimonSapin), [@jschwe](https://github.com/jschwe), [#48952](https://github.com/servo/servo/pull/48952), [#48957](https://github.com/servo/servo/pull/48957), [#49032](https://github.com/servo/servo/pull/49032), [#49049](https://github.com/servo/servo/pull/49049), [#49092](https://github.com/servo/servo/pull/49092), [#49134](https://github.com/servo/servo/pull/49134), [#49139](https://github.com/servo/servo/pull/49139), [#49132](https://github.com/servo/servo/pull/49132), [#48747](https://github.com/servo/servo/pull/48747), [#48752](https://github.com/servo/servo/pull/48752)).

We continue to work towards preventing certain sources of memory leaks with static analysis and the Rust type system ([@Gae24](https://github.com/Gae24), [@Narfinger](https://github.com/Narfinger), [@jdm](https://github.com/jdm), [#48147](https://github.com/servo/servo/pull/48147), [#48360](https://github.com/servo/servo/pull/48360), [#48832](https://github.com/servo/servo/pull/48832), [#48887](https://github.com/servo/servo/pull/48887), [#48913](https://github.com/servo/servo/pull/48913), [#48903](https://github.com/servo/servo/pull/48903), [#48965](https://github.com/servo/servo/pull/48965), [#48905](https://github.com/servo/servo/pull/48905), [#48834](https://github.com/servo/servo/pull/48834), [#48855](https://github.com/servo/servo/pull/48855), [#49083](https://github.com/servo/servo/pull/49083), [#49082](https://github.com/servo/servo/pull/49082), [#49081](https://github.com/servo/servo/pull/49081), [#49096](https://github.com/servo/servo/pull/49096), [#49135](https://github.com/servo/servo/pull/49135), [#49130](https://github.com/servo/servo/pull/49130)).

## More on the web platform

We fixed bugs related to the CORS preflight cache ([@sabbCodes](https://github.com/sabbCodes), [#49055](https://github.com/servo/servo/pull/49055), [#49252](https://github.com/servo/servo/pull/49252)), fetch metadata ([@TimvdLippe](https://github.com/TimvdLippe), [@mrobinson](https://github.com/mrobinson), [#48793](https://github.com/servo/servo/pull/48793)), HTTP cache revalidation ([@mrobinson](https://github.com/mrobinson), [@jdm](https://github.com/jdm), [#48927](https://github.com/servo/servo/pull/48927)), image load timing ([@mrobinson](https://github.com/mrobinson), [@TimvdLippe](https://github.com/TimvdLippe), [#48902](https://github.com/servo/servo/pull/48902), [#48790](https://github.com/servo/servo/pull/48790), [#48599](https://github.com/servo/servo/pull/48599)), touch events ([@yezhizhen](https://github.com/yezhizhen), [#48671](https://github.com/servo/servo/pull/48671), [#48699](https://github.com/servo/servo/pull/48699), [#48701](https://github.com/servo/servo/pull/48701)), cloning and moving input elements ([@skyz1](https://github.com/skyz1), [@mrobinson](https://github.com/mrobinson), [#48845](https://github.com/servo/servo/pull/48845), [#48069](https://github.com/servo/servo/pull/48069)), the `:indeterminate` pseudoclass ([@skyz1](https://github.com/skyz1), [#48070](https://github.com/servo/servo/pull/48070)), stylesheet introspection ([@mrobinson](https://github.com/mrobinson), [#48935](https://github.com/servo/servo/pull/48935)), mutating ranges ([@gabrielecabrini](https://github.com/gabrielecabrini), [#49072](https://github.com/servo/servo/pull/49072)), blob URLs ([@rogerkorantenng](https://github.com/rogerkorantenng), [#49074](https://github.com/servo/servo/pull/49074), [#48989](https://github.com/servo/servo/pull/48989), [#49206](https://github.com/servo/servo/pull/49206)), form controls ([@mrobinson](https://github.com/mrobinson), [@lukewarlow](https://github.com/lukewarlow), [@jdm](https://github.com/jdm), [#49163](https://github.com/servo/servo/pull/49163), [#49225](https://github.com/servo/servo/pull/49225), [#48513](https://github.com/servo/servo/pull/48513)), the `mapping` property of `Gamepad` ([@msub2](https://github.com/msub2), [#49381](https://github.com/servo/servo/pull/49381)), `beforeinput` events ([@dzfrias](https://github.com/dzfrias), [#48825](https://github.com/servo/servo/pull/48825)), image dimensions ([@TimvdLippe](https://github.com/TimvdLippe), [#49085](https://github.com/servo/servo/pull/49085)), table appearance attributes ([@Loirooriol](https://github.com/Loirooriol), [#49120](https://github.com/servo/servo/pull/49120), [#49108](https://github.com/servo/servo/pull/49108), [#49156](https://github.com/servo/servo/pull/49156), [#49150](https://github.com/servo/servo/pull/49150)), IME events ([@dzfrias](https://github.com/dzfrias), [#48690](https://github.com/servo/servo/pull/48690)), reconnecting `IntersectionObserver` ([@shubhamg13](https://github.com/shubhamg13), [#48581](https://github.com/servo/servo/pull/48581)), and root elements ([@TimvdLippe](https://github.com/TimvdLippe), [#48514](https://github.com/servo/servo/pull/48514)).

We also addressed layout issues related to soft wrap line breaks ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#48564](https://github.com/servo/servo/pull/48564)), grid and flex layouts with indefinite dimensions ([@RichardTjokroutomo](https://github.com/RichardTjokroutomo), [@rayguo17](https://github.com/rayguo17), [@nicoburns](https://github.com/nicoburns), [#48670](https://github.com/servo/servo/pull/48670), [#48644](https://github.com/servo/servo/pull/48644), [#49232](https://github.com/servo/servo/pull/49232)), hanging whitespace ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#48591](https://github.com/servo/servo/pull/48591), [#48753](https://github.com/servo/servo/pull/48753)), `preserve-3d` ([@mrobinson](https://github.com/mrobinson), [#47933](https://github.com/servo/servo/pull/47933)), inline block splits ([@Loirooriol](https://github.com/Loirooriol), [#46445](https://github.com/servo/servo/pull/46445)), video controls ([@rayguo17](https://github.com/rayguo17), [#44956](https://github.com/servo/servo/pull/44956)), `display: contents` ([@Loirooriol](https://github.com/Loirooriol), [#48784](https://github.com/servo/servo/pull/48784), [#48785](https://github.com/servo/servo/pull/48785)), `justify-contents` ([@yezhizhen](https://github.com/yezhizhen), [#48746](https://github.com/servo/servo/pull/48746), [#48988](https://github.com/servo/servo/pull/48988)), absolute positioning ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#48846](https://github.com/servo/servo/pull/48846)), `<progress>` ([@Loirooriol](https://github.com/Loirooriol), [#49143](https://github.com/servo/servo/pull/49143)), `text-transform: capitalize` ([@jschwe](https://github.com/jschwe), [#48901](https://github.com/servo/servo/pull/48901)), incremental table layout ([@Loirooriol](https://github.com/Loirooriol), [#49176](https://github.com/servo/servo/pull/49176)), `width: stretch` ([@Loirooriol](https://github.com/Loirooriol), [#49239](https://github.com/servo/servo/pull/49239), [#49237](https://github.com/servo/servo/pull/49237)), backface visibility ([@mrobinson](https://github.com/mrobinson), [#49196](https://github.com/servo/servo/pull/49196)), flex gaps ([@yezhizhen](https://github.com/yezhizhen), [#49335](https://github.com/servo/servo/pull/49335)), `perspective` ([@mrobinson](https://github.com/mrobinson), [#49174](https://github.com/servo/servo/pull/49174)), quirks mode ([@Loirooriol](https://github.com/Loirooriol), [#48942](https://github.com/servo/servo/pull/48942), [#39869](https://github.com/servo/servo/pull/39869), [#48978](https://github.com/servo/servo/pull/48978), [#49211](https://github.com/servo/servo/pull/49211)), SVG viewboxes ([@leowatts](https://github.com/leowatts), [#48556](https://github.com/servo/servo/pull/48556)), ISO-8859-8 documents ([@TTyChud](https://github.com/TTyChud), [#48444](https://github.com/servo/servo/pull/48444)), and table borders ([@adoublebarrel](https://github.com/adoublebarrel), [@mrobinson](https://github.com/mrobinson), [#47684](https://github.com/servo/servo/pull/47684)).

## New contributors

A special thanks to the following people for landing their first patch in Servo:

* Gab Virebent ([@gabrix73](https://github.com/gabrix73), [#48729](https://github.com/servo/servo/pull/48729))
* Lola ([@lolaodelola](https://github.com/lolaodelola), [#47339](https://github.com/servo/servo/pull/47339))
* Amriteshkumar Yadav ([@Amrit-04](https://github.com/Amrit-04), [#48772](https://github.com/servo/servo/pull/48772))
* Alexander Bransby-Sharples ([@adoublebarrel](https://github.com/adoublebarrel), [#47684](https://github.com/servo/servo/pull/47684))
* Joseph Zhao ([@programskillforverification](https://github.com/programskillforverification), [#49375](https://github.com/servo/servo/pull/49375))
* Sharadhi-v98 ([@Sharadhi-v98](https://github.com/Sharadhi-v98), [#49302](https://github.com/servo/servo/pull/49302))

Interested in helping build a web browser?
Take a look at our [curated list](https://starters.servo.org) of issues that are good for new contributors!

## Donations

Thanks again for your generous support!
We are now receiving **8057 USD/month** (-2% from September) in recurring donations.
This helps us cover the cost of our **[speedy](https://ci0.servo.org) [CI](https://ci1.servo.org) [and](https://ci2.servo.org) [benchmarking](https://ci3.servo.org) [servers](https://ci4.servo.org)**, one of our latest **[Outreachy interns](https://www.outreachy.org/alums/2026-05/#:~:text=Servo)**, and funding **[maintainer work]({{ '/blog/2026/09/15/one-year-of-sponsorship/' | url }})** that helps more people contribute to Servo, as well as **[feature development](https://github.com/servo/project/issues/252)**.

Servo is also on [thanks.dev](https://thanks.dev), and already **37 GitHub users** (+0 from September) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

We now have [**sponsorship tiers**]({{ '/blog/2025/11/21/sponsorship-tiers/' | url }}) that allow you or your organisation to donate to the Servo project with public acknowlegement of your support.
If you’re interested in this kind of sponsorship, please contact us at [join@servo.org](mailto:join@servo.org).

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; right: calc(100% - 100% * 8057 / 10000); padding-right: 0.5em;"><strong>8057</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 8057 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
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
