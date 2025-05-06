---
layout:     post
tags:       blog
title:      "This month in Servo: ????"
date:       2025-04-24
summary:    Who knows?
categories:
---

Big news! Complex sites such as GMail and Google Chat are now usable in Servo
if you have 2FA disabled for your Google account. This milestone is only possible through the continued hard work of many Servo contributors across the engine, and we're thankful for all of the efforts to reach this point.

![Google Chat rendering in Servo](assets/img/servo-gchat.png)
![GMail rendering in Servo](assets/img/servo-gmail.png)

We've **enabled Shadow DOM by default** after significantly improving support, allowing Servo to render sites like wpt.fyi correctly (@simonwuelker, @longvatron111, @elomscansio, #35923, #35899, #35930, #36104, #34964, #36024, #36106, #36173, #36010, #35769).

![wpt.fyi rendering in Servo](assets/img/servo-wptfyi.png)

We also merged the preliminary steps to support **animated images** in web content (@rayguo17, #36058, #36141).

Having disabled by default Servo's original, experimental layout implementation back in November 2024, we have taken the step of **deleting all of the disabled code** (@Loirooriol, #35943). The new layout engine is improving significantly month over month! We now better support **transform-style: preserve-3d** (@HastD, #35808), and the **will-change** property (@yezhizhen, #35787).

Our flexbox implementation supports **min/max keyword sizes** for both cross and main axes (@Loirooriol, #35860, #35961), as well as **keyword sizes** for non-replaced content (@Loirooriol, #35826) and **min and max sizing properties** (@Loirooriol, #36015). This means Servo's flexbox layout now has full support for sizing keywords!

We laid the groundwork for supporting the **::marker pseudo element** (#36202), and implemented the **fit-content()** sizing function (@Loirooriol, #36056), as well as the **image-set()** notation (@chocolate-pie, #36210). Additionally, the **`scale`, `rotate`, and `translate`** transform properties now work (@chocolate-pie, @Loirooriol, #35926). Finally, we **improved the performance** of deeply nested pages that require laying out boxes multiple times (@Loirooriol, @mrobinson, #36082).

We also fixed many layout bugs:
* incorrect **fallback font** caching (@mrobinson, #35705)
* improved **overflow handling** in some special cases (@yezhizhen, #35670)
* **addressed a crash** caused by flex boxes and mixing fixed position and absolutely positioned descendants (@mrobinson, #36123)
* **table-layout: fixed** is no longer ignored when `inline-size` is `auto` (@Loirooriol, #35882)
* margins of block-level box stretches are always zero, regardless of collapsing status (@Loirooriol, #35904)
* fixed the intrinsic block size of replaced elements with auto width (@Loirooriol, #35275)
* added support for **z-index on grid items** (@Loirooriol, #35947)
* indefinite stretch contributes to intrinsic sizes (@Loirooriol, #36030)
* static positions include ancestor padding (@Loirooriol, #36051)
* table rows with a span of >1 are sized appropriately (@PotatoCP, #36064)
* input element contents ignore any outer display value (@PotatoCP, #35908)

There was also lots of progress on non-layout web API features in the engine:
* we implemented **ReadableByteStreamController and ReadableStream.pipeTo** (@Taym95, @gterzian, #35410, #35650)
* the **nonce attribute** is used in Content Security Policy checks (@simonwuelker, #35876)
* we removed some cases where **custom element callbacks fired incorrectly** (@xiaochengh, #35960, #35883)
* added **partial support for InterSectionObserver** (@stevennovaryo, #35551)
* we **implemented Range.getClientRects and Range.getBoundingClientRect** (@simonwuelker, #35993)
* **touchmove events** are more reliable (@kongbai1996, #36218 #36200) and support the `cancelable` property (@kongbai1996, #35713)
* we added support for **HTMLOptgroupElement.label** (@simonwuelker, #35970)
* **DOMPoint and DOMPointReadOnly are serializable** with `postMessage` (@jdm, @mrobinson, #35989)
* Notifications fetch **associated image resources** (@pewsheen, #35878)
* `ResizeObserver` callbacks are only invoked **when elements change size** (@simonwuelker, #36226)
* **Request objects with FormData bodies** use the correct `Content-Type` (@andreubotella, #36194)
* Text response bodies containing a BOM consume it (@andreubotella, #36192)
* We have begun **implementing the URLPattern API** (@simonwuelker, #36144)
* Backspace **no longer removes entire lines** in `<textarea>` (@elomscansio, @jdm, #36112)
* we implemented the **HTMLParagraphElement.align** attribute (@stephenmuss, #36054)
* **passive event listeners** can be created (@shanehandley, #35877)
* cancelled enqueued animation frame callbacks **no longer run** (@xiaochengh, #35849)
* scripts are **no longer executed** in documents that should disable scripting (@simonwuelker, #35871)
* file inputs **show the selected file** (@dklassic, #35789)
* **removing an event listener** that has not run prevents it from running (@tharkum, #36163)
* members of radio input groups **apply validity constraints** more consistently (@jerensl, @elomscansio, @Barry-dE, #36197, #36090, #36103)
* indexing properties with **values near 2^32** resolves correctly (@reesmichael1, #36136)
* **history.replaceState()** can be called from file:// documents (@kkoyung, #35864)
* script elements **adopted between documents** use the original document to determine when to execute (@xiaochengh, #35718)

Our developer tools integration **supports iframes** (@simonwuelker, #35874), shows **computed display values** when inspecting elements (@stephenmuss, #35870), and supports **multiple tabs** open in the servoshell browser (@atbrakhi, #35884). To use the developer tools, we now **require Firefox 133 or newer** (@atbrakhi, #35792).

**Stylo** has been upgraded to 2025-03-15 (@nicoburns, @Loirooriol, #35782, #35925, #35990), and we upgraded to the **2024 Rust edition** (@simonwuelker, #35755).
We also are nearly finished **splitting up our massive `script` crate** (@jdm, #35988, #35987, #36107, #36216, #36220, #36095), which will eventually make Servo faster to rebuild.

## Servo-the-browser (servoshell)

servoshell supports a new command-line argument: **--enable-experimental-web-platform-features**. This argument enables incomplete engine features
that are not ready to be turned on by default. This can be useful when a page is not functioning correctly, since it may allow the page to make further progress.
The features enabled by this flag are expected to change over time as new web platform features are implemented in Servo.

We fixed a crash when **resizing the browsing area** too small (@sebsebmc, #35967).
Dialogs support **keyboard interaction** to close and cancel them (@chickenleaf, #3567), and the URL bar accepts any **domain-like input** (@kafji, #35756).
We also enabled **sRGB colorspaces** on macOS for better colour fidelity (@IsaacMarovitz, #35683).
Using the `--userscripts` argument without providing a path **defaults to ./resources/user-agent-js/**.
Finally, we **renamed the OpenHarmony app bundle** (@jschwe, #35790).

## Servo-the-engine (embedding)

We added a memory usage view for Servo embedders: **visit about:memory** for a breakdown of identified allocations (@webbeef, #35728).

![about:memory screenshot](assets/img/servo-aboutmemory.png)

Embedders can now **inject userscript sources** into all webviews (@Legend-Master, #35388).
Links can be **opened in a new tab** by pressing the ctrl/meta modifier (@webbeef, @mrobinson, #35017).
Delegates will receive **send error notifications** for requests (@delan, #35668).

We fixed a bug causing **flickering cursors** (@DevGev, #35934), and now **create the config directory** if it does not exist (@yezhizhen, #35761).
We also fixed a number of bugs in the webdriver server related to clicking on elements, opening and closing windows, and returning references to exotic objects (@jdm, #35737).
Setting a **non-default value for `Preferences.shell_background_color_rgba`** no longer cases a crash (@boluochoufeng, #35865).

Finally, we made progress towards a per-webview renderer model (@mrobinson, @delan, #35701, #35716).

## Perf and stability

The `OffscreenRenderingContext` is **no longer double buffered**, which can improve rendering performance in embeddings that rely on it.
We also removed a source of **canvas rendering latency** (@sagudev, #35719), and fixed performance cliffs related to the Shadow DOM (@simonwuelker, #35802, #35725).
We improved performance of block level layout by **reducing allocations** (@jschwe, #35781), and reduced the **latency of touch events** when they are non-cancelable (@kongbai1996, #35785).

We also fixed crashes involving **multiple touchmove events** (@kongbai1996, @jschwe, #35763), and **focusing iframes** (@leftmostcat, #35742).
The project to decrease the risk of [intermittent GC-related crashes](https://github.com/servo/servo/issues/33140) continues to make progress (@jdm, @Arya-A-Nair, @Dericko681, #35753, #36014, #36043, #36156, #36116, #36180, #36111).
Additionally, we **removed undefined behaviour** from the Rust bindings to the SpiderMonkey engine (@gmorenz, #35892, #36160, #36161, #36158).

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