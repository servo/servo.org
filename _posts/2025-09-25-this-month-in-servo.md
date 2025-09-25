---
layout:     post
tags:       blog
title:      "This month in Servo: variable fonts, network tools, SVG, and more!"
date:       2025-09-25
summary:    Servo’s biggest month by far, with everything from IndexedDB improvements to favicons in servoshell.
categories:
---

Another month, another record number of pull requests merged!
August flew by, and with it came **447 pull requests** from Servo contributors.
It was also the final month of our [Outreachy](https://www.outreachy.org/) cohort; you can read [Jerens'](https://www.jerensl.com/blog/en-final-project-progress-outreachy/) and [Uthman's](https://uthmaniv.github.io/) blogs to learn about how it went!

## Highlights

Our big new feature this month is rendering **inline SVG elements** ([@mukilan](https://github.com/mukilan), [@Loirooriol](https://github.com/Loirooriol), [#38188](https://github.com/servo/servo/pull/38188), [#38603](https://github.com/servo/servo/pull/38603)).
This improves the appearance of many popular websites.

<figure>
  <a href="{{ '/img/blog/2025-09-svg.png' | url }}"><img alt="Screenshot of servoshell with the Google homepage loaded" src="{{ '/img/blog/2025-09-svg.png' | url }}"></a>
  <figcaption>Did you know that the Google logo is an SVG element?</figcaption>
</figure>

We have implemented **named grid line lines and areas** ([@nicoburns](https://github.com/nicoburns), [@loirooriol](https://github.com/loirooriol), [#38306](https://github.com/servo/servo/pull/38306), [#38574](https://github.com/servo/servo/pull/38574), [#38493](https://github.com/servo/servo/pull/38493)), still gated behind the `layout_grid_enabled` preference ([#38306](https://github.com/servo/servo/pull/38306), [#38574](https://github.com/servo/servo/pull/38574)).

<figure>
  <a href="{{ '/img/blog/2025-09-grid.png' | url }}"><img alt="Screenshot of servoshell loading a page demoing a complex grid layout" src="{{ '/img/blog/2025-09-grid.png' | url }}"></a>
  <figcaption>CSS grids are all around us.</figcaption>
</figure>

Servo now supports CSS **‘font-variation-settings’** on all main desktop platforms ([@simonwuelker](https://github.com/simonwuelker), [@mrobinson](https://github.com/mrobinson), [#38642](https://github.com/servo/servo/pull/38642), [#38760](https://github.com/servo/servo/pull/38760), [#38831](https://github.com/servo/servo/pull/38831)).
This feature is currently gated behind the `layout_variable_fonts_enabled` preference.
We also respect `format(*-variations)` inside `@font-face` rules ([@mrobinson](https://github.com/mrobinson), [#38832](https://github.com/servo/servo/pull/38832)).
Additionally, Servo now reads data from **OpenType Collection (.ttc)** system font files on macOS ([@nicoburns](https://github.com/nicoburns), [#38753](https://github.com/servo/servo/pull/38753)), and uses `Helvetica` for the **‘system-ui’** font ([@dpogue](https://github.com/dpogue), [#39001](https://github.com/servo/servo/pull/39001)).

<figure>
  <details style="position:relative">
    <img src="{{ '/img/blog/2025-09-variations.webp' | url }}" style="position:absolute;margin:0;inset:0;pointer-events:none" loading="lazy" alt="servoshell nightly showcasing variable fonts, with variable weight (`wght`) values smoothly increasing and decreasing (click to pause)">
    <summary style="display:block"><img src="{{ '/img/blog/2025-09-variations-preview.png' | url }}" style="margin:0" loading="lazy"><div style="position:absolute;inset:0;display:flex;justify-content:center;align-items:center;color:#1192e8;font-size:7em;cursor:pointer;-webkit-text-stroke:1rem color-mix(in oklch,#1192e8,black 20%);user-select:none" alt="servoshell nightly showcasing variable fonts, with variable weight (`wght`) values smoothly increasing and decreasing (click to play)">▶</div></summary>
  </details>
  <figcaption>This font can be customized!</figcaption>
</figure>

Our [developer tools](https://book.servo.org/hacking/using-devtools.html) continue to make progress!
We now have a functional **network monitor** panel ([@uthmaniv](https://github.com/uthmaniv), [@jdm](https://github.com/jdm), [#38216](https://github.com/servo/servo/pull/38216), [#38601](https://github.com/servo/servo/pull/38601), [#38625](https://github.com/servo/servo/pull/38625)),
and our JS debugger can show potential breakpoints ([@delan](https://github.com/delan), [@atbrakhi](https://github.com/atbrakhi), [#38331](https://github.com/servo/servo/pull/38331), [#38363](https://github.com/servo/servo/pull/38363), [#38333](https://github.com/servo/servo/pull/38333), [#38551](https://github.com/servo/servo/pull/38551), [#38550](https://github.com/servo/servo/pull/38550), [#38334](https://github.com/servo/servo/pull/38334), [#38624](https://github.com/servo/servo/pull/38624), [#38826](https://github.com/servo/servo/pull/38826), [#38797](https://github.com/servo/servo/pull/38797)).
Additionally, the layout inspector now **dims nodes that are not displayed** ([@simonwuelker](https://github.com/simonwuelker), [#38575](https://github.com/servo/servo/pull/38575)).

<figure>
<a href="{{ '/img/blog/2025-09-mastodon.png' | url }}"><img src=" {{ '/img/blog/2025-09-mastodon.png' | url }}" alt="servoshell showing the Servo Mastodon account homepage"></a>
<a href="{{ '/img/blog/2025-09-netmonitor.png' | url }}"><img src="{{ '/img/blog/2025-09-netmonitor.png' | url }}" alt="The Firefox network monitor, showing a list of network connections for the Servo Mastodon account homepage"></a>
  <figcaption>That's a lot of network requests.</figcaption>
</figure>

We've fixed a significant source of crashes in the engine: hit testing using outdated display lists ([issue #37932](https://github.com/servo/servo/issues/37932)).
**Hit testing** in a web rendering engine is the process that determines which element(s) the user's mouse is hovering over.

Previously, this process ran inside of [WebRender](https://github.com/servo/webrender), which receives a display list representing what should be rendered for a particular page.
WebRender runs on a separate thread or process from the actual page content, so display lists are updated asynchronously.
By the time we do a hit test, the elements reported may not exist anymore, so we could trigger crashes by (for example) moving the mouse quickly over parts of the page that were rapidly changing.

This was fixed by making the hit test operation synchronous and moving it into the same thread as the actual content being tested against, eliminating the possibility of outdated results ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [@kongbai1996](https://github.com/kongbai1996), [@yezhizhen](https://github.com/yezhizhen), [#38480,](https://github.com/servo/servo/pull/38480) [#38464,](https://github.com/servo/servo/pull/38464) [#38463,](https://github.com/servo/servo/pull/38463) [#38884,](https://github.com/servo/servo/pull/38884) [#38518)](https://github.com/servo/servo/pull/38518).

## Web platform support

### DOM & JS

We’ve upgraded to **SpiderMonkey v140** ([changelog](https://gitlab.gnome.org/GNOME/gjs/-/blob/master/NEWS#L39-137)) ([@jdm](https://github.com/jdm), [#37077](https://github.com/servo/servo/pull/37077), [#38563](https://github.com/servo/servo/pull/38563)).

Numerous pieces of the [**Trusted Types API**](https://developer.mozilla.org/en-US/docs/Web/API/Trusted_Types_API) are now present in Servo
([@TimvdLippe](https://github.com/TimvdLippe), [@jdm](https://github.com/jdm), [#38595](https://github.com/servo/servo/pull/38595), [#37834](https://github.com/servo/servo/pull/37834), [#38700](https://github.com/servo/servo/pull/38700), [#38736](https://github.com/servo/servo/pull/38736), [#38718](https://github.com/servo/servo/pull/38718), [#38784](https://github.com/servo/servo/pull/38784), [#38871](https://github.com/servo/servo/pull/38871), [#8623](https://github.com/servo/servo/pull/8623), [#38874](https://github.com/servo/servo/pull/38874), [#38872](https://github.com/servo/servo/pull/38872), [#38886](https://github.com/servo/servo/pull/38886)), all gated behind the `dom_trusted_types_enabled` preference.

The [**IndexedDB**](https://developer.mozilla.org/en-US/docs/Web/API/IndexedDB_API) implementation (gated behind `dom_indexeddb_enabled`) is progressing quickly ([@arihant2math](https://github.com/arihant2math), [@jdm](https://github.com/jdm), [@rodion](https://github.com/rodion), [@kkoyung](https://github.com/kkoyung), [#28744](https://github.com/servo/servo/pull/28744), [#38737](https://github.com/servo/servo/pull/38737), [#38836](https://github.com/servo/servo/pull/38836), [#38813](https://github.com/servo/servo/pull/38813), [#38819](https://github.com/servo/servo/pull/38819), [#38115](https://github.com/servo/servo/pull/38115), [#38944](https://github.com/servo/servo/pull/38944), [#38740](https://github.com/servo/servo/pull/38740), [#38891](https://github.com/servo/servo/pull/38891), [#38723](https://github.com/servo/servo/pull/38723), [#38850](https://github.com/servo/servo/pull/38850), [#38735](https://github.com/servo/servo/pull/38735)), now reporting errors via `IDBRequest` interface and supporting autoincrement keys.

A prototype implementation of the [**CookieStore** API](https://developer.mozilla.org/en-US/docs/Web/API/CookieStore) is now implemented and gated by the `dom_cookiestore_enabled` preference ([@sebsebmc](https://github.com/sebsebmc), [#37968](https://github.com/servo/servo/pull/37968), [#38876](https://github.com/servo/servo/pull/38876)).

Servo now passes over **99.6% of the [CSS geometry](https://drafts.fxtf.org/geometry/) test suite**, thanks to an implementation of **matrixTransform() on DOMPointReadOnly**, making all geometry interfaces serializable, and adding the **SVGMatrix and SVGPoint aliases** ([@lumiscosity](https://github.com/lumiscosity), [#38801](https://github.com/servo/servo/pull/38801), [#38828](https://github.com/servo/servo/pull/38828), [#38810](https://github.com/servo/servo/pull/38810)).

You can now use the [**TextEncoderStream** API](https://developer.mozilla.org/en-US/docs/Web/API/TextEncoderStream) ([@minghuaw](https://github.com/minghuaw), [#38466](https://github.com/servo/servo/pull/38466)).
Streams that are piped now correctly pass through `undefined` values, too ([@gterzian](https://github.com/gterzian), [#38470](https://github.com/servo/servo/pull/38470)).
We also fixed a crash in the result of **pipeTo() on ReadableStream** ([@gterzian](https://github.com/gterzian), [#38385](https://github.com/servo/servo/pull/38385)).

We’ve implemented **getModifierState() on MouseEvent** ([@PotatoCP](https://github.com/PotatoCP), [#38535](https://github.com/servo/servo/pull/38535)), and made a number of changes involving DOM events: **‘mouseleave’ events** are fired when the pointer leaves an &lt;iframe> ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#38539](https://github.com/servo/servo/pull/38539)), pasting from the clipboard into a text input triggers an **‘input’ event** ([@mrobinson](https://github.com/mrobinson), [#37100](https://github.com/servo/servo/pull/37100)), **focus now occurs after ‘mousedown’** instead of ‘click’ ([@yezhizhen](https://github.com/yezhizhen), [#38589](https://github.com/servo/servo/pull/38589)), we ignore ‘mousedown’ and ‘mouseup’ events for elements that are disabled ([@yezhizhen](https://github.com/yezhizhen), [#38671](https://github.com/servo/servo/pull/38671)), and removing an event handler attribute like ‘onclick’ clears all relevant event listeners ([@TimvdLippe](https://github.com/TimvdLippe), [@kotx](https://github.com/kotx), [#38734](https://github.com/servo/servo/pull/38734), [#39011](https://github.com/servo/servo/pull/39011)).

Servo now supports **scrollIntoView()** ([@abdelrahman1234567](https://github.com/abdelrahman1234567), [#38230](https://github.com/servo/servo/pull/38230)), and fires a **‘scroll’ event** whenever a page is scrolled ([@stevennovaryo](https://github.com/stevennovaryo), [#38321](https://github.com/servo/servo/pull/38321)).
You can now focus an element without scrolling, by passing the `{preventScroll: true}` option to focus() ([@abdelrahman1234567](https://github.com/abdelrahman1234567), [#38495](https://github.com/servo/servo/pull/38495)).

**navigator.sendBeacon()** is now implemented, gated behind the `dom_navigator_sendbeacon_enabled` preference ([@TimvdLippe](https://github.com/TimvdLippe), [#38301](https://github.com/servo/servo/pull/38301)).
Similarly, the **AbortSignal.abort()** static method is hidden behind `dom_abort_controller_enabled` ([@Taym95](https://github.com/Taym95), [#38746](https://github.com/servo/servo/pull/38746)).

The **HTMLDocument** interface now exists as a property on the `Window` object ([@leo030303](https://github.com/leo030303), [#38433](https://github.com/servo/servo/pull/38433)).
Meanwhile, the **CSS** window property is now a [WebIDL namespace](https://webidl.spec.whatwg.org/#idl-namespaces) ([@simonwuelker](https://github.com/simonwuelker), [#38579](https://github.com/servo/servo/pull/38579)).
We also implemented the new **QuotaExceededError** interface ([@rmeno12](https://github.com/rmeno12), [#38507](https://github.com/servo/servo/pull/38507), [#38720](https://github.com/servo/servo/pull/38720)), which replaces previous usages of DOMException with the `QUOTA_EXCEEDED_ERR` name.

Our 2D canvas implementation now supports **addPath() on Path2D** ([@arthmis](https://github.com/arthmis), [#37838](https://github.com/servo/servo/pull/37838)) and the **restore()** methods on **CanvasRenderingContext2D** and **OffscreenCanvas** now pop all applied clipping paths ([@sagudev](https://github.com/sagudev), [#38496](https://github.com/servo/servo/pull/38496)).
Additionally, we now support **using web fonts in the 2D canvas** ([@mrobinson](https://github.com/mrobinson), [#38979](https://github.com/servo/servo/pull/38979)).
Meanwhile, the performance continues to improve in the new [Vello](https://github.com/linebender/vello?tab=readme-ov-file#vello)-based backends ([@sagudev](https://github.com/sagudev), [#38406](https://github.com/servo/servo/pull/38406), [#38356](https://github.com/servo/servo/pull/38356), [#38440](https://github.com/servo/servo/pull/38440), [#38437](https://github.com/servo/servo/pull/38437)), with asynchronous uploading also showing improvements ([@sagudev](https://github.com/sagudev), [@mrobinson](https://github.com/mrobinson), [#37776](https://github.com/servo/servo/pull/37776)).

Muting media elements with the **‘mute’** HTML attribute now works during the initial resource load ([@rayguo17](https://github.com/rayguo17), [@jschwe](https://github.com/jschwe), [#38462](https://github.com/servo/servo/pull/38462)).

Modifying stylesheets now integrates better with incremental layout, in both light trees and shadow trees ([@coding-joedow](https://github.com/coding-joedow), [#38530](https://github.com/servo/servo/pull/38530), [#38529](https://github.com/servo/servo/pull/38529)).
Note that calling setProperty() on a readonly CSSStyleDeclaration correctly throws an exception ([@simonwuelker](https://github.com/simonwuelker), [#38677](https://github.com/servo/servo/pull/38677)).

### CSS

We’ve upgraded to the upstream **Stylo** revision as of August 1, 2025.

We now support custom CSS properties with the **CSS.registerProperty()** method ([@simonwuelker](https://github.com/simonwuelker), [#38682](https://github.com/servo/servo/pull/38682)), as well as custom element states with the **‘states’ property on ElementInternals** ([@simonwuelker](https://github.com/simonwuelker), [#38564](https://github.com/servo/servo/pull/38564)).

Flexbox cross sizes can no longer end up negative through stretching ([@Loirooriol](https://github.com/Loirooriol), [#38521](https://github.com/servo/servo/pull/38521)), while ‘stretch’ on flex items now stretches to the line if possible ([@Loirooriol](https://github.com/Loirooriol), [#38526](https://github.com/servo/servo/pull/38526)).

**Overflow calculations are more accurate**, now that we ignore ‘position: fixed’ children of the root element ([@stevennovaryo](https://github.com/stevennovaryo), [#38618](https://github.com/servo/servo/pull/38618)), compute overflow for &lt;body> separate from the viewport ([@shubhamg13](https://github.com/shubhamg13), [#38825](https://github.com/servo/servo/pull/38825)), check for ‘overflow: visible’ in parents and children ([@shubhamg13](https://github.com/shubhamg13), [#38443](https://github.com/servo/servo/pull/38443)), and propagate ‘overflow’ to the viewport correctly ([@shubhamg13](https://github.com/shubhamg13), [@Loirooriol](https://github.com/Loirooriol), [#38598](https://github.com/servo/servo/pull/38598)).

‘color’ and ‘text-decoration’ properties no longer inherit into the contents of &lt;select> elements ([@simonwuelker](https://github.com/simonwuelker), [#38570](https://github.com/servo/servo/pull/38570)).

Negative outline offsets work correctly ([@lumiscosity](https://github.com/lumiscosity), [@mrobinson](https://github.com/mrobinson), [#38418](https://github.com/servo/servo/pull/38418)).

Video elements no longer fall back to a preferred aspect ratio of 2 ([@Loirooriol](https://github.com/Loirooriol), [#38705](https://github.com/servo/servo/pull/38705)).

‘position: sticky’ elements are handled correctly inside CSS transforms ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#38391](https://github.com/servo/servo/pull/38391)).

## Performance & Stability

We fixed several panics this month, involving IntersectionObserver and missing stacking contexts ([@mrobinson](https://github.com/mrobinson), [#38473](https://github.com/servo/servo/pull/38473)), unpaintable canvases and text ([@gterzian](https://github.com/gterzian), [#38664](https://github.com/servo/servo/pull/38664)), serializing ‘location’ properties on Window objects ([@jdm](https://github.com/jdm), [#38709](https://github.com/servo/servo/pull/38709)), and navigations canceled before HTTP headers are received ([@gterzian](https://github.com/gterzian), [#38739](https://github.com/servo/servo/pull/38739)).

We also fixed a number of performance pitfalls.
The document rendering loop is now **throttled to 60 FPS** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#38431](https://github.com/servo/servo/pull/38431)), while **animated images do less work** when advancing the current frame ([@mrobinson](https://github.com/mrobinson), [#38857](https://github.com/servo/servo/pull/38857)).
In addition, elements with **CSS images will not trigger page reflow** until their image data is fully available ([@coding-joedow](https://github.com/coding-joedow), [#38916](https://github.com/servo/servo/pull/38916)).

Finally, we made improvements to memory usage and binary size.
Inline stylesheets are now deduplicated, which can have a significant impact on pages with **lots of form inputs** or **custom elements** with common styles ([@coding-joedow](https://github.com/coding-joedow), [#38540](https://github.com/servo/servo/pull/38540)).
We also removed many unused pieces of the ICU library, **saving 16MB** from the final binary.

## Embedding

Servo has declared a **Minimum Supported Rust Version** (1.85.0), and this is verified with every new pull request ([@jschwe](https://github.com/jschwe), [#37152](https://github.com/servo/servo/pull/37152)).

Evaluating JS from the embedding layer now **reports an error** if the evaluation failed for any reason ([@rodio](https://github.com/rodio), [#38602](https://github.com/servo/servo/pull/38602)).

Our **WebDriver** implementation now passes 80% of the implementation conformance tests.
This is the result of lots of work on handling user prompts ([@PotatoCP](https://github.com/PotatoCP), [#38591](https://github.com/servo/servo/pull/38591)), computing obscured/disabled elements while clicking ([@yezhizhen](https://github.com/yezhizhen), [#38497](https://github.com/servo/servo/pull/38497), [#38841](https://github.com/servo/servo/pull/38841), [#38436](https://github.com/servo/servo/pull/38436), [#38490](https://github.com/servo/servo/pull/38490), [#38383](https://github.com/servo/servo/pull/38383)), and improving window focus behaviours ([@yezhizhen](https://github.com/yezhizhen), [#38889](https://github.com/servo/servo/pull/38889), [#38909](https://github.com/servo/servo/pull/38909)).
We also implemented the **Get Window Handles** command ([@longvatrong111](https://github.com/longvatrong111), [@yezhizhen](https://github.com/yezhizhen), [#38622](https://github.com/servo/servo/pull/38622), [#38745](https://github.com/servo/servo/pull/38745)), added support for getting element boolean attributes ([@kkoyung](https://github.com/kkoyung), [#38401](https://github.com/servo/servo/pull/38401)), and added more accurate errors for a number of commands ([@yezhizhen](https://github.com/yezhizhen), [@longvatrong111](https://github.com/longvatrong111), [#38620](https://github.com/servo/servo/pull/38620), [#38357](https://github.com/servo/servo/pull/38357)).
The **Element Clear** command now clears `<input type="file">` elements correctly ([@PotatoCP](https://github.com/PotatoCP), [#38536](https://github.com/servo/servo/pull/38536)), and **Element Send Keys** now appends to file inputs with the ‘multiple’ attribute.

## servoshell

We now **display favicons** of each top-level page in the tab bar ([@simonwuelker](https://github.com/simonwuelker), [#36680](https://github.com/servo/servo/pull/36680)).

<figure>
<a href="{{ '/img/blog/2025-09-favicon.png' | url }}"><img src=" {{ '/img/blog/2025-09-favicon.png' | url }}" alt="servoshell showing a diffie favicon in the tab bar"></a>
</figure>

Resizing the browser window to a very small dimension no longer crashes the browser ([@leo030303](https://github.com/leo030303), [#38461](https://github.com/servo/servo/pull/38461)).
Element hit testing in full screen mode now works as expected ([@yezhizhen](https://github.com/yezhizhen), [#38328](https://github.com/servo/servo/pull/38328)).

Various popup dialogs, such as the &lt;select> option chooser dialog, can now be closed without choosing a value ([@TimvdLippe](https://github.com/TimvdLippe), [#38373](https://github.com/servo/servo/pull/38373), [#38949](https://github.com/servo/servo/pull/38949)).
Additionally, the browser now responds to a popup closing without any other inputs ([@lumiscosity](https://github.com/lumiscosity), [#39038](https://github.com/servo/servo/pull/39038)).

## Donations

Thanks again for your generous support!
We are now receiving **5552 USD/month** (+18.3% over July) in recurring donations.

Historically this has helped cover the cost of our [speedy](https://ci0.servo.org) [CI](https://ci1.servo.org) [servers](https://ci2.servo.org) and [Outreachy interns](https://www.outreachy.org/alums/2025-06/#:~:text=Servo).
Thanks to your support, we’re now setting up **[two](https://ci3.servo.org) [new](https://ci4.servo.org) CI servers for benchmarking**, and **[funding the work of our long-time maintainer]({{ '/blog/2025/09/17/your-donations-at-work-funding-jdm/' | url }}) Josh Matthews** (@jdm), with a particular focus on helping more people contribute to Servo.

Keep an eye out for [further CI improvements](https://github.com/servo/servo/issues/38141) in the coming months, including [**ten-minute WPT builds**](https://github.com/servo/ci-runners/issues/21), **macOS arm64 builds**, and **faster pull request checks**.

Servo is also on [thanks.dev](https://thanks.dev), and already **15 GitHub users** (−7 from July) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 5552 / 10000); padding-left: 0.5em;"><strong>5552</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 5552 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="5552" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

As always, use of these funds will be decided transparently in the Technical Steering Committee.
For more details, head to our [Sponsorship page]({{ '/sponsorship/' | url }}).

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
