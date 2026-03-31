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

[**Servo 0.0.6**](https://github.com/servo/servo/releases/tag/v0.0.6) includes some exciting new features:

- **&lt;button command>** and **&lt;button commandfor>** (@lukewarlow, #41237)
- **‘:modal’** selectors on **&lt;dialog>** (@lukewarlow, #42201)
- **‘@property’** rules (@yezhizhen, @Loirooriol, #42136, #42858)
- **‘alignment-baseline’** and **‘baseline-shift’** (@Loirooriol, #42361)
- **‘Content-Security-Policy: base-uri’** (@WaterWhisperer, #42272)
- partial support for **&lt;iframe loading=lazy>** (@TimvdLippe, #41959)
- partial support for **‘transform-style: preserve-3d’** (@simonwuelker, #42755)

Plus a bunch of new DOM APIs:

- most of the [**Pointer Events**](https://w3c.github.io/pointerevents/) API (@webbeef, #41290)
- the **UserActivation** API (@stevennovaryo, #42060)
- **import.meta.resolve()** (@Gae24, #42506)
- **integrity** in **&lt;script type=importmap>** (@Gae24, #42604)
- the **formData()** method on **Request** (@Taym95, #42041)
- the **alpha** property on **HTMLInputElement** (@simonwuelker, #42293)
- **tabIndex** on **HTMLElement** and **SVGElement** (@mrobinson, @Loirooriol, #42913)
- **fullscreenElement** on **Document** and **ShadowRoot** (@onsah, #42401)
- **toJSON()** on **PerformancePaintTiming** (@shubhamg13, #42396)
- **navigator.pdfViewerEnabled** (@simonwuelker, #42277)
- **keyPath** on **IDBIndex** (@arihant2math, #42431)
- **createIndex()**, **deleteIndex()**, and **index()** on **IDBObjectStore** (@arihant2math, @bulltickr, #38840, #42440, #42443)

<figure>
    <a href="{{ '/img/blog/2026-03-diffie.png' | url }}"><img src="{{ '/img/blog/2026-03-diffie.png' | url }}" alt="Servo 0.0.6 showing ‘transform-style: preserve-3d’, ‘vertical-align’ shorthand with ‘baseline-shift’, objects being previewed in DevTools when passed to console.log(), pausing script execution in DevTools, and opening a modal `<dialog>` with `<button command>`"></a>
</figure>

This is a *big* update, so here’s an outline:

- [**Work in progress**](#work-in-progress)<br>– accessibility, execCommand()

- [**Developer tools**](#developer-tools)<br>– localhost only by default, Inspector, Console, Debugger

- [**servoshell**](#servoshell)<br>– servo:config, F5 to reload

- [**Embedding API**](#embedding-api)<br>– offline builds, user stylesheets, context menus, gamepad API

- [**More on the web platform**](#more-on-the-web-platform)<br>– font fallback, cookies, IndexedDB, First and Largest Contentful Paint

- [**Performance and stability**](#performance-and-stability)<br>– about:memory, incremental layout, shared memory

- [**Bug fixes**](#bug-fixes)<br>– Windows arm64, layout, DOM events, shadow DOM

## Work in progress

We’ve started working on **accessibility support for web content** (@alice, @delan, #42333, #42402), gated by a pref (`--pref accessibility_enabled`).
Each webview will be able to expose its own accessibility tree, which the embedder can then integrate into its own accessibility tree.
As part of this work:

- [**AccessKit**](https://accesskit.dev) now supports **combining accessibility trees** with its new “subtree” feature (@DataTriny, @delan, @lukewarlow, @alice, AccessKit/accesskit#655, AccessKit/accesskit#641)

- [**egui**](https://www.egui.rs) has been migrated to the new AccessKit API (@delan, @lukewarlow, @lucasmerlin, @DataTriny, emilk/egui#7850)

- we added a [`Servo`](https://doc.servo.org/servo/struct.Servo.html) API for activating accessibility features (@delan, @alice, #42336), although this has since become a [`WebView`](https://doc.servo.org/servo/struct.WebView.html) API

We’ve started implementing **document.execCommand()** (@TimvdLippe, #42621, #42626, #42750), gated by a pref (`--pref dom_exec_command_enabled`).
This feature is also **enabled in experimental mode**, and together with **contenteditable**, it’s critical for rich text editing on the web.
The work done in February includes:

- **document.queryCommandEnabled()** (@TimvdLippe, #42634)
- **document.queryCommandSupported()** (@TimvdLippe, #42731)
- **document.queryCommandIndeterm()**, **queryCommandState()**, and **queryCommandValue()** (@TimvdLippe, #42748)
- the [**canonicalize whitespace**](https://w3c.github.io/editing/docs/execCommand/#canonicalize-whitespace) algorithm – this is used by the ‘delete’, ‘forwardDelete’, and ‘insertText’ commands (@TimvdLippe, #42704)
- **contentEditable** on **HTMLElement** – for execCommand() only, excluding any support for interactive editing (@TimvdLippe, #42633, #42734)

## Developer tools

[**DevTools**](https://book.servo.org/contributing/devtools.html) has seen some big improvements in February!

When enabled in servoshell, the DevTools server is more secure by default, listening only on localhost when only a port number is specified (@Narfinger, #42502).
You can open the port for remote debugging by passing a full [SocketAddr](https://doc.rust-lang.org/std/net/enum.SocketAddr.html), such as `--devtools=[::]:6080` or `--devtools=0.0.0.0:6080`.

In the **Inspector** tab, you can now **edit DOM attributes**, and the DOM tree updates when attributes change (@simonwuelker, #42601, #42785).
You can now list the event type and phase of **event listeners** attached to a DOM node as well (@simonwuelker, #42355).

In the **Console** tab, **objects can now be previewed** when passed to console.log() and friends (@simonwuelker, #42296, #42510, #42752), and boolean values are now syntax highlighted (@pralkarz, #42513).

In the **Debugger** tab, you can now **pause and resume** script execution, both manually and when breakpoints are hit (@eerii, @atbrakhi, #42599, #42580, #42874).
We’ve also started working on other debugger features (@atbrakhi, @eerii, #42306), including stepping execution (@eerii, @atbrakhi, #42844, #42878, #42906), so once again stay tuned!

<figure>
    <video src="{{ '/img/blog/2026-03-devtools-debugger.mp4' | url }}" autoplay muted loop>Servo 0.0.6 showing DevTools debugger setting breakpoints, pausing on those breakpoints, and resuming script execution</video>
</figure>

## servoshell

servoshell now has a **servo:config** page (@arihant2math, #40324), allowing you to set any of Servo’s preferences, including internal prefs.
This is much like about:config in Firefox.
Note that preference changes are not yet persistent, and not all prefs take effect when changed at runtime.

You can now **press F5** to **reload the page** in servoshell (@Narfinger, #42538), in addition to pressing Ctrl+R or ⌘R.

We’ve fixed a regression where the caret stopped being visible in the location bar (@mrobinson, #42470).

## Embedding API

Servo is now easier to **build offline**, using the complete source tarball included in each release (@jschwe, #42852).
Go to a release on GitHub, then download `servo-[version]-src-vendored.tar.gz` to get started.

You can now **add and remove user stylesheets** with [`User­Content­Manager`](https://doc.servo.org/servo/struct.UserContentManager.html)::[`add­_stylesheet`](https://doc.servo.org/servo/struct.UserContentManager.html#method.add_stylesheet) and [`remove­_stylesheet`](https://doc.servo.org/servo/struct.UserContentManager.html#method.remove_stylesheet), and **remove user scripts** with [`User­Content­Manager`](https://doc.servo.org/servo/struct.UserContentManager.html)::[`remove­_script`](https://doc.servo.org/servo/struct.UserContentManager.html#method.remove_script) (@mukilan, #42288).
Previously user stylesheets were only configurable via servoshell’s `--user-stylesheet` option.

<aside class=_note>

**User stylesheets** work a bit differently to **userstyles**, since they [cascade](https://drafts.csswg.org/css-cascade/#cascading) via the [user origin](https://drafts.csswg.org/css-cascade/#cascade-origin-user), not the [author origin](https://drafts.csswg.org/css-cascade/#cascade-origin-author). For more details about the tradeoffs, check out [*Customising the web: browsers as user agents*](https://www.youtube.com/watch?v=xLFQejlPf6U) ([slides](https://www.azabani.com/talks/2023-11-10-customising-the-web/)).
</aside>

Before opening any [**context menus**](https://doc.servo.org/servo/enum.EmbedderControl.html#variant.ContextMenu) on behalf of web content, Servo now closes any context menus that were opened by web content (@mrobinson, #42487), to avoid UI problems on some platforms.
This is done by calling [`WebView­Delegate`](https://doc.servo.org/servo/trait.WebViewDelegate.html)::[`hide­_embedder­_control`](https://doc.servo.org/servo/trait.WebViewDelegate.html#method.hide_embedder_control) before calling [`show­_embedder­_control`](https://doc.servo.org/servo/trait.WebViewDelegate.html#method.show_embedder_control) in those cases.

[**Input method events**](https://doc.servo.org/servo/enum.EmbedderControl.html#variant.InputMethod) from web content now indicate whether or not the virtual keyboard should be shown (@stevennovaryo, @mrobinson, #42467), with the new [`Input­Method­Control`](https://doc.servo.org/servo/struct.InputMethodControl.html)::[`allow­_virtual­_keyboard`](https://doc.servo.org/servo/struct.InputMethodControl.html#method.allow_virtual_keyboard) method.
Generally the virtual keyboard should only be shown when the page has [sticky activation](https://developer.mozilla.org/en-US/docs/Glossary/Sticky_activation).

We’re reworking our **gamepad API**, with [`WebView­Delegate`](https://doc.servo.org/servo/trait.WebViewDelegate.html)::`play­_gamepad­_haptic­_effect` and `stop­_gamepad­_haptic­_effect` being replaced by a new API that (as of the end of February at least) is known as `GamepadProvider` (@atbrakhi, #41568).
The old methods are no longer called ([#43743](https://github.com/servo/servo/issues/43743)), and may be removed at some point.

We now have better diagnostic output when we fail to create an OpenGL context (@mrobinson, #42873), including when the OpenGL versions supported by the device are too old.

[`Servo`](https://doc.servo.org/servo/struct.Servo.html)::`constellation_sender` was removed (@jdm, #42389), since it was never useful to embedders.

We’ve also made some changes to [`Preferences`](https://doc.servo.org/servo/struct.Preferences.html):

- `devtools­_server­_port` is now [`devtools­_server­_listen­_address`](https://doc.servo.org/servo/struct.Preferences.html#structfield.devtools_server_listen_address), and can now take either a port number (as before) or a full [SocketAddr](https://doc.rust-lang.org/std/net/enum.SocketAddr.html) (@Narfinger, #42502)

- `dom­_worklet­_blockingsleep` is now `dom­_worklet­_blockingsleep­_enabled` (@mukilan, #42897)

- Removed many unused preferences (@mukilan, #42897) – `js­_asyncstack`, `js­_discard­_system­_source`, `js­_dump­_stack­_on­_debuggee­_would­_run`, `js­_ion­_offthread­_compilation­_enabled`, `js­_mem­_gc­_allocation­_threshold­_avoid­_interrupt­_factor`, `js­_mem­_gc­_allocation­_threshold­_factor`, `js­_mem­_gc­_allocation­_threshold­_mb`, `js­_mem­_gc­_decommit­_threshold­_mb`, `js­_mem­_gc­_dynamic­_heap­_growth­_enabled`, `js­_mem­_gc­_dynamic­_mark­_slice­_enabled`, `js­_shared­_memory`, `js­_throw­_on­_asmjs­_validation­_failure`, `js­_throw­_on­_debuggee­_would­_run`, `js­_werror­_enabled`, and `network­_mime­_sniff`

## More on the web platform

If you navigate to a **video file** or **audio file as a document**, the player now has controls (@webbeef, #42488).

**Images now rotate** according to their **EXIF metadata** by default (@rayguo17, #42567), like they would once we add support for ‘image-orientation: from-image’.

We’re implementing **system-font-aware font fallback** (@mrobinson, #42466), with support for this on macOS landing this month (@mrobinson, #42776).
This allows Servo to render text in scripts that are not covered by web fonts or any of the fonts on Servo’s built-in lists of fallback fonts, as long as they are covered by fonts installed on the system.

Servo now supports the newer **pointermove**, **pointerdown**, **pointerup**, and **pointercancel** events (@webbeef, #41290).
The older **touchmove**, **touchstart**, **touchend**, and **touchcancel** events continue to be supported.

The default language in **‘Accept-Language’** and **navigator.language** is now taken from the **$LANG** environment variable if present (@webbeef, #41919), rather than always being set to en-US.

**&lt;input type=color>** now supports any CSS color value (@simonwuelker, #42275), including the more complex values like color-mix().
We’ve also landed the **colorspace** attribute (@simonwuelker, #42279), but only in the web-facing side of Servo for now, not the embedding API or in servoshell.

**‘vertical-align’** is now a shorthand for ‘alignment-baseline’ and ‘baseline-shift’ (@Loirooriol, #42361), and **scrollParent** on **HTMLElement** is now a function per [this recent spec update](https://github.com/w3c/csswg-drafts/issues/12731) (@TimurBora, #42689).

**Cookies** are now more conformant (@sebsebmc, #42418, #42427, #42435).
**‘Expires’** and **‘Max-Age’** attributes are now handled correctly in ‘Set-Cookie’ headers, **get()** and **getAll()** on **CookieStore** now trim whitespace in cookie names and values, and the behaviour of **set()** on **CookieStore** has been improved.

**&lt;iframe>** elements are now more conformant in how **load** events are fired on the element and its contentWindow (@TimvdLippe, #42254), although there are still some bugs.
This has long behaved incorrectly in Servo, and it has historically caused many problems in the Web Platform Tests.

**IndexedDB** is now more conformant in our handling of transactions (@Taym95, #41508, #42732), and when opening and closing connections (@gterzian, @Taym95, #42082, #42669).

We’ve started implementing **Largest Contentful Paint** timings (@shubhamg13, #42024), and we’ve landed a bunch of improvements to how **First Contentful Paint** timings work in Servo:

- we now include ‘background-image’ (@shubhamg13, #42569)
- we now include ‘border-image’ (@shubhamg13, #42581)
- we now ignore subtrees with ‘opacity: 0’ (@shubhamg13, #42768)
- we now ignore zero-sized subtrees (@shubhamg13, #42178)
- we now ignore &lt;iframe> (@shubhamg13, #42498)
- we now ignore &lt;video> and &lt;video poster> unless they actually have an image (@shubhamg13, #42411)
- we now ignore mouse moves when deciding when to stop measuring (@shubhamg13, #41999)

**new WebSocket()** now resolves relative URLs (@webbeef, #42425).

**requestFullscreen()** on **Element** now requires [user activation](https://developer.mozilla.org/en-US/docs/Web/Security/Defenses/User_activation) (@stevennovaryo, #42060).

**performance.getEntries()** now returns [PerformanceResourceTiming](https://developer.mozilla.org/en-US/docs/Web/API/PerformanceResourceTiming) entries for navigations in &lt;iframe> (@muse254, #42270).

When geolocation is enabled (`--pref dom_geolocation_enabled`), **navigator­.geolocation­.get­Current­Position()** and **watch­Position()** now support the optional **errors** argument (@arihant2math, #42295).

We now support the **‘-webkit-text-security’** property in CSS (@mrobinson, #42181), which is not specified anywhere but required for [MotionMark](https://browserbench.org/MotionMark1.2/).

## Performance and stability

Our **about:memory** page now knows how to **report many new kinds of memory usage**, including the **DevTools** server (@Narfinger, #42478, #42480), **WebGL** (@sagudev, #42570), **localStorage** and **sessionStorage** (@arihant2math, #42484), and some of the memory used by **IndexedDB** (@arihant2math, #42486).
We’ve also started internally tracking the memory usage of the media subsystem (@Narfinger, #42504) and WebXR (@Narfinger, #42505).

**Layout** has seen a lot of performance work in February, with our main focus being on improving [**incremental layout**]({{ '/blog/2025/07/17/this-month-in-servo/#performance' | url }}) of the **box tree** and **fragment tree**.

We now have our first **truly incremental box tree layout** (@mrobinson, @Loirooriol, @lukewarlow, #42700, #42816), rather than our previous “dirty roots”-based approach.
Depending on how they were [damaged](https://en.wikipedia.org/wiki/Dirty_bit), some boxes for **independent formatting contexts** (@Loirooriol, @lukewarlow, @mrobinson, #42783) and **floats** (@Loirooriol, @lukewarlow, @mrobinson, #42816) can now be reused, and they avoid damaging their parents (@Loirooriol, @lukewarlow, @mrobinson, #42847).

**Incremental fragment tree layout** is improving too!
Whereas we previously had to decide whether to run fragment tree layout in an “all or nothing” way, we can now **reuse cached fragments** in independent formatting contexts (@mrobinson, @Loirooriol, @lukewarlow, #42687, #42717, #42871).
We can also measure how much work is being done on each layout (@Loirooriol, @lukewarlow, @mrobinson, #42817).

Servo uses **shared memory** for many situations where copying data over channels would be too expensive, such as for images and fonts.
In multiprocess mode (`--multiprocess`), we use the operating system to create the shared memory in a way that can be shared with other processes, such as [shm_open(3)](https://pubs.opengroup.org/onlinepubs/9799919799/functions/shm_open.html) or [CreateFileMappingW](https://learn.microsoft.com/en-us/windows/win32/api/memoryapi/nf-memoryapi-createfilemappingw), but this consumes resources that can sometimes be exhausted.
We only need to use those kinds of shared memory in multiprocess mode, so we’ve reworked Servo to use `Arc`﻿`<Vec<u8>>` in single-process mode (@Narfinger, #42083), which should avoid resource exhaustion.

We’ve also landed optimisations for **‘Content-Security-Policy’** (@Narfinger, #42716), **IntersectionObserver** (@Narfinger, @mrobinson, @stevennovaryo, #42366, #42390), **layout queries** (@webbeef, #42327), the **bfcache** (@Narfinger, #42703), loading **images** (@Narfinger, #42684), and in the interfaces between Servo and **SpiderMonkey** (@sagudev, #42135, #42576).

**Parsing web pages** is complicated: we want pages to render incrementally as they stream in from the network, and we want to prefetch resources, but scripts can call document.write(), which injects markup “on the spot”.
This is further complicated if that markup also contains a &lt;script>.

We’ve recently landed some fixes to Servo’s **async parser** (@simonwuelker, #42882, #42910), which handles these issues more efficiently.
This is currently an obscure and somewhat buggy feature (`--pref dom­_servoparser­_async­_html­_tokenizer­_enabled`), but if we can get the feature working more reliably ([#37418](https://github.com/servo/servo/issues/37418)), it could **halve the energy** Servo spends on parsing, **lower latency** for pages that don’t use document.write(), and even **improve the html5ever API** for the ecosystem.

We’ve continued our long-running effort to **use the Rust type system** to make certain kinds of dynamic borrow failures impossible (@Gae24, @pralkarz, @BryanSmith00, @sagudev, @Narfinger, @TimvdLippe, @kkoyung, @TimurBora, @onsah, #42342, #42294, #42370, #42417, #42619, #42616, #42637, #42640, #42662, #42679, #42681, #42665, #42667, #42699, #42712, #42725, #42729, #42726, #42720, #42738, #42737, #42735, #42751, #42805, #42809, #42780, #42820, #42715, #42635, #42880, #42846).

## Bug fixes

We’ve landed some fixes for issues preventing Servo from being built on **Windows arm64** (@dpaoliello, @npiesco, #42371, #42341).
Work to enable Windows arm64 as a build platform is ongoing (@npiesco, #42312).

**&lt;img height>** now takes the default &lt;img width> from the aspect ratio of the image (@Loirooriol, #42577), rather than using a width of 300px by default.
**&lt;svg width=0>** and **&lt;svg height=0>** now take the default width and height (respectively) from the aspect ratio of the &lt;svg viewBox> (@Loirooriol, #42545).

We’ve fixed a bug in the result of **layout queries**, such as getBoundingClientRect(), on inline **&lt;svg>** (@jdm, @Loirooriol, #42594), and we’ve fixed layout bugs related to **‘display: table-cell’** (@Loirooriol, #42778), **‘display: list-item’** (@Loirooriol, #42825, #42864), **‘inset: auto’** (@Loirooriol, #42586), **‘width: max-content’** (@mrobinson, @Loirooriol, @lukewarlow, #42574), **‘align-self: last baseline’** (@rayguo17, #42724), **‘list-style-image’** (@lukewarlow, #42332), **‘content: &lt;image>’** (@lukewarlow, #42332), negative **‘margin’** (@Loirooriol, #42889), and **ink overflow** (@mrobinson, #42403).

We’ve also fixed a variety of other web-related bugs:

- `event.target` being incorrect on **touchmove**, **touchend**, and **touchcancel** events (@yezhizhen, #42654)
- **touchmove** events not being fired when part of a two-finger pinch zoom (@yezhizhen, #42528)
- **touchend** events erroneously firing after touchcancel events (@yezhizhen, #42654)
- **assignedNodes()** on **HTMLSlotElement** returning incorrect results after the &lt;slot> was removed from the shadow tree (@rayguo17, #42250)
- **&lt;template>** failing to throw HierarchyRequestError when a DOM API is used to create an invalid hierarchy (@TimvdLippe, #42276)
- **&lt;a target>** failing to work correctly after the related &lt;iframe> is removed and a new one added with the same name (@jdm, #42344)
- **&lt;base>** not taking effect in some cases, or taking effect when given a **data:** or **javascript:** URL (@TimvdLippe, #42255, #42339)
- **Largest Contentful Paint** timings no longer being collected after reloading or navigating (@shubhamg13, #41169)
- **PerformancePaintTiming** being exposed to Worker globals when they shouldn’t be (@shubhamg13, #42409)
- **JavaScript modules** resolved incorrectly when there are overlapping `.imports` or `.scopes` or import maps (@Gae24, #42668, #42630, #42754, #42821)
- changes to how we trigger **garbage collection** breaking [Speedometer](https://browserbench.org/Speedometer3.1/) (@sagudev, #42271)

We’ve fixed **crashes in DevTools**, in the Inspector tab (@eerii, @mrobinson, #42330), when exiting Servo while DevTools is connected (@simonwuelker, #42543), when setting breakpoints (@atbrakhi, #42810), and after clients disconnect (@simonwuelker, #42583).

We’ve fixed **crashes in layout**, when using ‘background-repeat: round’ (@mrobinson, #42303), when using ‘list-style-image’ or ‘content: &lt;image>’ (@lukewarlow, #42332), when calling elementFromPoint() on Document (@mrobinson, @Loirooriol, @lukewarlow, #42822), and when handling layout queries like getBoundingClientRect() on inline &lt;svg> (@jdm, @Loirooriol, #42594).

We’ve fixed **crashes related to stylesheets**, when removing stylesheets from the DOM (@TimvdLippe, #42273), when changing the href of a &lt;link rel=stylesheet> (@TimvdLippe, #42481), and when loading stylesheets with `--layout-threads=1` (@mrobinson, @Loirooriol, @lukewarlow, #42685).

We’ve also fixed crashes when using multitouch input (@yezhizhen, #42350), when using MediaStreamAudioSourceNode (@mrobinson, #42914), when calling add() on HTMLOptionsCollection (@mrobinson, #42263), when calling elementFromPoint() on Document or ShadowRoot(), when we fail to open a database for IndexedDB (@jdm, @mrobinson, #42444), and when certain pages are run with a mozjs debug build (@Gae24, #42428).

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
