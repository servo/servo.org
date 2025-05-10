---
layout:     post
tags:       blog
title:      "This month in Servo: and more!"
date:       2025-05-09
summary:    ao!! wrrrrao!!
categories:
---

Before we start, let’s address the elephant in the room.
Last month, we proposed that we would change our [AI contributions policy](https://book.servo.org/contributing.html#ai-contributions) to allow the use of AI tools in some situations, including GitHub Copilot for code.
[The feedback we received](https://github.com/servo/servo/discussions/36379) from the community was overwhelmingly clear, and we’ve listened.
We will **keep the AI contributions ban in place**, and any future proposals regarding this policy will be discussed together, as a community.

At the same time, we have other big news!
Complex sites such as **GMail** and **Google Chat** are **now usable in Servo**, with some caveats.
This milestone is only possible through the continued hard work of many Servo contributors across the engine, and we're thankful for all of the efforts to reach this point.

<figure><a href="{{ '/img/blog/2025-04-servo-gchat.png' | url }}"><img alt="Google Chat rendering in Servo" src="{{ '/img/blog/2025-04-servo-gchat.png' | url }}"></a></figure>
<figure><a href="{{ '/img/blog/2025-04-servo-gmail.png' | url }}"><img alt="GMail rendering in Servo" src="{{ '/img/blog/2025-04-servo-gmail.png' | url }}"></a></figure>

<aside class=_note>

**Caveats:** must run Servo with `--pref dom_abort_controller_enabled`. Accounts with 2FA enabled may not be able to log in yet.
</aside>

Servo now supports single-valued **&lt;select> elements** (@simonwuelker, #35684, #36677), disabling stylesheets with **&lt;link disabled>** (@Loirooriol, #36446), and the **Refresh** header in HTTP responses and &lt;meta> (@sebsebmc, #36393), plus several new CSS features:

- the **&amp;** selector for **CSS nesting** (@Loirooriol, #36246, #36254, #36248, #36249)
- **‘scale’**, **‘rotate’**, and **‘translate’** (@chocolate-pie, @Loirooriol, #35926)
- **‘will-change’** (@yezhizhen, #35787)
- the **‘fit-content()’** sizing function (@Loirooriol, #36056)
- the **‘image-set()’** notation (@chocolate-pie, #36210)

We’ve also landed a bunch of new web API features:

- the **Response.json()** static method (@sebsebmc, #36589, #36523)
- the **CSSStyleSheet()** constructor (@Loirooriol, #36521)
- the **seekable** property on **HTMLMediaElement** (@rayguo17, #36541)
- the **label** property on **HTMLOptGroupElement** (@simonwuelker, #35970)
- the **align** property on **HTMLParagraphElement** (@stephenmuss, #36054)
- **ClipboardItem** and **navigator.clipboard.writeText()** (@Gae24, #36336, #36498)
- **addRule()**, **removeRules()**, **replaceSync()**, and the **rules** property on **CSSStyleSheet** (@Loirooriol, @webbeef, #36313, #36586)
- **getLineDash**, **setLineDash**, and **lineDashOffset** on **CanvasRenderingContext2D** (@stevennovaryo, #36257)

<figure><a href="{{ '/img/blog/april-2025.png' | url }}"><img alt="servoshell showing new support for ‘image-set()’, ‘fit-content()’, ‘scale’, ‘translate’, ‘rotate’, ‘setLineDash()’, caret and text selection in <input>, and single-valued <select>" src="{{ '/img/blog/april-2025.png' | url }}"></a></figure>

[The biggest engine improvements](https://servo.org/wpt/) we’ve made recently were in **Shadow DOM** (+70.0pp to 77.9%), the **Trusted Types API** (+57.8pp to 57.8%), **Content Security Policy** (+54.0pp to 54.8%), the **Streams API** (+31.9pp to 68.1%), and **CSS Text** (+20.4pp to 57.6%).

We've **enabled Shadow DOM by default** after significantly improving support, allowing Servo to render sites like wpt.fyi correctly (@simonwuelker, @longvatron111, @elomscansio, @jdm, @sakupi01, #35923, #35899, #35930, #36104, #34964, #36024, #36106, #36173, #36010, #35769, #36230, #36620).

<figure><a href="{{ '/img/blog/2025-04-servo-wptfyi.png' | url }}"><img alt="wpt.fyi rendering in Servo" src="{{ '/img/blog/2025-04-servo-wptfyi.png' | url }}"></a></figure>

**ReadableStream**, **WritableStream**, **DOMPoint**, **DOMPointReadOnly**, and **DOMException** can now be sent over **postMessage()** and **structuredClone()** (@gterzian, @kkoyung, @jdm, @mrobinson, #36181, #36588, #36535, #35989).

We’ve started working on support for **stream transforms** (@Taym95, #36470) and the [**trusted types API**](https://developer.mozilla.org/en-US/docs/Web/API/Trusted_Types_API) (@TimvdLippe, @jdm, #36354, #36355, #36422, #36454, #36409, #36363, #36511, #36596).
We’ve also laid the groundwork for supporting the **::marker pseudo element** (@mrobinson, #36202), **animated images** in web content (@rayguo17, #36058, #36141), and **getClientRects()** and **getBoundingClientRect()** on **Range** (@simonwuelker, #35993).

Servo can now render the **caret** and **text selection** in input fields (@dklassic, @webbeef, #35830, #36478), and we’ve landed a few fixes to **radio buttons** (@elomscansio, #36252, #36431), **file inputs** (@sebsebmc, #36458), and **input validation** (@MDCODE247, #36236).

Our devtools now support **color scheme simulation** (@uthmaniv, #36253, #36168, #36297), and the beginnings of a **Sources panel** (@delan, @atbrakhi, #36164, #35971, #36631, #36632, #36667).

Having disabled by default Servo's original, experimental layout implementation back in November 2024, we have taken the step of **deleting all of the disabled code** (@Loirooriol, @TimvdLippe, @mrobinson, #35943, #36281, #36698) and moving all of the remaining layout code to [`layout`](https://doc.servo.org/layout/) (@mrobinson, #36613).
Our new layout engine is improving significantly month over month!

We’ve added a **`--enable-experimental-web-platform-features` option** that enables all engine features, even those that may not be stable or complete.
This works much like [Chromium’s option with the same name](https://source.chromium.org/chromium/chromium/src/+/main:third_party/blink/renderer/platform/RuntimeEnabledFeatures.md;drc=a4e3e1f59b6f4bcf64806cf40c1acbb043b0bddc), and it can be useful when a page is not functioning correctly, since it may allow the page to make further progress.
Servo now uses this option when running the Web Platform Tests (@Loirooriol, #36335, #36519, #36348, #36475), and the features enabled by this option are expected to change over time.

## Servo-the-browser (servoshell)

Our developer tools integration **supports iframes** (@simonwuelker, #35874), shows **computed display values** when inspecting elements (@stephenmuss, #35870), and supports **multiple tabs** open in the servoshell browser (@atbrakhi, #35884).
To use the developer tools, we now **require Firefox 133 or newer** (@atbrakhi, #35792).

Dialogs support **keyboard interaction** to close and cancel them (@chickenleaf, #3567), and the URL bar accepts any **domain-like input** (@kafji, #35756).
We also enabled **sRGB colorspaces** on macOS for better colour fidelity (@IsaacMarovitz, #35683).
Using the `--userscripts` argument without providing a path **defaults to ./resources/user-agent-js/**.
Finally, we **renamed the OpenHarmony app bundle** (@jschwe, #35790).

## Servo-the-engine (embedding)

We’ve landed some big changes to our webview API:

- **pinch zoom**, **page zoom**, and **HiDPI scaling** are now handled independently **for each webview** (@mrobinson, @shubhamg13, #36419, #36312)
- **mouse click events** no longer need to be generated by the embedder, only mouse button down and up events (@yezhizhen, #36413)
- webviews are now created with [**WebViewBuilder**](https://doc.servo.org/servo/struct.WebViewBuilder.html) (@mrobinson, #36483)
- **EmbedderMethods** is now [**ServoBuilder**](https://doc.servo.org/servo/struct.ServoBuilder.html) (@mrobinson, #36276, #36549)
- **WindowMethods** have moved to [**WebViewDelegate**](https://doc.servo.org/servo/webview_delegate/trait.WebViewDelegate.html) and [**ServoDelegate**](https://doc.servo.org/servo/servo_delegate/trait.ServoDelegate.html) (@mrobinson, #36223, #36400)

Embedders can now **inject userscript sources** into all webviews (@Legend-Master, #35388).
Links can be **opened in a new tab** by pressing the ctrl/meta modifier (@webbeef, @mrobinson, #35017).
Delegates will receive **send error notifications** for requests (@delan, #35668).

We fixed a bug causing **flickering cursors** (@DevGev, #35934), and now **create the config directory** if it does not exist (@yezhizhen, #35761).
We also fixed a number of bugs in the WebDriver server related to clicking on elements, opening and closing windows, and returning references to exotic objects (@jdm, #35737).

Finally, we made progress towards a per-webview renderer model (@mrobinson, @delan, #35701, #35716).

## Under the hood

We’ve finally finished **splitting up our massive `script` crate** (@jdm, #35988, #35987, #36107, #36216, #36220, #36095, #36323), which should **cut incremental build times** for that crate **by 60%**.
This is something we’ve wanted to do for **over eleven years** (@kmcallister, #1799)!

**`webgpu` rebuilds are now faster** as well, with changes to that crate no longer requiring a `script` rebuild (@mrobinson, #36332, #36320).

**Stylo** has been upgraded to 2025-03-15 (@nicoburns, @Loirooriol, #35782, #35925, #35990), and we upgraded to the **2024 Rust edition** (@simonwuelker, #35755).

We added a memory usage view for Servo embedders: **visit about:memory** for a breakdown of identified allocations (@webbeef, @jdm, #35728, #36557, #36558, #36556, #36581, #36553, #36664).

<figure><a href="{{ '/img/blog/2025-04-servo-aboutmemory.png' | url }}"><img alt="about:memory screenshot" src="{{ '/img/blog/2025-04-servo-aboutmemory.png' | url }}"></a></figure>

## Perf and stability

We’ve started building an **incremental layout** system in Servo (@mrobinson, @Loirooriol, #36404, #36448, #36447, #36513), with a huge speedup to **offsetWidth**, **offsetHeight**, **offsetLeft**, **offsetTop**, and **offsetParent** layout queries (@mrobinson, @Loirooriol, #36583, #36629, #36681, #36663).
Incremental layout will allow Servo to respond to page updates and layout queries without repeating layout work, which is critical on today’s highly dynamic web.

The `OffscreenRenderingContext` is **no longer double buffered**, which can improve rendering performance in embeddings that rely on it.
We also removed a source of **canvas rendering latency** (@sagudev, #35719), and fixed performance cliffs related to the Shadow DOM (@simonwuelker, #35802, #35725).
We improved layout performance by **reducing allocations** (@jschwe, #35781) and **caching layout results** (@Loirooriol, @mrobinson, #36082), and reduced the **latency of touch events** when they are non-cancelable (@kongbai1996, #35785).

We also fixed crashes involving **touch events** (@kongbai1996, @jschwe, #35763, #36531, #36229), **service workers** (@jdm, #36256), **WritableStream** (@Taym95, #36566), **Location** (@jdm, #36494), **&lt;canvas>** (@tharkum, @simonwuelker, #36569, #36705), **&lt;input>** (@dklassic, #36461), **&lt;iframe>** (@leftmostcat, #35742), **‘min-content’** and **‘max-content’** (@Loirooriol, #36518, #36571), **flexbox** (@mrobinson, #36123), global objects (@jdm, #36491), resizing the viewport (@sebsebmc, #35967), and `--pref shell_background_color_rgba` (@boluochoufeng, #35865).
Additionally, we **removed undefined behaviour** from the Rust bindings to the SpiderMonkey engine (@gmorenz, #35892, #36160, #36161, #36158).

The project to decrease the risk of [intermittent GC-related crashes](https://github.com/servo/servo/issues/33140) continues to make progress (@jdm, @Arya-A-Nair, @Dericko681, @yerke, #35753, #36014, #36043, #36156, #36116, #36180, #36111, #36375, #36371, #36395, #36392, #36464, #36504, #36495, #36492).

## More changes

Our flexbox implementation supports **min/max keyword sizes** for both cross and main axes (@Loirooriol, #35860, #35961), as well as **keyword sizes** for non-replaced content (@Loirooriol, #35826) and **min and max sizing properties** (@Loirooriol, #36015).
This means Servo's flexbox layout now has full support for sizing keywords!

We made lots of progress on web API features:
* we implemented **ReadableByteStreamController and ReadableStream.pipeTo** (@Taym95, @gterzian, #35410, #35650)
* the **nonce attribute** is used in Content Security Policy checks (@simonwuelker, #35876)
* we removed some cases where **custom element callbacks fired incorrectly** (@xiaochengh, #35960, #35883)
* added **partial support for InterSectionObserver** (@stevennovaryo, #35551)
* **touchmove events** are more reliable (@kongbai1996, #36218 #36200) and support the `cancelable` property (@kongbai1996, #35713)
* Notifications fetch **associated image resources** (@pewsheen, #35878)
* `ResizeObserver` callbacks are only invoked **when elements change size** (@simonwuelker, #36226)
* **Request objects with FormData bodies** use the correct `Content-Type` (@andreubotella, #36194)
* Text response bodies containing a BOM consume it (@andreubotella, #36192)
* We have begun **implementing the URLPattern API** (@simonwuelker, #36144)
* Backspace **no longer removes entire lines** in `<textarea>` (@elomscansio, @jdm, #36112)
* **passive event listeners** can be created (@shanehandley, #35877)
* cancelled enqueued animation frame callbacks **no longer run** (@xiaochengh, #35849)
* scripts are **no longer executed** in documents that should disable scripting (@simonwuelker, #35871)
* file inputs **show the selected file** (@dklassic, #35789)
* **removing an event listener** that has not run prevents it from running (@tharkum, #36163)
* members of radio input groups **apply validity constraints** more consistently (@jerensl, @elomscansio, @Barry-dE, #36197, #36090, #36103)
* indexing properties with **values near 2^32** resolves correctly (@reesmichael1, #36136)
* **history.replaceState()** can be called from file:// documents (@kkoyung, #35864)
* script elements **adopted between documents** use the original document to determine when to execute (@xiaochengh, #35718)

We’ve also fixed many layout bugs:
* incorrect **fallback font** caching (@mrobinson, #35705)
* improved **overflow handling** in some special cases (@yezhizhen, #35670)
* **table-layout: fixed** is no longer ignored when `inline-size` is `auto` (@Loirooriol, #35882)
* margins of block-level box stretches are always zero, regardless of collapsing status (@Loirooriol, #35904)
* fixed the intrinsic block size of replaced elements with auto width (@Loirooriol, #35275)
* indefinite stretch contributes to intrinsic sizes (@Loirooriol, #36030)
* static positions include ancestor padding (@Loirooriol, #36051)
* table rows with a span of >1 are sized appropriately (@PotatoCP, #36064)
* input element contents ignore any outer display value (@PotatoCP, #35908)

## Donations

Thanks again for your generous support!
We are now receiving **4664 USD/month** (+6.8% over February) in recurring donations.
This helps cover the cost of our [self-hosted](https://ci0.servo.org) [CI](https://ci1.servo.org) [runners](https://ci2.servo.org) and our [latest Outreachy interns](https://www.outreachy.org/alums/2025-06/#:~:text=Servo), **Usman Baba Yahaya** (@uthmaniv) and **Jerens Lensun** (@jerensl)!

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

**Josh Matthews** (@jdm) will be [speaking about Servo](https://rustweek.org/talks/josh/) at [**RustWeek 2025**](https://rustweek.org), on **Tuesday 13 May** at [17:05 local time](https://everytimezone.com/?t=68228b80,929) (15:05 UTC).
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
