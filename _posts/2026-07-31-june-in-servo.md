---
layout:     post
tags:       blog
title:      "June in Servo: and more!"
date:       2026-07-31
summary:    ao!! wrrrrao!!
categories:
---

[**Servo 0.4.0**](https://github.com/servo/servo/releases/tag/v0.4.0) contains all of the changes we landed in May, which came out to yet another record **558 commits** (April: 534, May: 391).
For security fixes, see [**§ Security**](#security).

We’ve shipped several new web platform features:

- **‘attr()’**, in [experimental mode](https://book.servo.org/design-documentation/experimental-features.html#experimental-web-platform-features) (@Loirooriol, #45041)
- **‘image(&lt;color>)’**, **‘closest-corner’**, and **‘farthest-corner’** in **‘ellipse()’** and **‘circle()’** (@Loirooriol, #45421)
- **‘calc()’** and other [mathematical expressions](https://drafts.csswg.org/css-values/#math) can now be resolved later than parse time, e.g. `sign(1em - 32px)` (@Loirooriol, #45421)
- **‘&#x40;media (device-width)’**, **‘&#x40;media (device-height)’**, **‘&#x40;media (height)’**, **‘&#x40;media (aspect-ratio)’**, and their **min-** and **max-** variants (@jdm, @mrobinson, @nicoburns, @jschwe, #44978, #45707, #45490)
- **‘&#x40;media (orientation)’** (@nicoburns, #45707)
- **‘&#x40;media (pointer)’** and **‘&#x40;media (any-pointer)’** (@nicoburns, #45681)
- **‘&#x40;media (hover)’** and **‘&#x40;media (any-hover)’** (@nicoburns, #45681)

Plus a bunch of new DOM APIs:

- **Shared­Worker** (@Taym95, #45786)
- **custom­Element­Registry** on **Document** and **Shadow­Root** (@shubhamg13, #45872)
- **initialize()** on **Custom­Element­Registry** (@shubhamg13, @yezhizhen, #45903)
- **new Custom­Element­Registry()** (@shubhamg13, #45791)
- **text­Stream()** on **Request**, **Response**, and **Blob** (@yezhizhen, #45864, #45861)
- **set­Pointer­Capture()**, **release­Pointer­Capture()**, **has­Pointer­Capture()** on **Element** (@webbeef, #45048)
- **on­touch­start**, **on­touch­end**, **on­touch­move**, **on­touch­cancel** on **Element** (@stevennovaryo, #45049)
- **crypto­.subtle­.digest()** for **KT128** and **KT256** (@kkoyung, #45699)
- **crypto­.subtle­.get­Public­Key()** for **ML-KEM** and **ML-DSA** (@kkoyung, #45252)

This is another big update, so here’s an outline:

- [**You can help!**](#you-can-help)<br>– how to help us write the monthly updates

- [**Security**](#security)<br>– memory safety fixes

- [**Work in progress**](#work-in-progress)<br>– …

- [**Embedding API**](#embedding-api)<br>– …

- [**More on the web platform**](#more-on-the-web-platform)<br>– …

- [**Garbage collection safety**](#garbage-collection-safety)<br>– …

- [**Performance and stability**](#performance-and-stability)<br>– …

- [**New contributors**](#new-contributors)<br>– 21 new contributors in June

## You can help!

Servo is steadily becoming a bigger and busier project every month, and by June 2026, we’ve been reading through **over four times** the commits as we did when we started in September 2023.

<figure>
    <a href="{{ '/img/blog/2026-07-commits.png' | url }}"><img src="{{ '/img/blog/2026-07-commits.png' | url }}" alt="line chart showing how many commits landed in Servo’s main repo each month from September 2023 to June 2026 inclusive. there’s a clear linear trend, from 130 commits up to 551 commits"></a>
</figure>

This is hard work, particularly since there are things we need to know that are often difficult to answer just by reading the changes:

- **Who does the change affect**, if anyone? Does it affect users, Servo developers, embedders, or some other group?

- **What observable difference does the change make**, if any?

- **Does the feature require any preferences to be enabled**, or is it enabled for everyone by default?

- **Are any real-world websites affected by the change?**

- **What issue or broader project is the change related to?** This question is answered by `Fixes: #xxxxx` or `Part of: #xxxxx` in the PR description.

Thanks to an initiative by @jdm, it’s now easier than ever for you to **help us answer those questions**, using the Servo Highfive bot!
If you’re working on a pull request that you think might be interesting for the next monthly update, even if you’re not 100% sure, tell us about it by following the steps below:

1. You add the <span style="padding: 0.1875lh; border-radius: calc(0.5lh + 2 * 1px); background: rgb(13, 17, 23);"><span style="padding: 0 0.25lh; border: thin solid rgba(85, 221, 126, 0.3); border-radius: 0.5lh; color: rgb(85, 221, 126); background-color: rgba(84, 222, 126, 0.18);">monthly update</span></span> label to your pull request, or comment <code style="display: /* allow wrapping only as last resort */ inline-block;">@servo-highfive monthly update</code>

2. Highfive posts a comment asking you some questions

3. You answer those questions in a comment containing <code style="display: /* allow wrapping only as last resort */ inline-block;">@servo-highfive monthly update answer</code>

## Security

Servo’s JS runtime, **SpiderMonkey 140.10.1**, had several **security bugs** that have been fixed in Servo 0.4.0 with the update to SpiderMonkey 140.11.0 (@jschwe, #45584).
For more details, see [CVE-2026-8388](https://nvd.nist.gov/vuln/detail/CVE-2026-8388), [CVE-2026-8391](https://nvd.nist.gov/vuln/detail/CVE-2026-8391), [CVE-2026-8974](https://nvd.nist.gov/vuln/detail/CVE-2026-8974), [CVE-2026-8975](https://nvd.nist.gov/vuln/detail/CVE-2026-8975), and [MFSA 2026-48](https://www.mozilla.org/en-US/security/advisories/mfsa2026-48/).

Several more **security bugs** in Servo’s JS runtime have been fixed in Servo 0.4.0 with the update to SpiderMonkey 140.12.0 (@jschwe, #45766).
The exact CVEs that apply to us are not yet known, but for more details, see [MFSA 2026-58](https://www.mozilla.org/en-US/security/advisories/mfsa2026-58/).

**RSA** operations in **Subtle­Crypto** now do modular exponentiation in constant time (@kkoyung, #45631).
Please note that our RSA implementation is currently vulnerable to the [Marvin Attack](https://people.redhat.com/~hkario/marvin/) – for more details, see [RUSTSEC-2023-0071](https://rustsec.org/advisories/RUSTSEC-2023-0071.html).

**ML-DSA** operations in **Subtle­Crypto** now do the Decompose step in constant time, fixing [RUSTSEC-2025-0144](https://rustsec.org/advisories/RUSTSEC-2025-0144.html) (@kkoyung, #45294).

We’ve fixed an HTML injection bug (XSS) in **file:/// directory listings**, which affected file names containing `</script>` (@sahvx655-wq, #45510).

## Work in progress

We’re implementing the more powerful version of **‘attr()’** that can be used anywhere, not just in ‘content’, under `--pref layout­_css­_attr­_enabled` (@Loirooriol, #45041, #45421, #45495, #45752).

All of the features above are enabled in servoshell’s [experimental mode](https://book.servo.org/design-documentation/experimental-features.html#experimental-web-platform-features).

Rust doesn’t have a stable [ABI](https://en.wikipedia.org/wiki/Application_binary_interface), so it has generally not been possible to embed Servo in another application without building Servo from source.
To make it possible, we’ve started designing a **wrapper C API** that will let you consume Servo as a prebuilt shared library using the stable and ubiquitous C ABI (@mukilan, #44984).
Eventually the idea is that we’ll create a wrapper Rust API around *that* wrapper C API, so you can have both the ergonomics of Rust *and* the build simplicity of C.

## Embedding API

New in the [**Servo API**](https://doc.servo.org/servo/):

- [`Web­View`](https://doc.servo.org/servo/struct.WebView.html)::[`rendering­_context`](https://doc.servo.org/servo/struct.WebView.html#method.rendering_context) (@mrobinson, #46047)

Breaking changes:

- [`Web­View`](https://doc.servo.org/servo/struct.WebView.html)::`send­_error` has been removed (@mukilan, #45502) – this method was always meant to be internal, and has become unused after we introduced the new Web­View- and Web­View­Delegate-based API

We’ve improved the docs for Web­View, Web­View­Delegate, JS­Value, Alert­Dialog, Allow­Or­Deny­Request, Authentication­Response, Bluetooth­Device­Description, Confirm­Dialog, Console­Log­Level, Create­New­Web­View­Request, Embedder­Control, Embedder­Control­Response, File­Picker, Image, Java­Script­Error­Info, Navigation­Request, Permission­Request, Pixel­Format, Prompt­Dialog, Protocol­Handler­Registration, Protocol­Handler­Update­Registration, Scroll, Select­Element, Select­Element­Request, and Web­View­Vector (@mukilan, #45282, #45467).

## More on the web platform

We’ve improved the conformance of **&lt;dialog>** (@skyz1, #45825), **&lt;iframe sandbox>** (@cychronex-labs, #45880), **&lt;input minlength>** and **&lt;input maxlength>** (@skyz1, #45705), **‘font-style’** and **‘unicode-range’** in **‘@font-face’** (@Loirooriol, #45821), **HTML­Input­Element** (@steigeo, #45416), **new Response()** (@yezhizhen, #45953), **URL.create­Object­URL()** and **URL.revoke­Object­URL()** (@yezhizhen, #45182, #45417), and **ECDSA** and **Ed25519** in **Subtle­Crypto** (@kkoyung, #45833, #46017).

We’ve fixed bugs related to **‘animation­iteration’ events** (@Loirooriol, #45990), **‘click’ events** (@mrobinson, #45751), **‘error’ events** in Worker global scopes (@Gae24, #45829), and […].

## Garbage collection safety

We use a [**RefCell**-based mechanism](https://doc.servo.org/script_bindings/cell/struct.DomRefCell.html) to store many of our DOM types in other DOM types, enforcing Rust’s “aliasing xor mutability” rule at runtime by panicking if the rule is violated.
But when garbage collection happens, we need to [borrow()](https://doc.servo.org/script_bindings/cell/struct.DomRefCell.html#method.borrow) each DomRefCell to trace the references, and this is the source of many panic bugs.
To fix that whole class of bugs, we initially created **CanGc**, a marker type that would annotate the code paths where GC can occur, in conjunction with custom static analysis (@jdm, #33140).

With the Rust type system we can do even better, if we flip that around and require any [borrow\_mut()](https://doc.servo.org/script_bindings/cell/struct.DomRefCell.html#method.borrow_mut) call to prove that GC can *not* occur by passing a **NoGC** marker value.
We can then require that a `&NoGC` must be borrowed from a `&JSContext` (which blocks GC) and not a `&mut JSContext` (which allows GC), taking advantage of how Rust references work without needing any custom static analysis.

We have a large codebase that needs to be migrated in parts, so for now we’ve created the new method [safe­\_borrow­\_mut()](https://doc.servo.org/script_bindings/cell/struct.DomRefCell.html#method.safe_borrow_mut) (@sagudev, #46050).
We also need to update all of our script-related code to borrow our [safe JSContext wrapper](https://doc.servo.org/script_bindings/import/base/struct.JSContext.html), rather than creating an owned JSContext on the spot.

This continues our long-running effort to **use the Rust type system** to make Servo’s integration with SpiderMonkey safer and more reliable (@Gae24, @Keerti707, @Narfinger, @TimvdLippe, @sagudev, @guptapiyush16, @ivomurrell, @kunalmohan, @skyz1, #45230, #45436, #45503, #45617, #45711, #45797, #45800, #45858, #45884, #45937, #45902, #45968, #45977, #45991, #46003, #46005, #46084, #45548, #45552, #45590, #45909, #45912, #45943, #46089, #46117, #46114, #45320, #45324, #45328, #45340, #45381, #45385, #45410, #45392, #45409, #45604, #45616, #45618, #45627, #45636, #45662, #45663, #45675, #45674, #45677, #45684, #45735, #45807, #45810, #45816, #45818, #45828, #45838, #45836, #45837, #45840, #45841, #45857, #45859, #45862, #45875, #45887, #45931, #45964, #45935, #45987, #45988, #46001, #46040, #46051, #46057, #46106, #46125, #45678, #46002, #45845, #45645, #45673, #45259, #45817, #45822, #45876, #45877, #45891).

## Performance and stability

**NoGC** was designed to prevent dynamic borrow failures, but it also enables some performance optimisations!
If we can prove that garbage collection is impossible in some part of Servo, we can often **avoid rooting JavaScript objects** when interacting with them within that region of code.
This has allowed us to reduce overheads by over 1% in the **layout** process and in **HTML­Collection** (@Narfinger, #46092, #45582).

For several months, Frédéric (@fred-wang) has been [**fuzzing**](https://en.wikipedia.org/wiki/Fuzzing) for Servo bugs, and thanks to his work we’ve fixed sixteen (16) **crash bugs** in June, affecting **&lt;link onerror>**, **‘animation’**, **‘clip-path’**, **‘content’**, **‘rotate’**, **‘transition’**, **‘transform-style’**, **‘display: contents’**, **‘overflow: clip’**, **CSS­Keyframes­Rule**, **Font­Face**, **stop() on Window**, and the **DOM tree** (@mrobinson, @Loirooriol, #46031, #46027, #46054, #46058, #46016, #46028, #46033, #45287, #45951, #45634, #45629, #46110, #46094, #45799, #45611, #45682).

## New contributors

A special thanks to the following people for landing their first patch in Servo:

- Deepam Goyal (@Deepam02, #44836)
- Mark (@Mark-Boger, #45486)
- Mr SheerLuck (@MrSheerluck, #45557)
- Psychpsyo (Cameron) (@Psychpsyo, #45494)
- TusharSariya (@TusharSariya, #43663)
- Adam Sharif (@adamsharifc, #45551)
- Akash Ravikumar (@ak4shravikumar, #45736)
- Sean Cunneen (@alexcat3, #45419)
- Abdul Wahab Melethil Shibu (@cychronex-labs, #45880)
- darkdragon-001 (@darkdragon-001, #45267)
- Frédéric Wang Nélar (@fred-wang, #45834)
- fxzjshm (@fxzjshm, #45285)
- Piyush Gupta (@guptapiyush16, #45845)
- Ivo Murrell (@ivomurrell, #45645)
- rhit-kapilaar (@rhit-kapilaar, #45556)
- sahvx655-wq (@sahvx655-wq, #45510)
- Kagami Sascha Rosylight (@saschanaz, #45731)
- shangguanmachine-dot (@shangguanmachine-dot, #45310)
- Glenn Skrzypczak (@skyz1, #45471)
- Oskar Steiger (@steigeo, #45416)
- Veyndan Stuart (@veyndan, #45326)

Interested in helping build a web browser?
Take a look at our [curated list](https://starters.servo.org) of issues that are good for new contributors!

## Donations

<!--
7681.89/month total donations
- 3470.90/month opencollective
- 4065.00/month github
- 35 donors 145.99/month thanks.dev
-->

Thanks again for your generous support!
We are now receiving **7681 USD/month** (+0.2% from May) in recurring donations.
This helps us cover the cost of our **[speedy](https://ci0.servo.org) [CI](https://ci1.servo.org) [and](https://ci2.servo.org) [benchmarking](https://ci3.servo.org) [servers](https://ci4.servo.org)**, one of our latest **[Outreachy interns](https://www.outreachy.org/alums/2026-05/#:~:text=Servo)**, and funding **[maintainer work]({{ '/blog/2025/09/17/your-donations-at-work-funding-jdm/' | url }})** that helps more people contribute to Servo.

Servo is also on [thanks.dev](https://thanks.dev), and already **35 GitHub users** (same as May) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

We now have [**sponsorship tiers**]({{ '/blog/2025/11/21/sponsorship-tiers/' | url }}) that allow you or your organisation to donate to the Servo project with public acknowlegement of your support.
If you’re interested in this kind of sponsorship, please contact us at [join@servo.org](mailto:join@servo.org).

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; right: calc(100% - 100% * 7681 / 10000); padding-right: 0.5em;"><strong>7681</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 7681 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="7681" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
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
