---
layout:     post
tags:       blog
title:      "Two months in Servo: CSS nesting, Shadow DOM, Clipboard API, and more!"
date:       2025-05-09
summary:    Try our new about:memory page and --enable-experimental-web-platform-features.
categories:
---

Before we start, let’s address the elephant in the room.
Last month, we proposed that we would change our [AI contributions policy](https://book.servo.org/contributing.html#ai-contributions) to allow the use of AI tools in some situations, including GitHub Copilot for code.
[The feedback we received](https://github.com/servo/servo/discussions/36379) from the community was overwhelmingly clear, and we’ve listened.
We will **keep the AI contributions ban in place**, and any future proposals regarding this policy will be discussed together, as a community.

At the same time, we have other big news!
Complex sites such as **Gmail** and **Google Chat** are **now usable in Servo**, with some caveats.
This milestone is only possible through the continued hard work of many Servo contributors across the engine, and we're thankful for all of the efforts to reach this point.

<figure><a href="{{ '/img/blog/2025-04-servo-gchat.png' | url }}"><img alt="Google Chat rendering in Servo" src="{{ '/img/blog/2025-04-servo-gchat.png' | url }}"></a></figure>
<figure><a href="{{ '/img/blog/2025-04-servo-gmail.png' | url }}"><img alt="Gmail rendering in Servo" src="{{ '/img/blog/2025-04-servo-gmail.png' | url }}"></a></figure>

<aside class=_note>

**Caveats:** must run Servo with `--enable-experimental-web-platform-features --pref dom_abort_controller_enabled`. Accounts with 2FA enabled may not be able to log in yet.
</aside>

Servo now supports single-valued **&lt;select> elements** ([@simonwuelker](https://github.com/simonwuelker), [#35684](https://github.com/servo/servo/pull/35684), [#36677](https://github.com/servo/servo/pull/36677)), disabling stylesheets with **&lt;link disabled>** ([@Loirooriol](https://github.com/Loirooriol), [#36446](https://github.com/servo/servo/pull/36446)), and the **Refresh** header in HTTP responses and &lt;meta> ([@sebsebmc](https://github.com/sebsebmc), [#36393](https://github.com/servo/servo/pull/36393)), plus several new CSS features:

- the **&amp;** selector for **CSS nesting** ([@Loirooriol](https://github.com/Loirooriol), [#36246](https://github.com/servo/servo/pull/36246), [#36254](https://github.com/servo/servo/pull/36254), [#36248](https://github.com/servo/servo/pull/36248), [#36249](https://github.com/servo/servo/pull/36249))
- **‘scale’**, **‘rotate’**, and **‘translate’** ([@chocolate-pie](https://github.com/chocolate-pie), [@Loirooriol](https://github.com/Loirooriol), [#35926](https://github.com/servo/servo/pull/35926))
- **‘will-change’** ([@yezhizhen](https://github.com/yezhizhen), [#35787](https://github.com/servo/servo/pull/35787))
- the **‘fit-content()’** sizing function ([@Loirooriol](https://github.com/Loirooriol), [#36056](https://github.com/servo/servo/pull/36056))
- the **‘image-set()’** notation ([@chocolate-pie](https://github.com/chocolate-pie), [#36210](https://github.com/servo/servo/pull/36210))

We’ve also landed a bunch of new web API features:

- the **Response.json()** static method ([@sebsebmc](https://github.com/sebsebmc), [#36589](https://github.com/servo/servo/pull/36589), [#36523](https://github.com/servo/servo/pull/36523))
- the **CSSStyleSheet()** constructor ([@Loirooriol](https://github.com/Loirooriol), [#36521](https://github.com/servo/servo/pull/36521))
- the **seekable** property on **HTMLMediaElement** ([@rayguo17](https://github.com/rayguo17), [#36541](https://github.com/servo/servo/pull/36541))
- the **label** property on **HTMLOptGroupElement** ([@simonwuelker](https://github.com/simonwuelker), [#35970](https://github.com/servo/servo/pull/35970))
- the **align** property on **HTMLParagraphElement** ([@stephenmuss](https://github.com/stephenmuss), [#36054](https://github.com/servo/servo/pull/36054))
- **ClipboardItem** and **navigator.clipboard.writeText()** ([@Gae24](https://github.com/Gae24), [#36336](https://github.com/servo/servo/pull/36336), [#36498](https://github.com/servo/servo/pull/36498))
- **addRule()**, **removeRules()**, **replaceSync()**, and the **rules** property on **CSSStyleSheet** ([@Loirooriol](https://github.com/Loirooriol), [@webbeef](https://github.com/webbeef), [#36313](https://github.com/servo/servo/pull/36313), [#36586](https://github.com/servo/servo/pull/36586))
- **getLineDash()**, **setLineDash()**, and **lineDashOffset** on **CanvasRenderingContext2D** ([@stevennovaryo](https://github.com/stevennovaryo), [#36257](https://github.com/servo/servo/pull/36257))
- **ReadableByteStreamController** and **pipeTo()** on **ReadableStream** ([@Taym95](https://github.com/Taym95), [@gterzian](https://github.com/gterzian), [#35410](https://github.com/servo/servo/pull/35410), [#35650](https://github.com/servo/servo/pull/35650))

<figure><a href="{{ '/img/blog/april-2025.png' | url }}"><img alt="servoshell showing new support for ‘image-set()’, ‘fit-content()’, ‘scale’, ‘translate’, ‘rotate’, ‘setLineDash()’, caret and text selection in <input>, and single-valued <select>" src="{{ '/img/blog/april-2025.png' | url }}"></a></figure>

[The biggest engine improvements](https://servo.org/wpt/) we’ve made recently were in **Shadow DOM** (+70.0pp to 77.9%), the **Trusted Types API** (+57.8pp to 57.8%), **Content Security Policy** (+54.0pp to 54.8%), the **Streams API** (+31.9pp to 68.1%), and **CSS Text** (+20.4pp to 57.6%).

We've **enabled Shadow DOM by default** after significantly improving support, allowing Servo to render sites like [wpt.fyi](https://wpt.fyi) correctly ([@simonwuelker](https://github.com/simonwuelker), [@longvatron111](https://github.com/longvatron111), [@elomscansio](https://github.com/elomscansio), [@jdm](https://github.com/jdm), [@sakupi01](https://github.com/sakupi01), [#35923](https://github.com/servo/servo/pull/35923), [#35899](https://github.com/servo/servo/pull/35899), [#35930](https://github.com/servo/servo/pull/35930), [#36104](https://github.com/servo/servo/pull/36104), [#34964](https://github.com/servo/servo/pull/34964), [#36024](https://github.com/servo/servo/pull/36024), [#36106](https://github.com/servo/servo/pull/36106), [#36173](https://github.com/servo/servo/pull/36173), [#36010](https://github.com/servo/servo/pull/36010), [#35769](https://github.com/servo/servo/pull/35769), [#36230](https://github.com/servo/servo/pull/36230), [#36620](https://github.com/servo/servo/pull/36620)).

<figure><a href="{{ '/img/blog/2025-04-servo-wptfyi.png' | url }}"><img alt="wpt.fyi rendering in Servo" src="{{ '/img/blog/2025-04-servo-wptfyi.png' | url }}"></a></figure>

**ReadableStream**, **WritableStream**, **DOMPoint**, **DOMPointReadOnly**, and **DOMException** can now be sent over **postMessage()** and **structuredClone()** ([@gterzian](https://github.com/gterzian), [@kkoyung](https://github.com/kkoyung), [@jdm](https://github.com/jdm), [@mrobinson](https://github.com/mrobinson), [#36181](https://github.com/servo/servo/pull/36181), [#36588](https://github.com/servo/servo/pull/36588), [#36535](https://github.com/servo/servo/pull/36535), [#35989](https://github.com/servo/servo/pull/35989)).

We’ve started working on support for **stream transforms** ([@Taym95](https://github.com/Taym95), [#36470](https://github.com/servo/servo/pull/36470)) and the [**trusted types API**](https://developer.mozilla.org/en-US/docs/Web/API/Trusted_Types_API) ([@TimvdLippe](https://github.com/TimvdLippe), [@jdm](https://github.com/jdm), [#36354](https://github.com/servo/servo/pull/36354), [#36355](https://github.com/servo/servo/pull/36355), [#36422](https://github.com/servo/servo/pull/36422), [#36454](https://github.com/servo/servo/pull/36454), [#36409](https://github.com/servo/servo/pull/36409), [#36363](https://github.com/servo/servo/pull/36363), [#36511](https://github.com/servo/servo/pull/36511), [#36596](https://github.com/servo/servo/pull/36596)).
We’ve also laid the groundwork for supporting the **::marker pseudo element** ([@mrobinson](https://github.com/mrobinson), [#36202](https://github.com/servo/servo/pull/36202)), **animated images** in web content ([@rayguo17](https://github.com/rayguo17), [#36058](https://github.com/servo/servo/pull/36058), [#36141](https://github.com/servo/servo/pull/36141)), and **getClientRects()** and **getBoundingClientRect()** on **Range** ([@simonwuelker](https://github.com/simonwuelker), [#35993](https://github.com/servo/servo/pull/35993)).

Servo can now render the **caret** and **text selection** in input fields ([@dklassic](https://github.com/dklassic), [@webbeef](https://github.com/webbeef), [#35830](https://github.com/servo/servo/pull/35830), [#36478](https://github.com/servo/servo/pull/36478)), and we’ve landed a few fixes to **radio buttons** ([@elomscansio](https://github.com/elomscansio), [#36252](https://github.com/servo/servo/pull/36252), [#36431](https://github.com/servo/servo/pull/36431)), **file inputs** ([@sebsebmc](https://github.com/sebsebmc), [#36458](https://github.com/servo/servo/pull/36458)), and **input validation** ([@MDCODE247](https://github.com/MDCODE247), [#36236](https://github.com/servo/servo/pull/36236)).

Having disabled by default Servo's original, experimental layout implementation [back in November 2024]({{ '/blog/2024/12/09/this-month-in-servo/' | url }}), we’ve now taken the step of **deleting all of the disabled code** ([@Loirooriol](https://github.com/Loirooriol), [@TimvdLippe](https://github.com/TimvdLippe), [@mrobinson](https://github.com/mrobinson), [#35943](https://github.com/servo/servo/pull/35943), [#36281](https://github.com/servo/servo/pull/36281), [#36698](https://github.com/servo/servo/pull/36698)) and moving all of the remaining layout code to [`layout`](https://doc.servo.org/layout/) ([@mrobinson](https://github.com/mrobinson), [#36613](https://github.com/servo/servo/pull/36613)).
Our new layout engine is improving significantly month over month!

We’ve added a **new `--enable-experimental-web-platform-features` option** that enables all engine features, even those that may not be stable or complete.
This works much like [Chromium’s option with the same name](https://source.chromium.org/chromium/chromium/src/+/main:third_party/blink/renderer/platform/RuntimeEnabledFeatures.md;drc=a4e3e1f59b6f4bcf64806cf40c1acbb043b0bddc), and it can be useful when a page is not functioning correctly, since it may allow the page to make further progress.
Servo now uses this option when running the Web Platform Tests ([@Loirooriol](https://github.com/Loirooriol), [#36335](https://github.com/servo/servo/pull/36335), [#36519](https://github.com/servo/servo/pull/36519), [#36348](https://github.com/servo/servo/pull/36348), [#36475](https://github.com/servo/servo/pull/36475)), and the features enabled by this option are expected to change over time.

## Servo-the-browser (servoshell)

[Our devtools integration](https://book.servo.org/hacking/using-devtools.html) now **supports iframes** ([@simonwuelker](https://github.com/simonwuelker), [#35874](https://github.com/servo/servo/pull/35874)) and **color scheme simulation** ([@uthmaniv](https://github.com/uthmaniv), [#36253](https://github.com/servo/servo/pull/36253), [#36168](https://github.com/servo/servo/pull/36168), [#36297](https://github.com/servo/servo/pull/36297)), shows **computed display values** when inspecting elements ([@stephenmuss](https://github.com/stephenmuss), [#35870](https://github.com/servo/servo/pull/35870)), and supports **multiple tabs** open in the servoshell browser ([@atbrakhi](https://github.com/atbrakhi), [#35884](https://github.com/servo/servo/pull/35884)).
We’ve also landed the beginnings of a **Sources panel** ([@delan](https://github.com/delan), [@atbrakhi](https://github.com/atbrakhi), [#36164](https://github.com/servo/servo/pull/36164), [#35971](https://github.com/servo/servo/pull/35971), [#36631](https://github.com/servo/servo/pull/36631), [#36632](https://github.com/servo/servo/pull/36632), [#36667](https://github.com/servo/servo/pull/36667)).
To use devtools, we now **require Firefox 133 or newer** ([@atbrakhi](https://github.com/atbrakhi), [#35792](https://github.com/servo/servo/pull/35792)).

Dialogs support **keyboard interaction** to close and cancel them ([@chickenleaf](https://github.com/chickenleaf), [#35673](https://github.com/servo/servo/pull/35673)), and the URL bar accepts any **domain-like input** ([@kafji](https://github.com/kafji), [#35756](https://github.com/servo/servo/pull/35756)).
We’ve also enabled **sRGB colorspaces** on macOS for better colour fidelity ([@IsaacMarovitz](https://github.com/IsaacMarovitz), [#35683](https://github.com/servo/servo/pull/35683)).
Using the `--userscripts` option without providing a path **defaults to `resources/user-agent-js`**.
Finally, we’ve **renamed the OpenHarmony app bundle** ([@jschwe](https://github.com/jschwe), [#35790](https://github.com/servo/servo/pull/35790)).

## Servo-the-engine (embedding)

We’ve landed some big changes to our webview API:

- **pinch zoom**, **page zoom**, and **HiDPI scaling** are now handled independently **for each webview** ([@mrobinson](https://github.com/mrobinson), [@shubhamg13](https://github.com/shubhamg13), [#36419](https://github.com/servo/servo/pull/36419), [#36312](https://github.com/servo/servo/pull/36312))
- **mouse click events** no longer need to be generated by the embedder, only mouse button down and up events ([@yezhizhen](https://github.com/yezhizhen), [#36413](https://github.com/servo/servo/pull/36413))
- webviews are now created with [**WebViewBuilder**](https://doc.servo.org/servo/struct.WebViewBuilder.html) ([@mrobinson](https://github.com/mrobinson), [#36483](https://github.com/servo/servo/pull/36483))
- **EmbedderMethods** is now [**ServoBuilder**](https://doc.servo.org/servo/struct.ServoBuilder.html) ([@mrobinson](https://github.com/mrobinson), [#36276](https://github.com/servo/servo/pull/36276), [#36549](https://github.com/servo/servo/pull/36549))
- **WindowMethods** have moved to [**WebViewDelegate**](https://doc.servo.org/servo/webview_delegate/trait.WebViewDelegate.html) and [**ServoDelegate**](https://doc.servo.org/servo/servo_delegate/trait.ServoDelegate.html) ([@mrobinson](https://github.com/mrobinson), [#36223](https://github.com/servo/servo/pull/36223), [#36400](https://github.com/servo/servo/pull/36400))

Embedders can now **inject userscript sources** into all webviews ([@Legend-Master](https://github.com/Legend-Master), [#35388](https://github.com/servo/servo/pull/35388)).
Links can be **opened in a new tab** by pressing the **Ctrl** or **⌘** modifier ([@webbeef](https://github.com/webbeef), [@mrobinson](https://github.com/mrobinson), [#35017](https://github.com/servo/servo/pull/35017)).
Delegates will receive **send error notifications** for requests ([@delan](https://github.com/delan), [#35668](https://github.com/servo/servo/pull/35668)), and we made progress towards a per-webview renderer model ([@mrobinson](https://github.com/mrobinson), [@delan](https://github.com/delan), [#35701](https://github.com/servo/servo/pull/35701), [#35716](https://github.com/servo/servo/pull/35716)).

We fixed a bug causing **flickering cursors** ([@DevGev](https://github.com/DevGev), [#35934](https://github.com/servo/servo/pull/35934)), and now **create the config directory** if it does not exist ([@yezhizhen](https://github.com/yezhizhen), [#35761](https://github.com/servo/servo/pull/35761)).
We also fixed a number of bugs in the WebDriver server related to clicking on elements, opening and closing windows, and returning references to exotic objects ([@jdm](https://github.com/jdm), [#35737](https://github.com/servo/servo/pull/35737)).

## Under the hood

We’ve finally finished **splitting up our massive `script` crate** ([@jdm](https://github.com/jdm), [#35988](https://github.com/servo/servo/pull/35988), [#35987](https://github.com/servo/servo/pull/35987), [#36107](https://github.com/servo/servo/pull/36107), [#36216](https://github.com/servo/servo/pull/36216), [#36220](https://github.com/servo/servo/pull/36220), [#36095](https://github.com/servo/servo/pull/36095), [#36323](https://github.com/servo/servo/pull/36323)), which should **cut incremental build times** for that crate **by 60%**.
This is something we’ve wanted to do for **over eleven years** ([@kmcallister](https://github.com/kmcallister), [#1799](https://github.com/servo/servo/issues/1799))!

**`webgpu` rebuilds are now faster** as well, with changes to that crate no longer requiring a `script` rebuild ([@mrobinson](https://github.com/mrobinson), [#36332](https://github.com/servo/servo/pull/36332), [#36320](https://github.com/servo/servo/pull/36320)).

**Stylo** has been upgraded to 2025-03-15 ([@nicoburns](https://github.com/nicoburns), [@Loirooriol](https://github.com/Loirooriol), [#35782](https://github.com/servo/servo/pull/35782), [#35925](https://github.com/servo/servo/pull/35925), [#35990](https://github.com/servo/servo/pull/35990)), and we upgraded to the **2024 Rust edition** ([@simonwuelker](https://github.com/simonwuelker), [#35755](https://github.com/servo/servo/pull/35755)).

We added a memory usage view for Servo embedders: **visit about:memory** for a breakdown of identified allocations ([@webbeef](https://github.com/webbeef), [@jdm](https://github.com/jdm), [#35728](https://github.com/servo/servo/pull/35728), [#36557](https://github.com/servo/servo/pull/36557), [#36558](https://github.com/servo/servo/pull/36558), [#36556](https://github.com/servo/servo/pull/36556), [#36581](https://github.com/servo/servo/pull/36581), [#36553](https://github.com/servo/servo/pull/36553), [#36664](https://github.com/servo/servo/pull/36664)).

<figure><a href="{{ '/img/blog/2025-04-servo-aboutmemory.png' | url }}"><img alt="about:memory screenshot" src="{{ '/img/blog/2025-04-servo-aboutmemory.png' | url }}"></a></figure>

## Perf and stability

We’ve started building an **incremental layout** system in Servo ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#36404](https://github.com/servo/servo/pull/36404), [#36448](https://github.com/servo/servo/pull/36448), [#36447](https://github.com/servo/servo/pull/36447), [#36513](https://github.com/servo/servo/pull/36513)), with a huge speedup to **offsetWidth**, **offsetHeight**, **offsetLeft**, **offsetTop**, and **offsetParent** layout queries ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#36583](https://github.com/servo/servo/pull/36583), [#36629](https://github.com/servo/servo/pull/36629), [#36681](https://github.com/servo/servo/pull/36681), [#36663](https://github.com/servo/servo/pull/36663)).
Incremental layout will allow Servo to respond to page updates and layout queries without repeating layout work, which is critical on today’s highly dynamic web.

[OffscreenRenderingContext](https://doc.servo.org/servo/struct.OffscreenRenderingContext.html) is **no longer double buffered**, which can improve rendering performance in embeddings that rely on it.
We also removed a source of **canvas rendering latency** ([@sagudev](https://github.com/sagudev), [#35719](https://github.com/servo/servo/pull/35719)), and fixed performance cliffs related to the Shadow DOM ([@simonwuelker](https://github.com/simonwuelker), [#35802](https://github.com/servo/servo/pull/35802), [#35725](https://github.com/servo/servo/pull/35725)).
We improved layout performance by **reducing allocations** ([@jschwe](https://github.com/jschwe), [#35781](https://github.com/servo/servo/pull/35781)) and **caching layout results** ([@Loirooriol](https://github.com/Loirooriol), [@mrobinson](https://github.com/mrobinson), [#36082](https://github.com/servo/servo/pull/36082)), and reduced the **latency of touch events** when they are non-cancelable ([@kongbai1996](https://github.com/kongbai1996), [#35785](https://github.com/servo/servo/pull/35785)).

We also fixed crashes involving **touch events** ([@kongbai1996](https://github.com/kongbai1996), [@jschwe](https://github.com/jschwe), [#35763](https://github.com/servo/servo/pull/35763), [#36531](https://github.com/servo/servo/pull/36531), [#36229](https://github.com/servo/servo/pull/36229)), **service workers** ([@jdm](https://github.com/jdm), [#36256](https://github.com/servo/servo/pull/36256)), **WritableStream** ([@Taym95](https://github.com/Taym95), [#36566](https://github.com/servo/servo/pull/36566)), **Location** ([@jdm](https://github.com/jdm), [#36494](https://github.com/servo/servo/pull/36494)), **&lt;canvas>** ([@tharkum](https://github.com/tharkum), [@simonwuelker](https://github.com/simonwuelker), [#36569](https://github.com/servo/servo/pull/36569), [#36705](https://github.com/servo/servo/pull/36705)), **&lt;input>** ([@dklassic](https://github.com/dklassic), [#36461](https://github.com/servo/servo/pull/36461)), **&lt;iframe>** ([@leftmostcat](https://github.com/leftmostcat), [#35742](https://github.com/servo/servo/pull/35742)), **‘min-content’** and **‘max-content’** ([@Loirooriol](https://github.com/Loirooriol), [#36518](https://github.com/servo/servo/pull/36518), [#36571](https://github.com/servo/servo/pull/36571)), **flexbox** ([@mrobinson](https://github.com/mrobinson), [#36123](https://github.com/servo/servo/pull/36123)), global objects ([@jdm](https://github.com/jdm), [#36491](https://github.com/servo/servo/pull/36491)), resizing the viewport ([@sebsebmc](https://github.com/sebsebmc), [#35967](https://github.com/servo/servo/pull/35967)), and `--pref shell_background_color_rgba` ([@boluochoufeng](https://github.com/boluochoufeng), [#35865](https://github.com/servo/servo/pull/35865)).
Additionally, we **removed undefined behaviour** from the Rust bindings to the SpiderMonkey engine ([@gmorenz](https://github.com/gmorenz), [#35892](https://github.com/servo/servo/pull/35892), [#36160](https://github.com/servo/servo/pull/36160), [#36161](https://github.com/servo/servo/pull/36161), [#36158](https://github.com/servo/servo/pull/36158)).

The project to decrease the risk of [intermittent GC-related crashes](https://github.com/servo/servo/issues/33140) continues to make progress ([@jdm](https://github.com/jdm), [@Arya-A-Nair](https://github.com/Arya-A-Nair), [@Dericko681](https://github.com/Dericko681), [@yerke](https://github.com/yerke), [#35753](https://github.com/servo/servo/pull/35753), [#36014](https://github.com/servo/servo/pull/36014), [#36043](https://github.com/servo/servo/pull/36043), [#36156](https://github.com/servo/servo/pull/36156), [#36116](https://github.com/servo/servo/pull/36116), [#36180](https://github.com/servo/servo/pull/36180), [#36111](https://github.com/servo/servo/pull/36111), [#36375](https://github.com/servo/servo/pull/36375), [#36371](https://github.com/servo/servo/pull/36371), [#36395](https://github.com/servo/servo/pull/36395), [#36392](https://github.com/servo/servo/pull/36392), [#36464](https://github.com/servo/servo/pull/36464), [#36504](https://github.com/servo/servo/pull/36504), [#36495](https://github.com/servo/servo/pull/36495), [#36492](https://github.com/servo/servo/pull/36492)).

## More changes

Our flexbox implementation supports **min/max keyword sizes** for both cross and main axes ([@Loirooriol](https://github.com/Loirooriol), [#35860](https://github.com/servo/servo/pull/35860), [#35961](https://github.com/servo/servo/pull/35961)), as well as **keyword sizes** for non-replaced content ([@Loirooriol](https://github.com/Loirooriol), [#35826](https://github.com/servo/servo/pull/35826)) and **min and max sizing properties** ([@Loirooriol](https://github.com/Loirooriol), [#36015](https://github.com/servo/servo/pull/36015)).
As a result, we now have full support for size keywords in flexbox!

We made lots of progress on web API features:
* added **partial support for IntersectionObserver** ([@stevennovaryo](https://github.com/stevennovaryo), [#35551](https://github.com/servo/servo/pull/35551))
* initial work on implementing the URLPattern API ([@simonwuelker](https://github.com/simonwuelker), [#36144](https://github.com/servo/servo/pull/36144))
* history.replaceState() can be called from file:// documents ([@kkoyung](https://github.com/kkoyung), [#35864](https://github.com/servo/servo/pull/35864))
* members of radio input groups apply validity constraints more consistently ([@jerensl](https://github.com/jerensl), [@elomscansio](https://github.com/elomscansio), [@Barry-dE](https://github.com/Barry-dE), [#36197](https://github.com/servo/servo/pull/36197), [#36090](https://github.com/servo/servo/pull/36090), [#36103](https://github.com/servo/servo/pull/36103))
* file inputs show the selected file ([@dklassic](https://github.com/dklassic), [#35789](https://github.com/servo/servo/pull/35789))

On security and networking:
* the `nonce` attribute is used in Content Security Policy checks ([@simonwuelker](https://github.com/simonwuelker), [#35876](https://github.com/servo/servo/pull/35876))
* Request objects with FormData bodies use the correct Content-Type ([@andreubotella](https://github.com/andreubotella), [#36194](https://github.com/servo/servo/pull/36194))
* text response bodies containing a BOM consume it ([@andreubotella](https://github.com/andreubotella), [#36192](https://github.com/servo/servo/pull/36192))
* notifications fetch associated image resources ([@pewsheen](https://github.com/pewsheen), [#35878](https://github.com/servo/servo/pull/35878))

On the DOM:
* passive event listeners can be created ([@shanehandley](https://github.com/shanehandley), [#35877](https://github.com/servo/servo/pull/35877))
* removing an event listener that has not run prevents it from running ([@tharkum](https://github.com/tharkum), [#36163](https://github.com/servo/servo/pull/36163))
* we removed some cases where custom element callbacks fired incorrectly ([@xiaochengh](https://github.com/xiaochengh), [#35960](https://github.com/servo/servo/pull/35960), [#35883](https://github.com/servo/servo/pull/35883))
* `touchmove` events are more reliable ([@kongbai1996](https://github.com/kongbai1996), [#36218](https://github.com/servo/servo/pull/36218) [#36200](https://github.com/servo/servo/pull/36200)) and support the `cancelable` property ([@kongbai1996](https://github.com/kongbai1996), [#35713](https://github.com/servo/servo/pull/35713))
* ResizeObserver callbacks are only invoked when elements change size ([@simonwuelker](https://github.com/simonwuelker), [#36226](https://github.com/servo/servo/pull/36226))
* cancelled enqueued animation frame callbacks no longer run ([@xiaochengh](https://github.com/xiaochengh), [#35849](https://github.com/servo/servo/pull/35849))
* scripts are no longer executed in documents that should disable scripting ([@simonwuelker](https://github.com/simonwuelker), [#35871](https://github.com/servo/servo/pull/35871))
* script elements adopted between documents use the original document to determine when to execute ([@xiaochengh](https://github.com/xiaochengh), [#35718](https://github.com/servo/servo/pull/35718))

And on many other bugs:
* **Backspace no longer removes entire lines** in &lt;textarea> ([@elomscansio](https://github.com/elomscansio), [@jdm](https://github.com/jdm), [#36112](https://github.com/servo/servo/pull/36112))
* improved **overflow handling** in some special cases ([@yezhizhen](https://github.com/yezhizhen), [#35670](https://github.com/servo/servo/pull/35670))
* fixed incorrect **fallback font** caching ([@mrobinson](https://github.com/mrobinson), [#35705](https://github.com/servo/servo/pull/35705))
* fixed the intrinsic block size of replaced elements with auto width ([@Loirooriol](https://github.com/Loirooriol), [#35275](https://github.com/servo/servo/pull/35275))
* ‘table-layout: fixed’ is no longer ignored when ‘inline-size’ is ‘auto’ ([@Loirooriol](https://github.com/Loirooriol), [#35882](https://github.com/servo/servo/pull/35882))
* margins of block-level box stretches are always zero, regardless of collapsing status ([@Loirooriol](https://github.com/Loirooriol), [#35904](https://github.com/servo/servo/pull/35904))
* indefinite stretch contributes to intrinsic sizes ([@Loirooriol](https://github.com/Loirooriol), [#36030](https://github.com/servo/servo/pull/36030))
* static positions include ancestor padding ([@Loirooriol](https://github.com/Loirooriol), [#36051](https://github.com/servo/servo/pull/36051))
* table rows with a span of >1 are sized appropriately ([@PotatoCP](https://github.com/PotatoCP), [#36064](https://github.com/servo/servo/pull/36064))
* input element contents ignore any outer display value ([@PotatoCP](https://github.com/PotatoCP), [#35908](https://github.com/servo/servo/pull/35908))
* indexing properties with values near 2^32 resolves correctly ([@reesmichael1](https://github.com/reesmichael1), [#36136](https://github.com/servo/servo/pull/36136))

## Donations

Thanks again for your generous support!
We are now receiving **4664 USD/month** (+6.8% over February) in recurring donations.
This helps cover the cost of our [self-hosted](https://ci0.servo.org) [CI](https://ci1.servo.org) [runners](https://ci2.servo.org) and our [latest Outreachy interns](https://www.outreachy.org/alums/2025-06/#:~:text=Servo), **Usman Baba Yahaya** ([@uthmaniv](https://github.com/uthmaniv)) and **Jerens Lensun** ([@jerensl](https://github.com/jerensl))!

Servo is also on [thanks.dev](https://thanks.dev), and already **24 GitHub users** (+3 over February) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 4664 / 10000); padding-left: 0.5em;"><strong>4664</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 4664 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="4664" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

As always, use of these funds will be decided transparently in the Technical Steering Committee.
For more details, head to our [Sponsorship page]({{ '/sponsorship/' | url }}).

## Conference talks

**Josh Matthews** ([@jdm](https://github.com/jdm)) will be [speaking about Servo](https://rustweek.org/talks/josh/) at [**RustWeek 2025**](https://rustweek.org), on **Tuesday 13 May** at [17:05 local time](https://everytimezone.com/?t=68228b80,929) (15:05 UTC).
See you there!

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
