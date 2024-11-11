---
layout:     post
tags:       blog
title:      "This month in Servo: faster fonts, fetches, and flexbox!"
date:       2024-11-08
summary:    Plus initial SubtleCrypto support, CSS size keywords, and OpenHarmony nightlies.
categories:
---

<figure class="_figr"><a href="{{ '/img/blog/october-2024-narrow.png' | url }}"><img src="{{ '/img/blog/october-2024-narrow.png' | url }}"
    alt="Servo nightly showing new support for non-ASCII characters in <img srcset>, ‘transition-behavior: allow-discrete’, ‘mix-blend-mode: plus-lighter’, and ‘width: stretch’"></a></figure>

Servo now supports **‘mix-blend-mode: plus-lighter’** ([@mrobinson](https://github.com/mrobinson), [#34057](https://github.com/servo/servo/pull/34057)) and **‘transition-behavior: allow-discrete’** ([@Loirooriol](https://github.com/Loirooriol), [#33991](https://github.com/servo/servo/pull/33991)), including in the ‘transition’ shorthand ([@Loirooriol](https://github.com/Loirooriol), [#34005](https://github.com/servo/servo/pull/34005)), along with the [fetch metadata request headers](https://w3c.github.io/webappsec-fetch-metadata/) **‘Sec-Fetch-Site’**, **‘Sec-Fetch-Mode’**, **‘Sec-Fetch-User’**, and **‘Sec-Fetch-Dest’** ([@simonwuelker](https://github.com/simonwuelker), [#33830](https://github.com/servo/servo/pull/33830)).

We now have partial support for the CSS size keywords **‘min-content’**, **‘max-content’**, **‘fit-content’**, and **‘stretch’** ([@Loirooriol](https://github.com/Loirooriol), [#33558](https://github.com/servo/servo/pull/33558), [#33659](https://github.com/servo/servo/pull/33659), [#33854](https://github.com/servo/servo/pull/33854), [#33951](https://github.com/servo/servo/pull/33951)), including in floats ([@Loirooriol](https://github.com/Loirooriol), [#33666](https://github.com/servo/servo/pull/33666)), atomic inlines ([@Loirooriol](https://github.com/Loirooriol), [#33737](https://github.com/servo/servo/pull/33737)), and elements with ‘position: absolute’ or ‘fixed’ ([@Loirooriol](https://github.com/Loirooriol), [#33950](https://github.com/servo/servo/pull/33950)).

We’re implementing the **[SubtleCrypto](https://developer.mozilla.org/en-US/docs/Web/API/SubtleCrypto) API**, starting with full support for **crypto.subtle.digest()** ([@simonwuelker](https://github.com/simonwuelker), [#34034](https://github.com/servo/servo/pull/34034)), partial support for **generateKey()** with AES-CBC and AES-CTR ([@msub2](https://github.com/msub2), [#33628](https://github.com/servo/servo/pull/33628), [#33963](https://github.com/servo/servo/pull/33963)), and partial support for **encrypt()**, and **decrypt()** with AES-CBC ([@msub2](https://github.com/msub2), [#33795](https://github.com/servo/servo/pull/33795)).

## More engine changes

Servo’s architecture is improving, with a new cross-process compositor API that **reduces memory copy overhead for video** ([@mrobinson](https://github.com/mrobinson), [@crbrz](https://github.com/crbrz), [#33619](https://github.com/servo/servo/pull/33619), [#33660](https://github.com/servo/servo/pull/33660), [#33817](https://github.com/servo/servo/pull/33817)).
We’ve also started phasing out our old OpenGL bindings ([gleam](https://github.com/servo/gleam) and [sparkle](https://github.com/servo/sparkle)) in favour of [glow](https://crates.io/crates/glow), which should reduce Servo’s complexity and binary size ([@sagudev](https://github.com/sagudev), [@mrobinson](https://github.com/mrobinson), [surfman#318](https://github.com/servo/surfman/pull/318), [webxr#248](https://github.com/servo/webxr/pull/248), [#33538](https://github.com/servo/servo/pull/33538), [#33910](https://github.com/servo/servo/pull/33910), [#33911](https://github.com/servo/servo/pull/33911)).

We’ve updated to **Stylo 2024-10-04** ([@Loirooriol](https://github.com/Loirooriol), [#33767](https://github.com/servo/servo/pull/33767)) and [**wgpu 23**](https://github.com/gfx-rs/wgpu/releases/tag/v23.0.0) ([@sagudev](https://github.com/sagudev), [#34073](https://github.com/servo/servo/pull/34073), [#33819](https://github.com/servo/servo/pull/33819), [#33635](https://github.com/servo/servo/pull/33635)).
The new version of wgpu includes several patches from [@sagudev](https://github.com/sagudev), adding **support for `const_assert`**, as well as **accessing `const` arrays with runtime index values**.
We’ve also reworked WebGPU canvas presentation to ensure that we never use old buffers by mistake ([@sagudev](https://github.com/sagudev), [#33613](https://github.com/servo/servo/pull/33613)).

We’ve also landed a bunch of improvements to our DOM geometry APIs, with DOMMatrix now **supporting toString()** ([@simonwuelker](https://github.com/simonwuelker), [#33792](https://github.com/servo/servo/pull/33792)) and **updating `is2D` on mutation** ([@simonwuelker](https://github.com/simonwuelker), [#33796](https://github.com/servo/servo/pull/33796)), support for **DOMRect.fromRect()** ([@simonwuelker](https://github.com/simonwuelker), [#33798](https://github.com/servo/servo/pull/33798)), and getBounds() on DOMQuad now **handling NaN correctly** ([@simonwuelker](https://github.com/simonwuelker), [#33794](https://github.com/servo/servo/pull/33794)).

We now correctly handle **non-ASCII characters in &lt;img srcset>** ([@evuez](https://github.com/evuez), [#33873](https://github.com/servo/servo/pull/33873)), correctly handle **data: URLs** in more situations ([@webbeef](https://github.com/webbeef), [#33500](https://github.com/servo/servo/pull/33500)), and no longer throw an uncaught exception when pages try to use IntersectionObserver ([@mrobinson](https://github.com/mrobinson), [#33989](https://github.com/servo/servo/pull/33989)).

Outreachy contributors are doing great work in Servo again, helping us land many of this month’s improvements to GC static analysis ([@taniishkaa](https://github.com/taniishkaa), [@webbeef](https://github.com/webbeef), [@chickenleaf](https://github.com/chickenleaf), [@jdm](https://github.com/jdm), [@jahielkomu](https://github.com/jahielkomu), [@wulanseruniati](https://github.com/wulanseruniati), [@lauwwulan](https://github.com/lauwwulan), [#33692](https://github.com/servo/servo/pull/33692), [#33706](https://github.com/servo/servo/pull/33706), [#33800](https://github.com/servo/servo/pull/33800), [#33774](https://github.com/servo/servo/pull/33774), [#33816](https://github.com/servo/servo/pull/33816), [#33808](https://github.com/servo/servo/pull/33808), [#33827](https://github.com/servo/servo/pull/33827), [#33822](https://github.com/servo/servo/pull/33822), [#33820](https://github.com/servo/servo/pull/33820), [#33828](https://github.com/servo/servo/pull/33828), [#33852](https://github.com/servo/servo/pull/33852), [#33843](https://github.com/servo/servo/pull/33843), [#33836](https://github.com/servo/servo/pull/33836), [#33865](https://github.com/servo/servo/pull/33865), [#33862](https://github.com/servo/servo/pull/33862), [#33891](https://github.com/servo/servo/pull/33891), [#33888](https://github.com/servo/servo/pull/33888), [#33880](https://github.com/servo/servo/pull/33880), [#33902](https://github.com/servo/servo/pull/33902), [#33892](https://github.com/servo/servo/pull/33892), [#33893](https://github.com/servo/servo/pull/33893), [#33895](https://github.com/servo/servo/pull/33895), [#33931](https://github.com/servo/servo/pull/33931), [#33924](https://github.com/servo/servo/pull/33924), [#33917](https://github.com/servo/servo/pull/33917), [#33921](https://github.com/servo/servo/pull/33921), [#33958](https://github.com/servo/servo/pull/33958), [#33920](https://github.com/servo/servo/pull/33920), [#33973](https://github.com/servo/servo/pull/33973), [#33960](https://github.com/servo/servo/pull/33960), [#33928](https://github.com/servo/servo/pull/33928), [#33985](https://github.com/servo/servo/pull/33985), [#33984](https://github.com/servo/servo/pull/33984), [#33978](https://github.com/servo/servo/pull/33978), [#33975](https://github.com/servo/servo/pull/33975), [#34003](https://github.com/servo/servo/pull/34003), [#34002](https://github.com/servo/servo/pull/34002)) and code health ([@chickenleaf](https://github.com/chickenleaf), [@DileepReddyP](https://github.com/DileepReddyP), [@taniishkaa](https://github.com/taniishkaa), [@mercybassey](https://github.com/mercybassey), [@jahielkomu](https://github.com/jahielkomu), [@cashall-0](https://github.com/cashall-0), [@tony-nyagah](https://github.com/tony-nyagah), [@lwz23](https://github.com/lwz23), [@Noble14477](https://github.com/Noble14477), [#33959](https://github.com/servo/servo/pull/33959), [#33713](https://github.com/servo/servo/pull/33713), [#33804](https://github.com/servo/servo/pull/33804), [#33618](https://github.com/servo/servo/pull/33618), [#33625](https://github.com/servo/servo/pull/33625), [#33631](https://github.com/servo/servo/pull/33631), [#33632](https://github.com/servo/servo/pull/33632), [#33633](https://github.com/servo/servo/pull/33633), [#33643](https://github.com/servo/servo/pull/33643), [#33643](https://github.com/servo/servo/pull/33643), [#33646](https://github.com/servo/servo/pull/33646), [#33648](https://github.com/servo/servo/pull/33648), [#33653](https://github.com/servo/servo/pull/33653), [#33664](https://github.com/servo/servo/pull/33664), [#33685](https://github.com/servo/servo/pull/33685), [#33686](https://github.com/servo/servo/pull/33686), [#33689](https://github.com/servo/servo/pull/33689), [#33686](https://github.com/servo/servo/pull/33686), [#33690](https://github.com/servo/servo/pull/33690), [#33705](https://github.com/servo/servo/pull/33705), [#33707](https://github.com/servo/servo/pull/33707), [#33724](https://github.com/servo/servo/pull/33724), [#33727](https://github.com/servo/servo/pull/33727), [#33728](https://github.com/servo/servo/pull/33728), [#33729](https://github.com/servo/servo/pull/33729), [#33730](https://github.com/servo/servo/pull/33730), [#33740](https://github.com/servo/servo/pull/33740), [#33744](https://github.com/servo/servo/pull/33744), [#33757](https://github.com/servo/servo/pull/33757), [#33771](https://github.com/servo/servo/pull/33771), [#33757](https://github.com/servo/servo/pull/33757), [#33782](https://github.com/servo/servo/pull/33782), [#33790](https://github.com/servo/servo/pull/33790), [#33809](https://github.com/servo/servo/pull/33809), [#33818](https://github.com/servo/servo/pull/33818), [#33821](https://github.com/servo/servo/pull/33821), [#33835](https://github.com/servo/servo/pull/33835), [#33840](https://github.com/servo/servo/pull/33840), [#33853](https://github.com/servo/servo/pull/33853), [#33849](https://github.com/servo/servo/pull/33849), [#33860](https://github.com/servo/servo/pull/33860), [#33878](https://github.com/servo/servo/pull/33878), [#33881](https://github.com/servo/servo/pull/33881), [#33894](https://github.com/servo/servo/pull/33894), [#33935](https://github.com/servo/servo/pull/33935), [#33936](https://github.com/servo/servo/pull/33936), [#33943](https://github.com/servo/servo/pull/33943)).

## Performance improvements

Our font system is faster now, with **reduced latency** when loading system fonts ([@mrobinson](https://github.com/mrobinson), [#33638](https://github.com/servo/servo/pull/33638)), layout **no longer blocking on sending font data** to WebRender ([@mrobinson](https://github.com/mrobinson), [#33600](https://github.com/servo/servo/pull/33600)), and **memory mapped system fonts** on macOS and FreeType platforms like Linux ([@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#33747](https://github.com/servo/servo/pull/33747)).

Servo now has a **dedicated fetch thread** ([@mrobinson](https://github.com/mrobinson), [#33863](https://github.com/servo/servo/pull/33863)).
This greatly reduces the number of IPC channels we create for individual requests, and should fix crashes related to file descriptor exhaustion on some platforms.
**Brotli-compressed responses** are also handled more efficiently, such that we run the parser with up to 8 KiB of decompressed data at a time, rather than only 10 bytes of compressed data at a time ([@crbrz](https://github.com/crbrz), [#33611](https://github.com/servo/servo/pull/33611)).

**Flexbox layout now uses caching** to avoid doing unnecessary work ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#33964](https://github.com/servo/servo/pull/33964), [#33967](https://github.com/servo/servo/pull/33967)), and now has experimental **[tracing](https://docs.rs/tracing/0.1.40/tracing/)-based profiling support** ([@mrobinson](https://github.com/mrobinson), [#33647](https://github.com/servo/servo/pull/33647)), which in turn no longer spams RUST_LOG=info when not enabled ([@delan](https://github.com/delan), [#33845](https://github.com/servo/servo/pull/33845)).
We’ve also landed optimisations in table layout ([@Loirooriol](https://github.com/Loirooriol), [#33575](https://github.com/servo/servo/pull/33575)) and in our layout engine as a whole ([@Loirooriol](https://github.com/Loirooriol), [#33806](https://github.com/servo/servo/pull/33806)).

Work continues on making our massive `script` crate build faster, with **improved incremental builds** ([@sagudev](https://github.com/sagudev), [@mrobinson](https://github.com/mrobinson), [#33502](https://github.com/servo/servo/pull/33502)) and further patches towards **splitting `script` into smaller crates** ([@sagudev](https://github.com/sagudev), [@jdm](https://github.com/jdm), [#33627](https://github.com/servo/servo/pull/33627), [#33665](https://github.com/servo/servo/pull/33665)).

We’ve also fixed several crashes, including when initiating a WebXR session on macOS ([@jdm](https://github.com/jdm), [#33962](https://github.com/servo/servo/pull/33962)), when laying out replaced elements ([@Loirooriol](https://github.com/Loirooriol), [#34006](https://github.com/servo/servo/pull/34006)), when running JavaScript modules ([@jdm](https://github.com/jdm), [#33938](https://github.com/servo/servo/pull/33938)), and in many situations when garbage collection occurs ([@chickenleaf](https://github.com/chickenleaf), [@taniishkaa](https://github.com/taniishkaa), [@Loirooriol](https://github.com/Loirooriol), [@jdm](https://github.com/jdm), [#33857](https://github.com/servo/servo/pull/33857), [#33875](https://github.com/servo/servo/pull/33875), [#33904](https://github.com/servo/servo/pull/33904), [#33929](https://github.com/servo/servo/pull/33929), [#33942](https://github.com/servo/servo/pull/33942), [#33976](https://github.com/servo/servo/pull/33976), [#34019](https://github.com/servo/servo/pull/34019), [#34020](https://github.com/servo/servo/pull/34020), [#33965](https://github.com/servo/servo/pull/33965), [#33937](https://github.com/servo/servo/pull/33937)).

## servoshell, embedding, and devtools

**[Devtools](https://book.servo.org/hacking/using-devtools.html) support** (`--devtools 6080`) is now compatible with Firefox 131+ ([@eerii](https://github.com/eerii), [#33661](https://github.com/servo/servo/pull/33661)), and no longer lists iframes as if they were inspectable tabs ([@eerii](https://github.com/eerii), [#34032](https://github.com/servo/servo/pull/34032)).

[Servo-the-browser](https://book.servo.org/running-servoshell.html) now **avoids unnecessary redraws** ([@webbeef](https://github.com/webbeef), [#34008](https://github.com/servo/servo/pull/34008)), massively reducing its CPU usage, and no longer scrolls too slowly on HiDPI systems ([@nicoburns](https://github.com/nicoburns), [#34063](https://github.com/servo/servo/pull/34063)).
We now **update the location bar when redirects happen** ([@rwakulszowa](https://github.com/rwakulszowa), [#34004](https://github.com/servo/servo/pull/34004)), and these updates are sent to all embedders of Servo, not just servoshell.

We’ve added a **new `--unminify-css` option** ([@Taym95](https://github.com/Taym95), [#33919](https://github.com/servo/servo/pull/33919)), allowing you to dump the CSS used by a page [like you can for JavaScript](https://book.servo.org/hacking/web-compat-bugs.html#diagnosing-js-errors).
This will pave the way for allowing you to modify that CSS for debugging site compat issues, which is not yet implemented.

We’ve also added a **new `--screen-size` option** that can help with testing mobile websites ([@mrobinson](https://github.com/mrobinson), [#34038](https://github.com/servo/servo/pull/34038)), renaming the old `--resolution` option to `--window-size`, and we’ve **removed `--no-minibrowser` mode** ([@Taym95](https://github.com/Taym95), [#33677](https://github.com/servo/servo/pull/33677)).

We now publish **nightly builds for OpenHarmony** on servo.org ([@mukilan](https://github.com/mukilan), [#33801](https://github.com/servo/servo/pull/33801)).
When running servoshell on OpenHarmony, we now display toasts when pages load or panic ([@jschwe](https://github.com/jschwe), [#33621](https://github.com/servo/servo/pull/33621)), and you can now pass certain Servo options via `hdc shell aa start` or a test app ([@jschwe](https://github.com/jschwe), [#33588](https://github.com/servo/servo/pull/33588)).

## Donations

Thanks again for your generous support!
We are now receiving **4201 USD/month** (+1.3% over September) in recurring donations.
**We are no longer accepting donations on LFX** — if you were donating there, please move your recurring donations to [GitHub](https://github.com/sponsors/servo) or [Open Collective](https://opencollective.com/servo).

Servo is also on [thanks.dev](https://thanks.dev), and already **ten GitHub users** that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 4201 / 10000); padding-left: 0.5em;"><strong>4201</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 4201 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="4201" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

With this money, we’ve been able to pay for our web hosting and self-hosted CI runners for Windows and Linux builds, and when the time comes, we’ll be able to afford macOS runners, perf bots, and maybe even an Outreachy intern or two!
As always, use of these funds will be decided transparently in the Technical Steering Committee.
For more details, head to our [Sponsorship page]({{ '/sponsorship/' | url }}).

<style>
    /* guaranteed minimum width for first paragraph after a float */
    ._floatmin {
        display: block;
        width: 13em;
        overflow: hidden;
    }
    ._none {
        display: none;
    }
    ._fig:not(#specificity) {
        width: 33em;
        max-width: 100%;
        margin: 1em auto;
    }
    ._fig > ._flex {
        display: flex;
    }
    ._fig table {
        text-align: initial;
    }
    ._fig figcaption._notes {
        text-align: left;
        width: max-content;
        max-width: 100%;
    }
    ._figl:not(#specificity),
    ._figr:not(#specificity) {
        margin: 0 1em 1em;
    }
    ._figl {
        float: left;
        max-width: 100%;
    }
    ._figr {
        float: right;
        max-width: 100%;
    }
    ._figl > figcaption,
    ._figr > figcaption,
    ._figl > iframe,
    ._figr > iframe,
    ._figl > video,
    ._figr > video,
    ._figl > a > img,
    ._figr > a > img {
        width: 21em;
        max-width: 100%;
    }
    ._runin {
        margin-bottom: 1em;
    }
    ._runin > p,
    ._runin > h2 {
        display: inline;
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
