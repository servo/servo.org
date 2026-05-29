---
layout:     post
tags:       blog
title:      "April in Servo: and more!"
date:       2026-05-29
summary:    ao!! wrrrrao!!
categories:
---

For security fixes, see [**§ Security**](#security).

Navigating to a **JSON file** as the top-level document now renders the JSON with an **interactive pretty-printer** (@webbeef, @TimvdLippe, #43702).

Servo’s support for text in **Chinese**, **Japanese**, and **Korean** languages has improved, with correct wrapping in the layout engine (@SharanRP, #43744), and CJK fonts now enabled in servoshell’s browser UI on Windows, Linux, and FreeBSD (@yezhizhen, @CynthiaOketch, @nortti0, #44055, #44138, #44514).

We’ve shipped several new web platform features:

- **&lt;template shadowrootslotassignment>** (@simonwuelker, #44246)
- **&lt;video>** playback on OpenHarmony (@rayguo17, #43208)
- **‘minimum-scale’** and **‘maximum-scale’** values in **&lt;meta name=viewport>** (@shubhamg13, #40098, #43715)
- **‘tab-size’** (@mrobinson, @SimonSapin, #44480)
- **‘text-align: match-parent’** (@TG199, #44073)
- **new Worker()** with **blob URLs** (@jdm, #44004)
- **getContext(`"webgl"`)** on **OffscreenCanvas** (@niyabits, #44159)
- the **detail** property on **PerformanceMark** and **PerformanceMeasure** (@shubhamg13, #44289)

Plus a bunch of new DOM APIs:

- **‘selectionchange’** events on &lt;input> and &lt;textarea> (@TimvdLippe, #44461)
- **StorageManager**, in experimental mode (@Taym95, #43976)
- **activeElement** on **Document** and **ShadowRoot** (@mrobinson, #43861)
- **crypto.subtle.supports()** (@kkoyung, #43703) – Servo is the first major browser engine to support this!
- **cellPadding**, **cellSpacing**, and **align** properties on **HTMLTableElement** (@mrobinson, #43903) – previously supported in HTML only
- **relatedTarget** on **‘focus’** and **‘blur’** events (@mrobinson, #43926)
- **transferFromImageBitmap()** on **ImageBitmapRenderingContext** (@Messi002, #43984)

This is another big update, so here’s an outline:

- [**Security**](#security)

- [**Work in progress**](#work-in-progress)

- [**servoshell**](#servoshell)

- [**Embedding API**](#embedding-api)

- [**More on the web platform**](#more-on-the-web-platform)

- [**Performance and stability**](#performance-and-stability)

## Security

We fixed some undefined behaviour in servoshell’s signal handler (@Narfinger, #43891).

## Work in progress

**IndexedDB** is now enabled in servoshell’s experimental mode (@arihant2math, #44245).
As always, embedders can enable it with [`Preferences`](https://doc.servo.org/servo/struct.Preferences.html)::[`dom­_indexeddb­_enabled`](https://doc.servo.org/servo/struct.Preferences.html#structfield.dom_indexeddb_enabled) (@arihant2math, #44245, #44283).
To that end, we’ve landed improvements to IDBDatabase, IDBObjectStore, IDBCursor, IDBKeyRange, IDBRequest, and to the key handling, exception handling, and transactions (@Taym95, #44128, #43901, #44009, #43914, #44161, #44183, #44059, #44215, #42998).

We’ve made more progress on the **IntersectionObserver API**, under `--pref dom­_intersection­_observer­_enabled` (@stevennovaryo, @jdm, #42204).

We’re continuing to implement **document.execCommand()** for **rich text editing** (@TimvdLippe, #44529), under `--pref dom­_exec­_command­_enabled`.
This release adds support for the **‘bold’**, **‘fontName’**, **‘fontSize’**, **‘italic’**, **‘strikethrough’**, and **‘underline’** commands (@TimvdLippe, @jdm, @mrobinson, #44511, #43287, #44432, #44410, #44194, #44030, #44039, #44041, #44075, #44234, #44250, #44331, #44390, #44137, #44293, #44312, #44347).

All of the features above are enabled in servoshell’s experimental mode.

Servo can now build a very basic **accessibility tree** for web contents, under `--pref accessibility­_enabled` (@alice, @delan, @lukewarlow, #42338, #43558, #44437, #44438).
This includes text runs, plus nine other non-interactive accessibility roles (@alice, @delan, #44255).
We’ve also fixed a crash when reloading pages with accessibility enabled (@alice, #44473).

We’ve started implementing the **Sanitizer API**, under `--pref dom­_sanitizer­_enabled` (@kkoyung, #44198, #44290, #44335, #44421, #44452, #44481, #44585, #44594).

We’ve also started implementing **SharedWorker**, under `--pref dom­_sharedworker­_enabled` (@Taym95, #44375, #44440).

We’re working on the **WakeLock API** too, under `--pref dom­_wakelock­_enabled` (@TG199, @rovertrack, #43617, #44343).

## servoshell

servoshell for Android now has a **revamped browser UI**, including a new **history view** (@espy, #43795), and we’ve fixed the black screen bug when closing settings or switching back from another app (@yezhizhen, #44327).
You can now close tabs on OpenHarmony too (@Narfinger, #42713).

As for servoshell on desktop platforms, we’ve fixed some focus- and IME-related bugs (@mrobinson, #43872, #43932), and on Windows, we now install a normal shortcut without the strange behaviour of an “advertised” shortcut (@yezhizhen, #44223).

## Embedding API

With this second monthly release of the Servo library, we have some quick notes about **API stability** and **semver compatibility**:

- **The [‘servo’](https://crates.io/crates/servo) package** follows [Cargo’s rules for semver compatibility](https://doc.rust-lang.org/1.88.0/cargo/reference/specifying-dependencies.html#default-requirements).
0.1.1 is compatible with version 0.1.0, but 0.2.0 is a breaking update.

- Until we integrate semver analysis into our release process, each monthly release will have a breaking version number, while non-breaking version numbers may be used for LTS updates.

- In general, **dependencies of ‘servo’**, like [‘servo-base’](https://crates.io/crates/servo-base) and [‘servo-script’](https://crates.io/crates/servo-script), **do not use semver**.
Any release may include breaking changes.

We’ve fixed a **build failure** affecting embedders with a **new or updated Cargo.lock** (@jschwe, #44093), and landed several other changes to help us with the Servo library release process (@jschwe, @mukilan, #43972, #44642, #43182, #43866, #44086, #43797).

Breaking changes:

- [`Web­View`](https://doc.servo.org/servo/struct.WebView.html)::[`animating`](https://doc.servo.org/servo/struct.WebView.html#method.animating) now takes `&self` instead of `self`, so you can call it without cloning the handle (@JavaDerg, #44253)

- [`Servo`](https://doc.servo.org/servo/struct.Servo.html)::[`site­_data­_manager`](https://doc.servo.org/servo/struct.Servo.html#method.site_data_manager) now returns `&SiteDataManager` instead of `Ref<'_, SiteDataManager>` (@sabbCodes, #44116)

- [`Web­View­Delegate`](https://doc.servo.org/servo/trait.WebViewDelegate.html)::`play­_gamepad­_haptic­_effect` and `stop­_gamepad­_haptic­_effect` have been removed (@mrobinson, #43895), but they have not worked since February 2026 – use [`Gamepad­Delegate`](https://doc.servo.org/servo/trait.GamepadDelegate.html) instead

You can now load a URL with **custom request headers** by calling [`Web­View`](https://doc.servo.org/servo/struct.WebView.html)::[`load­_request`](https://doc.servo.org/servo/struct.WebView.html#method.load_request) (@Narfinger, @longvatrong111, @mrobinson, #43338).

You can now **retrieve cookies asynchronously** by calling [`Site­Data­Manager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::[`cookies­_for­_url­_async`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.cookies_for_url_async) (@longvatrong111, #43794).

The synchronous version of that method, [`Site­Data­Manager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::[`cookies­_for­_url`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.cookies_for_url), was previously not callable because [`Cookie­Source`](https://doc.servo.org/servo/enum.CookieSource.html) was not exposed to the public API, but we’ve fixed that now (@TG199, #44124).

You can now **clear session cookies** without clearing [permanent cookies](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/Cookies#removal_defining_the_lifetime_of_a_cookie) by calling [`Site­Data­Manager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::[`clear­_session­_cookies`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.clear_session_cookies) (@longvatrong111, #44166).

When **intercepting requests** with [`Servo­Delegate`](https://doc.servo.org/servo/trait.ServoDelegate.html):: and [`Web­View­Delegate`](https://doc.servo.org/servo/trait.WebViewDelegate.html)::[`load­_web­_resource`](https://doc.servo.org/servo/trait.WebViewDelegate.html#method.load_web_resource), we now include a [`destination`](https://doc.servo.org/servo/struct.WebResourceRequest.html#structfield.destination) and [`referrer­_url`](https://doc.servo.org/servo/struct.WebResourceRequest.html#structfield.referrer_url) in the [`Web­Resource­Request`](https://doc.servo.org/servo/struct.WebResourceRequest.html), which can be helpful if you’re implementing **ad blocking** (@webbeef, #44493).

You can configure Servo to **write all of its storage to a unique directory** for that session by enabling [`Opts`](https://doc.servo.org/servo/struct.Opts.html)::[`temporary­_storage`](https://doc.servo.org/servo/struct.Opts.html#structfield.temporary_storage) (@janvarga, #44433).
Note that these unique directories currently persist after Servo exits, so it’s an isolation feature, not a privacy feature.

[`Window­Rendering­Context`](https://doc.servo.org/servo/struct.WindowRenderingContext.html)::[`new`](https://doc.servo.org/servo/struct.WindowRenderingContext.html#method.new) and [`Software­Rendering­Context`](https://doc.servo.org/servo/struct.SoftwareRenderingContext.html)::[`new`](https://doc.servo.org/servo/struct.SoftwareRenderingContext.html#method.new) now return an error if the given `size` is less than 1x1 (@freyacodes, @mrobinson, #44011).

We’ve improved our API docs for [`Web­View`](https://doc.servo.org/servo/struct.WebView.html), [`Web­View­Builder`](https://doc.servo.org/servo/struct.WebViewBuilder.html), [`Web­View­Delegate`](https://doc.servo.org/servo/trait.WebViewDelegate.html), [`ServoDelegate`](https://doc.servo.org/servo/trait.ServoDelegate.html), [`Prompt­Dialog`](https://doc.servo.org/servo/struct.PromptDialog.html), [`Web­Resource­Load`](https://doc.servo.org/servo/struct.WebResourceLoad.html), [`Web­Xr­Registry`](https://doc.servo.org/servo/webxr/trait.WebXrRegistry.html), [`Preferences`](https://doc.servo.org/servo/struct.Preferences.html), and servoshell’s [`EXPERIMENTAL­_PREFS`](https://doc.servo.org/servoshell/prefs/static.EXPERIMENTAL_PREFS.html) (@simonwuelker, @TG199, @sabbCodes, @jdm, @rovertrack, #43892, #43787, #44171, #43947).

We’ve also improved our API docs for [`Opts`](https://doc.servo.org/servo/struct.Opts.html), [`Output­Options`](https://doc.servo.org/servo/enum.OutputOptions.html), [`Diagnostics­Logging`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html), [`Pref­Value`](https://doc.servo.org/servo/enum.PrefValue.html), [`servo`](https://doc.servo.org/servo/index.html)::[`opts`](https://doc.servo.org/servo/opts/index.html), and [`servo­_config`](https://doc.servo.org/servo_config/index.html) (@mukilan, #43802).

## More on the web platform

**Tab characters** are now rendered correctly in **&lt;pre>** (and other elements with **‘white-space: pre’**), with proper tab stops (@mrobinson, @SimonSapin, #44480).

**&lt;a href>** now correctly resolves the URL with the page encoding (@sabbCodes, #43822).

We’ve improved the default appearance of **&lt;input type=file>** (@sabbCodes, #44496) and **&lt;textarea placeholder>** (@mrobinson, #43770).

All **keyboard events**, **mouse events**, **wheel events**, and **pointer events**, other than **‘keydown’**, **‘pointerenter’**, and **‘pointerleave’**, now **bubble out of shadow roots** (@simonwuelker, #43799).
**‘error’ events** on **Window** now report the correct **filename** (**source** in **onerror**) and **lineno** (@Gae24, #43632).

We’ve improved the conformance of **fetch algorithms** (@yezhizhen, #43970, #43798), **focus** and **tab navigation** (@mrobinson, #43842, #44029, #44360, #43859, #44535), **form submission** (@TG199, #43700), **JS modules** (@elomscansio, @Gae24, #43741, #44179, #44042), **page navigation** (@TimvdLippe, #43857), **&lt;svg viewBox>** (@yezhizhen, #44420), **‘font’** (@RichardTjokroutomo, #44061), **‘load’** events (@jdm, @arabson99, #43807, #44046), **axes** and **buttons** on **Gamepad** (@log101, @rovertrack, #44411, #44357), **copyTexImage2D()** on **WebGLRenderingContext** (@simartin, @mrobinson, #43608), **texImage3D()** on **WebGL2RenderingContext** (@simartin, #44367), **environmentBlendMode** on **XRSession** (@msub2, #44155), and **PerformanceResourceTiming** (@shubhamg13, #44228).

We’ve fixed bugs related to **‘box-shadow’** (@yezhizhen, #44474, #44457), **‘display: contents’** (@Loirooriol, #44551), **‘display: inline-flex’** (@SimonSapin, #44281), **‘display: table-cell’** (@Loirooriol, #44550), **‘display: table-row-group’** (@Veercodeprog, #43674), **‘overflow-x: clip’** and **‘overflow-y: clip’** (@Messi002, #43620), **‘position: absolute’** on grid items (@nicoburns, #44324), **‘word-spacing: &lt;percentage>’** (@sabbCodes, #44031), and **removeChild()** on **Document** (@rovertrack, #44133).

## Performance and stability

Like most browser engines, Servo is a multi-threaded (and sometimes multi-process) system requiring a great deal of IPC messages to keep everything connected.
[Two key components](https://book.servo.org/design-documentation/architecture.html) of this system are the **constellation** thread, which manages the engine as a whole, and the **script threads** (or web processes), which render the web pages.
Sending these messages can be expensive though, so to **reduce unnecessary IPC traffic**, we’ve landed an optimisation that allows script threads to selectively receive only the relevant messages from the constellation (@webbeef, #43124).

We’ve reduced the **memory usage** of each **Attr**, **Text**, and **CharacterData** node in the DOM by 16 bytes (@mrobinson, @Loirooriol, #44074), and **fixed a memory leak** when deleting **&lt;video controls>** or **&lt;audio controls>** (@Messi002, #43983).

Our **about:memory** page is more accurate now too, with new tracking of **libc memory allocations** on macOS, improved tracking of libc memory allocations on Linux (@jschwe, #44037), and more accurate tracking of PathBuf and types in `tokio`, `http`, `data_url`, and `urlpattern` (@Narfinger, #43858).

Less memory usage isn’t always better in browser engines though, because there are many kinds of caches and other optimisations we can do to make browsing the web faster, at the expense of increased memory usage.
[TODO write about those]

We’ve landed several changes that should reduce the **binary size** of Servo (@rovertrack, @mrobinson, @nicoburns, @Narfinger, #44227, #44221, #44303, #44338, #44428, #44134).

We’ve also reduced clones, allocations, borrow checks, GC rooting steps, and other operations in many parts of Servo (@rovertrack, @Narfinger, @Loirooriol, @yezhizhen, #44008, #44544, #44271, #44279, #43826, #44052).

Several crashes have been fixed:

- in compressedTexSubImage2D() on WebGLRenderingContext (@thebabalola, #44050)
- in console.log() (@thebabalola, #43844)
- in getData() on DataTransfer (@SimonSapin, #44607)
- in remove() on Element (@SimonSapin, #44435)
- in replaceWith() on Element (@yezhizhen, #44503)
- in `--debug-mozjs` builds (@jdm, #44386, #44573, #44581)
- in flex and grid layout (@mrobinson, @nicoburns, #44424, #44203)
- in layout queries like `offsetHeight` (@mrobinson, #44560)
- in the devtools Debugger tab, when stepping and when inspecting nested values (@atbrakhi, @eerii, #44024, #43995)
- when removing &lt;colgroup> from the DOM (@Loirooriol, #43846)
- when running garbage collection (@drasticactions, #43933)
- when running servoshell with a [`u64`](https://doc.rust-lang.org/1.88.0/std/primitive.u64.html) `--pref` (@yezhizhen, #44079)
- when shadow roots are deeply nested, or when calling attachShadow() removes elements from the flat tree (@yezhizhen, @mrobinson, #43888, #43930, #44259)
- when [web storage features](https://storage.spec.whatwg.org) fail to write to disk or encounter SQLite errors (@arihant2math, @sabbCodes, #43918, #43949)

We fixed a crash in servoshell when pressing keys like Ctrl+2 or ⌘2 with not enough tabs open (@mrobinson, #44070).

**DOM data structures** (`#[dom_struct]`) can refer to one another, with the help of [garbage collection](https://research.mozilla.org/2014/08/26/javascript-servos-only-garbage-collector/).
But when DOM objects are being destroyed, those references can become invalid for a brief moment, depending on the order the GC finalizers run in.
This can be unsound if those references are accessed, which is a very easy mistake to make if the type has an `impl Drop`.
To help prevent that class of bug, we’re reworking our DOM types so that none of them have `#[dom_struct]` and `impl Drop` at the same time (@willypuzzle, #44119, #44501, #44513).

We’ve continued our long-running effort to **use the Rust type system** to make certain kinds of dynamic borrow failures impossible (@sagudev, @TimvdLippe, @Narfinger, @elomscansio, @Gae24, @rovertrack, @yezhizhen, @nodelpit, #43174, #43524, #43928, #43943, #43942, #43944, #43946, #43952, #43975, #44018, #44175, #44241, #44368, #44406, #44441, #44422, #44475, #44478, #44484, #44476, #44490, #44477, #44494, #44497, #44498, #44495, #44505, #44506, #44507, #44508, #44509, #44510, #44512, #44482, #44527, #44528, #44531, #44534, #44542, #44533, #44543, #44553, #44547, #44563, #44562, #44565, #44558, #44583, #44606, #44605, #44608, #44602, #44584, #44620, #44590, #44254, #44628, #44629, #44638, #44626).

Thanks to a wide range of people, we’ve also landed a bunch of cleanups and refactors (@delan, @alice, @Skgland, @atbrakhi, @eerii, @sabbCodes, @jdm, @thebabalola, @CynthiaOketch, @kkoyung, @TimvdLippe, @rovertrack, @webbeef, @arabson99, @yezhizhen, @simonwuelker, @mrobinson, @nicoburns, @longvatrong111, @niyabits, @treetmitterglad, @foresterre, @mukilan, @elomscansio, @TG199, #43772, #44006, #43860, #44121, #44160, #43884, #44154, #44569, #43939, #44003, #44110, #44122, #43824, #44635, #44103, #43978, #44092, #44114, #44277, #44454, #44274, #44237, #44232, #44167, #44214, #43820, #43825, #43810, #43838, #43841, #43847, #43875, #43876, #43889, #43893, #43896, #43881, #43906, #43913, #43908, #43917, #43910, #43921, #43924, #43925, #43907, #43923, #43916, #43909, #43911, #43957, #43969, #43967, #43915, #43954, #43963, #43959, #43955, #44067, #44068, #44071, #44084, #44265, #44115).

## Donations

<!--
- 3150.90/month opencollective
- 4048.00/month github
- 33 donors 150.92/month thanks.dev
-->

Thanks again for your generous support!
We are now receiving **7349 USD/month** (+2.5% from March) in recurring donations.
This helps us cover the cost of our **[speedy](https://ci0.servo.org) [CI](https://ci1.servo.org) [and](https://ci2.servo.org) [benchmarking](https://ci3.servo.org) [servers](https://ci4.servo.org)**, one of our latest **[Outreachy interns](https://www.outreachy.org/alums/2025-06/#:~:text=Servo)**, and funding **[maintainer work]({{ '/blog/2025/09/17/your-donations-at-work-funding-jdm/' | url }})** that helps more people contribute to Servo.

Servo is also on [thanks.dev](https://thanks.dev), and already **33 GitHub users** (−4 from March) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

We now have [**sponsorship tiers**]({{ '/blog/2025/11/21/sponsorship-tiers/' | url }}) that allow you or your organisation to donate to the Servo project with public acknowlegement of your support.
If you’re interested in this kind of sponsorship, please contact us at [join@servo.org](mailto:join@servo.org).

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; right: calc(100% - 100% * 7349 / 10000); padding-right: 0.5em;"><strong>7349</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 7349 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="7349" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

Use of donations is decided transparently via the Technical Steering Committee’s public **[funding request process](https://github.com/servo/project/blob/main/FUNDING_REQUEST.md)**, and active proposals are tracked in [servo/project#187](https://github.com/servo/project/issues/187).
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
