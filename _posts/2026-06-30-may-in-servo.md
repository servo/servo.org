---
layout:     post
tags:       blog
title:      "May in Servo: user scripts, mp4 compat, blackboxing in DevTools, and more!"
date:       2026-06-30
summary:    Plus seven new commands for execCommand(), and Sanitizer API now experimental.
categories:
---

[**Servo 0.3.0**](https://github.com/servo/servo/releases/tag/v0.3.0) contains all of the changes we landed in May, which came out to **391 commits** (March: 534).
For security fixes, see [**§ Security**](#security).

<figure>
    <a href="{{ '/img/blog/2026-06-diffie.png' | url }}"><img src="{{ '/img/blog/2026-06-diffie.png' | url }}" alt="servoshell 0.3.0 showing several new features: the `document.execCommand()` commands ‘back­Color’, ‘create­Link’, ‘unlink’, ‘superscript’, ‘subscript’, and ‘remove­Format’, plus ‘font-kerning’ and ‘font-variant-ligatures’"></a>
</figure>

We’ve shipped several new web platform features:

- **‘font-kerning: none’** ([@simonwuelker](https://github.com/simonwuelker), [#44634](https://github.com/servo/servo/pull/44634))
- **‘font-variant-east-asian’** ([@simonwuelker](https://github.com/simonwuelker), [#44989](https://github.com/servo/servo/pull/44989))
- **‘font-variant-ligatures’** ([@simonwuelker](https://github.com/simonwuelker), [#44903](https://github.com/servo/servo/pull/44903))
- **‘font-variant-numeric’** ([@simonwuelker](https://github.com/simonwuelker), [#44950](https://github.com/servo/servo/pull/44950))
- **‘font-variant-position’** ([@simonwuelker](https://github.com/simonwuelker), [#45142](https://github.com/servo/servo/pull/45142))
- **mp4** files **without fast start** in **&lt;video>** ([@calvaris](https://github.com/calvaris), [#45084](https://github.com/servo/servo/pull/45084))
- `<form enctype="multipart/form-data">` ([@yezhizhen](https://github.com/yezhizhen), [#45028](https://github.com/servo/servo/pull/45028))
- `<form enctype="text/plain">` ([@yezhizhen](https://github.com/yezhizhen), [#45111](https://github.com/servo/servo/pull/45111))
- **&lt;![CDATA[]]>** layout ([@mrobinson](https://github.com/mrobinson), [#44791](https://github.com/servo/servo/pull/44791))

Plus a bunch of new DOM APIs:

- **onslotchange** property on **Shadow­Root** ([@jdm](https://github.com/jdm), [#44688](https://github.com/servo/servo/pull/44688))
- **screen­Left** and **screen­Top** on **Window** ([@TG199](https://github.com/TG199), [#45128](https://github.com/servo/servo/pull/45128))
- **new Blob()** with `{endings: "native"}` ([@yezhizhen](https://github.com/yezhizhen), [#44803](https://github.com/servo/servo/pull/44803))
- **new Performance­Mark()** ([@shubhamg13](https://github.com/shubhamg13), [#44702](https://github.com/servo/servo/pull/44702))
- **parse­HTML()** on **Document** ([@kkoyung](https://github.com/kkoyung), [#44952](https://github.com/servo/servo/pull/44952))
- **read­As­Binary­String()** on **File­Reader** ([@yezhizhen](https://github.com/yezhizhen), [#44858](https://github.com/servo/servo/pull/44858), [#44921](https://github.com/servo/servo/pull/44921))
- **performance.measure()** with mark values **‘redirect­Start’**, **‘redirect­End’**, **‘secure­Connection­Start’**, and **‘response­End’** ([@shubhamg13](https://github.com/shubhamg13), [#44673](https://github.com/servo/servo/pull/44673), [#44624](https://github.com/servo/servo/pull/44624), [#44850](https://github.com/servo/servo/pull/44850), [#44739](https://github.com/servo/servo/pull/44739))

We’ve also fixed some build issues on Windows ([@mukilan](https://github.com/mukilan), [#45079](https://github.com/servo/servo/pull/45079)), FreeBSD ([@delan](https://github.com/delan), [@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#44600](https://github.com/servo/servo/pull/44600)), and for anyone building Servo on NixOS or with Nix ([@freyacodes](https://github.com/freyacodes), [#45051](https://github.com/servo/servo/pull/45051), [#45135](https://github.com/servo/servo/pull/45135)).

This is another big update, so here’s an outline:

- [**Security**](#security)<br>– memory safety fixes

- [**Work in progress**](#work-in-progress)<br>– execCommand(), Sanitizer, IndexedDB, accessibility, workers

- [**Embedding API**](#embedding-api)<br>– MSRV, cookies, preferences, diagnostics

- [**For users and developers**](#for-users-and-developers)<br>– `--host-file`, `--userscripts`, DevTools Debugger

- [**More on the web platform**](#more-on-the-web-platform)<br>– focus, forms, navigation, SubtleCrypto, WebGPU

- [**Performance**](#performance)<br>– about:memory, threads, layout, DOM, build times

- [**Stability**](#stability)<br>– crashes, hangs, static analysis

## Security

Servo’s JS runtime, **SpiderMonkey 140.10.0**, had several **memory safety bugs** that have been fixed in Servo 0.3.0 with the update to SpiderMonkey 140.10.1 ([@jschwe](https://github.com/jschwe), [#44755](https://github.com/servo/servo/pull/44755)).
For more details, see [CVE-2026-7322](https://nvd.nist.gov/vuln/detail/CVE-2026-7322), [CVE-2026-7323](https://nvd.nist.gov/vuln/detail/CVE-2026-7323), and [MFSA 2026-36](https://www.mozilla.org/en-US/security/advisories/mfsa2026-36/).

## Work in progress

We’re continuing to implement **document.exec­Command()** for **rich text editing**, under `--pref dom­_exec­_command­_enabled` ([@TimvdLippe](https://github.com/TimvdLippe), [#44735](https://github.com/servo/servo/pull/44735), [#44973](https://github.com/servo/servo/pull/44973), [#44887](https://github.com/servo/servo/pull/44887)).
This release adds support for the **‘back­Color’**, **‘fore­Color’**, **‘create­Link’**, **‘unlink’**, **‘superscript’**, **‘subscript’**, and **‘remove­Format’** commands ([@TimvdLippe](https://github.com/TimvdLippe), [#44644](https://github.com/servo/servo/pull/44644), [#44682](https://github.com/servo/servo/pull/44682), [#44657](https://github.com/servo/servo/pull/44657), [#44710](https://github.com/servo/servo/pull/44710), [#44677](https://github.com/servo/servo/pull/44677)), plus partial support for the **‘insert­Paragraph’** command ([@TimvdLippe](https://github.com/TimvdLippe), [#44909](https://github.com/servo/servo/pull/44909)).

We’re also working on the **Sanitizer** API, under `--pref dom­_sanitizer­_enabled`.
With the feature now enabled in servoshell’s experimental mode ([@kkoyung](https://github.com/kkoyung), [#44701](https://github.com/servo/servo/pull/44701)), this release adds support for **set­Comments()**, **set­Data­Attributes()**, **allow­Processing­Instruction()**, **remove­Processing­Instruction()**, and **remove­Unsafe()** on **Sanitizer** ([@kkoyung](https://github.com/kkoyung), [#44734](https://github.com/servo/servo/pull/44734), [#44983](https://github.com/servo/servo/pull/44983)).

**IndexedDB** continues to improve, under `--pref dom­_indexeddb­_enabled`.
This release brings a more conformant **abort()** on **IDB­Transaction** ([@Taym95](https://github.com/Taym95), [#43950](https://github.com/servo/servo/pull/43950)).

All of the features above are enabled in servoshell’s experimental mode.

We’ve made more progress towards **accessibility** support, including the [**name from contents**](https://w3c.github.io/aria/#namefromcontent) algorithm ([@alice](https://github.com/alice), [@delan](https://github.com/delan), [@mrobinson](https://github.com/mrobinson), [#44439](https://github.com/servo/servo/pull/44439)) and several changes towards **building the accessibility tree incrementally** ([@alice](https://github.com/alice), [@delan](https://github.com/delan), [@mrobinson](https://github.com/mrobinson), [#44766](https://github.com/servo/servo/pull/44766), [#45035](https://github.com/servo/servo/pull/45035), [#45207](https://github.com/servo/servo/pull/45207), [#44768](https://github.com/servo/servo/pull/44768), [#44785](https://github.com/servo/servo/pull/44785), [#44801](https://github.com/servo/servo/pull/44801), [#44767](https://github.com/servo/servo/pull/44767), [#45029](https://github.com/servo/servo/pull/45029)).
The latter is critical for performance in real-world web content.

We’re now working on **SharedWorker** and **ServiceWorker**, under `--pref dom­_sharedworker­_enabled` and `--pref dom­_serviceworker­_enabled` respectively.
This release adds support for **new Shared­Worker()** ([@Taym95](https://github.com/Taym95), [#44761](https://github.com/servo/servo/pull/44761)), and parts of the ServiceWorker API ([@gterzian](https://github.com/gterzian), [@arihant2math](https://github.com/arihant2math), [#45082](https://github.com/servo/servo/pull/45082), [#44787](https://github.com/servo/servo/pull/44787)).

## Embedding API

Servo now requires **Rust 1.88.0** or newer, up from the old MSRV of 1.86.0 ([@sagudev](https://github.com/sagudev), [#44815](https://github.com/servo/servo/pull/44815)).
We run compile tests with the MSRV, but most of our testing is now done with Rust 1.95.0 ([@simonwuelker](https://github.com/simonwuelker), [#44632](https://github.com/servo/servo/pull/44632)).

**Breaking changes** to the **cookies** methods in our [**SiteDataManager**](https://doc.servo.org/servo/struct.SiteDataManager.html) API ([@longvatrong111](https://github.com/longvatrong111), [#44708](https://github.com/servo/servo/pull/44708)):

- [`Site­Data­Manager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::[`clear­_cookies`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.clear_cookies) now takes an additional `callback` argument, allowing it to be called async – to continue calling it sync, pass `None` as the `callback`

- [`Site­Data­Manager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::[`clear­_session­_cookies`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.clear_session_cookies) now takes an additional `callback` argument, allowing it to be called async – to continue calling it sync, pass `None` as the `callback`

- [`Site­Data­Manager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::[`set­_cookie­_for­_url`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.set_cookie_for_url) now takes an additional `callback` argument, allowing it to be called async – to continue calling it sync, pass `None` as the `callback`

- [`Site­Data­Manager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::`set­_cookie­_for­_url­_async` has been removed in favour of [`set­_cookie­_for­_url`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.set_cookie_for_url) – to migrate, replace `set­_cookie­_for­_url­_async(​callback)` with `set­_cookie­_for­_url(​Some(​Box::new(​callback)))`

**Breaking changes** to our [**Preferences**](https://doc.servo.org/servo/struct.Preferences.html) API ([@Narfinger](https://github.com/Narfinger), [@mrobinson](https://github.com/mrobinson), [#44307](https://github.com/servo/servo/pull/44307)):

- `threadpools­_image­_cache­_workers­_max`, `threadpools­_indexeddb­_workers­_max`, and `threadpools­_webstorage­_workers­_max` have been **removed** in favour of a combined [`thread­_pool­_workers­_max`](https://doc.servo.org/servo/struct.Preferences.html#structfield.thread_pool_workers_max)

- `threadpools­_fallback­_worker­_num` has been **renamed** to [`thread­_pool­_fallback­_workers`](https://doc.servo.org/servo/struct.Preferences.html#structfield.thread_pool_fallback_workers)

- `threadpools­_async­_runtime­_workers­_max` has been **renamed** to [`thread­_pool­_async­_runtime­_workers­_max`](https://doc.servo.org/servo/struct.Preferences.html#structfield.thread_pool_async_runtime_workers_max)

- `threadpools­_webrender­_workers­_max` has been **renamed** to [`thread­_pool­_webrender­_workers­_max`](https://doc.servo.org/servo/struct.Preferences.html#structfield.thread_pool_webrender_workers_max)

We’ve also reworked our [**DiagnosticsLogging**](https://doc.servo.org/servo/struct.DiagnosticsLogging.html) API ([@mukilan](https://github.com/mukilan), [#44703](https://github.com/servo/servo/pull/44703)):

- You can now set options with [`DiagnosticsLogging`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html)::[`toggle­_option`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html#method.toggle_option), and check if they are enabled with [`DiagnosticsLogging`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html)::[`is­_enabled`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html#method.is_enabled)

- Each option is a variant of [`DiagnosticsLoggingOption`](https://doc.servo.org/servo/enum.DiagnosticsLoggingOption.html), a new type that also has useful methods for exposing these options in embedder UI

- **(Breaking change)** [`DiagnosticsLogging`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html) no longer has `pub` fields representing each option – to migrate, replace field writes and field reads with [`toggle­_option`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html#method.toggle_option) and [`is­_enabled`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html#method.is_enabled) respectively

- **(Breaking change)** [`DiagnosticsLogging`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html)::[`extend­_from­_string`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html#method.extend_from_string) no longer accepts a `help` option – this option only existed to support servoshell’s `-Z help` / `--debug=help` option, so the code implementing it has been moved to servoshell

## For users and developers

**servoshell** has two new options:

- You can now configure the path to a [**hosts file**](https://en.wikipedia.org/w/index.php?title=Hosts_(file)&oldid=1360805760) with **-\-host-file=** (singular), as an alternative to the **HOST_FILE** (singular) environment variable ([@jschwe](https://github.com/jschwe), [#44880](https://github.com/servo/servo/pull/44880)).

- You can now provide a directory of **user scripts** to run in every document with **-\-userscripts=** ([@jdm](https://github.com/jdm), [#44754](https://github.com/servo/servo/pull/44754)).

When using the **Debugger** tab in the Firefox **DevTools**:

- You can now [“blackbox”](https://antongunnarsson.com/devtools-blackbox/) a script by clicking **Ignore source** ([@freyacodes](https://github.com/freyacodes), [#44359](https://github.com/servo/servo/pull/44359)).
This prevents breakpoints from being hit inside that script, and it should also allow you to step through execution in the debugger without pausing inside that script.

- The **Scopes** panel is more accurate now ([@atbrakhi](https://github.com/atbrakhi), [@eerii](https://github.com/eerii), [#44765](https://github.com/servo/servo/pull/44765)).

For developers of Servo itself, please note that [per project policy](https://book.servo.org/contributing/getting-started.html#ai-contributions), you **must not** use the output of **large language models** or other **generative AI tools** in your contributions.
To help us enforce that, we now have CI checks that reject AI agents as coauthors ([@SimonSapin](https://github.com/SimonSapin), [@delan](https://github.com/delan), [#44723](https://github.com/servo/servo/pull/44723)).

We’ve also fixed build issues with `--features vello` ([@Gae24](https://github.com/Gae24), [@yezhizhen](https://github.com/yezhizhen), [#44875](https://github.com/servo/servo/pull/44875), [#45036](https://github.com/servo/servo/pull/45036)).

## More on the web platform

We’ve improved the default appearance of **&lt;dl>**, **&lt;ol>**, **&lt;ul>**, **&lt;table>**, **&lt;thead>**, **&lt;tbody>**, **&lt;tfoot>**, **&lt;tr>**, **&lt;td>**, **&lt;th>**, **&lt;dir>**, **&lt;menu>**, and **&lt;form>** ([@avis137](https://github.com/avis137), [#44837](https://github.com/servo/servo/pull/44837), [#44920](https://github.com/servo/servo/pull/44920)).

**CryptoKey** is now **serializable**, allowing it to be used in structuredClone() and postMessage() ([@kkoyung](https://github.com/kkoyung), [#45163](https://github.com/servo/servo/pull/45163)).

We’ve improved **JS error messages** in several parts of the DOM ([@n0blenote](https://github.com/n0blenote), [@jdm](https://github.com/jdm), [@TG199](https://github.com/TG199), [@PuercoPop](https://github.com/PuercoPop), [#44704](https://github.com/servo/servo/pull/44704), [#45186](https://github.com/servo/servo/pull/45186), [#44656](https://github.com/servo/servo/pull/44656)).

We’ve improved the conformance of **form submission** ([@yezhizhen](https://github.com/yezhizhen), [#44943](https://github.com/servo/servo/pull/44943), [#44953](https://github.com/servo/servo/pull/44953), [#44954](https://github.com/servo/servo/pull/44954), [#44957](https://github.com/servo/servo/pull/44957)), **tab navigation** ([@mrobinson](https://github.com/mrobinson), [#44684](https://github.com/servo/servo/pull/44684)), **javascript: url navigation** ([@jdm](https://github.com/jdm), [@TimvdLippe](https://github.com/TimvdLippe), [#43490](https://github.com/servo/servo/pull/43490)), **‘Refresh’ headers** and **&lt;meta http-equiv=Refresh>** ([@jschwe](https://github.com/jschwe), [@mrobinson](https://github.com/mrobinson), [#45113](https://github.com/servo/servo/pull/45113), [#45116](https://github.com/servo/servo/pull/45116)), **‘line-break: anywhere’** ([@mrobinson](https://github.com/mrobinson), [@SimonSapin](https://github.com/SimonSapin), [#44609](https://github.com/servo/servo/pull/44609)), **assign()** on **Location** ([@TG199](https://github.com/TG199), [@jdm](https://github.com/jdm), [#44298](https://github.com/servo/servo/pull/44298)), **crypto.subtle.derive­Bits()** ([@kkoyung](https://github.com/kkoyung), [#44706](https://github.com/servo/servo/pull/44706)), **get­Computed­Style()** ([@Loirooriol](https://github.com/Loirooriol), [#44856](https://github.com/servo/servo/pull/44856)), **performance.measure()** ([@shubhamg13](https://github.com/shubhamg13), [#44675](https://github.com/servo/servo/pull/44675)), **read­As­Data­URL()** on **File­Reader** ([@yezhizhen](https://github.com/yezhizhen), [#44897](https://github.com/servo/servo/pull/44897), [#44924](https://github.com/servo/servo/pull/44924)), **stream()** on **Blob** ([@Taym95](https://github.com/Taym95), [#45133](https://github.com/servo/servo/pull/45133)), and **ML-KEM** in **Subtle­Crypto** ([@kkoyung](https://github.com/kkoyung), [#45153](https://github.com/servo/servo/pull/45153)).

We’ve also landed improvements to **GPU­Supported­Limits** ([@sagudev](https://github.com/sagudev), [#45114](https://github.com/servo/servo/pull/45114)), **GPU­Texture** ([@sagudev](https://github.com/sagudev), [#45154](https://github.com/servo/servo/pull/45154)), **create­Bind­Group()** on **GPU­Device** ([@sagudev](https://github.com/sagudev), [#45140](https://github.com/servo/servo/pull/45140)), and other **WebGPU** features ([@sagudev](https://github.com/sagudev), [#45097](https://github.com/servo/servo/pull/45097)).

We’ve fixed bugs related to **&lt;svg>** with **‘Content-Security-Policy’** ([@TimvdLippe](https://github.com/TimvdLippe), [@jdm](https://github.com/jdm), [#44974](https://github.com/servo/servo/pull/44974)), **‘:active’** ([@SharanRP](https://github.com/SharanRP), [@mrobinson](https://github.com/mrobinson), [#43953](https://github.com/servo/servo/pull/43953)), **‘:hover’** ([@SharanRP](https://github.com/SharanRP), [@mrobinson](https://github.com/mrobinson), [#43979](https://github.com/servo/servo/pull/43979)), **‘align-items’** ([@yezhizhen](https://github.com/yezhizhen), [#44396](https://github.com/servo/servo/pull/44396)), **‘border-image-outset’** ([@lumiscosity](https://github.com/lumiscosity), [#45039](https://github.com/servo/servo/pull/45039)), **‘padding’** with **‘overflow: scroll’** ([@stevennovaryo](https://github.com/stevennovaryo), [#44263](https://github.com/servo/servo/pull/44263)), **‘pointerup’ events** ([@mrobinson](https://github.com/mrobinson), [#44666](https://github.com/servo/servo/pull/44666)), **‘slotchange’ events** ([@jdm](https://github.com/jdm), [#44688](https://github.com/servo/servo/pull/44688)), **dynamic import()** ([@Gae24](https://github.com/Gae24), [#44741](https://github.com/servo/servo/pull/44741)), and **clip()** on **CanvasRenderingContext2D** ([@yezhizhen](https://github.com/yezhizhen), [#44831](https://github.com/servo/servo/pull/44831)).

## Performance

We’ve built a tool that will help us improve **‘about:memory’** by finding untracked allocations ([@jdm](https://github.com/jdm), [@TimvdLippe](https://github.com/TimvdLippe), [@webbeef](https://github.com/webbeef), [#44674](https://github.com/servo/servo/pull/44674), [#44980](https://github.com/servo/servo/pull/44980)).

Servo now requires fewer OS threads per CPU, after we combined the **thread pools** for the image cache, web storage, and IndexedDB ([@Narfinger](https://github.com/Narfinger), [@mrobinson](https://github.com/mrobinson), [#44307](https://github.com/servo/servo/pull/44307)).

We’ve landed a bunch of **layout** optimisations:

- The fragment tree is now **immutable** for the most part, with small pockets of interior mutability where mutability is needed.
This means that most fragment tree accesses no longer have to incur the runtime cost of borrowing an [AtomicRefCell](https://docs.rs/atomic_refcell/0.1.14/atomic_refcell/) ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#44849](https://github.com/servo/servo/pull/44849)).

- Two steps in the layout process, calculating **containing blocks** and building the **stacking context tree**, require traversing the fragment tree.
This can be expensive, but we’ve now combined them into a **single fragment tree traversal** in most cases ([@SimonSapin](https://github.com/SimonSapin), [@mrobinson](https://github.com/mrobinson), [#44911](https://github.com/servo/servo/pull/44911), [#45210](https://github.com/servo/servo/pull/45210)).

- Another step in the layout process, calculating **scrollable overflow**, used to require traversing the entire fragment tree.
We’ve effectively eliminated that traversal, by making the calculation both **lazy** and **incremental** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#44854](https://github.com/servo/servo/pull/44854)).

- We’ve improved the caching of fragments, shaping results, and other layout results between reflows ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [@SimonSapin](https://github.com/SimonSapin), [#45038](https://github.com/servo/servo/pull/45038), [#44769](https://github.com/servo/servo/pull/44769)).

- We’ve made incremental fragment layout more precise ([@Loirooriol](https://github.com/Loirooriol), [@mrobinson](https://github.com/mrobinson), [#44925](https://github.com/servo/servo/pull/44925)).

- We’ve reduced the memory usage of text shaping ([@mrobinson](https://github.com/mrobinson), [@SimonSapin](https://github.com/SimonSapin), [#44609](https://github.com/servo/servo/pull/44609)).

**DOM attributes** are much more efficient in this release:

- When scripts write attribute values, we avoid serialising them until the attribute is read back by a script (if ever), speeding up frequent writes to inline styles by up to 25% ([@mrobinson](https://github.com/mrobinson), [#44931](https://github.com/servo/servo/pull/44931)).

- When we parse attributes in HTML or read attribute values internally, we avoid constructing [Attr](https://developer.mozilla.org/en-US/docs/Web/API/Attr) nodes until a script [actually](https://developer.mozilla.org/en-US/docs/Web/API/Element/getAttributeNode) [needs](https://developer.mozilla.org/en-US/docs/Web/API/Element/attributes) them, reducing memory usage and making garbage collection less likely ([@webbeef](https://github.com/webbeef), [@TimvdLippe](https://github.com/TimvdLippe), [@mrobinson](https://github.com/mrobinson), [#44209](https://github.com/servo/servo/pull/44209), [#45023](https://github.com/servo/servo/pull/45023), [#45031](https://github.com/servo/servo/pull/45031), [#45060](https://github.com/servo/servo/pull/45060)).

We’ve eliminated a traversal of the whole DOM tree whenever an **&lt;iframe>** is attached to the tree, which is especially noticeable when parsing documents with many &lt;iframe> tags ([@mrobinson](https://github.com/mrobinson), [#45236](https://github.com/servo/servo/pull/45236)).

Stylesheet locks now use [AtomicRefCell](https://docs.rs/atomic_refcell/0.1.14/atomic_refcell/), which is even more efficient than a [parking_lot](https://docs.rs/parking_lot/0.12.5/parking_lot/)::[RwLock](https://docs.rs/parking_lot/0.12.5/parking_lot/type.RwLock.html) ([@mrobinson](https://github.com/mrobinson), [#44883](https://github.com/servo/servo/pull/44883)).

On OpenHarmony, we now have a real refresh driver for reduced idle CPU usage ([@jschwe](https://github.com/jschwe), [@yezhizhen](https://github.com/yezhizhen), [#44927](https://github.com/servo/servo/pull/44927)), and we now cache the font list on disk for faster startup ([@RichardTjokroutomo](https://github.com/RichardTjokroutomo), [@d-desyatkin](https://github.com/d-desyatkin), [#44158](https://github.com/servo/servo/pull/44158)).

We’ve also reduced allocations, GC rooting steps, and other operations in many parts of Servo ([@jschwe](https://github.com/jschwe), [@kkoyung](https://github.com/kkoyung), [@mrobinson](https://github.com/mrobinson), [@SteveSharonSam](https://github.com/SteveSharonSam), [@Narfinger](https://github.com/Narfinger), [@jdm](https://github.com/jdm), [@nodelpit](https://github.com/nodelpit), [@simonwuelker](https://github.com/simonwuelker), [#44961](https://github.com/servo/servo/pull/44961), [#44944](https://github.com/servo/servo/pull/44944), [#44972](https://github.com/servo/servo/pull/44972), [#45231](https://github.com/servo/servo/pull/45231), [#45078](https://github.com/servo/servo/pull/45078), [#44662](https://github.com/servo/servo/pull/44662), [#44679](https://github.com/servo/servo/pull/44679), [#44967](https://github.com/servo/servo/pull/44967), [#44963](https://github.com/servo/servo/pull/44963), [#44933](https://github.com/servo/servo/pull/44933), [#44935](https://github.com/servo/servo/pull/44935), [#44905](https://github.com/servo/servo/pull/44905)).

To improve Servo’s **build times**, we’re moving more code out of our massive **script crate** ([@Narfinger](https://github.com/Narfinger), [@jdm](https://github.com/jdm), [#44598](https://github.com/servo/servo/pull/44598), [#44636](https://github.com/servo/servo/pull/44636), [#44823](https://github.com/servo/servo/pull/44823)), and reduced the size of our dependency tree ([@jschwe](https://github.com/jschwe), [#44818](https://github.com/servo/servo/pull/44818)).

## Stability

Several crashes and hangs have been fixed:

- in **‘content’** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [@SimonSapin](https://github.com/SimonSapin), [#45227](https://github.com/servo/servo/pull/45227), [#44762](https://github.com/servo/servo/pull/44762))
- in **Media­Stream** ([@jdm](https://github.com/jdm), [#44781](https://github.com/servo/servo/pull/44781))
- in **item()** on **attributes** on **Element** ([@webbeef](https://github.com/webbeef), [#44721](https://github.com/servo/servo/pull/44721))
- in **append­Rule()** on **CSS­Keyframes­Rule** ([@mrobinson](https://github.com/mrobinson), [#45173](https://github.com/servo/servo/pull/45173))
- in **init­Event()** on **Focus­Event** ([@mrobinson](https://github.com/mrobinson), [#44870](https://github.com/servo/servo/pull/44870))
- in **stop()** on **Window** ([@TimvdLippe](https://github.com/TimvdLippe), [#44804](https://github.com/servo/servo/pull/44804))
- in `document.exec­Command(​"delete")` ([@TimvdLippe](https://github.com/TimvdLippe), [#44748](https://github.com/servo/servo/pull/44748))
- in `--debug-mozjs` builds ([@Gae24](https://github.com/Gae24), [@SharanRP](https://github.com/SharanRP), [#44745](https://github.com/servo/servo/pull/44745), [#45001](https://github.com/servo/servo/pull/45001))
- when evaluating scripts in DevTools while paused ([@atbrakhi](https://github.com/atbrakhi), [#45050](https://github.com/servo/servo/pull/45050))
- when previewing some JS values in DevTools ([@eerii](https://github.com/eerii), [@atbrakhi](https://github.com/atbrakhi), [#45054](https://github.com/servo/servo/pull/45054))
- when shaping zero-width spaces in layout ([@mrobinson](https://github.com/mrobinson), [#45176](https://github.com/servo/servo/pull/45176))
- when toggling servoshell’s experimental mode at runtime ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#45226](https://github.com/servo/servo/pull/45226))

We’ve continued our long-running effort to **use the Rust type system** to make certain kinds of dynamic borrow failures impossible ([@Gae24](https://github.com/Gae24), [@MavenRain](https://github.com/MavenRain), [@Narfinger](https://github.com/Narfinger), [@SteveSharonSam](https://github.com/SteveSharonSam), [@TimvdLippe](https://github.com/TimvdLippe), [@elomscansio](https://github.com/elomscansio), [@jdm](https://github.com/jdm), [@kkoyung](https://github.com/kkoyung), [@yezhizhen](https://github.com/yezhizhen), [#44712](https://github.com/servo/servo/pull/44712), [#44759](https://github.com/servo/servo/pull/44759), [#44879](https://github.com/servo/servo/pull/44879), [#45014](https://github.com/servo/servo/pull/45014), [#45058](https://github.com/servo/servo/pull/45058), [#45061](https://github.com/servo/servo/pull/45061), [#45076](https://github.com/servo/servo/pull/45076), [#45098](https://github.com/servo/servo/pull/45098), [#45110](https://github.com/servo/servo/pull/45110), [#45149](https://github.com/servo/servo/pull/45149), [#45117](https://github.com/servo/servo/pull/45117), [#45184](https://github.com/servo/servo/pull/45184), [#45201](https://github.com/servo/servo/pull/45201), [#44806](https://github.com/servo/servo/pull/44806), [#44930](https://github.com/servo/servo/pull/44930), [#44942](https://github.com/servo/servo/pull/44942), [#44946](https://github.com/servo/servo/pull/44946), [#45233](https://github.com/servo/servo/pull/45233), [#45181](https://github.com/servo/servo/pull/45181), [#44659](https://github.com/servo/servo/pull/44659), [#44660](https://github.com/servo/servo/pull/44660), [#44664](https://github.com/servo/servo/pull/44664), [#44668](https://github.com/servo/servo/pull/44668), [#44992](https://github.com/servo/servo/pull/44992), [#45000](https://github.com/servo/servo/pull/45000), [#45081](https://github.com/servo/servo/pull/45081), [#45009](https://github.com/servo/servo/pull/45009), [#45225](https://github.com/servo/servo/pull/45225), [#45087](https://github.com/servo/servo/pull/45087), [#45244](https://github.com/servo/servo/pull/45244), [#45245](https://github.com/servo/servo/pull/45245), [#45247](https://github.com/servo/servo/pull/45247), [#44663](https://github.com/servo/servo/pull/44663), [#44665](https://github.com/servo/servo/pull/44665), [#44993](https://github.com/servo/servo/pull/44993), [#45040](https://github.com/servo/servo/pull/45040), [#45053](https://github.com/servo/servo/pull/45053), [#44647](https://github.com/servo/servo/pull/44647), [#44671](https://github.com/servo/servo/pull/44671), [#44681](https://github.com/servo/servo/pull/44681), [#44717](https://github.com/servo/servo/pull/44717), [#44733](https://github.com/servo/servo/pull/44733), [#44686](https://github.com/servo/servo/pull/44686), [#44653](https://github.com/servo/servo/pull/44653)).

## New contributors

A special thanks to the following people for landing their first patch in Servo:

- AbdAlRahman Gad ([@AbdAlRahmanGad](https://github.com/AbdAlRahmanGad), [#45213](https://github.com/servo/servo/pull/45213))
- Onyeka Obi ([@MavenRain](https://github.com/MavenRain), [#44806](https://github.com/servo/servo/pull/44806))
- Steve Sharon Sam ([@SteveSharonSam](https://github.com/SteveSharonSam), [#45030](https://github.com/servo/servo/pull/45030))
- avis137 ([@avis137](https://github.com/avis137), [#44837](https://github.com/servo/servo/pull/44837))
- Xabier Rodríguez ([@calvaris](https://github.com/calvaris), [#45084](https://github.com/servo/servo/pull/45084))
- June ([@kimjune01](https://github.com/kimjune01), [#44816](https://github.com/servo/servo/pull/44816))
- Matt Van Horn ([@mvanhorn](https://github.com/mvanhorn), [#44740](https://github.com/servo/servo/pull/44740))
- nicole ([@n0blenote](https://github.com/n0blenote), [#44704](https://github.com/servo/servo/pull/44704))
- panxt8 ([@panxt8](https://github.com/panxt8), [#44991](https://github.com/servo/servo/pull/44991))

Interested in helping build a web browser?
Take a look at our [curated list](https://starters.servo.org) of issues that are good for new contributors!

## Donations

<!--
- 4048.00/month github
- 3475.90/month opencollective
- 35 donors 135.95/month thanks.dev
-->

Thanks again for your generous support!
We are now receiving **7659 USD/month** (+4.2% from April) in recurring donations.
This helps us cover the cost of our **[speedy](https://ci0.servo.org) [CI](https://ci1.servo.org) [and](https://ci2.servo.org) [benchmarking](https://ci3.servo.org) [servers](https://ci4.servo.org)**, one of our latest **[Outreachy interns](https://www.outreachy.org/alums/2026-05/#:~:text=Servo)**, and funding **[maintainer work]({{ '/blog/2025/09/17/your-donations-at-work-funding-jdm/' | url }})** that helps more people contribute to Servo.

Servo is also on [thanks.dev](https://thanks.dev), and already **35 GitHub users** (+2 from April) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

We now have [**sponsorship tiers**]({{ '/blog/2025/11/21/sponsorship-tiers/' | url }}) that allow you or your organisation to donate to the Servo project with public acknowlegement of your support.
If you’re interested in this kind of sponsorship, please contact us at [join@servo.org](mailto:join@servo.org).

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; right: calc(100% - 100% * 7659 / 10000); padding-right: 0.5em;"><strong>7659</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 7659 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="7659" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
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
