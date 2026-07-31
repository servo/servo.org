---
layout:     post
tags:       blog
title:      "June in Servo: real world compat, media queries, SharedWorker, and more!"
date:       2026-07-31
summary:    We now have a new way for you to help us write the monthly updates :)
categories:
---

[**Servo 0.4.0**](https://github.com/servo/servo/releases/tag/v0.4.0) contains all of the changes we landed in June, which came out to yet another record **558 commits** (April: 534, May: 391).
For security fixes, see [**§ Security**](#security).

<figure>
    <a href="{{ '/img/blog/2026-07-diffie.png' | url }}"><img src="{{ '/img/blog/2026-07-diffie.png' | url }}" alt="servoshell 0.4.0 showing several new features: the ‘width’, ‘height’, ‘device-width’, ‘device-height’, and ‘aspect-ratio’ media query features, plus the upgraded ‘attr()’ function, with a box whose ‘background-color’ and ‘width’ are controlled by data attributes that are in turn set by range inputs"></a>
</figure>

We’ve shipped several new web platform features:

- **‘attr()’**, in [experimental mode](https://book.servo.org/design-documentation/experimental-features.html#experimental-web-platform-features) ([@Loirooriol](https://github.com/Loirooriol), [#45041](https://github.com/servo/servo/pull/45041))
- **‘image(&lt;color>)’**, **‘closest-corner’**, and **‘farthest-corner’** in **‘ellipse()’** and **‘circle()’** ([@Loirooriol](https://github.com/Loirooriol), [#45421](https://github.com/servo/servo/pull/45421))
- **‘calc()’** and other [mathematical expressions](https://drafts.csswg.org/css-values/#math) can now be resolved later than parse time, e.g. `sign(1em - 32px)` ([@Loirooriol](https://github.com/Loirooriol), [#45421](https://github.com/servo/servo/pull/45421))
- **‘&#x40;media (device-width)’**, **‘&#x40;media (device-height)’**, **‘&#x40;media (height)’**, **‘&#x40;media (aspect-ratio)’**, and their **min-** and **max-** variants ([@jdm](https://github.com/jdm), [@mrobinson](https://github.com/mrobinson), [@nicoburns](https://github.com/nicoburns), [@jschwe](https://github.com/jschwe), [#44978](https://github.com/servo/servo/pull/44978), [#45707](https://github.com/servo/servo/pull/45707), [#45490](https://github.com/servo/servo/pull/45490))
- **‘&#x40;media (orientation)’** ([@nicoburns](https://github.com/nicoburns), [#45707](https://github.com/servo/servo/pull/45707))
- **‘&#x40;media (pointer)’** and **‘&#x40;media (any-pointer)’** ([@nicoburns](https://github.com/nicoburns), [#45681](https://github.com/servo/servo/pull/45681))
- **‘&#x40;media (hover)’** and **‘&#x40;media (any-hover)’** ([@nicoburns](https://github.com/nicoburns), [#45681](https://github.com/servo/servo/pull/45681))

Plus a bunch of new DOM APIs:

- **Shared­Worker** ([@Taym95](https://github.com/Taym95), [#45786](https://github.com/servo/servo/pull/45786))
- **console­.dir()** ([@Taym95](https://github.com/Taym95), [#45109](https://github.com/servo/servo/pull/45109))
- **custom­Element­Registry** on **Document** and **Shadow­Root** ([@shubhamg13](https://github.com/shubhamg13), [#45872](https://github.com/servo/servo/pull/45872))
- **initialize()** on **Custom­Element­Registry** ([@shubhamg13](https://github.com/shubhamg13), [@yezhizhen](https://github.com/yezhizhen), [#45903](https://github.com/servo/servo/pull/45903))
- **new Custom­Element­Registry()** ([@shubhamg13](https://github.com/shubhamg13), [#45791](https://github.com/servo/servo/pull/45791), [#45550](https://github.com/servo/servo/pull/45550))
- **text­Stream()** on **Request**, **Response**, and **Blob** ([@yezhizhen](https://github.com/yezhizhen), [#45864](https://github.com/servo/servo/pull/45864), [#45861](https://github.com/servo/servo/pull/45861))
- **set­Pointer­Capture()**, **release­Pointer­Capture()**, **has­Pointer­Capture()** on **Element** ([@webbeef](https://github.com/webbeef), [#45048](https://github.com/servo/servo/pull/45048))
- **on­touch­start**, **on­touch­end**, **on­touch­move**, **on­touch­cancel** on **Element** ([@stevennovaryo](https://github.com/stevennovaryo), [#45049](https://github.com/servo/servo/pull/45049))
- **crypto­.subtle­.digest()** for **KT128** and **KT256** ([@kkoyung](https://github.com/kkoyung), [#45699](https://github.com/servo/servo/pull/45699))
- **crypto­.subtle­.get­Public­Key()** for **ML-KEM** and **ML-DSA** ([@kkoyung](https://github.com/kkoyung), [#45252](https://github.com/servo/servo/pull/45252))

This is another big update, so here’s an outline:

- [**You can help!**](#you-can-help)

- [**Security**](#security)

- [**Real world compat**](#real-world-compat)

- [**Work in progress**](#work-in-progress)

- [**Embedding API**](#embedding-api)

- [**For users and developers**](#for-users-and-developers)

- [**More on the web platform**](#more-on-the-web-platform)

- [**Garbage collection safety**](#garbage-collection-safety)

- [**Performance and stability**](#performance-and-stability)

- [**New contributors**](#new-contributors)

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

Thanks to an initiative by [@jdm](https://github.com/jdm), it’s now easier than ever for you to **help us answer those questions**, using the Servo Highfive bot!
If you’re working on a pull request that you think might be interesting for the next monthly update, even if you’re not 100% sure, tell us about it by following the steps below:

1. You add the <span style="padding: 0.1875lh; border-radius: calc(0.5lh + 2 * 1px); background: rgb(13, 17, 23);"><span style="padding: 0 0.25lh; border: thin solid rgba(85, 221, 126, 0.3); border-radius: 0.5lh; color: rgb(85, 221, 126); background-color: rgba(84, 222, 126, 0.18);">monthly update</span></span> label to your pull request, or comment <code style="display: /* allow wrapping only as last resort */ inline-block;">[@servo-highfive](https://github.com/servo-highfive) monthly update</code>

2. Highfive posts a comment asking you some questions

3. You answer those questions in a comment containing <code style="display: /* allow wrapping only as last resort */ inline-block;">[@servo-highfive](https://github.com/servo-highfive) monthly update answer</code>

## Security

Servo’s JS runtime, **SpiderMonkey 140.10.1**, had several **security bugs** that have been fixed in Servo 0.4.0 with the update to SpiderMonkey 140.11.0 ([@jschwe](https://github.com/jschwe), [#45584](https://github.com/servo/servo/pull/45584)).
For more details, see [CVE-2026-8388](https://nvd.nist.gov/vuln/detail/CVE-2026-8388), [CVE-2026-8391](https://nvd.nist.gov/vuln/detail/CVE-2026-8391), [CVE-2026-8974](https://nvd.nist.gov/vuln/detail/CVE-2026-8974), [CVE-2026-8975](https://nvd.nist.gov/vuln/detail/CVE-2026-8975), and [MFSA 2026-48](https://www.mozilla.org/en-US/security/advisories/mfsa2026-48/).

Several more **security bugs** in Servo’s JS runtime have been fixed in Servo 0.4.0 with the update to SpiderMonkey 140.12.0 ([@jschwe](https://github.com/jschwe), [#45766](https://github.com/servo/servo/pull/45766)).
The exact CVEs that apply to us are not yet known, but for more details, see [MFSA 2026-58](https://www.mozilla.org/en-US/security/advisories/mfsa2026-58/).

**RSA** operations in **Subtle­Crypto** now do modular exponentiation in constant time ([@kkoyung](https://github.com/kkoyung), [#45631](https://github.com/servo/servo/pull/45631)).
Please note that our RSA implementation is currently vulnerable to the [Marvin Attack](https://people.redhat.com/~hkario/marvin/) – for more details, see [RUSTSEC-2023-0071](https://rustsec.org/advisories/RUSTSEC-2023-0071.html).

**ML-DSA** operations in **Subtle­Crypto** now do the Decompose step in constant time, fixing [RUSTSEC-2025-0144](https://rustsec.org/advisories/RUSTSEC-2025-0144.html) ([@kkoyung](https://github.com/kkoyung), [#45294](https://github.com/servo/servo/pull/45294)).

We’ve fixed an HTML injection bug (XSS) in **file:/// directory listings**, which affected file names containing `</script>` ([@sahvx655-wq](https://github.com/sahvx655-wq), [#45510](https://github.com/servo/servo/pull/45510)).

## Real world compat

Layout correctness has significantly improved on **[lichess.org](https://lichess.org)**, and many websites have become a lot more readable thanks to our improved handling of **variable fonts** ([@simonwuelker](https://github.com/simonwuelker), [#45768](https://github.com/servo/servo/pull/45768)), including **Zulip ([servo.zulipchat.com](https://servo.zulipchat.com))** and **Speedtest ([speedtest.net](https://speedtest.net))**.

<figure class="_spaced">
    <div class="_peel" style="--default-position: 33%;">
        <div class="_line">
            <div class="_left"><div>v0.3.0</div></div>
            <div class="_right"><div>v0.4.0</div></div>
        </div>
        <img src="{{ '/img/blog/2026-07-161705.png' | url }}">
        <img src="{{ '/img/blog/2026-07-161708.png' | url }}">
    </div>
    <figcaption><a href="https://lichess.org">lichess.org</a></figcaption>
</figure>

<figure class="_spaced">
    <div class="_peel" style="--default-position: 20%;">
        <div class="_line">
            <div class="_left"><div>v0.3.0</div></div>
            <div class="_right"><div>v0.4.0</div></div>
        </div>
        <img src="{{ '/img/blog/2026-07-161115.png' | url }}">
        <img src="{{ '/img/blog/2026-07-161201.png' | url }}">
    </div>
    <figcaption>Zulip (<a href="https://servo.zulipchat.com">servo.zulipchat.com</a>)</figcaption>
</figure>

<figure class="_spaced">
    <div class="_peel" style="--default-position: 39%;">
        <div class="_line">
            <div class="_left"><div>v0.3.0</div></div>
            <div class="_right"><div>v0.4.0</div></div>
        </div>
        <img src="{{ '/img/blog/2026-07-174050.png' | url }}">
        <img src="{{ '/img/blog/2026-07-174052.png' | url }}">
    </div>
    <figcaption>Speedtest (<a href="https://speedtest.net">speedtest.net</a>)</figcaption>
</figure>

Many websites worked in Servo even before version 0.4.0, including **Google Photos ([photos.google.com](https://photos.google.com))** and Cash Converters ([cashconverters.com.au](https://cashconverters.com.au)), and continue to work in version 0.4.0.
Other websites, like Google Maps ([maps.google.com](https://maps.google.com)) and OpenStreetMap ([www.openstreetmap.org](https://www.openstreetmap.org)), render well but have some issues with interactivity.

<figure class="_spaced _halves">
    <figure class="_spaced">
        <a href="{{ '/img/blog/2026-07-175215.png' | url }}"><img src="{{ '/img/blog/2026-07-175215.png' | url }}"></a>
        <figcaption>Google Photos (<a href="https://photos.google.com">photos.google.com</a>)</figcaption>
    </figure>
    <figure class="_spaced">
        <a href="{{ '/img/blog/2026-07-162341.png' | url }}"><img src="{{ '/img/blog/2026-07-162341.png' | url }}"></a>
        <figcaption>Cash Converters (<a href="https://cashconverters.com.au">cashconverters.com.au</a>)</figcaption>
    </figure>
    <figure class="_spaced">
        <a href="{{ '/img/blog/2026-07-202258.png' | url }}"><img src="{{ '/img/blog/2026-07-202258.png' | url }}"></a>
        <figcaption>Google Maps (<a href="https://maps.google.com">maps.google.com</a>)</figcaption>
    </figure>
    <figure class="_spaced">
        <a href="{{ '/img/blog/2026-07-203458.png' | url }}"><img src="{{ '/img/blog/2026-07-203458.png' | url }}"></a>
        <figcaption>OpenStreetMap (<a href="https://www.openstreetmap.org">www.openstreetmap.org</a>)</figcaption>
    </figure>
</figure>

<style>
    ._spaced {
        margin: 1em 0;
    }
    ._halves {
        display: flex;
        flex-flow: row wrap;
    }
    ._halves > * {
        width: 50%;
    }
    ._peel {
        --default-position: 50%;
        position: relative;
        overflow: hidden;
        background: white;
        * {
            /* ensure ‘pointermove’ events always target the root */
            pointer-events: none;
            user-select: none;
        }
        img {
            background: white;
        }
        :not(:last-child) {
            position: absolute;
            inset: 0 auto 0 auto;
            width: var(--position, var(--default-position));
            height: 100%;
            object-fit: cover;
            object-position: top left;
        }
        ._line {
            z-index: 1;
            border-right: thin solid #1192e8;
            div {
                position: absolute;
                right: 0;
                width: 0;
            }
            div div {
                position: absolute;
                width: max-content;
                padding: 0 0.25em;
                background: #ffffff80;
            }
            ._left div {
                /* extend left of the line */
                right: 0;
            }
            ._right div {
                /* extend right of the line */
                left: 0;
            }
        }
    }
</style>

<script>
    for (const peel of document.querySelectorAll("._peel")) {
        peel.addEventListener("pointermove", event => {
            const position = Math.max(0, Math.min(1, event.offsetX / peel.offsetWidth));
            peel.style.setProperty("--position", `${position * 100}%`);
        }, true);
    }
</script>

We’re interested to hear how well your favourite websites run in Servo!
Report successes in [this Zulip thread](https://servo.zulipchat.com/#narrow/channel/263398-general/topic/Servo.20web.20compat.20success.20stories/with/612898341), and failures [in our GitHub issues](https://github.com/servo/servo/issues).

## Work in progress

We’re implementing the more powerful version of **‘attr()’** that can be used anywhere, not just in ‘content’, under `--pref layout­_css­_attr­_enabled` ([@Loirooriol](https://github.com/Loirooriol), [#45041](https://github.com/servo/servo/pull/45041), [#45421](https://github.com/servo/servo/pull/45421), [#45495](https://github.com/servo/servo/pull/45495), [#45752](https://github.com/servo/servo/pull/45752)).

**WebGPU** support has improved, under `--pref dom­_webgpu­_enabled`:

- implemented **copy­External­Image­To­Texture()** on **GPU­Queue** ([@sagudev](https://github.com/sagudev), [#45646](https://github.com/servo/servo/pull/45646))
- implemented **create­Query­Set()** on **GPU­Device** and **resolve­Query­Set()** on **GPU­Command­Encoder** ([@sagudev](https://github.com/sagudev), [#45644](https://github.com/servo/servo/pull/45644))
- implemented **push­Debug­Group()**, **pop­Debug­Group()**, and **insert­Debug­Marker()** on **GPU­Command­Encoder**, **GPU­Compute­Pass­Encoder**, and **GPU­Render­Pass­Encoder** ([@jschwe](https://github.com/jschwe), [#45489](https://github.com/servo/servo/pull/45489))
- more conformant **GPU­Texture** ([@sagudev](https://github.com/sagudev), [#45300](https://github.com/servo/servo/pull/45300))
- more conformant **request­Adapter()** on **GPU** ([@sagudev](https://github.com/sagudev), [#45424](https://github.com/servo/servo/pull/45424))
- more conformant **secure context** enforcement ([@sagudev](https://github.com/sagudev), [#45279](https://github.com/servo/servo/pull/45279))

All of the features above are enabled in servoshell’s [experimental mode](https://book.servo.org/design-documentation/experimental-features.html#experimental-web-platform-features).

We’ve made more progress towards **accessibility** support, under `--pref accessibility_enabled` ([@alice](https://github.com/alice), [@delan](https://github.com/delan), [#45555](https://github.com/servo/servo/pull/45555), [#45554](https://github.com/servo/servo/pull/45554), [#44949](https://github.com/servo/servo/pull/44949)).

We’ve started implementing **Web Animations**, under `--pref dom­_web­_animations­_enabled` ([@simonwuelker](https://github.com/simonwuelker), [#45522](https://github.com/servo/servo/pull/45522)), as well as **webkit­Relative­Path** on **File**, under `--pref dom­_entries­_api­_enabled` ([@yezhizhen](https://github.com/yezhizhen), [#45666](https://github.com/servo/servo/pull/45666)).

Rust doesn’t have a stable [ABI](https://en.wikipedia.org/wiki/Application_binary_interface), so it has generally not been possible to embed Servo in another application without building Servo from source.
To make it possible, we’ve started designing a **wrapper C API** that will let you consume Servo as a prebuilt shared library using the stable and ubiquitous C ABI ([@mukilan](https://github.com/mukilan), [#44984](https://github.com/servo/servo/pull/44984)).
Eventually the idea is that we’ll create a wrapper Rust API around *that* wrapper C API, so you can have both the ergonomics of Rust *and* the build simplicity of C.

## Embedding API

New in the [**Servo API**](https://doc.servo.org/servo/):

- [`Web­View`](https://doc.servo.org/servo/struct.WebView.html)::[`rendering­_context`](https://doc.servo.org/servo/struct.WebView.html#method.rendering_context) ([@mrobinson](https://github.com/mrobinson), [#46047](https://github.com/servo/servo/pull/46047))

Breaking changes:

- [`Web­View`](https://doc.servo.org/servo/struct.WebView.html)::`send­_error` has been removed ([@mukilan](https://github.com/mukilan), [#45502](https://github.com/servo/servo/pull/45502)) – this method was always meant to be internal, and has become unused after we introduced the new Web­View- and Web­View­Delegate-based API

We’ve improved the docs for Web­View, Web­View­Delegate, JS­Value, Alert­Dialog, Allow­Or­Deny­Request, Authentication­Response, Bluetooth­Device­Description, Confirm­Dialog, Console­Log­Level, Create­New­Web­View­Request, Embedder­Control, Embedder­Control­Response, File­Picker, Image, Java­Script­Error­Info, Navigation­Request, Permission­Request, Pixel­Format, Prompt­Dialog, Protocol­Handler­Registration, Protocol­Handler­Update­Registration, Scroll, Select­Element, Select­Element­Request, and Web­View­Vector ([@mukilan](https://github.com/mukilan), [#45282](https://github.com/servo/servo/pull/45282), [#45467](https://github.com/servo/servo/pull/45467)).

## For users and developers

In servoshell:

- the **Android** version now requires **Android 13+** ([@jschwe](https://github.com/jschwe), [#46104](https://github.com/servo/servo/pull/46104))

- the **desktop** version now lets you **drag and drop files** to open them ([@simonwuelker](https://github.com/simonwuelker), [#45454](https://github.com/servo/servo/pull/45454))

- the **desktop** version now lets the **tab bar scroll horizontally** if you have too many tabs open, but from one tab hoarder to another, maybe you should reconsider having so many tabs open ([@Nylme](https://github.com/Nylme), [#44884](https://github.com/servo/servo/pull/44884))

- **&lt;select multiple>** should now be interactable on **all desktop platforms** ([@alexcat3](https://github.com/alexcat3), [#45419](https://github.com/servo/servo/pull/45419))

- `localhost:<port>` now implies `http://` **in the location bar** and **on the command line**, rather than treating `localhost:` as an unsupported URL scheme ([@SteveSharonSam](https://github.com/SteveSharonSam), [#45729](https://github.com/servo/servo/pull/45729), [#45832](https://github.com/servo/servo/pull/45832))

- entering fullscreen now happens on the monitor containing the window, even if you’ve moved it to a different monitor ([@rhit-kapilaar](https://github.com/rhit-kapilaar), [#45556](https://github.com/servo/servo/pull/45556))

- the browser UI no longer gets stuck in hovered states ([@mrobinson](https://github.com/mrobinson), [#45290](https://github.com/servo/servo/pull/45290))

When using the Firefox **DevTools**:

- in the **Console** tab, **uncaught exceptions** are reported correctly ([@jdm](https://github.com/jdm), [#45549](https://github.com/servo/servo/pull/45549))

- in the **Console** and **Debugger** tabs, you can now inspect the elements of **nested arrays** and the entries of **Map objects** ([@atbrakhi](https://github.com/atbrakhi), [#45435](https://github.com/servo/servo/pull/45435), [#45514](https://github.com/servo/servo/pull/45514), [#45767](https://github.com/servo/servo/pull/45767))

- in the **Debugger** tab, the **Scopes** panel now shows any **‘(uninitialized)’** variables, the value of `this`, and the **global scope** ([@atbrakhi](https://github.com/atbrakhi), [@eerii](https://github.com/eerii), [#45824](https://github.com/servo/servo/pull/45824), [#45517](https://github.com/servo/servo/pull/45517))

We’ve fixed some build issues on **riscv32**, **riscv64**, and **arm64** ([@fxzjshm](https://github.com/fxzjshm), [@saschanaz](https://github.com/saschanaz), [#45285](https://github.com/servo/servo/pull/45285), [#45731](https://github.com/servo/servo/pull/45731)), and modernised servoshell for **Android** to use Compose UI and Kotlin ([@veyndan](https://github.com/veyndan), [#45923](https://github.com/servo/servo/pull/45923), [#45932](https://github.com/servo/servo/pull/45932), [#45941](https://github.com/servo/servo/pull/45941), [#45982](https://github.com/servo/servo/pull/45982), [#45985](https://github.com/servo/servo/pull/45985), [#46015](https://github.com/servo/servo/pull/46015), [#46035](https://github.com/servo/servo/pull/46035), [#46037](https://github.com/servo/servo/pull/46037), [#46046](https://github.com/servo/servo/pull/46046), [#46053](https://github.com/servo/servo/pull/46053), [#46061](https://github.com/servo/servo/pull/46061), [#46071](https://github.com/servo/servo/pull/46071), [#45641](https://github.com/servo/servo/pull/45641), [#45643](https://github.com/servo/servo/pull/45643), [#45650](https://github.com/servo/servo/pull/45650), [#45665](https://github.com/servo/servo/pull/45665), [#45671](https://github.com/servo/servo/pull/45671), [#45676](https://github.com/servo/servo/pull/45676), [#45679](https://github.com/servo/servo/pull/45679), [#45683](https://github.com/servo/servo/pull/45683), [#45712](https://github.com/servo/servo/pull/45712), [#45713](https://github.com/servo/servo/pull/45713), [#45734](https://github.com/servo/servo/pull/45734), [#45738](https://github.com/servo/servo/pull/45738)).

## More on the web platform

To allow for more performant scrolling, **‘wheel’ events** are no longer `.cancelable` unless there are one or more non-[`passive`](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener#passive) event listeners ([@kunalmohan](https://github.com/kunalmohan), [#45667](https://github.com/servo/servo/pull/45667)).
Note that like in Firefox, ‘wheel’ events are `passive` by default.

**‘dotted’**, **‘dashed’**, and **‘wavy’ text decorations** are now continuous across element boundaries ([@mrobinson](https://github.com/mrobinson), [#45726](https://github.com/servo/servo/pull/45726)).

We’ve improved the conformance of **&lt;dialog>** ([@skyz1](https://github.com/skyz1), [#45825](https://github.com/servo/servo/pull/45825)), **&lt;iframe sandbox>** ([@cychronex-labs](https://github.com/cychronex-labs), [#45880](https://github.com/servo/servo/pull/45880)), **&lt;input minlength>** and **&lt;input maxlength>** ([@skyz1](https://github.com/skyz1), [#45705](https://github.com/servo/servo/pull/45705)), **‘font-style’** and **‘unicode-range’** in **‘[@font-face](https://github.com/font-face)’** ([@Loirooriol](https://github.com/Loirooriol), [#45821](https://github.com/servo/servo/pull/45821)), **FontFaceSet** ([@mrobinson](https://github.com/mrobinson), [#45390](https://github.com/servo/servo/pull/45390), [#45382](https://github.com/servo/servo/pull/45382)), **HTML­Input­Element** ([@steigeo](https://github.com/steigeo), [#45416](https://github.com/servo/servo/pull/45416)), **new Response()** ([@yezhizhen](https://github.com/yezhizhen), [#45953](https://github.com/servo/servo/pull/45953)), **URL.create­Object­URL()** and **URL.revoke­Object­URL()** ([@yezhizhen](https://github.com/yezhizhen), [#45182](https://github.com/servo/servo/pull/45182), [#45417](https://github.com/servo/servo/pull/45417)), and **ECDSA** and **Ed25519** in **Subtle­Crypto** ([@kkoyung](https://github.com/kkoyung), [#45833](https://github.com/servo/servo/pull/45833), [#46017](https://github.com/servo/servo/pull/46017)).

We’ve fixed bugs related to **&lt;input hidden>** ([@mrobinson](https://github.com/mrobinson), [#45750](https://github.com/servo/servo/pull/45750)), **‘animation-delay’** ([@yezhizhen](https://github.com/yezhizhen), [#45013](https://github.com/servo/servo/pull/45013)), **‘clip-path’** ([@Loirooriol](https://github.com/Loirooriol), [#45468](https://github.com/servo/servo/pull/45468), [#45373](https://github.com/servo/servo/pull/45373)), **‘tab-size’** ([@SimonSapin](https://github.com/SimonSapin), [@mrobinson](https://github.com/mrobinson), [#45309](https://github.com/servo/servo/pull/45309)), **‘width’** and **‘height’** ([@RichardTjokroutomo](https://github.com/RichardTjokroutomo), [#44627](https://github.com/servo/servo/pull/44627)), **‘box-shadow: inset’** ([@Loirooriol](https://github.com/Loirooriol), [#45620](https://github.com/servo/servo/pull/45620)), **‘animation­iteration’ events** ([@Loirooriol](https://github.com/Loirooriol), [#45990](https://github.com/servo/servo/pull/45990)), **‘click’ events** ([@mrobinson](https://github.com/mrobinson), [#45751](https://github.com/servo/servo/pull/45751)), and **‘error’ events** in Worker global scopes ([@Gae24](https://github.com/Gae24), [#45829](https://github.com/servo/servo/pull/45829)).

## Garbage collection safety

We use a [**RefCell**-based mechanism](https://doc.servo.org/script_bindings/cell/struct.DomRefCell.html) to store many of our DOM types in other DOM types, enforcing Rust’s “aliasing xor mutability” rule at runtime by panicking if the rule is violated.
But when garbage collection happens, we need to [borrow()](https://doc.servo.org/script_bindings/cell/struct.DomRefCell.html#method.borrow) each DomRefCell to trace the references, and this is the source of many panic bugs.
To fix that whole class of bugs, we initially created **CanGc**, a marker type that would annotate the code paths where GC can occur, in conjunction with custom static analysis ([@jdm](https://github.com/jdm), [#33140](https://github.com/servo/servo/pull/33140)).

With the Rust type system we can do even better, if we flip that around and require any [borrow\_mut()](https://doc.servo.org/script_bindings/cell/struct.DomRefCell.html#method.borrow_mut) call to prove that GC can *not* occur by passing a **NoGC** marker value.
We can then require that a `&NoGC` must be borrowed from a `&JSContext` (which blocks GC) and not a `&mut JSContext` (which allows GC), taking advantage of how Rust references work without needing any custom static analysis.

We have a large codebase that needs to be migrated in parts, so for now we’ve created the new method [safe­\_borrow­\_mut()](https://doc.servo.org/script_bindings/cell/struct.DomRefCell.html#method.safe_borrow_mut) ([@sagudev](https://github.com/sagudev), [#46050](https://github.com/servo/servo/pull/46050)).
We also need to update all of our script-related code to borrow our [safe JSContext wrapper](https://doc.servo.org/script_bindings/import/base/struct.JSContext.html), rather than creating an owned JSContext on the spot.

This continues our long-running effort to **use the Rust type system** to make Servo’s integration with SpiderMonkey safer and more reliable ([@Gae24](https://github.com/Gae24), [@Keerti707](https://github.com/Keerti707), [@Narfinger](https://github.com/Narfinger), [@TimvdLippe](https://github.com/TimvdLippe), [@sagudev](https://github.com/sagudev), [@guptapiyush16](https://github.com/guptapiyush16), [@ivomurrell](https://github.com/ivomurrell), [@kunalmohan](https://github.com/kunalmohan), [@skyz1](https://github.com/skyz1), [#45230](https://github.com/servo/servo/pull/45230), [#45436](https://github.com/servo/servo/pull/45436), [#45503](https://github.com/servo/servo/pull/45503), [#45617](https://github.com/servo/servo/pull/45617), [#45711](https://github.com/servo/servo/pull/45711), [#45797](https://github.com/servo/servo/pull/45797), [#45800](https://github.com/servo/servo/pull/45800), [#45858](https://github.com/servo/servo/pull/45858), [#45884](https://github.com/servo/servo/pull/45884), [#45937](https://github.com/servo/servo/pull/45937), [#45902](https://github.com/servo/servo/pull/45902), [#45968](https://github.com/servo/servo/pull/45968), [#45977](https://github.com/servo/servo/pull/45977), [#45991](https://github.com/servo/servo/pull/45991), [#46003](https://github.com/servo/servo/pull/46003), [#46005](https://github.com/servo/servo/pull/46005), [#46084](https://github.com/servo/servo/pull/46084), [#45548](https://github.com/servo/servo/pull/45548), [#45552](https://github.com/servo/servo/pull/45552), [#45590](https://github.com/servo/servo/pull/45590), [#45909](https://github.com/servo/servo/pull/45909), [#45912](https://github.com/servo/servo/pull/45912), [#45943](https://github.com/servo/servo/pull/45943), [#46089](https://github.com/servo/servo/pull/46089), [#46117](https://github.com/servo/servo/pull/46117), [#46114](https://github.com/servo/servo/pull/46114), [#45320](https://github.com/servo/servo/pull/45320), [#45324](https://github.com/servo/servo/pull/45324), [#45328](https://github.com/servo/servo/pull/45328), [#45340](https://github.com/servo/servo/pull/45340), [#45381](https://github.com/servo/servo/pull/45381), [#45385](https://github.com/servo/servo/pull/45385), [#45410](https://github.com/servo/servo/pull/45410), [#45392](https://github.com/servo/servo/pull/45392), [#45409](https://github.com/servo/servo/pull/45409), [#45604](https://github.com/servo/servo/pull/45604), [#45616](https://github.com/servo/servo/pull/45616), [#45618](https://github.com/servo/servo/pull/45618), [#45627](https://github.com/servo/servo/pull/45627), [#45636](https://github.com/servo/servo/pull/45636), [#45662](https://github.com/servo/servo/pull/45662), [#45663](https://github.com/servo/servo/pull/45663), [#45675](https://github.com/servo/servo/pull/45675), [#45674](https://github.com/servo/servo/pull/45674), [#45677](https://github.com/servo/servo/pull/45677), [#45684](https://github.com/servo/servo/pull/45684), [#45735](https://github.com/servo/servo/pull/45735), [#45807](https://github.com/servo/servo/pull/45807), [#45810](https://github.com/servo/servo/pull/45810), [#45816](https://github.com/servo/servo/pull/45816), [#45818](https://github.com/servo/servo/pull/45818), [#45828](https://github.com/servo/servo/pull/45828), [#45838](https://github.com/servo/servo/pull/45838), [#45836](https://github.com/servo/servo/pull/45836), [#45837](https://github.com/servo/servo/pull/45837), [#45840](https://github.com/servo/servo/pull/45840), [#45841](https://github.com/servo/servo/pull/45841), [#45857](https://github.com/servo/servo/pull/45857), [#45859](https://github.com/servo/servo/pull/45859), [#45862](https://github.com/servo/servo/pull/45862), [#45875](https://github.com/servo/servo/pull/45875), [#45887](https://github.com/servo/servo/pull/45887), [#45931](https://github.com/servo/servo/pull/45931), [#45964](https://github.com/servo/servo/pull/45964), [#45935](https://github.com/servo/servo/pull/45935), [#45987](https://github.com/servo/servo/pull/45987), [#45988](https://github.com/servo/servo/pull/45988), [#46001](https://github.com/servo/servo/pull/46001), [#46040](https://github.com/servo/servo/pull/46040), [#46051](https://github.com/servo/servo/pull/46051), [#46057](https://github.com/servo/servo/pull/46057), [#46106](https://github.com/servo/servo/pull/46106), [#46125](https://github.com/servo/servo/pull/46125), [#45678](https://github.com/servo/servo/pull/45678), [#46002](https://github.com/servo/servo/pull/46002), [#45845](https://github.com/servo/servo/pull/45845), [#45645](https://github.com/servo/servo/pull/45645), [#45673](https://github.com/servo/servo/pull/45673), [#45259](https://github.com/servo/servo/pull/45259), [#45817](https://github.com/servo/servo/pull/45817), [#45822](https://github.com/servo/servo/pull/45822), [#45876](https://github.com/servo/servo/pull/45876), [#45877](https://github.com/servo/servo/pull/45877), [#45891](https://github.com/servo/servo/pull/45891)).

## Performance and stability

**NoGC** was designed to prevent dynamic borrow failures, but it also enables some performance optimisations!
If we can prove that garbage collection is impossible in some part of Servo, we can often **avoid rooting JavaScript objects** when interacting with them within that region of code.
This has allowed us to reduce overheads by over 1% in the **layout** process and in **HTML­Collection** ([@Narfinger](https://github.com/Narfinger), [#46092](https://github.com/servo/servo/pull/46092), [#45582](https://github.com/servo/servo/pull/45582)).

Our **memory usage** has improved, with **BoxFragment** now **17% smaller** (288 → 240 bytes on amd64) and **ShapeCacheEntry** now smaller too ([@SimonSapin](https://github.com/SimonSapin), [@mrobinson](https://github.com/mrobinson), [@simonwuelker](https://github.com/simonwuelker), [#45183](https://github.com/servo/servo/pull/45183), [#45496](https://github.com/servo/servo/pull/45496)).

We’ve fixed some nasty **memory leaks** when **reloading** and in **2D canvases** ([@Taym95](https://github.com/Taym95), [@sagudev](https://github.com/sagudev), [@jschwe](https://github.com/jschwe), [#45455](https://github.com/servo/servo/pull/45455), [#45261](https://github.com/servo/servo/pull/45261), [#45414](https://github.com/servo/servo/pull/45414)).

Speaking of which, **2D canvases** now use up to **23% less power** ([@yezhizhen](https://github.com/yezhizhen), [#45301](https://github.com/servo/servo/pull/45301)), and we now avoid rasterising the same SVG more than once ([@Narfinger](https://github.com/Narfinger), [@jschwe](https://github.com/jschwe), [#44805](https://github.com/servo/servo/pull/44805)).

Servo now **decodes all images asynchronously** and **fills image caches asynchronously**, leaving script threads (web content processes) more time for other work ([@Narfinger](https://github.com/Narfinger), [#45542](https://github.com/servo/servo/pull/45542), [#44483](https://github.com/servo/servo/pull/44483)).
On top of that, we’ve improved **incremental layout** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#45411](https://github.com/servo/servo/pull/45411)) and reduced reflows in **IntersectionObserver** ([@jschwe](https://github.com/jschwe), [#45986](https://github.com/servo/servo/pull/45986)).

We’ve started working on **incremental updates** for the **stacking context tree**, and as a side effect, we’ve made some layout-bound microbenchmarks up to 10% faster ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#45208](https://github.com/servo/servo/pull/45208)).

We’ve also reduced allocations, copies, GC rooting steps, and other operations in many parts of Servo ([@Narfinger](https://github.com/Narfinger), [@SimonSapin](https://github.com/SimonSapin), [@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#45506](https://github.com/servo/servo/pull/45506), [#45969](https://github.com/servo/servo/pull/45969), [#45940](https://github.com/servo/servo/pull/45940), [#45760](https://github.com/servo/servo/pull/45760), [#46090](https://github.com/servo/servo/pull/46090), [#45335](https://github.com/servo/servo/pull/45335), [#45413](https://github.com/servo/servo/pull/45413), [#45511](https://github.com/servo/servo/pull/45511)).

For several months, Frédéric ([@fred-wang](https://github.com/fred-wang)) has been [**fuzzing**](https://en.wikipedia.org/wiki/Fuzzing) for Servo bugs, and thanks to his work we’ve fixed sixteen (16) **crash bugs** in June, affecting **&lt;link onerror>**, **‘animation’**, **‘clip-path’**, **‘content’**, **‘rotate’**, **‘transition’**, **‘transform-style’**, **‘display: contents’**, **‘overflow: clip’**, **CSS­Keyframes­Rule**, **Font­Face**, **stop() on Window**, and the **DOM tree** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#46031](https://github.com/servo/servo/pull/46031), [#46027](https://github.com/servo/servo/pull/46027), [#46054](https://github.com/servo/servo/pull/46054), [#46058](https://github.com/servo/servo/pull/46058), [#46016](https://github.com/servo/servo/pull/46016), [#46028](https://github.com/servo/servo/pull/46028), [#46033](https://github.com/servo/servo/pull/46033), [#45287](https://github.com/servo/servo/pull/45287), [#45951](https://github.com/servo/servo/pull/45951), [#45634](https://github.com/servo/servo/pull/45634), [#45629](https://github.com/servo/servo/pull/45629), [#46110](https://github.com/servo/servo/pull/46110), [#46094](https://github.com/servo/servo/pull/46094), [#45799](https://github.com/servo/servo/pull/45799), [#45611](https://github.com/servo/servo/pull/45611), [#45682](https://github.com/servo/servo/pull/45682)).

We’ve also fixed crash bugs related to **IPC** failures, **HTML­Input­Element**, **Range**, the **DevTools** Debugger tab, and when servoshell is built with `--features native-bluetooth` ([@jschwe](https://github.com/jschwe), [@Taym95](https://github.com/Taym95), [@mrobinson](https://github.com/mrobinson), [@atbrakhi](https://github.com/atbrakhi), [@mukilan](https://github.com/mukilan), [#45311](https://github.com/servo/servo/pull/45311), [#45619](https://github.com/servo/servo/pull/45619), [#45765](https://github.com/servo/servo/pull/45765), [#45513](https://github.com/servo/servo/pull/45513), [#45702](https://github.com/servo/servo/pull/45702)).

## New contributors

A special thanks to the following people for landing their first patch in Servo:

- Deepam Goyal ([@Deepam02](https://github.com/Deepam02), [#44836](https://github.com/servo/servo/pull/44836))
- Mark ([@Mark-Boger](https://github.com/Mark-Boger), [#45486](https://github.com/servo/servo/pull/45486))
- Mr SheerLuck ([@MrSheerluck](https://github.com/MrSheerluck), [#45557](https://github.com/servo/servo/pull/45557))
- Psychpsyo (Cameron) ([@Psychpsyo](https://github.com/Psychpsyo), [#45494](https://github.com/servo/servo/pull/45494))
- TusharSariya ([@TusharSariya](https://github.com/TusharSariya), [#43663](https://github.com/servo/servo/pull/43663))
- Adam Sharif ([@adamsharifc](https://github.com/adamsharifc), [#45551](https://github.com/servo/servo/pull/45551))
- Akash Ravikumar ([@ak4shravikumar](https://github.com/ak4shravikumar), [#45736](https://github.com/servo/servo/pull/45736))
- Sean Cunneen ([@alexcat3](https://github.com/alexcat3), [#45419](https://github.com/servo/servo/pull/45419))
- Abdul Wahab Melethil Shibu ([@cychronex-labs](https://github.com/cychronex-labs), [#45880](https://github.com/servo/servo/pull/45880))
- darkdragon-001 ([@darkdragon-001](https://github.com/darkdragon-001), [#45267](https://github.com/servo/servo/pull/45267))
- Frédéric Wang Nélar ([@fred-wang](https://github.com/fred-wang), [#45834](https://github.com/servo/servo/pull/45834))
- fxzjshm ([@fxzjshm](https://github.com/fxzjshm), [#45285](https://github.com/servo/servo/pull/45285))
- Piyush Gupta ([@guptapiyush16](https://github.com/guptapiyush16), [#45845](https://github.com/servo/servo/pull/45845))
- Ivo Murrell ([@ivomurrell](https://github.com/ivomurrell), [#45645](https://github.com/servo/servo/pull/45645))
- rhit-kapilaar ([@rhit-kapilaar](https://github.com/rhit-kapilaar), [#45556](https://github.com/servo/servo/pull/45556))
- sahvx655-wq ([@sahvx655-wq](https://github.com/sahvx655-wq), [#45510](https://github.com/servo/servo/pull/45510))
- Kagami Sascha Rosylight ([@saschanaz](https://github.com/saschanaz), [#45731](https://github.com/servo/servo/pull/45731))
- shangguanmachine-dot ([@shangguanmachine-dot](https://github.com/shangguanmachine-dot), [#45310](https://github.com/servo/servo/pull/45310))
- Glenn Skrzypczak ([@skyz1](https://github.com/skyz1), [#45471](https://github.com/servo/servo/pull/45471))
- Oskar Steiger ([@steigeo](https://github.com/steigeo), [#45416](https://github.com/servo/servo/pull/45416))
- Veyndan Stuart ([@veyndan](https://github.com/veyndan), [#45326](https://github.com/servo/servo/pull/45326))

Interested in helping build a web browser?
Take a look at our [curated list](https://starters.servo.org) of issues that are good for new contributors!

## Donations

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
