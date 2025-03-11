---
layout:     post
tags:       blog
title:      "This month in Servo: new elements, IME support, delegate API, and more!"
date:       2025-03-10
summary:    A huge month for both Servo the browser and Servo the engine.
categories:
---

Servo now supports more HTML and CSS features:

- the **&lt;details>** element ([@simonwuelker](https://github.com/simonwuelker), [#35261](https://github.com/servo/servo/pull/35261))
- the **&lt;meter>** element ([@simonwuelker](https://github.com/simonwuelker), [#35524](https://github.com/servo/servo/pull/35524))
- the **&lt;progress>** element ([@simonwuelker](https://github.com/simonwuelker), [#35531](https://github.com/servo/servo/pull/35531))
- the **‘quotes’** property ([@xiaochengh](https://github.com/xiaochengh), [@Loirooriol](https://github.com/Loirooriol), [#34770](https://github.com/servo/servo/pull/34770), [#35420](https://github.com/servo/servo/pull/35420))
- the **‘isolation’** property ([@kkoyung](https://github.com/kkoyung), [@Loirooriol](https://github.com/Loirooriol), [#35552](https://github.com/servo/servo/pull/35552))
- **‘overflow: clip’** ([@longvatrong111](https://github.com/longvatrong111), [#35103](https://github.com/servo/servo/pull/35103))
- **‘overflow’** property with two values ([@yezhizhen](https://github.com/yezhizhen), [@mrobinson](https://github.com/mrobinson), [#35414](https://github.com/servo/servo/pull/35414))
- the **‘::slotted’** selector ([@simonwuelker](https://github.com/simonwuelker), [#35352](https://github.com/servo/servo/pull/35352))

<figure>

[![servoshell showing new support for <details>, <meter>, and <progress> elements, plus layout support for <slot> elements]({{ "/img/blog/february-2025.png" | url }})]({{ "/img/blog/february-2025.png" | url }})
</figure>

Plus several new web API features:

- **contextmenu** events ([@pewsheen](https://github.com/pewsheen), [#35364](https://github.com/servo/servo/pull/35364))
- **WritableStream** ([@gterzian](https://github.com/gterzian), [@jdm](https://github.com/jdm), [#34844](https://github.com/servo/servo/pull/34844))
- **ReadableStreamBYOBRequest** ([@Taym95](https://github.com/Taym95), [#35074](https://github.com/servo/servo/pull/35074))
- initial support for **FontFace** and its **load()** method ([@mukilan](https://github.com/mukilan), [#35262](https://github.com/servo/servo/pull/35262))
- **toBlob()** and **toDataURL()** on **WebGPU canvases** ([@sagudev](https://github.com/sagudev), [#35237](https://github.com/servo/servo/pull/35237))
- **bytes()** on **Request**, **Response**, and **Blob** ([@shanehandley](https://github.com/shanehandley), [@yoseio](https://github.com/yoseio), [@gterzian](https://github.com/gterzian), [@Taym95](https://github.com/Taym95), [#35250](https://github.com/servo/servo/pull/35250), [#35151](https://github.com/servo/servo/pull/35151))
- **href**, **origin**, **protocol**, **username**, **password**, **host**, **hostname**, **port**, **pathname**, **search**, and **hash** properties on **HTMLAreaElement** ([@shanehandley](https://github.com/shanehandley), [#35482](https://github.com/servo/servo/pull/35482))
- **insertRule() with no argument** on **CSSGroupingRule** ([@Loirooriol](https://github.com/Loirooriol), [#35295](https://github.com/servo/servo/pull/35295))

**&lt;slot> elements** are now fully supported including layout ([@simonwuelker](https://github.com/simonwuelker), [#35220](https://github.com/servo/servo/pull/35220), [#35519](https://github.com/servo/servo/pull/35519)), and we’ve also landed support for the **‘::slotted’** selector ([@simonwuelker](https://github.com/simonwuelker), [#35352](https://github.com/servo/servo/pull/35352)).
**Shadow roots** are now **supported in devtools** ([@simonwuelker](https://github.com/simonwuelker), [#35294](https://github.com/servo/servo/pull/35294)), and we’ve fixed some bugs related to shadow DOM trees ([@simonwuelker](https://github.com/simonwuelker), [#35276](https://github.com/servo/servo/pull/35276), [#35338](https://github.com/servo/servo/pull/35338)), event handling ([@simonwuelker](https://github.com/simonwuelker), [#35380](https://github.com/servo/servo/pull/35380)), and custom elements ([@maxtidev](https://github.com/maxtidev), [@jdm](https://github.com/jdm), [#35382](https://github.com/servo/servo/pull/35382)).

We’ve landed layout improvements around **‘border-collapse’** ([@Loirooriol](https://github.com/Loirooriol), [#35219](https://github.com/servo/servo/pull/35219)), **‘align-content: normal’** ([@rayguo17](https://github.com/rayguo17), [#35178](https://github.com/servo/servo/pull/35178)), **‘place-self’** with **‘position: absolute’** ([@Loirooriol](https://github.com/Loirooriol), [#35208](https://github.com/servo/servo/pull/35208)), the **intrinsic sizing keywords** ([@Loirooriol](https://github.com/Loirooriol), [#35413](https://github.com/servo/servo/pull/35413), [#35469](https://github.com/servo/servo/pull/35469), [#35471](https://github.com/servo/servo/pull/35471), [#35630](https://github.com/servo/servo/pull/35630), [#35642](https://github.com/servo/servo/pull/35642), [#35663](https://github.com/servo/servo/pull/35663), [#35652](https://github.com/servo/servo/pull/35652), [#35688](https://github.com/servo/servo/pull/35688)), and **‘position: absolute’** now works correctly in a **‘position: relative’ grid item** ([@stevennovaryo](https://github.com/stevennovaryo), [#35014](https://github.com/servo/servo/pull/35014)).

Input has also been improved, with **better IME support** ([@dklassic](https://github.com/dklassic), [#35535](https://github.com/servo/servo/pull/35535), [#35623](https://github.com/servo/servo/pull/35623)) and several fixes to touch input ([@kongbai1996](https://github.com/kongbai1996), [@jschwe](https://github.com/jschwe), [@shubhamg13](https://github.com/shubhamg13), [#35450](https://github.com/servo/servo/pull/35450), [#35031](https://github.com/servo/servo/pull/35031), [#35550](https://github.com/servo/servo/pull/35550), [#35537](https://github.com/servo/servo/pull/35537), [#35692](https://github.com/servo/servo/pull/35692)).

## Servo-the-browser (servoshell)

**Directory listings** are now enabled for local files ([@mrobinson](https://github.com/mrobinson), [#35317](https://github.com/servo/servo/pull/35317)).

<figure>

[![servoshell showing a local directory listing]({{ "/img/blog/2025-02-directory-listing.png" | url }})]({{ "/img/blog/2025-02-directory-listing.png" | url }})
</figure>

servoshell’s **dialogs now use egui** ([@chickenleaf](https://github.com/chickenleaf), [#34823](https://github.com/servo/servo/pull/34823), [#35399](https://github.com/servo/servo/pull/35399), [#35464](https://github.com/servo/servo/pull/35464), [#35507](https://github.com/servo/servo/pull/35507), [#35564](https://github.com/servo/servo/pull/35564), [#35577](https://github.com/servo/servo/pull/35577), [#35657](https://github.com/servo/servo/pull/35657), [#35671](https://github.com/servo/servo/pull/35671)), rather than shelling out to a program like `zenity` ([@chickenleaf](https://github.com/chickenleaf), [#35674](https://github.com/servo/servo/pull/35674)), making them more secure and no longer falling back to terminal input.

<figure>

[![egui-based dialogs for alert(), confirm(), prompt(), and HTTP authentication]({{ "/img/blog/2025-02-egui-dialogs.png" | url }})]({{ "/img/blog/2025-02-egui-dialogs.png" | url }})
</figure>

We’ve also fixed a bug when closing a tab other than the current one ([@pewsheen](https://github.com/pewsheen), [#35569](https://github.com/servo/servo/pull/35569)).

## Servo-the-engine (embedding)

We’ve simplified our embedding API by **merging all input event delivery** into [`WebView::notify_input_event`](https://doc.servo.org/servo/struct.WebView.html#method.notify_input_event) ([@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#35430](https://github.com/servo/servo/pull/35430)), making **bluetooth optional** ([@jdm](https://github.com/jdm), [@webbeef](https://github.com/webbeef), [#35479](https://github.com/servo/servo/pull/35479), [#35590](https://github.com/servo/servo/pull/35590)), making the **“background hang monitor” optional** ([@jdm](https://github.com/jdm), [#35256](https://github.com/servo/servo/pull/35256)), and **eliminating the need to depend on `webxr`** ([@mrobinson](https://github.com/mrobinson), [#35229](https://github.com/servo/servo/pull/35229)).
We’ve also moved some servoshell-only options out of [`Opts`](https://doc.servo.org/servo_config/opts/struct.Opts.html) ([@mrobinson](https://github.com/mrobinson), [#35377](https://github.com/servo/servo/pull/35377), [#35407](https://github.com/servo/servo/pull/35407)), since they have no effect on Servo’s behaviour.

We’ve landed our initial **delegate-based API** ([@delan](https://github.com/delan), [@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#35196](https://github.com/servo/servo/pull/35196), [#35260](https://github.com/servo/servo/pull/35260), [#35297](https://github.com/servo/servo/pull/35297), [#35396](https://github.com/servo/servo/pull/35396), [#35400](https://github.com/servo/servo/pull/35400), [#35544](https://github.com/servo/servo/pull/35544), [#35579](https://github.com/servo/servo/pull/35579), [#35662](https://github.com/servo/servo/pull/35662), [#35672](https://github.com/servo/servo/pull/35672)), which replaces our old message-based API for integrating Servo with your app ([@mrobinson](https://github.com/mrobinson), [@delan](https://github.com/delan), [@mukilan](https://github.com/mukilan), [#35284](https://github.com/servo/servo/pull/35284), [#35315](https://github.com/servo/servo/pull/35315), [#35366](https://github.com/servo/servo/pull/35366)).
By implementing [`WebViewDelegate`](https://doc.servo.org/servo/trait.WebViewDelegate.html) and [`ServoDelegate`](https://doc.servo.org/servo/trait.ServoDelegate.html) and [installing](https://doc.servo.org/servo/struct.WebView.html#method.set_delegate) [them](https://doc.servo.org/servo/struct.Servo.html#method.set_delegate), you can have Servo call back into your app’s logic with ease.

We’ve simplified the [`RenderingContext`](https://doc.servo.org/servo/trait.RenderingContext.html) trait ([@wusyong](https://github.com/wusyong), [@mrobinson](https://github.com/mrobinson), [#35251](https://github.com/servo/servo/pull/35251), [#35553](https://github.com/servo/servo/pull/35553)) and **added three built-in `RenderingContext` impls** ([@mrobinson](https://github.com/mrobinson), [@mukilan](https://github.com/mukilan), [#35465](https://github.com/servo/servo/pull/35465), [#35501](https://github.com/servo/servo/pull/35501)), making it easier to set up a context Servo can render to:

- [`WindowRenderingContext`](https://doc.servo.org/servo/struct.WindowRenderingContext.html) renders to a **whole window**
- [`OffscreenRenderingContext`](https://doc.servo.org/servo/struct.OffscreenRenderingContext.html) renders to **part of a window**
- [`SoftwareRenderingContext`](https://doc.servo.org/servo/struct.SoftwareRenderingContext.html) renders to an image, **without hardware acceleration**

We’ve heavily reworked and documented our **webview rendering model** ([@mrobinson](https://github.com/mrobinson), [@wusyong](https://github.com/wusyong), [@mukilan](https://github.com/mukilan), [#35522](https://github.com/servo/servo/pull/35522), [#35621](https://github.com/servo/servo/pull/35621)), **moved image output** and **shutdown logic** out of the compositor ([@mrobinson](https://github.com/mrobinson), [@wusyong](https://github.com/wusyong), [#35538](https://github.com/servo/servo/pull/35538)), and removed some complicated logic around synchronous repaints when a window is resized ([@mrobinson](https://github.com/mrobinson), [#35283](https://github.com/servo/servo/pull/35283), [#35277](https://github.com/servo/servo/pull/35277)).
These changes should make it a lot clearer how to get Servo’s webviews onto your display.

One part of this model that we’re starting to move away from is the support for multiple webviews in one rendering context ([@mrobinson](https://github.com/mrobinson), [@wusyong](https://github.com/wusyong), [#35536](https://github.com/servo/servo/pull/35536)).
First landed in [#31417](https://github.com/servo/servo/pull/31417), this was an expedient way to add support for multiple webviews, but it imposed some serious limitations on how webviews could be interleaved with other app content, and the performance and security was inadequate.

We’ve **updated our [winit_minimal example](https://github.com/servo/servo/blob/139774e6b55c297bc94f7fcb8c9bf5bb8c6a7474/components/servo/examples/winit_minimal.rs)** to take advantage of these changes ([@webbeef](https://github.com/webbeef), [#35350](https://github.com/servo/servo/pull/35350), [#35686](https://github.com/servo/servo/pull/35686)), simplify it further ([@robertohuertasm](https://github.com/robertohuertasm), [#35253](https://github.com/servo/servo/pull/35253)), and fix window resizing ([@webbeef](https://github.com/webbeef), [#35691](https://github.com/servo/servo/pull/35691)).

## Perf and stability

The compositor now **notifies the embedder of new frames immediately** ([@mrobinson](https://github.com/mrobinson), [#35369](https://github.com/servo/servo/pull/35369)), not via the constellation thread.

Servo’s typical **memory usage has been reduced by over 1%** thanks to Node object optimisations ([@webbeef](https://github.com/webbeef), [#35592](https://github.com/servo/servo/pull/35592), [#35554](https://github.com/servo/servo/pull/35554)), and we’ve also improved our [memory profiler](https://book.servo.org/hacking/profiling.html#memory-profiling) ([@webbeef](https://github.com/webbeef), [#35618](https://github.com/servo/servo/pull/35618), [#35607](https://github.com/servo/servo/pull/35607)).

We’ve fixed a bug causing very high CPU usage on sites like wikipedia.org ([@webbeef](https://github.com/webbeef), [#35245](https://github.com/servo/servo/pull/35245)), as well as bugs affecting requestAnimationFrame ([@mukilan](https://github.com/mukilan), [#35387](https://github.com/servo/servo/pull/35387), [#35435](https://github.com/servo/servo/pull/35435)).

You can now configure our tracing-based profiler (`--features tracing`) with `servo --tracing-filter` instead of `SERVO_TRACING` ([@jschwe](https://github.com/jschwe), [#35370](https://github.com/servo/servo/pull/35370)).

We’ve continued **reducing our use of `unsafe` in script** ([@nscaife](https://github.com/nscaife), [@stephenmuss](https://github.com/stephenmuss), [#35351](https://github.com/servo/servo/pull/35351), [#35360](https://github.com/servo/servo/pull/35360), [#35367](https://github.com/servo/servo/pull/35367), [#35411](https://github.com/servo/servo/pull/35411)), and **moving parts of `script` to `script_bindings`** ([@jdm](https://github.com/jdm), [#35279](https://github.com/servo/servo/pull/35279), [#35280](https://github.com/servo/servo/pull/35280), [#35292](https://github.com/servo/servo/pull/35292), [#35457](https://github.com/servo/servo/pull/35457), [#35459](https://github.com/servo/servo/pull/35459), [#35578](https://github.com/servo/servo/pull/35578), [#35620](https://github.com/servo/servo/pull/35620)).
Breaking up our massive `script` crate is absolutely critical for reducing Servo’s build times.

We’ve fixed crashes that happen when moving windows past the edge of your monitor ([@webbeef](https://github.com/webbeef), [#35235](https://github.com/servo/servo/pull/35235)), when unpaired UTF-16 surrogates are sent to the DOM ([@mrobinson](https://github.com/mrobinson), [#35381](https://github.com/servo/servo/pull/35381)), when focusing elements inside shadow roots ([@simonwuelker](https://github.com/simonwuelker), [#35606](https://github.com/servo/servo/pull/35606)), and when calling getAsString() on a DataTransferItem ([@Gae24](https://github.com/Gae24), [#35699](https://github.com/servo/servo/pull/35699)).
We’ve also continued working on static analysis that will help catch crashes due to [GC borrow hazards](https://github.com/servo/servo/issues/33140) ([@augustebaum](https://github.com/augustebaum), [@yerke](https://github.com/yerke), [@jdm](https://github.com/jdm), [@Gae24](https://github.com/Gae24), [#35541](https://github.com/servo/servo/pull/35541), [#35593](https://github.com/servo/servo/pull/35593), [#35565](https://github.com/servo/servo/pull/35565), [#35610](https://github.com/servo/servo/pull/35610), [#35591](https://github.com/servo/servo/pull/35591), [#35609](https://github.com/servo/servo/pull/35609), [#35601](https://github.com/servo/servo/pull/35601), [#35596](https://github.com/servo/servo/pull/35596), [#35595](https://github.com/servo/servo/pull/35595), [#35594](https://github.com/servo/servo/pull/35594), [#35597](https://github.com/servo/servo/pull/35597), [#35622](https://github.com/servo/servo/pull/35622), [#35604](https://github.com/servo/servo/pull/35604), [#35616](https://github.com/servo/servo/pull/35616), [#35605](https://github.com/servo/servo/pull/35605), [#35640](https://github.com/servo/servo/pull/35640), [#35647](https://github.com/servo/servo/pull/35647), [#35646](https://github.com/servo/servo/pull/35646)).

## Donations

Thanks again for your generous support!
We are now receiving **4363 USD/month** (+13.7% over January) in recurring donations.
This helps cover the cost of our [self-hosted](https://ci0.servo.org) [CI](https://ci1.servo.org) [runners](https://ci2.servo.org) and [Outreachy](https://www.outreachy.org/) internships.

Servo is also on [thanks.dev](https://thanks.dev), and already **21 GitHub users** (+5 over January) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 4363 / 10000); padding-left: 0.5em;"><strong>4363</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 4363 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="4363" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

As always, use of these funds will be decided transparently in the Technical Steering Committee.
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
