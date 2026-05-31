---
layout:     post
tags:       blog
title:      "April in Servo: new Android UI, focus, forms, security fixes, and more!"
date:       2026-05-31
summary:    Plus better inspection of values in the DevTools Console and Debugger tabs.
categories:
---

[**Servo 0.2.0**](https://github.com/servo/servo/releases/tag/v0.2.0) contains all of the changes we landed in April, which came out to yet another record **534 commits** (March: 530).
For security fixes, see [**§ Security**](#security).

<aside class=_note>

**Note:** the GitHub release is available now, but [the crates.io release](https://crates.io/crates/servo) is not yet complete.
We expect to publish it some time **next week**.
</aside>

<figure>
    <a href="{{ '/img/blog/2026-05-diffie.png' | url }}"><img src="{{ '/img/blog/2026-05-diffie.png' | url }}" alt="servoshell 0.2.0 showing several new features: better wrapping for CJK scripts, ‘tab-size’, better file pickers and `<textarea>`, `<select multiple>`, ‘::details-content::before’ and ‘::details-content::after’, and ‘color-mix()’ with any number of colors"></a>
</figure>

We’ve shipped several new web platform features:

- **&lt;select multiple>** ([@lukewarlow](https://github.com/lukewarlow), [@mrobinson](https://github.com/mrobinson), [#43189](https://github.com/servo/servo/pull/43189))
- **&lt;template shadowrootslotassignment>** ([@simonwuelker](https://github.com/simonwuelker), [#44246](https://github.com/servo/servo/pull/44246))
- **&lt;video>** playback on OpenHarmony ([@rayguo17](https://github.com/rayguo17), [#43208](https://github.com/servo/servo/pull/43208))
- **‘minimum-scale’** and **‘maximum-scale’** values in **&lt;meta name=viewport>** ([@shubhamg13](https://github.com/shubhamg13), [#40098](https://github.com/servo/servo/pull/40098), [#43715](https://github.com/servo/servo/pull/43715))
- **‘color-mix()’** with **any number of &lt;color> values** ([@Loirooriol](https://github.com/Loirooriol), [#43890](https://github.com/servo/servo/pull/43890))
- **‘&amp;::before’** and **‘&amp;::after’** in **‘::details-content’** ([@Loirooriol](https://github.com/Loirooriol), [#43878](https://github.com/servo/servo/pull/43878))
- **‘revert-rule’** ([@Loirooriol](https://github.com/Loirooriol), [#43878](https://github.com/servo/servo/pull/43878))
- **‘tab-size’** ([@mrobinson](https://github.com/mrobinson), [@SimonSapin](https://github.com/SimonSapin), [#44480](https://github.com/servo/servo/pull/44480))
- **‘text-align: match-parent’** ([@TG199](https://github.com/TG199), [#44073](https://github.com/servo/servo/pull/44073))
- **new Worker()** with **blob URLs** ([@jdm](https://github.com/jdm), [#44004](https://github.com/servo/servo/pull/44004))
- **get­Context(`"webgl"`)** on **Offscreen­Canvas** ([@niyabits](https://github.com/niyabits), [#44159](https://github.com/servo/servo/pull/44159))
- the **detail** property on **Performance­Mark** and **Performance­Measure** ([@shubhamg13](https://github.com/shubhamg13), [#44289](https://github.com/servo/servo/pull/44289), [#44272](https://github.com/servo/servo/pull/44272))

Plus a bunch of new DOM APIs:

- **‘selectionchange’** events on &lt;input> and &lt;textarea> ([@TimvdLippe](https://github.com/TimvdLippe), [#44461](https://github.com/servo/servo/pull/44461))
- **Storage­Manager**, in experimental mode ([@Taym95](https://github.com/Taym95), [#43976](https://github.com/servo/servo/pull/43976))
- **active­Element** on **Document** and **Shadow­Root** ([@mrobinson](https://github.com/mrobinson), [#43861](https://github.com/servo/servo/pull/43861))
- **crypto.subtle.supports()** ([@kkoyung](https://github.com/kkoyung), [#43703](https://github.com/servo/servo/pull/43703)) – Servo is the first major browser engine to support this!
- **cell­Padding**, **cell­Spacing**, and **align** properties on **HTML­Table­Element** ([@mrobinson](https://github.com/mrobinson), [#43903](https://github.com/servo/servo/pull/43903)) – previously supported in HTML only
- **related­Target** on **‘focus’** and **‘blur’** events ([@mrobinson](https://github.com/mrobinson), [#43926](https://github.com/servo/servo/pull/43926))
- **transfer­From­Image­Bitmap()** on **Image­Bitmap­Rendering­Context** ([@Messi002](https://github.com/Messi002), [#43984](https://github.com/servo/servo/pull/43984))

Servo’s support for text in **Chinese**, **Japanese**, and **Korean** languages has improved, with correct wrapping in the layout engine ([@SharanRP](https://github.com/SharanRP), [#43744](https://github.com/servo/servo/pull/43744)), and CJK fonts now enabled in servoshell’s browser UI on Windows, Linux, and FreeBSD ([@yezhizhen](https://github.com/yezhizhen), [@CynthiaOketch](https://github.com/CynthiaOketch), [@nortti0](https://github.com/nortti0), [#44055](https://github.com/servo/servo/pull/44055), [#44138](https://github.com/servo/servo/pull/44138), [#44514](https://github.com/servo/servo/pull/44514)).

Navigating to a **JSON file** as the top-level document now renders the JSON with an **interactive pretty-printer** ([@webbeef](https://github.com/webbeef), [@TimvdLippe](https://github.com/TimvdLippe), [#43702](https://github.com/servo/servo/pull/43702)).

April was a big milestone for Servo, with some automated tests failing because they had hard-coded cookie expiry dates set to April 2016 plus ten years.
Surprise!
We’re still here.
Here’s to the next 100 years of Servo ([@jdm](https://github.com/jdm), [#44341](https://github.com/servo/servo/pull/44341)).

This is another big update, so here’s an outline:

- [**Security**](#security)

- [**Work in progress**](#work-in-progress)

- [**servoshell**](#servoshell)

- [**For developers**](#for-developers)

- [**Embedding API**](#embedding-api)

- [**More on the web platform**](#more-on-the-web-platform)

- [**Performance and stability**](#performance-and-stability)

## Security

**Crypto­Key** now zeroes buffers containing key material after use ([@kkoyung](https://github.com/kkoyung), [#44597](https://github.com/servo/servo/pull/44597)).

With only a few exceptions, you can only access DOM APIs in another document if that document is in the **same origin**.
But if that document is in the same *site* with a different port number, Servo currently allows these accesses even though it shouldn’t.
We’ve fixed some (but not all) of these incorrect accesses, specifically those that involve binding a Window or Location method in this document with a `this` from the other document ([@yvt](https://github.com/yvt), [@jdm](https://github.com/jdm), [#28583](https://github.com/servo/servo/pull/28583)).

We’ve fixed a bug where **local­Storage** and **session­Storage** were usable in **sandboxed &lt;iframe>** and shared with every other sandboxed &lt;iframe>, rather than throwing Security­Error ([@Taym95](https://github.com/Taym95), [#44002](https://github.com/servo/servo/pull/44002)).

We’ve fixed a bug where **local­Storage** and **session­Storage** were shared between all **&lt;iframe srcdoc> documents**, rather than isolated using the origin of the containing document ([@niyabits](https://github.com/niyabits), [#43988](https://github.com/servo/servo/pull/43988), [#44038](https://github.com/servo/servo/pull/44038)).

We’ve fixed a bug where **IndexedDB** was usable in **sandboxed &lt;iframe>** and **data: URL web workers** ([@Taym95](https://github.com/Taym95), [#44088](https://github.com/servo/servo/pull/44088)).

We’ve fixed a bug where pages in some **IP address origins** can evict cookies from other IP address origins ([@officialasishkumar](https://github.com/officialasishkumar), [#44152](https://github.com/servo/servo/pull/44152)).
Only evicting cookies was possible, not reading or writing them.

We’ve fixed an **out-of-bounds memory read** in **tex­Image3D()** on **Web­GL2­Rendering­Context** ([@simartin](https://github.com/simartin), [#44270](https://github.com/servo/servo/pull/44270)), and fixed some undefined behaviour in servoshell’s signal handler ([@Narfinger](https://github.com/Narfinger), [#43891](https://github.com/servo/servo/pull/43891)).

## Work in progress

**IndexedDB** is now enabled in servoshell’s experimental mode ([@arihant2math](https://github.com/arihant2math), [#44245](https://github.com/servo/servo/pull/44245)).
As always, embedders can enable it with [`Preferences`](https://doc.servo.org/servo/struct.Preferences.html)::[`dom­_indexeddb­_enabled`](https://doc.servo.org/servo/struct.Preferences.html#structfield.dom_indexeddb_enabled) ([@arihant2math](https://github.com/arihant2math), [#44245](https://github.com/servo/servo/pull/44245), [#44283](https://github.com/servo/servo/pull/44283)).

IndexedDB now uses Servo’s new **“client storage”** system, which is based on the [Storage Standard](https://storage.spec.whatwg.org) and will allow us to have a unified on-disk format and quota management for all web platform features that persistently store data ([@gterzian](https://github.com/gterzian), [#44374](https://github.com/servo/servo/pull/44374), [#43900](https://github.com/servo/servo/pull/43900)).
We’ve also made key range queries more efficient ([@arihant2math](https://github.com/arihant2math), [#39009](https://github.com/servo/servo/pull/39009)), landed improvements to IDB­Database, IDB­Object­Store, IDB­Cursor, IDB­Key­Range, IDB­Request, and to the handling of transactions, keys, values, and exceptions ([@Taym95](https://github.com/Taym95), [#44128](https://github.com/servo/servo/pull/44128), [#43901](https://github.com/servo/servo/pull/43901), [#44009](https://github.com/servo/servo/pull/44009), [#43914](https://github.com/servo/servo/pull/43914), [#44161](https://github.com/servo/servo/pull/44161), [#44183](https://github.com/servo/servo/pull/44183), [#44059](https://github.com/servo/servo/pull/44059), [#44215](https://github.com/servo/servo/pull/44215), [#42998](https://github.com/servo/servo/pull/42998), [#43805](https://github.com/servo/servo/pull/43805)).

We’ve made more progress on the **Intersection­Observer API**, under `--pref dom­_intersection­_observer­_enabled` ([@stevennovaryo](https://github.com/stevennovaryo), [@jdm](https://github.com/jdm), [#42204](https://github.com/servo/servo/pull/42204)).

We’re continuing to implement **document.exec­Command()** for **rich text editing** ([@TimvdLippe](https://github.com/TimvdLippe), [#44529](https://github.com/servo/servo/pull/44529)), under `--pref dom­_exec­_command­_enabled`.
This release adds support for the **‘bold’**, **‘font­Name’**, **‘font­Size’**, **‘italic’**, **‘strikethrough’**, and **‘underline’** commands ([@TimvdLippe](https://github.com/TimvdLippe), [@jdm](https://github.com/jdm), [@mrobinson](https://github.com/mrobinson), [#44511](https://github.com/servo/servo/pull/44511), [#43287](https://github.com/servo/servo/pull/43287), [#44432](https://github.com/servo/servo/pull/44432), [#44410](https://github.com/servo/servo/pull/44410), [#44194](https://github.com/servo/servo/pull/44194), [#44030](https://github.com/servo/servo/pull/44030), [#44039](https://github.com/servo/servo/pull/44039), [#44041](https://github.com/servo/servo/pull/44041), [#44075](https://github.com/servo/servo/pull/44075), [#44234](https://github.com/servo/servo/pull/44234), [#44250](https://github.com/servo/servo/pull/44250), [#44331](https://github.com/servo/servo/pull/44331), [#44390](https://github.com/servo/servo/pull/44390), [#44137](https://github.com/servo/servo/pull/44137), [#44293](https://github.com/servo/servo/pull/44293), [#44312](https://github.com/servo/servo/pull/44312), [#44347](https://github.com/servo/servo/pull/44347)).

All of the features above are enabled in servoshell’s experimental mode.

Servo can now build a very basic **accessibility tree** for web contents, under `--pref accessibility­_enabled` ([@alice](https://github.com/alice), [@delan](https://github.com/delan), [@lukewarlow](https://github.com/lukewarlow), [#42338](https://github.com/servo/servo/pull/42338), [#43558](https://github.com/servo/servo/pull/43558), [#44437](https://github.com/servo/servo/pull/44437), [#44438](https://github.com/servo/servo/pull/44438)).
This includes text runs, plus nine other non-interactive accessibility roles ([@alice](https://github.com/alice), [@delan](https://github.com/delan), [#44255](https://github.com/servo/servo/pull/44255)).
We’ve also fixed a crash when reloading pages with accessibility enabled ([@alice](https://github.com/alice), [#44473](https://github.com/servo/servo/pull/44473)), and made accessibility tree updates more efficient ([@alice](https://github.com/alice), [#44208](https://github.com/servo/servo/pull/44208)).

We’ve started implementing the **Sanitizer API**, under `--pref dom­_sanitizer­_enabled` ([@kkoyung](https://github.com/kkoyung), [#44198](https://github.com/servo/servo/pull/44198), [#44290](https://github.com/servo/servo/pull/44290), [#44335](https://github.com/servo/servo/pull/44335), [#44421](https://github.com/servo/servo/pull/44421), [#44452](https://github.com/servo/servo/pull/44452), [#44481](https://github.com/servo/servo/pull/44481), [#44585](https://github.com/servo/servo/pull/44585), [#44594](https://github.com/servo/servo/pull/44594)).

We’ve also started implementing **Shared­Worker**, under `--pref dom­_sharedworker­_enabled` ([@Taym95](https://github.com/Taym95), [#44375](https://github.com/servo/servo/pull/44375), [#44440](https://github.com/servo/servo/pull/44440)).

We’re working on the **Wake­Lock API** too, under `--pref dom­_wakelock­_enabled` ([@TG199](https://github.com/TG199), [@rovertrack](https://github.com/rovertrack), [#43617](https://github.com/servo/servo/pull/43617), [#44343](https://github.com/servo/servo/pull/44343)).

## servoshell

servoshell for Android now has a **revamped browser UI**, including a new **history view** ([@espy](https://github.com/espy), [#43795](https://github.com/servo/servo/pull/43795)), the **apk is 30% smaller** ([@jschwe](https://github.com/jschwe), [#44278](https://github.com/servo/servo/pull/44278), [#44182](https://github.com/servo/servo/pull/44182)), and we’ve fixed the black screen bug when closing settings or switching back from another app ([@yezhizhen](https://github.com/yezhizhen), [#44327](https://github.com/servo/servo/pull/44327)).
You can now close tabs on OpenHarmony too ([@Narfinger](https://github.com/Narfinger), [#42713](https://github.com/servo/servo/pull/42713)).

<figure>
    <a href="{{ '/img/blog/2026-05-android.png' | url }}"><img src="{{ '/img/blog/2026-05-android.png' | url }}" alt="servoshell 0.2.0 showing the revamped browser UI on Android. from left to right: viewing a web page, the settings view, the history view"></a>
</figure>

As for servoshell on desktop platforms, we’ve fixed some focus- and IME-related bugs ([@mrobinson](https://github.com/mrobinson), [#43872](https://github.com/servo/servo/pull/43872), [#43932](https://github.com/servo/servo/pull/43932)), and on Windows, we now install a normal shortcut without the strange behaviour of an “advertised” shortcut ([@yezhizhen](https://github.com/yezhizhen), [#44223](https://github.com/servo/servo/pull/44223)).

## For developers

When using the **Inspector** tab in the Firefox **DevTools**, the **Rules** panel now includes declarations in **‘@layer’ rules** ([@arabson99](https://github.com/arabson99), [#43912](https://github.com/servo/servo/pull/43912)).

When **logging expressions** in the **Console** tab, and when **hovering over symbols** in the **Debugger** tab, you can now get more information about the contents of functions, arrays, objects, and other values ([@atbrakhi](https://github.com/atbrakhi), [@eerii](https://github.com/eerii), [#44172](https://github.com/servo/servo/pull/44172), [#44173](https://github.com/servo/servo/pull/44173), [#44022](https://github.com/servo/servo/pull/44022), [#44233](https://github.com/servo/servo/pull/44233), [#44196](https://github.com/servo/servo/pull/44196), [#44181](https://github.com/servo/servo/pull/44181), [#44064](https://github.com/servo/servo/pull/44064), [#44023](https://github.com/servo/servo/pull/44023), [#44164](https://github.com/servo/servo/pull/44164), [#44369](https://github.com/servo/servo/pull/44369), [#44262](https://github.com/servo/servo/pull/44262)).

When using the **Debugger** tab, you can now use the **Scopes** panel to inspect local and global variables ([@eerii](https://github.com/eerii), [@atbrakhi](https://github.com/atbrakhi), [#43792](https://github.com/servo/servo/pull/43792), [#43791](https://github.com/servo/servo/pull/43791)), you can now debug **web worker** scripts ([@atbrakhi](https://github.com/atbrakhi), [#43981](https://github.com/servo/servo/pull/43981)), and we’ve started implementing **blackboxing**, aka the **Ignore source** button ([@freyacodes](https://github.com/freyacodes), [#44142](https://github.com/servo/servo/pull/44142)).

We’ve also landed some initial support for the **Style Editor** tab ([@rovertrack](https://github.com/rovertrack), [#44517](https://github.com/servo/servo/pull/44517), [#44462](https://github.com/servo/servo/pull/44462)).

We’re working towards re-enabling our automated DevTools tests in CI, which should make the feature more reliable ([@freyacodes](https://github.com/freyacodes), [#44577](https://github.com/servo/servo/pull/44577)), and we’ve landed a small build reproducibility fix too ([@jschwe](https://github.com/jschwe), [#44459](https://github.com/servo/servo/pull/44459)).

For developers of Servo itself, please note that the **Cargo ‘release’ profile** is no longer `#[cfg(debug­_assertions)]` ([@jschwe](https://github.com/jschwe), [@mrobinson](https://github.com/mrobinson), [#44177](https://github.com/servo/servo/pull/44177)).
If you’ve been using ‘release’ as a “faster ‘debug’ with assertions” build locally, consider switching to ‘checked-release’ or ‘medium’.

The pull request template has been updated ([@mrobinson](https://github.com/mrobinson), [#44135](https://github.com/servo/servo/pull/44135)).
**‘Testing’** and **‘Fixes’** should go at the *bottom* of the PR description, and **‘Testing’** is about automated tests, not how you tested the PR locally.

We’ve made more progress on the new [**dev container**](https://containers.dev), which will provide an alternative to [our usual procedures](https://book.servo.org/building/building.html) for setting up a Servo build environment ([@jschwe](https://github.com/jschwe), [@sagudev](https://github.com/sagudev), [#44126](https://github.com/servo/servo/pull/44126), [#44111](https://github.com/servo/servo/pull/44111), [#44162](https://github.com/servo/servo/pull/44162), [#44641](https://github.com/servo/servo/pull/44641), [#44109](https://github.com/servo/servo/pull/44109)).
Keep an eye out for that [in the book](https://book.servo.org/building/building.html)!

In the meantime, did you know that you can use [**Lix**](https://lix.systems) or [**Nix**](https://nixos.org/manual/nix/stable) to build Servo on Linux with a lot less hassle, *even if* you’re not using NixOS?
For now at least, head to the [NixOS page](https://book.servo.org/building/nixos.html) in the book to learn more.
We’ve also fixed a regression that made `--debug-mozjs` and `MOZJS­_FROM­_SOURCE` builds take much longer to complete on Linux when not using Nix ([@jschwe](https://github.com/jschwe), [#44346](https://github.com/servo/servo/pull/44346)).

We’ve fixed building Servo with the **‘jitspew’ feature** in mozjs, allowing you to set **IONFLAGS** to enable JIT logging ([@simonwuelker](https://github.com/simonwuelker), [#44010](https://github.com/servo/servo/pull/44010)).
We’ve also fixed build issues on Windows and FreeBSD ([@zhangxichang](https://github.com/zhangxichang), [@mrobinson](https://github.com/mrobinson), [#44264](https://github.com/servo/servo/pull/44264), [#44591](https://github.com/servo/servo/pull/44591)).

## Embedding API

With this second monthly release of the Servo library, we have some quick notes about **API stability** and **semver compatibility**:

- **The [‘servo’](https://crates.io/crates/servo) package** follows [Cargo’s rules for semver compatibility](https://doc.rust-lang.org/1.88.0/cargo/reference/specifying-dependencies.html#default-requirements).
0.1.1 is compatible with version 0.1.0, but 0.2.0 is a breaking update.

- Until we integrate semver analysis into our release process, each monthly release will have a breaking version number, while non-breaking version numbers may be used for LTS updates.

- In general, **dependencies of ‘servo’**, like [‘servo-base’](https://crates.io/crates/servo-base) and [‘servo-script’](https://crates.io/crates/servo-script), **do not use semver**.
Any release may include breaking changes.

We’ve fixed a **build failure** affecting embedders with a **new or updated Cargo.lock** ([@jschwe](https://github.com/jschwe), [#44093](https://github.com/servo/servo/pull/44093)), and landed several other changes to help us with the Servo library release process ([@jschwe](https://github.com/jschwe), [@mukilan](https://github.com/mukilan), [#43972](https://github.com/servo/servo/pull/43972), [#44642](https://github.com/servo/servo/pull/44642), [#43182](https://github.com/servo/servo/pull/43182), [#43866](https://github.com/servo/servo/pull/43866), [#44086](https://github.com/servo/servo/pull/44086), [#43797](https://github.com/servo/servo/pull/43797)).

Breaking changes:

- [`Web­View`](https://doc.servo.org/servo/struct.WebView.html)::[`animating`](https://doc.servo.org/servo/struct.WebView.html#method.animating) now takes `&self` instead of `self`, so you can call it without cloning the handle ([@JavaDerg](https://github.com/JavaDerg), [#44253](https://github.com/servo/servo/pull/44253))

- [`Servo`](https://doc.servo.org/servo/struct.Servo.html)::[`site­_data­_manager`](https://doc.servo.org/servo/struct.Servo.html#method.site_data_manager) now returns `&SiteDataManager` instead of `Ref<'_, SiteDataManager>` ([@sabbCodes](https://github.com/sabbCodes), [#44116](https://github.com/servo/servo/pull/44116))

- [`Web­View­Delegate`](https://doc.servo.org/servo/trait.WebViewDelegate.html)::`play­_gamepad­_haptic­_effect` and `stop­_gamepad­_haptic­_effect` have been removed ([@mrobinson](https://github.com/mrobinson), [#43895](https://github.com/servo/servo/pull/43895)), but they have not worked since February 2026 – use [`Gamepad­Delegate`](https://doc.servo.org/servo/trait.GamepadDelegate.html) instead

You can now load a URL with **custom request headers** by calling [`Web­View`](https://doc.servo.org/servo/struct.WebView.html)::[`load­_request`](https://doc.servo.org/servo/struct.WebView.html#method.load_request) ([@Narfinger](https://github.com/Narfinger), [@longvatrong111](https://github.com/longvatrong111), [@mrobinson](https://github.com/mrobinson), [#43338](https://github.com/servo/servo/pull/43338)).

You can now **retrieve cookies asynchronously** by calling [`Site­Data­Manager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::[`cookies­_for­_url­_async`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.cookies_for_url_async) ([@longvatrong111](https://github.com/longvatrong111), [#43794](https://github.com/servo/servo/pull/43794)).

The synchronous version of that method, [`Site­Data­Manager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::[`cookies­_for­_url`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.cookies_for_url), was previously not callable because [`Cookie­Source`](https://doc.servo.org/servo/enum.CookieSource.html) was not exposed to the public API, but we’ve fixed that now ([@TG199](https://github.com/TG199), [#44124](https://github.com/servo/servo/pull/44124)).

You can now **clear session cookies** without clearing [permanent cookies](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/Cookies#removal_defining_the_lifetime_of_a_cookie) by calling [`Site­Data­Manager`](https://doc.servo.org/servo/struct.SiteDataManager.html)::[`clear­_session­_cookies`](https://doc.servo.org/servo/struct.SiteDataManager.html#method.clear_session_cookies) ([@longvatrong111](https://github.com/longvatrong111), [#44166](https://github.com/servo/servo/pull/44166)).

When **intercepting requests** with [`Servo­Delegate`](https://doc.servo.org/servo/trait.ServoDelegate.html):: and [`Web­View­Delegate`](https://doc.servo.org/servo/trait.WebViewDelegate.html)::[`load­_web­_resource`](https://doc.servo.org/servo/trait.WebViewDelegate.html#method.load_web_resource), we now include a [`destination`](https://doc.servo.org/servo/struct.WebResourceRequest.html#structfield.destination) and [`referrer­_url`](https://doc.servo.org/servo/struct.WebResourceRequest.html#structfield.referrer_url) in the [`Web­Resource­Request`](https://doc.servo.org/servo/struct.WebResourceRequest.html), which can be helpful if you’re implementing **ad blocking** ([@webbeef](https://github.com/webbeef), [#44493](https://github.com/servo/servo/pull/44493)).

You can configure Servo to **write all of its storage to a unique directory** for that session by enabling [`Opts`](https://doc.servo.org/servo/struct.Opts.html)::[`temporary­_storage`](https://doc.servo.org/servo/struct.Opts.html#structfield.temporary_storage) ([@janvarga](https://github.com/janvarga), [#44433](https://github.com/servo/servo/pull/44433)).
Note that these unique directories currently persist after Servo exits, so it’s an isolation feature, not a privacy feature.

[`Window­Rendering­Context`](https://doc.servo.org/servo/struct.WindowRenderingContext.html)::[`new`](https://doc.servo.org/servo/struct.WindowRenderingContext.html#method.new) and [`Software­Rendering­Context`](https://doc.servo.org/servo/struct.SoftwareRenderingContext.html)::[`new`](https://doc.servo.org/servo/struct.SoftwareRenderingContext.html#method.new) now return an error if the given `size` is less than 1x1 ([@freyacodes](https://github.com/freyacodes), [@mrobinson](https://github.com/mrobinson), [#44011](https://github.com/servo/servo/pull/44011)).

We’ve improved our API docs for [`Web­View`](https://doc.servo.org/servo/struct.WebView.html), [`Web­View­Builder`](https://doc.servo.org/servo/struct.WebViewBuilder.html), [`Web­View­Delegate`](https://doc.servo.org/servo/trait.WebViewDelegate.html), [`ServoDelegate`](https://doc.servo.org/servo/trait.ServoDelegate.html), [`Prompt­Dialog`](https://doc.servo.org/servo/struct.PromptDialog.html), [`Web­Resource­Load`](https://doc.servo.org/servo/struct.WebResourceLoad.html), [`Web­Xr­Registry`](https://doc.servo.org/servo/webxr/trait.WebXrRegistry.html), [`Preferences`](https://doc.servo.org/servo/struct.Preferences.html), and servoshell’s [`EXPERIMENTAL­_PREFS`](https://doc.servo.org/servoshell/prefs/static.EXPERIMENTAL_PREFS.html) ([@simonwuelker](https://github.com/simonwuelker), [@TG199](https://github.com/TG199), [@sabbCodes](https://github.com/sabbCodes), [@jdm](https://github.com/jdm), [@rovertrack](https://github.com/rovertrack), [#43892](https://github.com/servo/servo/pull/43892), [#43787](https://github.com/servo/servo/pull/43787), [#44171](https://github.com/servo/servo/pull/44171), [#43947](https://github.com/servo/servo/pull/43947)).

We’ve also improved our API docs for [`Opts`](https://doc.servo.org/servo/struct.Opts.html), [`Output­Options`](https://doc.servo.org/servo/enum.OutputOptions.html), [`Diagnostics­Logging`](https://doc.servo.org/servo/struct.DiagnosticsLogging.html), [`Pref­Value`](https://doc.servo.org/servo/enum.PrefValue.html), [`servo`](https://doc.servo.org/servo/index.html)::[`opts`](https://doc.servo.org/servo/opts/index.html), and [`servo­_config`](https://doc.servo.org/servo_config/index.html) ([@mukilan](https://github.com/mukilan), [#43802](https://github.com/servo/servo/pull/43802)).

## More on the web platform

**<kbd>Tab</kbd> navigation** now works across **&lt;iframe>** boundaries ([@mrobinson](https://github.com/mrobinson), [#44397](https://github.com/servo/servo/pull/44397)), and **<kbd>Ctrl</kbd>+<kbd>Backspace</kbd>** (or **<kbd>⌥</kbd><kbd>⌫</kbd>**) now **deletes a whole word** in input fields ([@mrobinson](https://github.com/mrobinson), [#43940](https://github.com/servo/servo/pull/43940)).

**Tab characters** are now rendered correctly in **&lt;pre>** (and other elements with **‘white-space: pre’**), with proper tab stops ([@mrobinson](https://github.com/mrobinson), [@SimonSapin](https://github.com/SimonSapin), [#44480](https://github.com/servo/servo/pull/44480)).
**Spaces** are now rendered correctly in **2D &lt;canvas>**, instead of twice as wide as they should be ([@mrobinson](https://github.com/mrobinson), [#43899](https://github.com/servo/servo/pull/43899)).

**&lt;a href>** now correctly resolves the URL with the page encoding ([@sabbCodes](https://github.com/sabbCodes), [#43822](https://github.com/servo/servo/pull/43822)).

We’ve improved the default appearance of **&lt;input type=file>** ([@sabbCodes](https://github.com/sabbCodes), [#44496](https://github.com/servo/servo/pull/44496)) and **&lt;textarea placeholder>** ([@mrobinson](https://github.com/mrobinson), [#43770](https://github.com/servo/servo/pull/43770)).

All **keyboard events**, **mouse events**, **wheel events**, and **pointer events**, other than **‘pointerenter’** and **‘pointerleave’**, now **bubble out of shadow roots** ([@simonwuelker](https://github.com/simonwuelker), [@webbeef](https://github.com/webbeef), [#43799](https://github.com/servo/servo/pull/43799), [#44094](https://github.com/servo/servo/pull/44094)).
**‘error’ events** on **Window** now report the correct **filename** (**source** in **onerror**) and **lineno** ([@Gae24](https://github.com/Gae24), [#43632](https://github.com/servo/servo/pull/43632)).

**console.log()** and friends now support **printf-style formatting directives**, although for now `%c` is ignored ([@TG199](https://github.com/TG199), [#43897](https://github.com/servo/servo/pull/43897)).

**file: URLs** are now considered **secure contexts**, so they can now use features like **crypto.subtle** and **crypto.random­UUID** ([@simonwuelker](https://github.com/simonwuelker), [#43989](https://github.com/servo/servo/pull/43989)).

**Exception messages** have improved in Location, Static­Range, and the HTML­Element family of types ([@arihant2math](https://github.com/arihant2math), [@MuhammadMouostafa](https://github.com/MuhammadMouostafa), [@treetmitterglad](https://github.com/treetmitterglad), [#44282](https://github.com/servo/servo/pull/44282), [#43260](https://github.com/servo/servo/pull/43260), [#43882](https://github.com/servo/servo/pull/43882)).

We’ve improved the conformance of **fetch algorithms** ([@yezhizhen](https://github.com/yezhizhen), [#43970](https://github.com/servo/servo/pull/43970), [#43798](https://github.com/servo/servo/pull/43798)), **focus** and **tab navigation** ([@mrobinson](https://github.com/mrobinson), [#43842](https://github.com/servo/servo/pull/43842), [#44029](https://github.com/servo/servo/pull/44029), [#44360](https://github.com/servo/servo/pull/44360), [#43859](https://github.com/servo/servo/pull/43859), [#44535](https://github.com/servo/servo/pull/44535)), **form submission** ([@TG199](https://github.com/TG199), [#43700](https://github.com/servo/servo/pull/43700)), **JS modules** ([@elomscansio](https://github.com/elomscansio), [@Gae24](https://github.com/Gae24), [#43741](https://github.com/servo/servo/pull/43741), [#44179](https://github.com/servo/servo/pull/44179), [#44042](https://github.com/servo/servo/pull/44042)), **page navigation** ([@TimvdLippe](https://github.com/TimvdLippe), [#43857](https://github.com/servo/servo/pull/43857)), **&lt;svg view­Box>** ([@yezhizhen](https://github.com/yezhizhen), [#44420](https://github.com/servo/servo/pull/44420)), **‘attr()’** ([@Loirooriol](https://github.com/Loirooriol), [#43878](https://github.com/servo/servo/pull/43878)), **‘:focus’** ([@mrobinson](https://github.com/mrobinson), [#43873](https://github.com/servo/servo/pull/43873)), **‘font’** ([@RichardTjokroutomo](https://github.com/RichardTjokroutomo), [#44061](https://github.com/servo/servo/pull/44061)), **‘@keyframes’** ([@simonwuelker](https://github.com/simonwuelker), [#43461](https://github.com/servo/servo/pull/43461)), **‘@property’** ([@Loirooriol](https://github.com/Loirooriol), [#43878](https://github.com/servo/servo/pull/43878)), **‘load’** events ([@jdm](https://github.com/jdm), [@arabson99](https://github.com/arabson99), [#43807](https://github.com/servo/servo/pull/43807), [#44046](https://github.com/servo/servo/pull/44046)), **fetch­Later()** ([@TimvdLippe](https://github.com/TimvdLippe), [#43627](https://github.com/servo/servo/pull/43627)), **axes** and **buttons** on **Gamepad** ([@log101](https://github.com/log101), [@rovertrack](https://github.com/rovertrack), [#44411](https://github.com/servo/servo/pull/44411), [#44357](https://github.com/servo/servo/pull/44357)), **copy­Tex­Image­2D()** on **Web­GL­Rendering­Context** ([@simartin](https://github.com/simartin), [@mrobinson](https://github.com/mrobinson), [#43608](https://github.com/servo/servo/pull/43608)), **tex­Image3D()** on **Web­GL2­Rendering­Context** ([@simartin](https://github.com/simartin), [#44367](https://github.com/servo/servo/pull/44367)), **environment­Blend­Mode** on **XR­Session** ([@msub2](https://github.com/msub2), [#44155](https://github.com/servo/servo/pull/44155)), **mark()** and **measure()** on **Performance** ([@shubhamg13](https://github.com/shubhamg13), [@simonwuelker](https://github.com/simonwuelker), [#44471](https://github.com/servo/servo/pull/44471), [#44199](https://github.com/servo/servo/pull/44199), [#43990](https://github.com/servo/servo/pull/43990), [#43753](https://github.com/servo/servo/pull/43753)), and **Performance­Resource­Timing** ([@shubhamg13](https://github.com/shubhamg13), [#44228](https://github.com/servo/servo/pull/44228)).

We’ve fixed bugs related to **console logging** ([@sabbCodes](https://github.com/sabbCodes), [#44243](https://github.com/servo/servo/pull/44243)), **‘animation’** ([@mrobinson](https://github.com/mrobinson), [#44299](https://github.com/servo/servo/pull/44299)), **‘box-shadow’** ([@yezhizhen](https://github.com/yezhizhen), [#44474](https://github.com/servo/servo/pull/44474), [#44457](https://github.com/servo/servo/pull/44457)), **‘display: contents’** ([@Loirooriol](https://github.com/Loirooriol), [@mrobinson](https://github.com/mrobinson), [#44551](https://github.com/servo/servo/pull/44551), [#44299](https://github.com/servo/servo/pull/44299)), **‘display: inline-flex’** ([@SimonSapin](https://github.com/SimonSapin), [#44281](https://github.com/servo/servo/pull/44281)), **‘display: table-cell’** ([@Loirooriol](https://github.com/Loirooriol), [#44550](https://github.com/servo/servo/pull/44550)), **‘display: table-row-group’** ([@Veercodeprog](https://github.com/Veercodeprog), [#43674](https://github.com/servo/servo/pull/43674)), **‘overflow-x: clip’** and **‘overflow-y: clip’** ([@Messi002](https://github.com/Messi002), [#43620](https://github.com/servo/servo/pull/43620)), **‘position: absolute’** on grid items ([@nicoburns](https://github.com/nicoburns), [#44324](https://github.com/servo/servo/pull/44324)), **‘word-spacing: &lt;percentage>’** ([@sabbCodes](https://github.com/sabbCodes), [#44031](https://github.com/servo/servo/pull/44031)), **remove­Child()** on **Document** ([@rovertrack](https://github.com/rovertrack), [#44133](https://github.com/servo/servo/pull/44133)), and **URL.revoke­Object­URL()** ([@simonwuelker](https://github.com/simonwuelker), [@jdm](https://github.com/jdm), [#43746](https://github.com/servo/servo/pull/43746), [#43977](https://github.com/servo/servo/pull/43977), [#44035](https://github.com/servo/servo/pull/44035)).

## Performance and stability

We’ve fixed some big inefficiencies in Servo.
**append­Child()** with nested shadow roots is no longer <math><mrow><mi>O</mi><mrow><mo>(</mo><msup><mn>2</mn><mi>n</mi></msup><mo>)</mo></mrow></mrow></math> ([@yezhizhen](https://github.com/yezhizhen), [@webbeef](https://github.com/webbeef), [#44016](https://github.com/servo/servo/pull/44016)), and we’ve halved the time it takes to load [the ECMAScript spec](https://262.ecma-international.org/16.0/index.html) by fixing the <math><mrow><mi>O</mi><mrow><mo>(</mo><mtext>whole DOM tree</mtext><mo>)</mo></mrow></mrow></math> processing of **‘id’** and **‘name’ attributes** ([@simonwuelker](https://github.com/simonwuelker), [#44120](https://github.com/servo/servo/pull/44120), [#44127](https://github.com/servo/servo/pull/44127), [#44117](https://github.com/servo/servo/pull/44117)).

Servo makes its **first TLS connection** in each session **30–60 ms faster** ([@jschwe](https://github.com/jschwe), [#44242](https://github.com/servo/servo/pull/44242)), and we’ve instrumented the Servo and servoshell startup processes to find more opportunities for optimisation ([@jschwe](https://github.com/jschwe), [#44443](https://github.com/servo/servo/pull/44443), [#44456](https://github.com/servo/servo/pull/44456)).

Like most browser engines, Servo is a multi-threaded (and sometimes multi-process) system requiring a great deal of IPC messages to keep everything connected.
[Two key components](https://book.servo.org/design-documentation/architecture.html) of this system are the **constellation** thread, which manages the engine as a whole, and the **script threads** (or web processes), which render the web pages.
Sending these messages can be expensive though, so to **reduce unnecessary IPC traffic**, we’ve landed an optimisation that allows script threads to selectively receive only the relevant messages from the constellation ([@webbeef](https://github.com/webbeef), [#43124](https://github.com/servo/servo/pull/43124)).

We’ve reduced the **memory usage** of each **Attr**, **Text**, and **Character­Data** node in the DOM by 16 bytes ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#44074](https://github.com/servo/servo/pull/44074)), and **fixed a memory leak** when deleting **&lt;video controls>** or **&lt;audio controls>** ([@Messi002](https://github.com/Messi002), [#43983](https://github.com/servo/servo/pull/43983)).

Our **about:memory** page is more accurate now too, with new tracking of **libc memory allocations** on macOS, improved tracking of libc memory allocations on Linux ([@jschwe](https://github.com/jschwe), [#44037](https://github.com/servo/servo/pull/44037)), and more accurate tracking of Path­Buf and types in `tokio`, `http`, `data­_url`, and `urlpattern` ([@Narfinger](https://github.com/Narfinger), [#43858](https://github.com/servo/servo/pull/43858)).

Less memory usage isn’t always better in browser engines though, because there are many kinds of caches and other optimisations we can do to make browsing the web faster, at the expense of increased memory usage.
For example, we can greatly speed up **prototype checks** for DOM objects by storing a number in each object that identifies the concrete type, at the expense of making each DOM object 64 bits larger ([@webbeef](https://github.com/webbeef), [#44364](https://github.com/servo/servo/pull/44364)).

Layout can now **reuse fragments** in later reflows, in many cases that involve block layout or ‘position: absolute’ ([@mrobinson](https://github.com/mrobinson), [@lukewarlow](https://github.com/lukewarlow), [@Loirooriol](https://github.com/Loirooriol), [#42904](https://github.com/servo/servo/pull/42904), [#44231](https://github.com/servo/servo/pull/44231)).
We’re also working on **reusing shaping results** in later reflows, and making inline layout more efficient ([@mrobinson](https://github.com/mrobinson), [#44370](https://github.com/servo/servo/pull/44370), [#43974](https://github.com/servo/servo/pull/43974), [#44436](https://github.com/servo/servo/pull/44436)).

We’ve landed several changes that should reduce the **binary size** of Servo ([@rovertrack](https://github.com/rovertrack), [@mrobinson](https://github.com/mrobinson), [@nicoburns](https://github.com/nicoburns), [@Narfinger](https://github.com/Narfinger), [#44227](https://github.com/servo/servo/pull/44227), [#44221](https://github.com/servo/servo/pull/44221), [#44303](https://github.com/servo/servo/pull/44303), [#44338](https://github.com/servo/servo/pull/44338), [#44428](https://github.com/servo/servo/pull/44428), [#44134](https://github.com/servo/servo/pull/44134)).

We’ve also reduced clones, allocations, borrow checks, GC rooting steps, and other operations in many parts of Servo ([@rovertrack](https://github.com/rovertrack), [@Narfinger](https://github.com/Narfinger), [@Loirooriol](https://github.com/Loirooriol), [@yezhizhen](https://github.com/yezhizhen), [@simonwuelker](https://github.com/simonwuelker), [#44008](https://github.com/servo/servo/pull/44008), [#44544](https://github.com/servo/servo/pull/44544), [#44271](https://github.com/servo/servo/pull/44271), [#44279](https://github.com/servo/servo/pull/44279), [#43826](https://github.com/servo/servo/pull/43826), [#44052](https://github.com/servo/servo/pull/44052), [#44139](https://github.com/servo/servo/pull/44139)).

Several crashes have been fixed:

- in compressed­Tex­Sub­Image2D() on Web­GL­Rendering­Context ([@thebabalola](https://github.com/thebabalola), #44050)
- in console.log() ([@thebabalola](https://github.com/thebabalola), [#43844](https://github.com/servo/servo/pull/43844))
- in get­Data() on Data­Transfer ([@SimonSapin](https://github.com/SimonSapin), [#44607](https://github.com/servo/servo/pull/44607))
- in remove() on Element ([@SimonSapin](https://github.com/SimonSapin), [#44435](https://github.com/servo/servo/pull/44435))
- in replace­With() on Element ([@yezhizhen](https://github.com/yezhizhen), [#44503](https://github.com/servo/servo/pull/44503))
- in `--debug-mozjs` builds ([@jdm](https://github.com/jdm), [#44386](https://github.com/servo/servo/pull/44386), [#44573](https://github.com/servo/servo/pull/44573), [#44581](https://github.com/servo/servo/pull/44581))
- in flex and grid layout ([@mrobinson](https://github.com/mrobinson), [@nicoburns](https://github.com/nicoburns), [#44424](https://github.com/servo/servo/pull/44424), [#44203](https://github.com/servo/servo/pull/44203))
- in layout queries like `offset­Height` ([@mrobinson](https://github.com/mrobinson), [#44560](https://github.com/servo/servo/pull/44560))
- in the devtools Debugger tab, when stepping and when inspecting nested values ([@atbrakhi](https://github.com/atbrakhi), [@eerii](https://github.com/eerii), [#44024](https://github.com/servo/servo/pull/44024), [#43995](https://github.com/servo/servo/pull/43995))
- when removing &lt;colgroup> from the DOM ([@Loirooriol](https://github.com/Loirooriol), [#43846](https://github.com/servo/servo/pull/43846))
- when running garbage collection ([@drasticactions](https://github.com/drasticactions), [#43933](https://github.com/servo/servo/pull/43933))
- when running servoshell with a [`u64`](https://doc.rust-lang.org/1.88.0/std/primitive.u64.html) `--pref` ([@yezhizhen](https://github.com/yezhizhen), [#44079](https://github.com/servo/servo/pull/44079))
- when shadow roots are deeply nested, or when calling attach­Shadow() removes elements from the flat tree ([@yezhizhen](https://github.com/yezhizhen), [@mrobinson](https://github.com/mrobinson), [#43888](https://github.com/servo/servo/pull/43888), [#43930](https://github.com/servo/servo/pull/43930), [#44259](https://github.com/servo/servo/pull/44259))
- when [web storage features](https://storage.spec.whatwg.org) fail to write to disk or encounter SQLite errors ([@arihant2math](https://github.com/arihant2math), [@sabbCodes](https://github.com/sabbCodes), [#43918](https://github.com/servo/servo/pull/43918), [#43949](https://github.com/servo/servo/pull/43949))

We fixed a crash in servoshell when pressing keys like Ctrl+2 or ⌘2 with not enough tabs open ([@mrobinson](https://github.com/mrobinson), [#44070](https://github.com/servo/servo/pull/44070)).

**DOM data structures** (`#[dom­_struct]`) can refer to one another, with the help of [garbage collection](https://research.mozilla.org/2014/08/26/javascript-servos-only-garbage-collector/).
But when DOM objects are being destroyed, those references can become invalid for a brief moment, depending on the order the GC finalizers run in.
This can be unsound if those references are accessed, which is a very easy mistake to make if the type has an `impl Drop`.
To help prevent that class of bug, we’re reworking our DOM types so that none of them have `#[dom­_struct]` and `impl Drop` at the same time ([@willypuzzle](https://github.com/willypuzzle), [#44119](https://github.com/servo/servo/pull/44119), [#44501](https://github.com/servo/servo/pull/44501), [#44513](https://github.com/servo/servo/pull/44513)).

We’ve improved our static analysis for GC rooting ([@officialasishkumar](https://github.com/officialasishkumar), [#44489](https://github.com/servo/servo/pull/44489)), and we’ve continued our long-running effort to **use the Rust type system** to make certain kinds of dynamic borrow failures impossible ([@sagudev](https://github.com/sagudev), [@TimvdLippe](https://github.com/TimvdLippe), [@Narfinger](https://github.com/Narfinger), [@elomscansio](https://github.com/elomscansio), [@Gae24](https://github.com/Gae24), [@rovertrack](https://github.com/rovertrack), [@yezhizhen](https://github.com/yezhizhen), [@nodelpit](https://github.com/nodelpit), [#43174](https://github.com/servo/servo/pull/43174), [#43524](https://github.com/servo/servo/pull/43524), [#43928](https://github.com/servo/servo/pull/43928), [#43943](https://github.com/servo/servo/pull/43943), [#43942](https://github.com/servo/servo/pull/43942), [#43944](https://github.com/servo/servo/pull/43944), [#43946](https://github.com/servo/servo/pull/43946), [#43952](https://github.com/servo/servo/pull/43952), [#43975](https://github.com/servo/servo/pull/43975), [#44018](https://github.com/servo/servo/pull/44018), [#44175](https://github.com/servo/servo/pull/44175), [#44241](https://github.com/servo/servo/pull/44241), [#44368](https://github.com/servo/servo/pull/44368), [#44406](https://github.com/servo/servo/pull/44406), [#44441](https://github.com/servo/servo/pull/44441), [#44422](https://github.com/servo/servo/pull/44422), [#44475](https://github.com/servo/servo/pull/44475), [#44478](https://github.com/servo/servo/pull/44478), [#44484](https://github.com/servo/servo/pull/44484), [#44476](https://github.com/servo/servo/pull/44476), [#44490](https://github.com/servo/servo/pull/44490), [#44477](https://github.com/servo/servo/pull/44477), [#44494](https://github.com/servo/servo/pull/44494), [#44497](https://github.com/servo/servo/pull/44497), [#44498](https://github.com/servo/servo/pull/44498), [#44495](https://github.com/servo/servo/pull/44495), [#44505](https://github.com/servo/servo/pull/44505), [#44506](https://github.com/servo/servo/pull/44506), [#44507](https://github.com/servo/servo/pull/44507), [#44508](https://github.com/servo/servo/pull/44508), [#44509](https://github.com/servo/servo/pull/44509), [#44510](https://github.com/servo/servo/pull/44510), [#44512](https://github.com/servo/servo/pull/44512), [#44482](https://github.com/servo/servo/pull/44482), [#44527](https://github.com/servo/servo/pull/44527), [#44528](https://github.com/servo/servo/pull/44528), [#44531](https://github.com/servo/servo/pull/44531), [#44534](https://github.com/servo/servo/pull/44534), [#44542](https://github.com/servo/servo/pull/44542), [#44533](https://github.com/servo/servo/pull/44533), [#44543](https://github.com/servo/servo/pull/44543), [#44553](https://github.com/servo/servo/pull/44553), [#44547](https://github.com/servo/servo/pull/44547), [#44563](https://github.com/servo/servo/pull/44563), [#44562](https://github.com/servo/servo/pull/44562), [#44565](https://github.com/servo/servo/pull/44565), [#44558](https://github.com/servo/servo/pull/44558), [#44583](https://github.com/servo/servo/pull/44583), [#44606](https://github.com/servo/servo/pull/44606), [#44605](https://github.com/servo/servo/pull/44605), [#44608](https://github.com/servo/servo/pull/44608), [#44602](https://github.com/servo/servo/pull/44602), [#44584](https://github.com/servo/servo/pull/44584), [#44620](https://github.com/servo/servo/pull/44620), [#44590](https://github.com/servo/servo/pull/44590), [#44254](https://github.com/servo/servo/pull/44254), [#44628](https://github.com/servo/servo/pull/44628), [#44629](https://github.com/servo/servo/pull/44629), [#44638](https://github.com/servo/servo/pull/44638), [#44626](https://github.com/servo/servo/pull/44626), [#44081](https://github.com/servo/servo/pull/44081)).

Thanks to a wide range of people, we’ve also landed a bunch of cleanups and refactors ([@delan](https://github.com/delan), [@alice](https://github.com/alice), [@Skgland](https://github.com/Skgland), [@atbrakhi](https://github.com/atbrakhi), [@eerii](https://github.com/eerii), [@sabbCodes](https://github.com/sabbCodes), [@jdm](https://github.com/jdm), [@thebabalola](https://github.com/thebabalola), [@CynthiaOketch](https://github.com/CynthiaOketch), [@kkoyung](https://github.com/kkoyung), [@TimvdLippe](https://github.com/TimvdLippe), [@rovertrack](https://github.com/rovertrack), [@webbeef](https://github.com/webbeef), [@arabson99](https://github.com/arabson99), [@yezhizhen](https://github.com/yezhizhen), [@simonwuelker](https://github.com/simonwuelker), [@mrobinson](https://github.com/mrobinson), [@nicoburns](https://github.com/nicoburns), [@longvatrong111](https://github.com/longvatrong111), [@niyabits](https://github.com/niyabits), [@treetmitterglad](https://github.com/treetmitterglad), [@foresterre](https://github.com/foresterre), [@mukilan](https://github.com/mukilan), [@elomscansio](https://github.com/elomscansio), [@freyacodes](https://github.com/freyacodes), [@StaySafe020](https://github.com/StaySafe020), [@TG199](https://github.com/TG199), [#43772](https://github.com/servo/servo/pull/43772), [#44006](https://github.com/servo/servo/pull/44006), [#43860](https://github.com/servo/servo/pull/43860), [#44121](https://github.com/servo/servo/pull/44121), [#44160](https://github.com/servo/servo/pull/44160), [#43884](https://github.com/servo/servo/pull/43884), [#44154](https://github.com/servo/servo/pull/44154), [#44569](https://github.com/servo/servo/pull/44569), [#43939](https://github.com/servo/servo/pull/43939), [#44003](https://github.com/servo/servo/pull/44003), [#44110](https://github.com/servo/servo/pull/44110), [#44122](https://github.com/servo/servo/pull/44122), [#43824](https://github.com/servo/servo/pull/43824), [#44635](https://github.com/servo/servo/pull/44635), [#44103](https://github.com/servo/servo/pull/44103), [#43978](https://github.com/servo/servo/pull/43978), [#44092](https://github.com/servo/servo/pull/44092), [#44114](https://github.com/servo/servo/pull/44114), [#44277](https://github.com/servo/servo/pull/44277), [#44454](https://github.com/servo/servo/pull/44454), [#44274](https://github.com/servo/servo/pull/44274), [#44237](https://github.com/servo/servo/pull/44237), [#44232](https://github.com/servo/servo/pull/44232), [#44167](https://github.com/servo/servo/pull/44167), [#44214](https://github.com/servo/servo/pull/44214), [#43820](https://github.com/servo/servo/pull/43820), [#43825](https://github.com/servo/servo/pull/43825), [#43810](https://github.com/servo/servo/pull/43810), [#43838](https://github.com/servo/servo/pull/43838), [#43841](https://github.com/servo/servo/pull/43841), [#43847](https://github.com/servo/servo/pull/43847), [#43875](https://github.com/servo/servo/pull/43875), [#43876](https://github.com/servo/servo/pull/43876), [#43889](https://github.com/servo/servo/pull/43889), [#43893](https://github.com/servo/servo/pull/43893), [#43896](https://github.com/servo/servo/pull/43896), [#43881](https://github.com/servo/servo/pull/43881), [#43906](https://github.com/servo/servo/pull/43906), [#43913](https://github.com/servo/servo/pull/43913), [#43908](https://github.com/servo/servo/pull/43908), [#43917](https://github.com/servo/servo/pull/43917), [#43910](https://github.com/servo/servo/pull/43910), [#43921](https://github.com/servo/servo/pull/43921), [#43924](https://github.com/servo/servo/pull/43924), [#43925](https://github.com/servo/servo/pull/43925), [#43907](https://github.com/servo/servo/pull/43907), [#43923](https://github.com/servo/servo/pull/43923), [#43916](https://github.com/servo/servo/pull/43916), [#43909](https://github.com/servo/servo/pull/43909), [#43911](https://github.com/servo/servo/pull/43911), [#43957](https://github.com/servo/servo/pull/43957), [#43969](https://github.com/servo/servo/pull/43969), [#43967](https://github.com/servo/servo/pull/43967), [#43915](https://github.com/servo/servo/pull/43915), [#43954](https://github.com/servo/servo/pull/43954), [#43963](https://github.com/servo/servo/pull/43963), [#43959](https://github.com/servo/servo/pull/43959), [#43955](https://github.com/servo/servo/pull/43955), [#44067](https://github.com/servo/servo/pull/44067), [#44068](https://github.com/servo/servo/pull/44068), [#44071](https://github.com/servo/servo/pull/44071), [#44084](https://github.com/servo/servo/pull/44084), [#44265](https://github.com/servo/servo/pull/44265), [#44115](https://github.com/servo/servo/pull/44115), [#44358](https://github.com/servo/servo/pull/44358), [#43848](https://github.com/servo/servo/pull/43848)).

## Donations

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
