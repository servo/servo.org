---
layout:     post
tags:       blog
title:      "This month in Servo: console logging, parallel tables, OpenXR, and more!"
date:       2024-07-31
summary:    Servo’s unique parallel layout engine just got even better.
categories:
---

<figure><a href="{{ '/img/blog/quest-3-passthrough.png' | url }}"><img src="{{ '/img/blog/quest-3-passthrough.png' | url }}"
    alt="Servo displaying WebXR content on a Quest 3 in Quest Link mode"></a>
<figcaption>Figure 1: Servo can now render to XR headsets via OpenXR. Image: Daniel Adams (<a href="https://twitter.com/msub2official/status/1818533316477251669">Twitter</a>)</figcaption></figure>

<span class=_floatmin></span>
Servo has had several new features land in our nightly builds over the last month:

- as of 2024-06-27, **document.fonts.ready** ([@mukilan](https://github.com/mukilan), [@mrobinson](https://github.com/mrobinson), [#32576](https://github.com/servo/servo/pull/32576))
- as of 2024-07-03, the **getCompilationInfo() method on GPUShaderModule** ([@sagudev](https://github.com/sagudev), [#32642](https://github.com/servo/servo/pull/32642))
- as of 2024-07-08, window.**customElements.getName** ([@keithamus](https://github.com/keithamus), [#32715](https://github.com/servo/servo/pull/32715))
- as of 2024-07-09, **&lt;caption> in tables** ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [@mukilan](https://github.com/mukilan), [#32657](https://github.com/servo/servo/pull/32657), [#32695](https://github.com/servo/servo/pull/32695))
- as of 2024-07-13, **document.visibilityState** and **document.hidden** ([@wusyong](https://github.com/wusyong), [#32635](https://github.com/servo/servo/pull/32635))
- as of 2024-07-18, the **measureText() method on CanvasRenderingContext2D** ([@chocolate-pie](https://github.com/chocolate-pie), [#32704](https://github.com/servo/servo/pull/32704))
- as of 2024-07-23, **URL.parse()** ([@shanehandley](https://github.com/shanehandley), [#32819](https://github.com/servo/servo/pull/32819))

We’ve also landed an experimental **OpenXR backend** ([@msub2](https://github.com/msub2), [#32817](https://github.com/servo/servo/pull/32817)), allowing Servo to display WebXR content on actual headsets like the **Quest 3** in Quest Link mode.
You can enable it with `--pref dom.webxr.openxr.enabled`, though the backend currently only works on Windows.

<figure><a href="{{ '/img/blog/july-2024.png' | url }}"><img src="{{ '/img/blog/july-2024.png' | url }}"
    alt="Servo nightly showing a table with a caption, containing demos of several other new features"></a>
<figcaption>Figure 2: a table with a caption, containing demos of several other new features.</figcaption></figure>

## <span class=_floatmin></span>Rendering changes

**Parallel table layout** is now enabled ([@mrobinson](https://github.com/mrobinson), [#32477](https://github.com/servo/servo/pull/32477)), spreading the work for laying out rows and their columns over all available CPU cores.
This change is a great example of the strengths of [Rayon](https://crates.io/crates/rayon) and the opportunistic parallelism in Servo’s layout engine.

We‘ve also made progress on our new **flexbox layout engine** (`--pref layout.flexbox.enabled`), landing support for **‘min-height’** and **‘max-height’** on row containers ([@delan](https://github.com/delan), [@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#32785](https://github.com/servo/servo/pull/32785)), as well as **baseline alignment of row containers** with their siblings ([@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [@delan](https://github.com/delan), [#32841](https://github.com/servo/servo/pull/32841), [#32810](https://github.com/servo/servo/pull/32810)) and for their items by setting **‘align-items’** or **‘align-self’** to **‘baseline’**, **‘first baseline’**, or **‘last baseline’** ([@delan](https://github.com/delan), [@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [@nicoburns](https://github.com/nicoburns), [#32787](https://github.com/servo/servo/pull/32787), [#32790](https://github.com/servo/servo/pull/32790)).

<aside class="_note">

Note that our flexbox layout support is still very much experimental, and missing major functionality such as ‘flex-direction: column’.
</aside>

We’ve landed support for **generic font families** like ‘sans-serif’ and ‘monospace’ ([@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#32673](https://github.com/servo/servo/pull/32673)), as well as **commas in &lt;font face>** ([@mrobinson](https://github.com/mrobinson), [#32622](https://github.com/servo/servo/pull/32622)) and fixes for font matching on Android and OpenHarmony ([@jschwe](https://github.com/jschwe), [#32725](https://github.com/servo/servo/pull/32725), [#32731](https://github.com/servo/servo/pull/32731)).

For **replaced elements** like &lt;img> and &lt;canvas>, the **‘min-width’**, **‘max-width’**, **‘min-height’**, and **‘max-height’** properties now **respect the aspect ratio** of the element ([@valadaptive](https://github.com/valadaptive), [#32777](https://github.com/servo/servo/pull/32777)), and you can now change that aspect ratio with the **‘aspect-ratio’ property** ([@valadaptive](https://github.com/valadaptive), [#32800](https://github.com/servo/servo/pull/32800), [#32803](https://github.com/servo/servo/pull/32803)).

<figure class="_figr"><a href="{{ '/img/blog/devtools-july-2024.png' | url }}"><img src="{{ '/img/blog/devtools-july-2024.png' | url }}"
    alt="Firefox devtools connected to Servo, showing several console errors"></a>
<figcaption>Figure 3: console logging is now supported when using the Firefox devtools.</figcaption></figure>

## <span class=_floatmin></span>Devtools and servoshell changes

When debugging in Servo [with the **Firefox devtools**](https://book.servo.org/running-servoshell.html), you can now see **console messages** from the page ([@eerii](https://github.com/eerii), [#32727](https://github.com/servo/servo/pull/32727)), as shown in *Figure 3*, and you can even debug the devtools connection itself with our new **devtools protocol analyzer** ([@eerii](https://github.com/eerii), [#32684](https://github.com/servo/servo/pull/32684)).

servoshell now has experimental **OpenHarmony support** ([@jschwe](https://github.com/jschwe), [#32594](https://github.com/servo/servo/pull/32594)), in addition to our experimental Android support and nightly releases for Windows, macOS, and Linux.
We’ve also landed **directory listings** for local files ([@Bobulous](https://github.com/Bobulous), [@mrobinson](https://github.com/mrobinson), [#32580](https://github.com/servo/servo/pull/32580)), made the location bar behave more consistently on Android ([@jschwe](https://github.com/jschwe), [#32586](https://github.com/servo/servo/pull/32586)), and servoshell no longer quits when you press Escape ([@mrego](https://github.com/mrego), [#32603](https://github.com/servo/servo/pull/32603)).

<figure class="_figr" style="clear: right;"><div style="text-align: left;">

| Version and build config | `servo` binary size |
|---|---|
| Before [#32651](https://github.com/servo/servo/pull/32651) | 126364k |
| With [#32651](https://github.com/servo/servo/pull/32651) | 110111k (−12.8%) |
| With [#32651](https://github.com/servo/servo/pull/32651)<br>• Without debug symbols | 102878k (−18.5%) |
| With [#32759](https://github.com/servo/servo/pull/32759)<br>• Without `layout_2013` | 107652k (−14.8%) |
| With [#32759](https://github.com/servo/servo/pull/32759)<br>• Without debug symbols<br>• Without `layout_2013` | 100886k (−20.1%) |
</div>
<figcaption>Figure 4: servoshell binary size improvements on Linux (amd64).</figcaption></figure>

<span class=_floatmin></span>
To reduce servoshell’s binary size, we now build our nightly releases with **ThinLTO** ([@jschwe](https://github.com/jschwe), [#32651](https://github.com/servo/servo/pull/32651)), and you can go even further by building Servo **without debug symbols** ([@jschwe](https://github.com/jschwe), [#32651](https://github.com/servo/servo/pull/32651)) or **without the legacy layout engine** ([@jschwe](https://github.com/jschwe), [#32759](https://github.com/servo/servo/pull/32759)).
Note that these builds use the `production` profile in Cargo, not the `release` profile.

## Changes for Servo developers

[**The Servo book**](https://book.servo.org) is now the place to go for Servo’s documentation ([@delan](https://github.com/delan), [#32743](https://github.com/servo/servo/pull/32743)).
It includes our architecture and design docs, a link to our API docs, as well as docs on building, running, testing, debugging, and profiling Servo.

Servo now builds without the `crown` linter by default ([@jschwe](https://github.com/jschwe), [#32494](https://github.com/servo/servo/pull/32494)), simplifying the build process in some cases.
If you’re working on DOM code, you can enable it again with `./mach build --use-crown`.

<figure class="_figr" style="clear: right;"><a href="{{ '/img/blog/dco-check.png' | url }}"><img src="{{ '/img/blog/dco-check.png' | url }}"
    alt="GitHub checks popup showing the “DCO” check failing and a link to “Details”"></a>
<figcaption>Figure 5: the DCO check will now fail unless you sign off your commits.</figcaption></figure>

<span class=_floatmin></span>
When contributing to Servo, **your commits must now be [“signed off”](https://developercertificate.org)**, which is essentially a promise that you own (or are allowed to contribute) the code in your patch.
If the DCO check fails, click Details for help on signing off your commits (*Figure 5*).

<aside class="_note">

Note that this is **not** a contributor license agreement (CLA), which would allow Servo to become closed source someday, nor is it a copyright assignment.
</aside>

## Donations

Thanks again for your generous support!
We are now receiving **2955 USD/month** (+32.6% over June) in recurring donations.

Servo is now on [thanks.dev](https://thanks.dev), and already **three GitHub orgs** that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

We are still receiving donations from **14 people** on LFX, but we will stop accepting donations there soon — **please move your recurring donations to [GitHub](https://github.com/sponsors/servo) or [Open Collective](https://opencollective.com/servo)**.
In the meantime, we’ve transferred **2723 USD** of donations from LFX to our Open Collective account.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 2955 / 10000); padding-left: 0.5em;"><strong>2955</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 2955 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="2955" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

As always, use of these funds will be decided transparently in the Technical Steering Committee.
Our updated proposal for a [dedicated server for CI runners](https://github.com/servo/project/issues/94#issuecomment-2252262955) ([@delan](https://github.com/delan), [@sagudev](https://github.com/sagudev), [@nicoburns](https://github.com/nicoburns)) was accepted, which should reduce build times significantly, and this is just the start!

For more details, head to our [Sponsorship page]({{ '/sponsorship/' | url }}).

## Conferences and blogs

- [**Servo: A web rendering engine for the future**](https://www.youtube.com/watch?v=SamA5Oz-G5w) ([slides](https://servo.org/slides/2024-07-02-global-software-technology-summit/)) — Manuel Rego spoke at the [Global Software Technology Summit 2024](https://huawei-events.de/en/gsts24.htm) about the status and long-term vision of the Servo project
- [**Verso: A new browser based on Servo**](https://wusyong.github.io/posts/verso-0-1/) — Wu Yu Wei wrote about their plans to build a more polished Servo-based browser while improving Servo’s architecture
- [**Verso: Writing its own compositor part 1**](https://wusyong.github.io/posts/verso-compositor-part1/) — Wu Yu Wei uses Verso as a sandbox to explore how we might rework Servo’s compositor to support multiple windows
- [**Halfway point**](https://conflor.es/blog/03_halfway_point) — Eri wrote about repairing Servo’s devtools support, from planning to selecting tabs to finding resources and now the console, as part of their Outreachy internship

## Alan Jeffrey (1967–2024)

[Alan Jeffrey](https://web.archive.org/web/20240714161830/https://asaj.org/), an early member of the Servo team and a key part of helping the Servo project find a new life outside of Mozilla, passed away on 4 July.

His research has furthered a wide range of fields, including concurrent and distributed systems, programming languages, formal verification, software semantics, typesetting, protocol security, and circuit design.

Alan’s family have also written about his kindness, curiosity, and persistence [on his LinkedIn page](https://www.linkedin.com/feed/update/activity:7215033040614436865/).

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
