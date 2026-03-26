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
