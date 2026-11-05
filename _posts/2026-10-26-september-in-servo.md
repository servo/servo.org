---
layout:     post
tags:       blog
title:      "September in Servo: <progress>, rounded rectangles, and more!"
date:       2026-11-05
summary:    Plus new CSS functions and WEbGL2 improvements.
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

The developer tools console now **eagerly evaluates** JS inputs, allowing faster feedback ([@freyacodes](https://github.com/freyacodes), [#47527](https://github.com/servo/servo/pull/47527)).

We've shipped new web platform features:
* the **:checked** pseudoclass ([@skyz1](https://github.com/skyz1), [#47987](https://github.com/servo/servo/pull/47987))
* the **user-select** property ([@SimonSapin](https://github.com/SimonSapin), [@mrobinson](https://github.com/mrobinson), [#48137](https://github.com/servo/servo/pull/48137), [#48242](https://github.com/servo/servo/pull/48242))
* the **&lt;progress>** element ([@rayguo17](https://github.com/rayguo17), [#46974](https://github.com/servo/servo/pull/46974))
* CSS [typed arithmetic](https://developer.mozilla.org/en-US/docs/Web/CSS/Guides/Values_and_units/Using_typed_arithmetic) ([@Loirooriol](https://github.com/Loirooriol), [#48338](https://github.com/servo/servo/pull/48338))
* the **alpha()** CSS function ([@Loirooriol](https://github.com/Loirooriol), [#48344](https://github.com/servo/servo/pull/48344))
* the **font-width** property ([@Loirooriol](https://github.com/Loirooriol), [#47914](https://github.com/servo/servo/pull/47914))

Plus a bunch of new DOM APIs:
* **parentRule** on **CSSRule** and **CSSStyleDeclaration** ([@skyz1](https://github.com/skyz1), [#47743](https://github.com/servo/servo/pull/47743))
* **version** on **HTMLHtmlElement** ([@SilvioPilato](https://github.com/SilvioPilato), [#47786](https://github.com/servo/servo/pull/47786))
* **getComposedRanges()** and **direction** on **Selection** ([@mrobinson](https://github.com/mrobinson), [#47683](https://github.com/servo/servo/pull/47683))
* **baseURL** on **CSSStyleSheet** ([@Gae24](https://github.com/Gae24), [#47783](https://github.com/servo/servo/pull/47783))
* [**CSS modules**](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules#loading_non-javascript_resources)([@Gae24](https://github.com/Gae24), [#47813](https://github.com/servo/servo/pull/47813)) and **text modules** ([@Gae24](https://github.com/Gae24), [#47863](https://github.com/servo/servo/pull/47863))
* **getContextAttributes()** on **CanvasRenderingContext2D** and **OffscreenCanvasRenderingContext2D** ([@Taym95](https://github.com/Taym95), [#47868](https://github.com/servo/servo/pull/47868))
* the **Content-Language** header ([@TimvdLippe](https://github.com/TimvdLippe), [#47930](https://github.com/servo/servo/pull/47930))
* **dir** on **Document** ([@yezhizhen](https://github.com/yezhizhen), [#48170](https://github.com/servo/servo/pull/48170))
* **SVGAElement**, **SVGPatternElement**, **SVGTSpanElement**, **SVGTextContentElement**, **SVGTextElement**, **SVGTextPositioningElement** ([@mu-mostafa98](https://github.com/mu-mostafa98), [#48174](https://github.com/servo/servo/pull/48174))
* the **MLKEM768-X25519** algorithm for **WebCrypto** ([@kkoyung](https://github.com/kkoyung), [#48240](https://github.com/servo/servo/pull/48240), [#48282](https://github.com/servo/servo/pull/48282), [#48313](https://github.com/servo/servo/pull/48313), [#48350](https://github.com/servo/servo/pull/48350))
* **roundRect()** on **CanvasRenderingContext2D** ([@yezhizhen](https://github.com/yezhizhen), [#48293](https://github.com/servo/servo/pull/48293))
* **paintTime** and **presentationTime** on **PerformancePaintTiming** ([@shubhamg13](https://github.com/shubhamg13), [#47926](https://github.com/servo/servo/pull/47926))
* **getCueAsHTML()** on **VTTCue** ([@TimvdLippe](https://github.com/TimvdLippe), [#48146](https://github.com/servo/servo/pull/48146))

## Security

We upgraded to **SpiderMonkey v153.3** and **mozangle v0.7**, both of which included fixes for security bugs reported upstream ([@sagudev](https://github.com/sagudev), [#48176](https://github.com/servo/servo/pull/48176), [#47655](https://github.com/servo/servo/pull/47655), [#48259](https://github.com/servo/servo/pull/48259)).

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

Our accessibility tree (`--pref accessibility_enabled`) now **reports geometry bounds** for inline elements ([@alice](https://github.com/alice), [#47905](https://github.com/servo/servo/pull/47905)) and does much less work when responding to DOM changes ([@alice](https://github.com/alice), [@mrobinson](https://github.com/mrobinson), [#47690](https://github.com/servo/servo/pull/47690)).
Additionally, elements with `display: none` are reported as hidden ([@alice](https://github.com/alice), [#47772](https://github.com/servo/servo/pull/47772)).

We had lots of conformance improvements for our **WebGL2 implementation** (`--pref dom_webgl2_enabled`) ([@mxmgorin](https://github.com/mxmgorin), [#48423](https://github.com/servo/servo/pull/48423), [#48441](https://github.com/servo/servo/pull/48441), [#48470](https://github.com/servo/servo/pull/48470), [#48479](https://github.com/servo/servo/pull/48479), [#48495](https://github.com/servo/servo/pull/48495), [#48473](https://github.com/servo/servo/pull/48473), [#48536](https://github.com/servo/servo/pull/48536)).

Support for WSIWYG editors (which rely heavily on **`contenteditable`**) is going very well: keyboard inputs are now hooked up when `--pref dom_exec_command_enabled` is present, so many editors are now usable ([example](https://www.tiny.cloud/docs/tinymce/latest/basic-example/)).

**Closed captioning** for video elements is making progress.
Text tracks now fire `enter`, `exit`, and `cuechange` events ([@TimvdLippe](https://github.com/TimvdLippe), [#47725](https://github.com/servo/servo/pull/47725)).
Media elements now return the full sorted list of text tracks ([@TimvdLippe](https://github.com/TimvdLippe), [#47785](https://github.com/servo/servo/pull/47785)), and adding cues to a text track now sets that track correctly ([@TimvdLippe](https://github.com/TimvdLippe), [#48012](https://github.com/servo/servo/pull/48012)).
Text track objects now reflect the attributes of the associated `<track>` element.
Text track URLs are fetched at the correct time ([@TimvdLippe](https://github.com/TimvdLippe), [#48325](https://github.com/servo/servo/pull/48325)), and active cues are computed correctly ([@TimvdLippe](https://github.com/TimvdLippe), [#48305](https://github.com/servo/servo/pull/48305)), while text track cues are ordered as expected ([@TimvdLippe](https://github.com/TimvdLippe), [#48368](https://github.com/servo/servo/pull/48368)).
Additionally, WebVTT parsing can now recover from errors ([@TimvdLippe](https://github.com/TimvdLippe), [#48391](https://github.com/servo/servo/pull/48391)).

The **Sanitizer API** (`--pref dom_sanitizer_enabled`) now accepts the `javascriptURLs` property ([@skyz1](https://github.com/skyz1), [#47867](https://github.com/servo/servo/pull/47867)).

**IndexedDB** continues to improve: tables no longer error if unrelated tables contain duplicate index names (`--pref dom_indexeddb_enabled`) ([@leowatts](https://github.com/leowatts), [#47936](https://github.com/servo/servo/pull/47936)).
Additionally, we implemented **openCursor()** and **openKeyCursor()** on **IDBIndex** ([@kuntal-devrat](https://github.com/kuntal-devrat), [#48281](https://github.com/servo/servo/pull/48281)), as well as **advance()**, **continue()**, and **continuePrimaryKey()** on **IDBCursor** ([@kuntal-devrat](https://github.com/kuntal-devrat), [#48400](https://github.com/servo/servo/pull/48400)).

We implemented the **getTimeline()** and **setTimeline()** methods for the **Animation** interface (`--pref dom_web_animations_enabled`) ([@simonwuelker](https://github.com/simonwuelker), [#48122](https://github.com/servo/servo/pull/48122)).

## Embedding API

There's a new API for events originating from accessibility tools: [`Servo`](https://doc.servo.org/servo/struct.Servo.html)::[`forward_accessibility_action`](https://doc.servo.org/servo/struct.Servo.html#method.forward_accessibility_action) ([@alice](https://github.com/alice), [@mrobinson](https://github.com/mrobinson), [#48512](https://github.com/servo/servo/pull/48512)).

There is also an API to clear session history: [`WebView`](https://doc.servo.org/servo/struct.WebView.html)::[`clear_session_history`](https://doc.servo.org/servo/struct.WebView.html#method.clear_session_history) ([@Narfinger](https://github.com/Narfinger), [#47483](https://github.com/servo/servo/pull/47483)).

The [`WebView`](https://doc.servo.org/servo/struct.WebView.html)::`set_throttled` API has been removed ([@mrobinson](https://github.com/mrobinson), [#39923](https://github.com/servo/servo/pull/39923)).
Throttling automatically occurs when a WebView is [hidden](https://doc.servo.org/servo/struct.WebView.html#method.hide) and is stopped when [shown](https://doc.servo.org/servo/struct.WebView.html#method.show).

The [`WebViewDelegate`](https://doc.servo.org/servo/trait.WebViewDelegate.html)::`notify_focus_changed` method was removed, along with the [`Servo`](https://doc.servo.org/servo/struct.Servo.html) methods `focus` and `blur` ([@mrobinson](https://github.com/mrobinson), [#48364](https://github.com/servo/servo/pull/48364)).
Embedders must call [`WebView`](https://doc.servo.org/servo/struct.WebView.html)::[`set_focused`](https://doc.servo.org/servo/struct.WebView.html#method.set_focused) whenever a WebView has gained or lost system focus.

The `webgl` feature has been added to the `default_web_features` feature ([@janeoa](https://github.com/janeoa), [#47866](https://github.com/servo/servo/pull/47866)).
If an embedding does not want to ship with WebGL support they will now need to disable default features.

Multiprocess mode is enabled at build time with the new Cargo feature `multprocess` ([@Narfinger](https://github.com/Narfinger), [#47360](https://github.com/servo/servo/pull/47360)).
To remove support for this feature (reducing binary size by ~2MB), build Servo with default features disabled.

Two new preferences exist to tune garbage collector behaviour: `js_mem_gc_malloc_threshold_base_mb` and `js_mem_gc_urgent_threshold_mb` ([@mxmgorin](https://github.com/mxmgorin), [#47999](https://github.com/servo/servo/pull/47999)).
These can help on memory-constrained devices, and more information is available in the SpiderMonkey source ([base](https://searchfox.org/firefox-main/rev/28b7a7bffb5f82828143d9ad63839ad263b598be/js/src/gc/Scheduling.h#425-429), [urgent](https://searchfox.org/firefox-main/rev/28b7a7bffb5f82828143d9ad63839ad263b598be/js/src/gc/Scheduling.h#440-445)).

The JVM compatibility target was raised to 11 on Android ([@veyndan](https://github.com/veyndan), [#48414](https://github.com/servo/servo/pull/48414)).

## For users and developers

It is now possible to cross-compile the OpenHarmony build from Windows hosts ([@jschwe](https://github.com/jschwe), [#48392](https://github.com/servo/servo/pull/48392)).

Unhandled promise rejections are reported to the JS console ([@TTyChud](https://github.com/TTyChud), [#48486](https://github.com/servo/servo/pull/48486)), making it easier to narrow down web compatibility issues in Servo.

The OpenHarmony SDK was updated to API level 23 ([@Narfinger](https://github.com/Narfinger), [#48505](https://github.com/servo/servo/pull/48505)).

Pressing Control+A (or Command+A on macOS) now selects all the content in a document ([@dzfrias](https://github.com/dzfrias), [@mrobinson](https://github.com/mrobinson), [#48025](https://github.com/servo/servo/pull/48025)).
It is no longer possible to copy text inside of password inputs ([@dzfrias](https://github.com/dzfrias), [#48404](https://github.com/servo/servo/pull/48404)).

Embedder-originating JS (e.g. devtools console or embedding APIs) will always execute, even in documents that disable scripting via sandboxing or CSP ([@derdilla](https://github.com/derdilla), [#48394](https://github.com/servo/servo/pull/48394)).


## Performance and stability

We improved performance by removing **unnecessary allocations** ([@Narfinger](https://github.com/Narfinger), [@TimvdLippe](https://github.com/TimvdLippe), [@yezhizhen](https://github.com/yezhizhen), [#47689](https://github.com/servo/servo/pull/47689), [#47839](https://github.com/servo/servo/pull/47839), [#47838](https://github.com/servo/servo/pull/47838), [#47982](https://github.com/servo/servo/pull/47982), [#48006](https://github.com/servo/servo/pull/48006), [#48036](https://github.com/servo/servo/pull/48036), [#48099](https://github.com/servo/servo/pull/48099), [#48204](https://github.com/servo/servo/pull/48204), [#48127](https://github.com/servo/servo/pull/48127), [#48218](https://github.com/servo/servo/pull/48218), [#48357](https://github.com/servo/servo/pull/48357), [#48386](https://github.com/servo/servo/pull/48386), [#48422](https://github.com/servo/servo/pull/48422), [#48440](https://github.com/servo/servo/pull/48440), [#48452](https://github.com/servo/servo/pull/48452), [#48508](https://github.com/servo/servo/pull/48508)), **preallocating more** when building vectors ([@jschwe](https://github.com/jschwe), [@Narfinger](https://github.com/Narfinger), [@sagudev](https://github.com/sagudev), [@webbeef](https://github.com/webbeef), [#47455](https://github.com/servo/servo/pull/47455), [#47613](https://github.com/servo/servo/pull/47613), [#48026](https://github.com/servo/servo/pull/48026), [#48398](https://github.com/servo/servo/pull/48398)), and **avoiding IPC** in single process mode ([@leowatts](https://github.com/leowatts), [@Narfinger](https://github.com/Narfinger), [@Uiniel](https://github.com/Uiniel), [@TTyChud](https://github.com/TTyChud), [#47691](https://github.com/servo/servo/pull/47691), [#47718](https://github.com/servo/servo/pull/47718), [#48002](https://github.com/servo/servo/pull/48002), [#48073](https://github.com/servo/servo/pull/48073), [#48476](https://github.com/servo/servo/pull/48476), [#48435](https://github.com/servo/servo/pull/48435)).

We also sped up Servo by reducing interactions with the GC ([@TimvdLippe](https://github.com/TimvdLippe), [@Narfinger](https://github.com/Narfinger), [#47818](https://github.com/servo/servo/pull/47818), [#48257](https://github.com/servo/servo/pull/48257), [#48396](https://github.com/servo/servo/pull/48396)), and doing less work when modifying selections ([@SimonSapin](https://github.com/SimonSapin), [#47579](https://github.com/servo/servo/pull/47579)), dispatching events ([@webbeef](https://github.com/webbeef), [#48078](https://github.com/servo/servo/pull/48078)), calculating font metrics ([@RichardTjokroutomo](https://github.com/RichardTjokroutomo), [#48238](https://github.com/servo/servo/pull/48238)), and indexing window frames ([@mrobinson](https://github.com/mrobinson), [#47832](https://github.com/servo/servo/pull/47832)).

We **reduced memory usage** in common cases by reusing buffers ([@Narfinger](https://github.com/Narfinger), [#47751](https://github.com/servo/servo/pull/47751)), clearing more page-specific data ([@Radeonares32](https://github.com/Radeonares32), [@Narfinger](https://github.com/Narfinger), [@jschwe](https://github.com/jschwe), [@mrobinson](https://github.com/mrobinson), [@mxmgorin](https://github.com/mxmgorin), [#47651](https://github.com/servo/servo/pull/47651), [#47806](https://github.com/servo/servo/pull/47806), [#47805](https://github.com/servo/servo/pull/47805), [#48166](https://github.com/servo/servo/pull/48166), [#48295](https://github.com/servo/servo/pull/48295), [#48297](https://github.com/servo/servo/pull/48297), [#48016](https://github.com/servo/servo/pull/48016)), compacting data structures ([@Narfinger](https://github.com/Narfinger), [@webbeef](https://github.com/webbeef), [@SimonSapin](https://github.com/SimonSapin), [@mrobinson](https://github.com/mrobinson), [#47776](https://github.com/servo/servo/pull/47776), [#48039](https://github.com/servo/servo/pull/48039), [#48050](https://github.com/servo/servo/pull/48050), [#47742](https://github.com/servo/servo/pull/47742), [#48301](https://github.com/servo/servo/pull/48301), [#48296](https://github.com/servo/servo/pull/48296), [#48105](https://github.com/servo/servo/pull/48105)), and sharing more buffers ([@jdm](https://github.com/jdm), [#47998](https://github.com/servo/servo/pull/47998)).
We also fixed a memory leak involving `<audio>` and `<video>` elements ([@TTyChud](https://github.com/TTyChud), [#48371](https://github.com/servo/servo/pull/48371)).

We turned on **thread affinity boosting** on Linux, which can improve performance on some CPU architectures ([@jschwe](https://github.com/jschwe), [#47058](https://github.com/servo/servo/pull/47058)).

We're working on statically preventing [a footgun](https://github.com/servo/servo/issues/39139) that can lead to uncollectible GC cycles and leaking memory ([@Gae24](https://github.com/Gae24), [@jdm](https://github.com/jdm), [@lumiscosity](https://github.com/lumiscosity), [@SilvioPilato](https://github.com/SilvioPilato), [@sahilnyk](https://github.com/sahilnyk), [@TTyChud](https://github.com/TTyChud), [@kuntal-devrat](https://github.com/kuntal-devrat), [@MohamedAli00949](https://github.com/MohamedAli00949), [#47941](https://github.com/servo/servo/pull/47941), [#48013](https://github.com/servo/servo/pull/48013), [#48021](https://github.com/servo/servo/pull/48021), [#48035](https://github.com/servo/servo/pull/48035), [#48033](https://github.com/servo/servo/pull/48033), [#48051](https://github.com/servo/servo/pull/48051), [#48072](https://github.com/servo/servo/pull/48072), [#48171](https://github.com/servo/servo/pull/48171), [#48209](https://github.com/servo/servo/pull/48209), [#48248](https://github.com/servo/servo/pull/48248), [#48246](https://github.com/servo/servo/pull/48246), [#48264](https://github.com/servo/servo/pull/48264), [#48285](https://github.com/servo/servo/pull/48285), [#48311](https://github.com/servo/servo/pull/48311), [#48408](https://github.com/servo/servo/pull/48408), [#48053](https://github.com/servo/servo/pull/48053), [#48156](https://github.com/servo/servo/pull/48156), [#48186](https://github.com/servo/servo/pull/48186), [#48223](https://github.com/servo/servo/pull/48223), [#48315](https://github.com/servo/servo/pull/48315), [#47872](https://github.com/servo/servo/pull/47872), [#47698](https://github.com/servo/servo/pull/47698), [#47682](https://github.com/servo/servo/pull/47682), [#47735](https://github.com/servo/servo/pull/47735), [#47816](https://github.com/servo/servo/pull/47816), [#47817](https://github.com/servo/servo/pull/47817), [#47794](https://github.com/servo/servo/pull/47794), [#47909](https://github.com/servo/servo/pull/47909), [#47934](https://github.com/servo/servo/pull/47934), [#47935](https://github.com/servo/servo/pull/47935), [#47954](https://github.com/servo/servo/pull/47954), [#48022](https://github.com/servo/servo/pull/48022), [#47955](https://github.com/servo/servo/pull/47955), [#48058](https://github.com/servo/servo/pull/48058), [#48228](https://github.com/servo/servo/pull/48228), [#48247](https://github.com/servo/servo/pull/48247), [#48261](https://github.com/servo/servo/pull/48261), [#48280](https://github.com/servo/servo/pull/48280), [#48302](https://github.com/servo/servo/pull/48302), [#48316](https://github.com/servo/servo/pull/48316), [#48328](https://github.com/servo/servo/pull/48328), [#48346](https://github.com/servo/servo/pull/48346), [#48355](https://github.com/servo/servo/pull/48355), [#48262](https://github.com/servo/servo/pull/48262), [#48377](https://github.com/servo/servo/pull/48377), [#48304](https://github.com/servo/servo/pull/48304), [#48378](https://github.com/servo/servo/pull/48378), [#48388](https://github.com/servo/servo/pull/48388), [#48432](https://github.com/servo/servo/pull/48432)).

We fixed panics in **WebRTC** ([@MunishMummadi](https://github.com/MunishMummadi), [#4772](https://github.com/servo/servo/pull/4772)), **execCommand()** on **Document** ([@TimvdLippe](https://github.com/TimvdLippe), [#47784](https://github.com/servo/servo/pull/47784)), `<video>` ([@calvaris](https://github.com/calvaris), [#46148](https://github.com/servo/servo/pull/46148)), `<iframe>` ([@jdm](https://github.com/jdm), [#48465](https://github.com/servo/servo/pull/48465)), **SharedWorker** ([@mrobinson](https://github.com/mrobinson), [#47940](https://github.com/servo/servo/pull/47940)), **ancestorOrigins** on **Document** ([@mrobinson](https://github.com/mrobinson), [#48009](https://github.com/servo/servo/pull/48009)), `about:memory` ([@mxmgorin](https://github.com/mxmgorin), [#47686](https://github.com/servo/servo/pull/47686), [#48001](https://github.com/servo/servo/pull/48001)), and EGL 1.4 configurations ([@mxmgorin](https://github.com/mxmgorin), [#47803](https://github.com/servo/servo/pull/47803)).

We also fixed a very ironic panic triggered by the `about:crash` page that loads when a normal page triggers a panic ([@mrobinson](https://github.com/mrobinson), [#48055](https://github.com/servo/servo/pull/48055))

The JS console no longer hangs when primitive values as thrown as exceptions ([@FatCat560](https://github.com/FatCat560), [#47629](https://github.com/servo/servo/pull/47629)).
Servo no longer hangs on shutdown in multiprocess mode ([@Narfinger](https://github.com/Narfinger), [#48523](https://github.com/servo/servo/pull/48523)), when certain pages use **IntersectionObserver** ([@mxmgorin](https://github.com/mxmgorin), [#47693](https://github.com/servo/servo/pull/47693)), when closing a browsing context with pending WebDriver commands ([@yezhizhen](https://github.com/yezhizhen), [#48131](https://github.com/servo/servo/pull/48131), [#48172](https://github.com/servo/servo/pull/48172)), or when closing **SharedWorker**s ([@nicoburns](https://github.com/nicoburns), [#48477](https://github.com/servo/servo/pull/48477)).

`about:memory` got more improvements: we measure more memory for SVG rendering ([@Narfinger](https://github.com/Narfinger), [@mrobinson](https://github.com/mrobinson), [#47061](https://github.com/servo/servo/pull/47061)), WebAudio ([@jdm](https://github.com/jdm), [#47996](https://github.com/servo/servo/pull/47996)), and identify globals that have been leaked ([@jdm](https://github.com/jdm), [#48237](https://github.com/servo/servo/pull/48237)).

## More on the web platform

CSS images now **delay the `load` event**, leading to more consistent behaviour for engine users performing visual rendering ([@TimvdLippe](https://github.com/TimvdLippe), [#48199](https://github.com/servo/servo/pull/48199)).

Interactive selections in documents continued to improve!
They now can span shadow trees ([@mrobinson](https://github.com/mrobinson), [@SimonSapin](https://github.com/SimonSapin), [#47931](https://github.com/servo/servo/pull/47931), [#47694](https://github.com/servo/servo/pull/47694), [#47895](https://github.com/servo/servo/pull/47895)), and have consistent heights and positions ([@mrobinson](https://github.com/mrobinson), [#47937](https://github.com/servo/servo/pull/47937)), plus there are new context menu entries to copy and select all ([@mrobinson](https://github.com/mrobinson), [#48101](https://github.com/servo/servo/pull/48101)).
Additionally, image-based content shows when it is part of a selection ([@mrobinson](https://github.com/mrobinson), [#48149](https://github.com/servo/servo/pull/48149)).

`Window.open()` respects sandbox flags that prevent popups ([@mrobinson](https://github.com/mrobinson), [#47653](https://github.com/servo/servo/pull/47653)).

**LargestContentfulPaint** now reports the **loadTime** for image content ([@shubhamg13](https://github.com/shubhamg13), [#48286](https://github.com/servo/servo/pull/48286)), ignores cross-origin frames ([@shubhamg13](https://github.com/shubhamg13), [#48094](https://github.com/servo/servo/pull/48094)), ignores invisible text ([@shubhamg13](https://github.com/shubhamg13), [#48010](https://github.com/servo/servo/pull/48010)), and reports null elements when they are removed from the tree ([@shubhamg13](https://github.com/shubhamg13), [#48125](https://github.com/servo/servo/pull/48125)).

**select()** on a text input now focuses the control ([@dzfrias](https://github.com/dzfrias), [@mrobinson](https://github.com/mrobinson), [#48475](https://github.com/servo/servo/pull/48475)).

Our WebDriver server now automates setting permissions ([@xbwwj](https://github.com/xbwwj), [@yezhizhen](https://github.com/yezhizhen), [#47623](https://github.com/servo/servo/pull/47623)), while sending click events and keyboard actions uses fewer delays ([@yezhizhen](https://github.com/yezhizhen), [#48066](https://github.com/servo/servo/pull/48066)).

There are more useful error messages for methods on **Document** ([@eachra-bawn](https://github.com/eachra-bawn), [#47835](https://github.com/servo/servo/pull/47835)) and **CSS**-related interfaces ([@eachra-bawn](https://github.com/eachra-bawn), [@jdm](https://github.com/jdm), [#47746](https://github.com/servo/servo/pull/47746)).

We upgraded our [stylo](https://crates.io/crates/stylo) dependency, which improves compatibility with **contrast-color()**, **color-mix()**, **vertical-align**, **list-style**, **place-items**, **at-rule()**, **calc()**, **alpha()**, **attr()**, **content: attr()**, and **named-feature()** ([@Loirooriol](https://github.com/Loirooriol), [#46987](https://github.com/servo/servo/pull/46987), [#47942](https://github.com/servo/servo/pull/47942)).

We also fixed bugs related to **visibilityState** on **Document** ([@yezhizhen](https://github.com/yezhizhen), [#47908](https://github.com/servo/servo/pull/47908)), **containsNode()** on **Selection** ([@mrobinson](https://github.com/mrobinson), [#47938](https://github.com/servo/servo/pull/47938)), **setKeyframes** on **KeyframeEffect** ([@simonwuelker](https://github.com/simonwuelker), [#48103](https://github.com/servo/servo/pull/48103)), selections when focusing a text input ([@mrobinson](https://github.com/mrobinson), [#48107](https://github.com/servo/servo/pull/48107)), **AudioParam** clamping and automation ([@kevlu93](https://github.com/kevlu93), [#48351](https://github.com/servo/servo/pull/48351), [#48347](https://github.com/servo/servo/pull/48347)), **PannerNode** outputs ([@kevlu93](https://github.com/kevlu93), [#48510](https://github.com/servo/servo/pull/48510)), the **muted** attribute on **HTMLMediaElement** ([@TimvdLippe](https://github.com/TimvdLippe), [#48403](https://github.com/servo/servo/pull/48403)), placeholders in text inputs ([@jdm](https://github.com/jdm), [#47761](https://github.com/servo/servo/pull/47761), [#47797](https://github.com/servo/servo/pull/47797)), animations when modifying document stylesheets ([@SharanRP](https://github.com/SharanRP), [#48000](https://github.com/servo/servo/pull/48000)), gradient color stops ([@BudiArb](https://github.com/BudiArb), [#48288](https://github.com/servo/servo/pull/48288)), sticky table rows ([@TTyChud](https://github.com/TTyChud), [#48380](https://github.com/servo/servo/pull/48380)), **::first-letter** ([@Loirooriol](https://github.com/Loirooriol), [#48307](https://github.com/servo/servo/pull/48307)), **text-wrap-mode** ([@mrobinson](https://github.com/mrobinson), [#48469](https://github.com/servo/servo/pull/48469)), OTF fonts ([@wood-ghost](https://github.com/wood-ghost), [#47904](https://github.com/servo/servo/pull/47904)), CSS and nosniff ([@sahvx655-wq](https://github.com/sahvx655-wq), [#45481](https://github.com/servo/servo/pull/45481)), **Sec-Fetch-** headers and redirects ([@TimvdLippe](https://github.com/TimvdLippe), [#48203](https://github.com/servo/servo/pull/48203)), **moveBefore()** on **Node** ([@mrobinson](https://github.com/mrobinson), [#47692](https://github.com/servo/servo/pull/47692)), **supports()** on **WebCrypto** ([@kkoyung](https://github.com/kkoyung), [#47768](https://github.com/servo/servo/pull/47768), [#47891](https://github.com/servo/servo/pull/47891), [#47953](https://github.com/servo/servo/pull/47953), [#47984](https://github.com/servo/servo/pull/47984), [#48410](https://github.com/servo/servo/pull/48410), [#47545](https://github.com/servo/servo/pull/47545)), cross-origin windows ([@mrobinson](https://github.com/mrobinson), [@jdm](https://github.com/jdm), [#47632](https://github.com/servo/servo/pull/47632), [#48411](https://github.com/servo/servo/pull/48411), [#48038](https://github.com/servo/servo/pull/48038)), origins of `about:blank` and `about:srcdoc` ([@mrobinson](https://github.com/mrobinson), [#47630](https://github.com/servo/servo/pull/47630)), `keypress` events ([@mrobinson](https://github.com/mrobinson), [#48324](https://github.com/servo/servo/pull/48324)), text and media documents ([@SilvioPilato](https://github.com/SilvioPilato), [#47823](https://github.com/servo/servo/pull/47823)), **body()** on **Response** ([@TTyChud](https://github.com/TTyChud), [#48409](https://github.com/servo/servo/pull/48409)), `<details>` with `<summary>` ([@TimvdLippe](https://github.com/TimvdLippe), [#48224](https://github.com/servo/servo/pull/48224)), editing hidden inputs ([@dzfrias](https://github.com/dzfrias), [#48165](https://github.com/servo/servo/pull/48165)), attribute nodes in XPath ([@leowatts](https://github.com/leowatts), [@mrobinson](https://github.com/mrobinson), [#47912](https://github.com/servo/servo/pull/47912)), absolutely positioned boxes ([@mxmgorin](https://github.com/mxmgorin), [#48081](https://github.com/servo/servo/pull/48081)), CSS Grid containers with absolutely positioned nodes ([@nicoburns](https://github.com/nicoburns), [#47519](https://github.com/servo/servo/pull/47519)), **WebDriver** wheel/pointer actions ([@yezhizhen](https://github.com/yezhizhen), [#48143](https://github.com/servo/servo/pull/48143)), and **blob:** URLs ([@Gae24](https://github.com/Gae24), [#47910](https://github.com/servo/servo/pull/47910)).

## New contributors

A special thanks to the following people for landing their first patch in Servo:

* Arnau Camprubí ([@Arnau478](https://github.com/Arnau478), [#47726](https://github.com/servo/servo/pull/47726))
* Silvio Pilato ([@SilvioPilato](https://github.com/SilvioPilato), [#47786](https://github.com/servo/servo/pull/47786))
* Radeonares32 ([@Radeonares32](https://github.com/Radeonares32), [#47651](https://github.com/servo/servo/pull/47651))
* derdilla ([@derdilla](https://github.com/derdilla), [#47828](https://github.com/servo/servo/pull/47828))
* pr3pony ([@pr3pony](https://github.com/pr3pony), [#48030](https://github.com/servo/servo/pull/48030))
* Mario ([@Fatcat560](https://github.com/Fatcat560), [#47629](https://github.com/servo/servo/pull/47629))
* TtyChud ([@TTyChud](https://github.com/TTyChud), [#48228](https://github.com/servo/servo/pull/48228))
* Devrate Kuntal ([@kuntal-devrat](https://github.com/kuntal-devrat), [#48247](https://github.com/servo/servo/pull/48247))
* Diego Frias ([@dzfrias](https://github.com/dzfrias), [#48025](https://github.com/servo/servo/pull/48025))
* LiamillionSS ([@LiamillionSS](https://github.com/LiamillionSS), [#48424](https://github.com/servo/servo/pull/48424))

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
