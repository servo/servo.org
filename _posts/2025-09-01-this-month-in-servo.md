---
layout:     post
tags:       blog
title:      "This month in Servo: ?????????"
date:       2025-09-01
summary:    Who even knows?
categories:
---

Another month, another record number of pull requests merged!
August flew by, and with it came **447 pull requests** from Servo contributors.
It was also the final month of our [Outreachy](https://www.outreachy.org/) cohort; you can read [Jerens'](https://www.jerensl.com/blog/en-final-project-progress-outreachy/) and [Uthman's](https://uthmaniv.github.io/) blogs to learn about how it went!

## Highlights

Our big new feature this month is rendering **inline SVG elements** (@mukilan, @Loirooriol, #38188, #38603).
This improves the appearance of many popular websites.

<figure>
  <a href="{{ '/img/blog/2025-09-svg.png' | url }}"><img alt="Screenshot of servoshell with the Google homepage loaded" src="{{ '/img/blog/2025-09-svg.png' | url }}"></a>
  <figcaption>Did you know that the Google logo is an SVG element?</figcaption>
</figure>

We have implemented **named grid line lines and areas** (@nicoburns, @loirooriol, #38306, #38574, #38493), still gated behind the `layout_grid_enabled` preference (#38306, #38574).

<figure>
  <a href="{{ '/img/blog/2025-09-grid.png' | url }}"><img alt="Screenshot of servoshell loading a page demoing a complex grid layout" src="{{ '/img/blog/2025-09-grid.png' | url }}"></a>
  <figcaption>CSS grids are all around us.</figcaption>
</figure>

Servo now supports CSS **font-variation-settings** on all main desktop platforms (@simonwuelker, @mrobinson, #38642, #38760, #38831).
This feature is currently gated behind the `layout_variable_fonts_enabled` preference.
We also respect `format(*-variations)` inside `@font-face` rules (@mrobinson, #38832).
Additionally, Servo now reads data from **OpenType Collection** system font files on macOS (@nicoburns, #38753), and uses `Helvetica` for the **system-ui** font (@dpogue, #39001).

<figure>
  <a href="{{ '/img/blog/2025-09-variations.png' | url }}"><img alt="Screenshot of servoshell loading a page showcasing font variations, with customizable variation values." src="{{ '/img/blog/2025-09-variations.png' | url }}"></a>
  <figcaption>This font can be customized!</figcaption>
</figure>

Our [developer tools](https://book.servo.org/hacking/using-devtools.html) continue to make progress! We now have a functional network monitor panel (@uthmaniv, @jdm, #38216, #38601, #38625),
and our JS debugger can show potential breakpoints (@delan, @atbrakhi, #38331, #38363, #38333, #38551, #38550, #38334, #38624, #38826, #38797).
Additionally, the layout inspector now dims nodes that are not displayed (@simonwuelker, #38575).

<figure>
<a href="{{ '/img/blog/2025-09-mastodon.png' | url }}"><img src=" {{ '/img/blog/2025-09-mastodon.png' | url }}" alt="servoshell showing the Servo Mastodon account homepage"></a>
<a href="{{ '/img/blog/2025-09-netmonitor.png' | url }}"><img src="{{ '/img/blog/2025-09-netmonitor.png' | url }}" alt="The Firefox network monitor, showing a list of network connections for the Servo Mastodon account homepage"></a>
  <figcaption>That's a lot of network requests.</figcaption>
</figure>

We fixed a significant source of crashes in the engine: hit testing using outdated display lists ([issue #37932](https://github.com/servo/servo/issues/37932)).
Hit testing in a web rendering engine is the process that determines which element(s) the user's mouse is hovering over.
Previously, this process ran inside of [WebRender](https://github.com/servo/webrender), which receives a display list representing what should be rendered for a particular page.
Since this is either a separate thread or process from the actual page content, display lists are updated asynchronously.

This means it was possible to trigger crashes by performing a hit test (e.g. moving the mouse quickly) over parts of the page that were rapidly changing, since the elements reported may not exist any more.
This was fixed by making the hit test operation synchronous and moving it into the same thread as the actual content being tested against, eliminating the possibility of outdated results (@mrobinson, @Loirooriol, @kongbai1996, @yezhizhen, #38480, #38464, #38463, #38884, #38518).

## Web platform support

### DOM & JS

We upgraded to **SpiderMonkey v140** ([changelog](https://gitlab.gnome.org/GNOME/gjs/-/blob/master/NEWS#L39-137)) (@jdm, #37077, #38563).

Numerous pieces of the [**Trusted Types API**](https://developer.mozilla.org/en-US/docs/Web/API/Trusted_Types_API) are now present in Servo
(@TimvdLippe, @jdm, #38595, #37834, #38700, #38736, #38718, #38784, #38871, #8623, #38874, #38872, #38886), all gated behind the `dom_trusted_types_enabled` preference.

The [**IndexedDB**](https://developer.mozilla.org/en-US/docs/Web/API/IndexedDB_API) implementation (gated behind `dom_indexeddb_enabled`) is progressing quickly (@arihant2math, @jdm, @rodion, @kkoyung, #28744, #38737, #38836, #38813, #38819, #38115, #38944, #38740, #38891, #38723, #38850, #38735), now reporting errors via `IDBRequest` interface and supporting autoincrement keys.

A prototype implementation of the [CookieStore API](https://developer.mozilla.org/en-US/docs/Web/API/CookieStore) is now implemented and gated by the `dom_cookiestore_enabled` preference (@sebsebmc, #37968, #38876).

Servo now passes over 99.6% of the [CSS geometry](https://drafts.fxtf.org/geometry/) testsuite, thanks to an implementation of **DOMPointReadOnly.matrixTransform**, making all geometry interfaces serializable, and adding the **SVGMatrix and SVGPoint aliases** (@lumiscosity, #38801, #38828, #38810).

You can now use the [**TextEncoderStream** API](https://developer.mozilla.org/en-US/docs/Web/API/TextEncoderStream) (@minghuaw, #38466).
Streams that are piped now correctly pass through `undefined` values, too (@gterzian, #38470).
We also fixed a crash in the result of the **ReadableStream.pipeTo** method (@gterzian, #38385).

There were a number of changes involving DOM events: element focus now occurs after `mousedown` instead of `click` (@yezhizhen, #38589), `mouseleave` events are fired when the pointer leaves an `<iframe>` (@mrobinson, @Loirooriol, #38539), and pasting from the clipboard into a text input triggers an `input` event (@mrobinson, #37100).
We also ignore `mousedown` and `mouseup` events for elements that are disabled (@yezhizhen, #38671), and implemented the **MouseEvent.getModifierState** method (@PotatoCP, #38535).
Finally, removing an event handler content attribute clears all relevant event listeners (@TimvdLippe, @kotx, #38734, #39011).

Servo now fires a **scroll event** whenever a page is scrolled (@stevennovaryo, #38321). Additionally, the **Window.scrollIntoView** method is now available (@abdelrahman1234567, #38230).
The **FocusOptions.preventScroll** method can now be used to prevent scrolling when focusing an element with `Element.focus` (@abdelrahman1234567, #38495).

The **Navigator.sendBeacon()** API is implemented, gated behind the `dom_navigator_sendbeacon_enabled` preference (@TimvdLippe, #38301).
Similarly, the static **AbortSignal.abort()** method is hidden behind `dom_abort_controller_enabled` (@Taym95, #38746).

The **HTMLDocument** interface now exists as a property on the `Window` object (@leo030303, #38433).
Meanwhile, the **CSS** window property is now a [WebIDL namespace](https://webidl.spec.whatwg.org/#idl-namespaces) (@simonwuelker, #38579).
We also implemented the new **QuotaExceededError** DOMException interface (@rmeno12, #38507, #38720), which replaces previous usages of DOMException with the `QUOTA_EXCEEDED_ERR` name.

Our 2d canvas implementation now supports the **Path2D.addPath** method (@arthmis, #37838) and the **Canvas2dRenderingContext/OffscreenCanvas.restore** methods now pop all applied clipping paths (@sagudev, #38496).
Additionally, we now support **using web fonts in the 2D canvas** (@mrobinson, #38979).
Meanwhile, the performance continues to improve in the new [Vello](https://github.com/linebender/vello?tab=readme-ov-file#vello)-based backends (@sagudev, #38406, #38356, #38440, #38437), with asynchronous uploading also showing improvements (@sagudev, @mrobinson, #37776).

Muting media elements with the `mute` HTML attribute works during the initial resource load (@rayguo17, @jschwe, #38462).

Modifying stylesheets now integrates better with incremental layout, in both light trees and shadow trees (@coding-joedow, #38530, #38529).
However, calling `setProperty` on a readonly `CSSStyleDeclaration` correctly throws an exception (@simonwuelker, #38677).

### CSS

We now support custom CSS properties with the **CSS.registerProperty** method (@simonwuelker, #38682), as well as custom element states with **ElementInternals.states** (@simonwuelker, #38564).

Flexbox cross sizes can no longer end up negative through stretching (@Loirooriol, #38521), while `stretch` on flex items now stretches to the line if possible (@Loirooriol, #38526).

**Overflow calculations are more accurate**, now that we ignore `position: fixed` children of the root element (@stevennovaryo, #38618), compute overflow for `<body>` separate from the viewport (@shubhamg13, #38825), check for `overflow: visible` in parents and children (@shubhamg13, #38443), and propagate `overflow` to the viewport correctly (@shubhamg13, @Loirooriol, #38598).

Color and text decorations no longer inherit into `<select>` element contents (@simonwuelker, #38570).

Negative outline offsets work correctly (@lumiscosity, @mrobinson, #38418).

Video elements no longer fall back to a preferred aspect ratio of 2 (@Loirooriol, #38705).

`position: sticky` elements are handled correctly inside CSS transforms (@mrobinson, @Loirooriol, #38391).

We upgraded to the **upstream Stylo** revision as of August 1, 2025.

## Performance & Stability

We fixed several panics this month, involving `IntersectionObserver` and missing stacking contexts (@mrobinson, #38473), unpaintable canvases and text (@gterzian, #38664), serializing the result of `Window.location` (@jdm, #38709), and navigations canceled before HTTP headers are received (@gterzian, #38739).

We also fixed a number of performance pitfalls.
The document rendering loop is now **throttled to 60 FPS** (@mrobinson, @Loirooriol, #38431), while animated images do less work when advancing the current frame (@mrobinson, #38857).
In addition, elements with CSS images will not trigger page reflow until their image data is fully available (@coding-joedow, #38916).

Finally, we made improvements to memory usage and binary size.
Inline stylesheets are now deduplicated, which can have a significant impact on pages with **lots of form inputs or custom elements** with common styles (@coding-joedow, #38540). We also removed many unused pieces of the ICU library, **saving 16MB** from the final binary.

## Embedding

Servo has declared a **Minimum Supported Rust Version** (1.85.0), and this is verified with every new pull request (@jschwe, #37152).

Evaluating JS from the embedding layer now **reports an error** if the evaluation failed for any reason (@rodio, #38602).

Our **WebDriver** implementation now passes 80% of the implementation conformance tests.
This is the result of lots of work on handling user prompts (@PotatoCP, #38591), computing obscured/disabled elements while clicking (@yezhizhen, #38497, #38841, #38436, #38490, #38383), and improving window focus behaviours (@yezhizhen, #38889, #38909).
We also implemented the **Get Window Handles** command (@longvatrong111, @yezhizhen, #38622, #38745), added support for getting element boolean attributes (@kkoyung, #38401), and added more accurate errors for a number of commands (@yezhizhen, @longvatrong111, #38620, #38357).
The **Element Clear** command now clears `<input type=file>` elements correctly (@PotatoCP, #38536), and **Element Send Keys** now appends to file inputs with the `multiple` attribute.

## Servoshell

We now **display favicons** in the tab bar for each toplevel page (#36680, @simonwuelker).

Resizing the browser window to a very small dimension no longer crashes the browser (@leo030303, #38461).
Element hit testing in full screen mode now works as expected (@yezhizhen, #38328).

Various popup dialogs (e.g. the `<select>` option chooser dialog) now can be closed without choosing a value (@TimvdLippe, #38373, #38949).
Additionally, the browser now responds to a popup closing without any other inputs (@lumiscosity, #39038).

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

