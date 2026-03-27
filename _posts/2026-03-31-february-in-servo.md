---
layout:     post
tags:       blog
title:      "February in Servo: and more!"
date:       2026-03-31
summary:    ao!! wrrrrao!!
categories:
---

<!--
- 3023.90 opencollective
- 3911.00 github
- 50.98 thanks.dev
-->

Some highlights:

- **&lt;button command>** and **&lt;button commandfor>** (@lukewarlow, #41237)
- **‘:modal’** selectors on **&lt;dialog>** (@lukewarlow, #42201)
- **‘@property’** rules (@yezhizhen, @Loirooriol, #42136, #42858)
- **‘alignment-baseline’** and **‘baseline-shift’** (@Loirooriol, #42361)
- partial support for **‘transform-style: preserve-3d’** (@simonwuelker, #42755)
- **‘Content-Security-Policy: base-uri’** (@WaterWhisperer, #42272)

Plus a bunch of new DOM APIs:

- most of [**Pointer Events**](https://w3c.github.io/pointerevents/) (@webbeef, #41290)
- **import.meta.resolve()** (@Gae24, #42506)
- the **formData()** method on **Request** (@Taym95, #42041)
- the **alpha** property on **HTMLInputElement** (@simonwuelker, #42293)
- **tabIndex** on **HTMLElement** and **SVGElement** (@mrobinson, @Loirooriol, #42913)
- **fullscreenElement** on **Document** and **ShadowRoot** (@onsah, #42401)
- **toJSON()** on **PerformancePaintTiming** (@shubhamg13, #42396)
- **navigator.pdfViewerEnabled** (@simonwuelker, #42277)
- **createIndex()**, **deleteIndex()**, and **index()** on **IDBObjectStore** (@arihant2math, @bulltickr, #38840, #42440, #42443)

Servo now supports the newer **pointermove**, **pointerdown**, **pointerup**, and **pointercancel** events (@webbeef, #41290).
We’ve also fixed the `event.target` on the older **touchmove**, **touchend**, and **touchcancel** events, and we no longer fire erroneous touchend events after touchcancel events (@yezhizhen, #42654).

The default language in **‘Accept-Language’** and **navigator.language** is now taken from the **$LANG** environment variable if present (@webbeef, #41919), rather than always being set to en-US.

**&lt;input type=color>** now supports any CSS color value (@simonwuelker, #42275), including the more complex values like color-mix().
We’ve also landed the **colorspace** attribute (@simonwuelker, #42279), but only in the web-facing side of Servo for now, not the embedding API or in servoshell.

**‘vertical-align’** is now a shorthand for ‘alignment-baseline’ and ‘baseline-shift’ (@Loirooriol, #42361).

## Performance and stability

Our **about:memory** page now knows how to **report many new kinds of memory usage**, including the **DevTools** server (@Narfinger, #42478, #42480), **WebGL** (@sagudev, #42570), **localStorage** and **sessionStorage** (@arihant2math, #42484), and some of the memory used by **IndexedDB** (@arihant2math, #42486).
We’ve also started internally tracking the memory usage of the media subsystem (@Narfinger, #42504) and WebXR (@Narfinger, #42505).

We’ve continued our long-running effort to use the **Rust type system** to make certain kinds of dynamic borrow failures impossible (@Gae24, @pralkarz, @BryanSmith00, @sagudev, @Narfinger, @TimvdLippe, @kkoyung, @TimurBora, @onsah, #42342, #42294, #42370, #42417, #42619, #42616, #42637, #42640, #42662, #42679, #42681, #42665, #42667, #42699, #42712, #42725, #42729, #42726, #42720, #42738, #42737, #42735, #42751, #42805, #42809, #42780, #42820, #42715, #42635, #42880, #42846).

We’ve fixed crashes in DevTools, in the Inspector tab (@eerii, @mrobinson, #42330), when exiting Servo while DevTools is connected (@simonwuelker, #42543), and when setting breakpoints in some cases (@atbrakhi, #42810).

We’ve fixed crashes in layout, when using ‘background-repeat: round’ in some cases (@mrobinson, #42303), when using ‘list-style-image’ or ‘content: &lt;image>’ in some cases (@lukewarlow, #42332), when calling elementFromPoint() on Document in some cases (@mrobinson, @Loirooriol, @lukewarlow, #42822), and when handling layout queries like getBoundingClientRect() on inline &lt;svg> (@jdm, @Loirooriol, #42594).

We’ve fixed crashes related to stylesheets, when removing stylesheets from the DOM in some cases (@TimvdLippe, #42273), when changing the href of a &lt;link rel=stylesheet> in some cases (@TimvdLippe, #42481), and when loading stylesheets in some cases with `--layout-threads=1` (@mrobinson, @Loirooriol, @lukewarlow, #42685).

We’ve also fixed crashes when using multitouch input (@yezhizhen, #42350), when using MediaStreamAudioSourceNode in some cases (@mrobinson, #42914), when calling add() on HTMLOptionsCollection (@mrobinson, #42263), when calling elementFromPoint() on Document or ShadowRoot(), and when certain pages are run with a mozjs debug build (@Gae24, #42428).

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
