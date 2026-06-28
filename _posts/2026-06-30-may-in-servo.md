---
layout:     post
tags:       blog
title:      "May in Servo: and more!"
date:       2026-06-30
summary:    ao!! wrrrrao!!
categories:
---

[**Servo 0.3.0**](https://github.com/servo/servo/releases/tag/v0.3.0) contains all of the changes we landed in May, which came out to **391 commits** (March: 534).
For security fixes, see [**§ Security**](#security).

We’ve shipped several new web platform features:

- **‘font-kerning: none’** (@simonwuelker, #44634)
- **‘font-variant-east-asian’** (@simonwuelker, #44989)
- **‘font-variant-ligatures’** (@simonwuelker, #44903)
- **‘font-variant-numeric’** (@simonwuelker, #44950)
- **‘font-variant-position’** (@simonwuelker, #45142)
- **mp4** files **without fast start** in **&lt;video>** (@calvaris, #45084)
- `<form enctype="multipart/form-data">` (@yezhizhen, #45028)
- `<form enctype="text/plain">` (@yezhizhen, #45111)
- **&lt;![CDATA[]]>** layout (@mrobinson, #44791)

Plus a bunch of new DOM APIs:

- **onslotchange** property on **Shadow­Root** (@jdm, #44688)
- **screen­Left** and **screen­Top** on **Window** (@TG199, #45128)
- **new Blob()** with `{endings: "native"}` (@yezhizhen, #44803)
- **new Performance­Mark()** (@shubhamg13, #44702)
- **parse­HTML()** on **Document** (@kkoyung, #44952)
- **read­As­Binary­String()** on **File­Reader** (@yezhizhen, #44858, #44921)
- **performance.measure()** with mark values **‘redirect­Start’**, **‘redirect­End’**, **‘secure­Connection­Start’**, and **‘response­End’** (@shubhamg13, #44673, #44624, #44850, #44739)

We’ve also fixed some build issues on Windows (@mukilan, #45079), FreeBSD (@delan, @mrobinson, @mukilan, #44600), and for anyone building Servo on NixOS or with Nix (@freyacodes, #45051, #45135).

This is another big update, so here’s an outline:

- [**Security**](#security)<br>– memory safety fixes

- [**Work in progress**](#work-in-progress)<br>– execCommand(), Sanitizer, IndexedDB, accessibility, workers

- [**Embedding API**](#embedding-api)<br>– MSRV, cookies, preferences, diagnostics

- [**For users and developers**](#for-users-and-developers)<br>– `--host-file`, `--userscripts`, DevTools Debugger

- [**More on the web platform**](#more-on-the-web-platform)<br>– focus, forms, navigation, SubtleCrypto, WebGPU

- [**Performance**](#performance)<br>– about:memory, threads, layout, DOM, build times

- [**Stability**](#stability)<br>– crashes, hangs, static analysis

## Security

Servo’s JS runtime, **SpiderMonkey 140.10.0**, had several **memory safety bugs** that have been fixed in Servo 0.3.0 with the update to SpiderMonkey 140.10.1 (@jschwe, #44755).
For more details, see [CVE-2026-7322](https://nvd.nist.gov/vuln/detail/CVE-2026-7322), [CVE-2026-7323](https://nvd.nist.gov/vuln/detail/CVE-2026-7323), and [MFSA 2026-36](https://www.mozilla.org/en-US/security/advisories/mfsa2026-36/).

## Work in progress

We’re continuing to implement **document.exec­Command()** for **rich text editing**, under `--pref dom­_exec­_command­_enabled` (@TimvdLippe, #44735, #44973, #44887).
This release adds support for the **‘back­Color’**, **‘fore­Color’**, **‘create­Link’**, **‘unlink’**, **‘superscript’**, **‘subscript’**, and **‘remove­Format’** commands (@TimvdLippe, #44644, #44682, #44657, #44710, #44677), plus partial support for the **‘insert­Paragraph’** command (@TimvdLippe, #44909).

We’re also working on the **Sanitizer** API, under `--pref dom­_sanitizer­_enabled`.
With the feature now enabled in servoshell’s experimental mode (@kkoyung, #44701), this release adds support for **set­Comments()**, **set­Data­Attributes()**, **allow­Processing­Instruction()**, **remove­Processing­Instruction()**, and **remove­Unsafe()** on **Sanitizer** (@kkoyung, #44734, #44983).

**IndexedDB** continues to improve, under `--pref dom­_indexeddb­_enabled`.
This release brings a more conformant **abort()** on **IDB­Transaction** (@Taym95, #43950).

All of the features above are enabled in servoshell’s experimental mode.

We’ve made more progress towards **accessibility** support, including the [**name from contents**](https://book.servo.org/contributing/getting-started.html#ai-contributions) algorithm (@alice, @delan, @mrobinson, #44439) and several changes towards **building the accessibility tree incrementally** (@alice, @delan, @mrobinson, #44766, #45035, #45207, #44768, #44785, #44801, #44767, #45029).
The latter is critical for performance in real-world web content.

We’re now working on **SharedWorker** and **ServiceWorker**, under `--pref dom­_sharedworker­_enabled` and `--pref dom­_serviceworker­_enabled` respectively.
This release adds support for **new Shared­Worker()** (@Taym95, #44761), and parts of the ServiceWorker API (@gterzian, @arihant2math, #45082, #44787).

## Embedding API

Servo now requires **Rust 1.88.0** or newer, up from the old MSRV of 1.86.0 (@sagudev, #44815).
We run compile tests with the MSRV, but most of our testing is now done with Rust 1.95.0 (@simonwuelker, #44632).

**Breaking changes** to the **cookies** methods in our [**SiteDataManager**](https://doc.servo.org/servo/struct.SiteDataManager.html) API (@longvatrong111, #44708):

- [`Site­Data­Manager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::[`clear­_cookies`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.clear_cookies) now takes an additional `callback` argument, allowing it to be called async – to continue calling it sync, pass `None` as the `callback`

- [`Site­Data­Manager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::[`clear­_session­_cookies`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.clear_session_cookies) now takes an additional `callback` argument, allowing it to be called async – to continue calling it sync, pass `None` as the `callback`

- [`Site­Data­Manager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::[`set­_cookie­_for­_url`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.set_cookie_for_url) now takes an additional `callback` argument, allowing it to be called async – to continue calling it sync, pass `None` as the `callback`

- [`Site­Data­Manager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::`set­_cookie­_for­_url­_async` has been removed in favour of [`set­_cookie­_for­_url`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.set_cookie_for_url) – to migrate, replace `set­_cookie­_for­_url­_async(​callback)` with `set­_cookie­_for­_url(​Some(​Box::new(​callback)))`

**Breaking changes** to our [**Preferences**](https://doc.servo.org/servo/struct.Preferences.html) API (@Narfinger, @mrobinson, #44307):

- `threadpools­_image­_cache­_workers­_max`, `threadpools­_indexeddb­_workers­_max`, and `threadpools­_webstorage­_workers­_max` have been **removed** in favour of a combined [`thread­_pool­_workers­_max`](https://doc.servo.org/servo/struct.Preferences.html#structfield.thread_pool_workers_max)

- `threadpools­_fallback­_worker­_num` has been **renamed** to [`thread­_pool­_fallback­_workers`](https://doc.servo.org/servo/struct.Preferences.html#structfield.thread_pool_fallback_workers)

- `threadpools­_async­_runtime­_workers­_max` has been **renamed** to [`thread­_pool­_async­_runtime­_workers­_max`](https://doc.servo.org/servo/struct.Preferences.html#structfield.thread_pool_async_runtime_workers_max)

- `threadpools­_webrender­_workers­_max` has been **renamed** to [`thread­_pool­_webrender­_workers­_max`](https://doc.servo.org/servo/struct.Preferences.html#structfield.thread_pool_webrender_workers_max)

We’ve also reworked our [**DiagnosticsLogging**](https://doc.servo.org/servo/struct.DiagnosticsLogging.html) API (@mukilan, #44703):

- You can now set options with [`DiagnosticsLogging`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html)::[`toggle­_option`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html#method.toggle_option), and check if they are enabled with [`DiagnosticsLogging`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html)::[`is­_enabled`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html#method.is_enabled)

- Each option is a variant of [`DiagnosticsLoggingOption`](https://doc.servo.org/servo/enum.DiagnosticsLoggingOption.html), a new type that also has useful methods for exposing these options in embedder UI

- **(Breaking change)** [`DiagnosticsLogging`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html) no longer has `pub` fields representing each option – to migrate, replace field writes and field reads with [`toggle­_option`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html#method.toggle_option) and [`is­_enabled`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html#method.is_enabled) respectively

- **(Breaking change)** [`DiagnosticsLogging`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html)::[`extend­_from­_string`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html#method.extend_from_string) no longer accepts a `help` option – this option only existed to support servoshell’s `-Z help` / `--debug=help` option, so the code implementing it has been moved to servoshell

## For users and developers

**servoshell** has two new options:

- You can now configure the path to a [**hosts file**](https://en.wikipedia.org/w/index.php?title=Hosts_(file)&oldid=1360805760) with **-\-host-file=** (singular), as an alternative to the **HOST_FILE** (singular) environment variable (@jschwe, #44880).

- You can now provide a directory of **user scripts** to run in every document with **-\-userscripts=** (@jdm, #44754).

When using the **Debugger** tab in the Firefox **DevTools**:

- You can now [“blackbox”](https://antongunnarsson.com/devtools-blackbox/) a script by clicking **Ignore source** (@freyacodes, #44359).
This prevents breakpoints from being hit inside that script, and it should also allow you to step through execution in the debugger without pausing inside that script.

- The **Scopes** panel is more accurate now (@atbrakhi, @eerii, #44765).

For developers of Servo itself, please note that [per project policy](https://book.servo.org/contributing/getting-started.html#ai-contributions), you **must not** use the output of **large language models** or other **generative AI tools** in your contributions.
To help us enforce that, we now have CI checks that reject AI agents as coauthors (@SimonSapin, @delan, #44723).

We’ve also fixed build issues with `--features vello` (@Gae24, @yezhizhen, #44875, #45036).

## More on the web platform

We’ve improved the default appearance of **&lt;dl>**, **&lt;ol>**, **&lt;ul>**, **&lt;table>**, **&lt;thead>**, **&lt;tbody>**, **&lt;tfoot>**, **&lt;tr>**, **&lt;td>**, **&lt;th>**, **&lt;dir>**, **&lt;menu>**, and **&lt;form>** (@avis137, #44837, #44920).

**CryptoKey** is now **serializable**, allowing it to be used in structuredClone() and postMessage() (@kkoyung, #45163).

We’ve improved **JS error messages** in several parts of the DOM (@n0blenote, @jdm, @TG199, @PuercoPop, #44704, #45186, #44656).

We’ve improved the conformance of **form submission** (@yezhizhen, #44943, #44953, #44954, #44957), **tab navigation** (@mrobinson, #44684), **javascript: url navigation** (@jdm, @TimvdLippe, #43490), **‘Refresh’ headers** and **&lt;meta http-equiv=Refresh>** (@jschwe, @mrobinson, #45113, #45116), **‘line-break: anywhere’** (@mrobinson, @SimonSapin, #44609), **assign()** on **Location** (@TG199, @jdm, #44298), **crypto.subtle.derive­Bits()** (@kkoyung, #44706), **get­Computed­Style()** (@Loirooriol, #44856), **performance.measure()** (@shubhamg13, #44675), **read­As­Data­URL()** on **File­Reader** (@yezhizhen, #44897, #44924), **stream()** on **Blob** (@Taym95, #45133), and **ML-KEM** in **Subtle­Crypto** (@kkoyung, #45153).

We’ve also landed improvements to **GPU­Supported­Limits** (@sagudev, #45114), **GPU­Texture** (@sagudev, #45154), **create­Bind­Group()** on **GPU­Device** (@sagudev, #45140), and other **WebGPU** features (@sagudev, #45097).

We’ve fixed bugs related to **&lt;svg>** with **‘Content-Security-Policy’** (@TimvdLippe, @jdm, #44974), **‘:active’** (@SharanRP, @mrobinson, #43953), **‘:hover’** (@SharanRP, @mrobinson, #43979), **‘align-items’** (@yezhizhen, #44396), **‘border-image-outset’** (@lumiscosity, #45039), **‘padding’** with **‘overflow: scroll’** (@stevennovaryo, #44263), **‘pointerup’ events** (@mrobinson, #44666), **‘slotchange’ events** (@jdm, #44688), **dynamic import()** (@Gae24, #44741), and **clip()** on **CanvasRenderingContext2D** (@yezhizhen, #44831).

## Performance

We’ve built a tool that will help us improve **‘about:memory’** by finding untracked allocations (@jdm, @TimvdLippe, @webbeef, #44674, #44980).

Servo now requires fewer OS threads per CPU, after we combined the **thread pools** for the image cache, web storage, and IndexedDB (@Narfinger, @mrobinson, #44307).

We’ve landed a bunch of **layout** optimisations:

- The fragment tree is now **immutable** for the most part, with small pockets of interior mutability where mutability is needed.
This means that most fragment tree accesses no longer have to incur the runtime cost of borrowing an [AtomicRefCell](https://docs.rs/atomic_refcell/0.1.14/atomic_refcell/) (@mrobinson, @Loirooriol, #44849).

- Two steps in the layout process, calculating **containing blocks** and building the **stacking context tree**, require traversing the fragment tree.
This can be expensive, but we’ve now combined them into a **single fragment tree traversal** in most cases (@SimonSapin, @mrobinson, #44911, #45210).

- Another step in the layout process, calculating **scrollable overflow**, used to require traversing the entire fragment tree.
We’ve effectively eliminated that traversal, by making the calculation both **lazy** and **incremental** (@mrobinson, @Loirooriol, #44854).

- We’ve improved the caching of fragments, shaping results, and other layout results between reflows (@mrobinson, @Loirooriol, @SimonSapin, #45038, #44769).

- We’ve made incremental fragment layout more precise (@Loirooriol, @mrobinson, #44925).

- We’ve reduced the memory usage of text shaping (@mrobinson, @SimonSapin, #44609).

**DOM attributes** are much more efficient in this release:

- When scripts write attribute values, we avoid serialising them until the attribute is read back by a script (if ever), speeding up frequent writes to inline styles by up to 25% (@mrobinson, #44931).

- When we parse attributes in HTML or read attribute values internally, we avoid constructing [Attr](https://developer.mozilla.org/en-US/docs/Web/API/Attr) nodes until a script [actually](https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttributeNode) [needs](https://developer.mozilla.org/en-US/docs/Web/API/Element/attributes) them, reducing memory usage and making garbage collection less likely (@webbeef, @TimvdLippe, @mrobinson, #44209, #45023, #45031, #45060).

We’ve eliminated a traversal of the whole DOM tree whenever an **&lt;iframe>** is attached to the tree, which is especially noticeable when parsing documents with many &lt;iframe> tags (@mrobinson, #45236).

Stylesheet locks now use [AtomicRefCell](https://docs.rs/atomic_refcell/0.1.14/atomic_refcell/), which is even more efficient than a [parking_lot](https://docs.rs/parking_lot/0.12.5/parking_lot/)::[RwLock](https://docs.rs/parking_lot/0.12.5/parking_lot/type.RwLock.html) (@mrobinson, #44883).

On OpenHarmony, we now have a real refresh driver for reduced idle CPU usage (@jschwe, @yezhizhen, #44927), and we now cache the font list on disk for faster startup (@RichardTjokroutomo, @d-desyatkin, #44158).

We’ve also reduced allocations, GC rooting steps, and other operations in many parts of Servo (@jschwe, @kkoyung, @mrobinson, @SteveSharonSam, @Narfinger, @jdm, @nodelpit, @simonwuelker, #44961, #44944, #44972, #45231, #45078, #44662, #44679, #44967, #44963, #44933, #44935, #44905).

To improve Servo’s **build times**, we’re moving more code out of our massive **script crate** (@Narfinger, @jdm, #44598, #44636, #44823), and reduced the size of our dependency tree (@jschwe, #44818).

## Stability

Several crashes and hangs have been fixed:

- in **‘content’** (@mrobinson, @Loirooriol, @SimonSapin, #45227, #44762)
- in **Media­Stream** (@jdm, #44781)
- in **item()** on **attributes** on **Element** (@webbeef, #44721)
- in **append­Rule()** on **CSS­Keyframes­Rule** (@mrobinson, #45173)
- in **init­Event()** on **Focus­Event** (@mrobinson, #44870)
- in **stop()** on **Window** (@TimvdLippe, #44804)
- in `document.exec­Command(​"delete")` (@TimvdLippe, #44748)
- in `--debug-mozjs` builds (@Gae24, @SharanRP, #44745, #45001)
- when evaluating scripts in DevTools while paused (@atbrakhi, #45050)
- when previewing some JS values in DevTools (@eerii, @atbrakhi, #45054)
- when shaping zero-width spaces in layout (@mrobinson, #45176)
- when toggling servoshell’s experimental mode at runtime (@mrobinson, @Loirooriol, #45226)

We’ve continued our long-running effort to **use the Rust type system** to make certain kinds of dynamic borrow failures impossible (@Gae24, @MavenRain, @Narfinger, @SteveSharonSam, @TimvdLippe, @elomscansio, @jdm, @kkoyung, @yezhizhen, #44712, #44759, #44879, #45014, #45058, #45061, #45076, #45098, #45110, #45149, #45117, #45184, #45201, #44806, #44930, #44942, #44946, #45233, #45181, #44659, #44660, #44664, #44668, #44992, #45000, #45081, #45009, #45225, #45087, #45244, #45245, #45247, #44663, #44665, #44993, #45040, #45053, #44647, #44671, #44681, #44717, #44733, #44686, #44653).

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
