---
layout:     post
tags:       blog
title:      "This month in Servo: tabbed browsing, Windows buffs, devtools, and more!"
date:       2024-08-31
summary:    Flexbox and WebXR are now enabled by default.
categories:
---

<figure class="_figr"><a href="{{ '/img/blog/features-august-2024.png' | url }}"><img src="{{ '/img/blog/features-august-2024.png' | url }}"
    alt="Servo nightly with a flexbox-based table of new features including textarea text, ‘border-image’, structuredClone(), crypto.randomUUID(), ‘clip-path’, and flexbox properties themselves"></a>
<figcaption>A flexbox-based table showcasing some of Servo’s new features this month.</figcaption></figure>

<span class=_floatmin></span>Servo has had several new features land in our nightly builds over the last month:

- as of 2024-07-27, basic support for **show() on HTMLDialogElement** ([@lukewarlow](https://github.com/lukewarlow), [#32681](https://github.com/servo/servo/pull/32681))
- as of 2024-07-29, the **type property on HTMLFieldSetElement** ([@shanehandley](https://github.com/shanehandley), [#32869](https://github.com/servo/servo/pull/32869))
- as of 2024-07-31, we now support **rendering text typed in &lt;textarea>** ([@mrobinson](https://github.com/mrobinson), [#32886](https://github.com/servo/servo/pull/32886))
- as of 2024-07-31, we now support the **‘border-image’** property ([@mrobinson](https://github.com/mrobinson), [#32874](https://github.com/servo/servo/pull/32874))
- as of 2024-08-02, **unsafe-eval** and **wasm-unsafe-eval** CSP [sources](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/Sources) ([@chocolate-pie](https://github.com/chocolate-pie), [#32893](https://github.com/servo/servo/pull/32893))
- as of 2024-08-04, we now support playback of **WAV audio files** ([@Melchizedek6809](https://github.com/Melchizedek6809), [#32924](https://github.com/servo/servo/pull/32924))
- as of 2024-08-09, we now support the **structuredClone()** API ([@Taym95](https://github.com/Taym95), [#32960](https://github.com/servo/servo/pull/32960))
- as of 2024-08-12, we now support **IIRFilterNode** in Web Audio ([@msub2](https://github.com/msub2), [#33001](https://github.com/servo/servo/pull/33001))
- as of 2024-08-13, we now support navigating through **cross-origin redirects** ([@jdm](https://github.com/jdm), [#32996](https://github.com/servo/servo/pull/32996))
- as of 2024-08-23, we now support the **crypto.randomUUID()** API ([@webbeef](https://github.com/webbeef), [#33158](https://github.com/servo/servo/pull/33158))
- as of 2024-08-29, the **‘clip-path’** property, except path(), polygon(), shape(), or url() values ([@chocolate-pie](https://github.com/chocolate-pie), [#33107](https://github.com/servo/servo/pull/33107))

We’ve upgraded Servo to **SpiderMonkey 128** ([@sagudev](https://github.com/sagudev), [@jschwe](https://github.com/jschwe), [#32769](https://github.com/servo/servo/pull/32769), [#32882](https://github.com/servo/servo/pull/32882), [#32951](https://github.com/servo/servo/pull/32951), [#33048](https://github.com/servo/servo/pull/33048)), **WebRender 0.65** ([@mrobinson](https://github.com/mrobinson), [#32930](https://github.com/servo/servo/pull/32930), [#33073](https://github.com/servo/servo/pull/33073)), **wgpu 22.0** ([@sagudev](https://github.com/sagudev), [#32827](https://github.com/servo/servo/pull/32827), [#32873](https://github.com/servo/servo/pull/32873), [#32981](https://github.com/servo/servo/pull/32981), [#33209](https://github.com/servo/servo/pull/33209)), and **Rust 1.80.1** ([@Hmikihiro](https://github.com/Hmikihiro), [@sagudev](https://github.com/sagudev), [#32896](https://github.com/servo/servo/pull/32896), [#33008](https://github.com/servo/servo/pull/33008)).

**WebXR** ([@msub2](https://github.com/msub2), [#33245](https://github.com/servo/servo/pull/33245)) and **flexbox** ([@mrobinson](https://github.com/mrobinson), [#33186](https://github.com/servo/servo/pull/33186)) are now **enabled by default**, and web APIs that return promises now correctly **reject the promise on failure**, rather than throwing an exception ([@sagudev](https://github.com/sagudev), [#32923](https://github.com/servo/servo/pull/32923), [#32950](https://github.com/servo/servo/pull/32950)).

To get there, we revamped our **WebXR API**, landing support for **Gamepad** ([@msub2](https://github.com/msub2), [#32860](https://github.com/servo/servo/pull/32860)), and updates to **hand input** ([@msub2](https://github.com/msub2), [#32958](https://github.com/servo/servo/pull/32958)), XRBoundedReferenceSpace ([@msub2](https://github.com/msub2), [#33176](https://github.com/servo/servo/pull/33176)), XRFrame ([@msub2](https://github.com/msub2), [#33102](https://github.com/servo/servo/pull/33102)), XRInputSource ([@msub2](https://github.com/msub2), [#33155](https://github.com/servo/servo/pull/33155)), XRPose ([@msub2](https://github.com/msub2), [#33146](https://github.com/servo/servo/pull/33146)), XRSession ([@msub2](https://github.com/msub2), [#33007](https://github.com/servo/servo/pull/33007), [#33059](https://github.com/servo/servo/pull/33059)), XRTargetRayMode (#33155), XRView ([@msub2](https://github.com/msub2), [#33007](https://github.com/servo/servo/pull/33007), [#33145](https://github.com/servo/servo/pull/33145)), and XRWebGLLayer ([@msub2](https://github.com/msub2), [#33157](https://github.com/servo/servo/pull/33157)).

And to top it all off, you can now call **makeXRCompatible() on WebGL2RenderingContext** ([@msub2](https://github.com/msub2), [#33097](https://github.com/servo/servo/pull/33097)), not just on WebGLRenderingContext.

The biggest flexbox features that landed this month are the **‘gap’ property** ([@Loirooriol](https://github.com/Loirooriol), [#32891](https://github.com/servo/servo/pull/32891)), **‘align-content: stretch’** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#32906](https://github.com/servo/servo/pull/32906), [#32913](https://github.com/servo/servo/pull/32913)), and the **‘start’** and **‘end’** values on **‘align-items’** and **‘align-self’** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#33032](https://github.com/servo/servo/pull/33032)), as well as basic support for **‘flex-direction: column’** and **‘column-reverse’** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [#33031](https://github.com/servo/servo/pull/33031), [#33068](https://github.com/servo/servo/pull/33068)).

**‘position: relative’** is now supported on flex items ([@mrobinson](https://github.com/mrobinson), [#33151](https://github.com/servo/servo/pull/33151)), **‘z-index’ always creates stacking contexts** for flex items ([@mrobinson](https://github.com/mrobinson), [#32961](https://github.com/servo/servo/pull/32961)), and we now give flex items and flex containers their correct **intrinsic sizes** ([@delan](https://github.com/delan), [@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#32854](https://github.com/servo/servo/pull/32854)).

We’re now working on support for **bidirectional text**, with architectural changes to the fragment tree ([@mrobinson](https://github.com/mrobinson), [#33030](https://github.com/servo/servo/pull/33030)) and ‘writing-mode’ interfaces ([@mrobinson](https://github.com/mrobinson), [@atbrakhi](https://github.com/atbrakhi), [#33082](https://github.com/servo/servo/pull/33082)), and now partial support for the **‘unicode-bidi’ property** and the **dir attribute** ([@mrobinson](https://github.com/mrobinson), [@atbrakhi](https://github.com/atbrakhi), [#33148](https://github.com/servo/servo/pull/33148)).
Note that the `dir=auto` value is not yet supported.

<figure class="_figl"><a href="{{ '/img/blog/servoshell-august-2024.png' | url }}"><img src="{{ '/img/blog/servoshell-august-2024.png' | url }}"
    alt="Servo nightly showing a toolbar with icons on the buttons, one tab open with the title “Servo - New Tab”, and a location bar that reads “servo:newtab”"></a>
<figcaption>servoshell now has a more elegant toolbar, tabbed browsing, and a clean but useful “new tab” page.</figcaption></figure>

## <span class=_floatmin></span>Beyond the engine

[Servo-the-browser](https://book.servo.org/running-servoshell.html) now has a **redesigned toolbar** ([@Melchizedek6809](https://github.com/Melchizedek6809), 33179) and **tabbed browsing** ([@webbeef](https://github.com/webbeef), [@Wuelle](https://github.com/Wuelle), [#33100](https://github.com/servo/servo/pull/33100), [#33229](https://github.com/servo/servo/pull/33229))!
This includes a slick **new tab page**, taking advantage of a new API that lets Servo embedders register **custom protocol handlers** ([@webbeef](https://github.com/webbeef), [#33104](https://github.com/servo/servo/pull/33104)).

Servo now runs better on Windows, with keyboard navigation now fixed ([@crbrz](https://github.com/crbrz), [#33252](https://github.com/servo/servo/pull/33252)), `--output` to PNG also fixed ([@crbrz](https://github.com/crbrz), [#32914](https://github.com/servo/servo/pull/32914)), and fixes for some font- and GPU-related bugs ([@crbrz](https://github.com/crbrz), [#33045](https://github.com/servo/servo/pull/33045), [#33177](https://github.com/servo/servo/pull/33177)), which were causing misaligned glyphs with incorrect colors on servo<!-- no link -->.org ([#32459](https://github.com/servo/servo/issues/32459)) and duckduckgo<!-- no link -->.com ([#33094](https://github.com/servo/servo/issues/33094)), and corrupted images on wikipedia<!-- no link -->.org ([#33170](https://github.com/servo/servo/issues/33170)).

Our **devtools support** is becoming very capable after [@eerii](https://github.com/eerii)’s final month of work on their internship project, with Servo now supporting the **HTML tree** ([@eerii](https://github.com/eerii), [#32655](https://github.com/servo/servo/pull/32655), [#32884](https://github.com/servo/servo/pull/32884), [#32888](https://github.com/servo/servo/pull/32888)) and the **Styles and Computed panels** ([@eerii](https://github.com/eerii), [#33025](https://github.com/servo/servo/pull/33025)).
Stay tuned for a more in-depth post about the Servo devtools!

## Changes for Servo developers

Running servoshell immediately after building it is now **several seconds faster on macOS** ([@mrobinson](https://github.com/mrobinson), [#32928](https://github.com/servo/servo/pull/32928)).

We now **run clippy in CI** ([@sagudev](https://github.com/sagudev), [#33150](https://github.com/servo/servo/pull/33150)), together with the existing tidy checks in a dedicated linting job.

Servo now has **new CI runners** for Windows builds ([@delan](https://github.com/delan), [#33081](https://github.com/servo/servo/pull/33081)), thanks to your donations, **cutting Windows-only build times by 70%**!
We’re not stopping at Windows though, and with new runners for Linux builds just around the corner, your WPT try builds will soon be a lot faster.

We’ve been running some **triage meetings** to investigate GitHub issues and coordinate our work on them.
The next Servo issue triage meeting is on **2 September at 10:00 UTC**.
For more details, see [project#99](https://github.com/servo/project/issues/99).

## Engine reliability

August has been a huge month for squashing **crash bugs** in Servo, including on real-world websites.

We’ve fixed crashes when rendering **floats near tables** in [the HTML spec](https://html.spec.whatwg.org) ([@Wuelle](https://github.com/Wuelle), [#33098](https://github.com/servo/servo/pull/33098)), **removed unnecessary explicit reflows** that were causing crashes on w3schools<!-- no link -->.com ([@jdm](https://github.com/jdm), [#33067](https://github.com/servo/servo/pull/33067)), and **made the HTML parser re-entrant** ([@jdm](https://github.com/jdm), [#32820](https://github.com/servo/servo/pull/32820), [#33056](https://github.com/servo/servo/pull/33056), [html5ever#548](https://github.com/servo/html5ever/pull/548)), fixing crashes on kilonova<!-- no link -->.ro ([#32454](https://github.com/servo/servo/issues/32454)), tweakers<!-- no link -->.net ([#32744](https://github.com/servo/servo/issues/32744)), and many other sites.
Several other crashes have also been fixed:

- crashes when **resizing windows with WebGL** on macOS ([@jdm](https://github.com/jdm), [#33124](https://github.com/servo/servo/pull/33124))
- crashes when rendering text with **extremely long grapheme clusters** ([@crbrz](https://github.com/crbrz), [#33074](https://github.com/servo/servo/pull/33074))
- crashes when rendering text with **tabs in certain fonts** ([@mrobinson](https://github.com/mrobinson), [#32979](https://github.com/servo/servo/pull/32979))
- crashes in the parser **after calling window.stop()** ([@Taym95](https://github.com/Taym95), [#33173](https://github.com/servo/servo/pull/33173))
- crashes when **passing some values to console.log()** ([@jdm](https://github.com/jdm), [#33085](https://github.com/servo/servo/pull/33085))
- crashes when **parsing some &lt;img srcset> values** ([@NotnaKO](https://github.com/NotnaKO), [#32980](https://github.com/servo/servo/pull/32980))
- crashes when **parsing some HTTP header values** ([@ToBinio](https://github.com/ToBinio), [#32973](https://github.com/servo/servo/pull/32973))
- crashes when **setting window.opener** in certain situations ([@Taym95](https://github.com/Taym95), [#33002](https://github.com/servo/servo/pull/33002), [#33122](https://github.com/servo/servo/pull/33122))
- crashes when **removing iframes** from documents ([@newmoneybigbucks](https://github.com/newmoneybigbucks), [#32782](https://github.com/servo/servo/pull/32782))
- crashes when **calling new AudioContext()** with unsupported options ([@Taym95](https://github.com/Taym95), [#33023](https://github.com/servo/servo/pull/33023))
- intermittent crashes in WRSceneBuilder **when exiting Servo** ([@Taym95](https://github.com/Taym95), [#32897](https://github.com/servo/servo/pull/32897))

We’ve fixed a bunch of **BorrowError** crashes under SpiderMonkey GC ([@jdm](https://github.com/jdm), [#33133](https://github.com/servo/servo/pull/33133), [#24115](https://github.com/servo/servo/issues/24115), [#32646](https://github.com/servo/servo/issues/32646)), and we’re now working towards preventing this class of bugs with static analysis ([@jdm](https://github.com/jdm), [#33144](https://github.com/servo/servo/pull/33144)).

Servo no longer **leaks the DOM Window object** when navigating ([@ede1998](https://github.com/ede1998), [@rhetenor](https://github.com/rhetenor), [#32773](https://github.com/servo/servo/pull/32773)), and servoshell now **[terminates abnormally](https://pubs.opengroup.org/onlinepubs/9799919799/functions/V2_chap02.html#tag_16_04_03_01) when panicking** on Unix ([@mrobinson](https://github.com/mrobinson), [#32947](https://github.com/servo/servo/pull/32947)), ensuring [web tests](https://book.servo.org/hacking/testing.html) correctly record their test results as “CRASH”.

## Donations

Thanks again for your generous support!
We are now receiving **3077 USD/month** (+4.1% over July) in recurring donations.
This includes donations from **12 people** on LFX, but we will stop accepting donations there soon — **please move your recurring donations to [GitHub](https://github.com/sponsors/servo) or [Open Collective](https://opencollective.com/servo)**.

Servo is also on [thanks.dev](https://thanks.dev), and already **three GitHub orgs** that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 3077 / 10000); padding-left: 0.5em;"><strong>3077</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 3077 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="3077" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

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
