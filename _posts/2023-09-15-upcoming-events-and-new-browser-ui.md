---
layout:     post
tags:       blog
title:      "This month in Servo: upcoming events, new browser UI, and more!"
date:       2023-09-15
summary:    Conferences and booths you can find us at in September, plus nightly updates around rustls, WebGPU, ARM32, floats, white-space, crash handling, and browser UI.
categories:
---

Servo has had some exciting changes land in our nightly builds over the last month:

* as of 2023-08-09, we now use **rustls** instead of OpenSSL ([#30025](https://github.com/servo/servo/pull/30025))
* as of 2023-08-21, our experimental **WebGPU** support was updated ([#29795](https://github.com/servo/servo/pull/29795), [#30359](https://github.com/servo/servo/pull/30359))
* as of 2023-08-26, we can now build on **ARM32** in addition to ARM64 ([#30204](https://github.com/servo/servo/pull/30204))
* as of 2023-09-01, CSS **floats** are now supported again ([#30243](https://github.com/servo/servo/pull/30243) et al)
* as of 2023-09-05, **‘white-space: nowrap’** is now supported again ([#30259](https://github.com/servo/servo/pull/30259))
* as of 2023-09-07, we have an improved **crash error page** ([#30290](https://github.com/servo/servo/pull/30290))
* as of 2023-09-15, our **new browser UI** is enabled by default ([#30049](https://github.com/servo/servo/issues/30049))

<style>
    /* guaranteed minimum width for first paragraph after a float */
    ._floatmin {
        display: block;
        width: 13em;
        overflow: hidden;
    }
    .figl:not(#specificity),
    .figr:not(#specificity) {
        margin: 0 1em 1em;
    }
    .figl {
        float: left;
    }
    .figr {
        float: right;
    }
    .figl > a > img,
    .figr > a > img {
        width: 17em;
        max-width: max-content;
    }
    .figw > a > img {
        width: 33em;
        max-width: 100%;
    }
</style>

<figure class="figr"><a href="{{ '/img/blog/webgpu-game-of-life.png' | url }}"><img src="{{ '/img/blog/webgpu-game-of-life.png' | url }}"
    alt="WebGPU game of life, showing a 32x32 grid where the living cells are shaded with a rainbow texture"></a></figure>

<span class="_floatmin"></span>While our **WebGPU** support is still very much experimental (`--pref dom.webgpu.enabled`), it now passes over 5000 more tests in the [Conformance Test Suite](https://github.com/gpuweb/cts), after an upgrade from wgpu 0.6 (2020) to 0.16 (2023) and the addition of GPUSupportedFeatures. A few WebGPU demos now run too, notably those that don’t require [changing the width or height on the fly](https://github.com/servo/servo/blob/0b86d6579823d0786b37cee86eaaf3ce6bd8aa7d/components/script/dom/htmlcanvaselement.rs#L98-L110), such as the [Conway’s Game of Life](https://sagudev.github.io/briefcase/first-webgpu/9-endgame.html) built in [Your first WebGPU app](https://codelabs.developers.google.com/your-first-webgpu-app).

Both of these were contributed by [Samson @sagudev](https://github.com/sagudev), who has also done a lot of work on our DOM bindings, SpiderMonkey integration, and CI workflows, and we’re pleased to now have them join Servo as a reviewer too!

<figure class="figl"><a href="{{ '/img/blog/floats-wikipedia.png' | url }}"><img src="{{ '/img/blog/floats-wikipedia.png' | url }}"
    alt="Wikipedia article for Servo, showing article text flowing around the floating infobox on the right"></a></figure>

On the CSS front, **floats** and **‘white-space: nowrap’** were previously only supported in our legacy layout engine (`--legacy-layout`), but now they are supported again, and better than ever before! Floats in particular are one of the trickiest parts of CSS2, and our legacy version had many bugs that were essentially unfixable due to the [legacy layout architecture]({{ '/blog/2023/04/13/layout-2013-vs-2020/' | url }}).

Sometimes Servo crashes due to bugs or unimplemented features, and Rust helps us ensure that they almost always happen *safely* by panicking, but there’s still a lot we can do to improve the user experience while surfacing those panics, especially on platforms without stdio like Windows.

Our new **crash error page** shows the panic message and stack trace, instead of a confusing “unexpected scheme” error, and allows the user to reload the page. Note that not all crashes are handled gracefully yet — more work is needed to allow recovery from crashes in style and layout.

<figure class="figw"><a href="{{ '/img/blog/crash-error-page.png' | url }}"><img src="{{ '/img/blog/crash-error-page.png' | url }}"
    alt="Servo’s new crash error page, showing a fake panic!() inserted at the start of Document::Write"></a></figure>

Servo’s example browser — the nightly version of Servo you can download and run — now has a location bar! This **new browser UI**, or “minibrowser” mode, is now enabled by default, though you can disable it with `--no-minibrowser` if you run into any problems. See also [#30049](https://github.com/servo/servo/issues/30049) for known issues with the minibrowser.

<figure class="figw"><a href="{{ '/img/blog/new-browser-ui.png' | url }}"><img src="{{ '/img/blog/new-browser-ui.png' | url }}"
    alt="Servo’s new browser UI, showing a toolbar with a location field and go button"></a></figure>

### Upcoming events

September is also a big month for Servo as a project! We have [joined Linux Foundation Europe](https://linuxfoundation.eu/newsroom/servo-web-rendering-engine-joins-linux-foundation-europe), and we’re also attending several events in Bilbao, Spain, and Shanghai, China.

Servo will be at the [LF Europe Member Summit](https://events.linuxfoundation.org/lf-europe-member-summit/program/schedule/) in Bilbao, with a [brief project update](https://lfeuropems2023.sched.com/event/1PCHu) on **18&#xA0;September** at **10:45 local time** (08:45 UTC), and the [Open Source Summit Europe](https://events.linuxfoundation.org/open-source-summit-europe/), with Manuel Rego [speaking about Servo](https://osseu2023.sched.com/event/1OGkc) on **21&#xA0;September** at **11:55 local time** (09:55 UTC).

At both events, we will also have a booth where you can play with Servo on a real device and ask us questions about the project, all day from **18&#xA0;September** through **21&#xA0;September**.

The following week, you can find us at the [GOSIM](https://www.gosim.org/#events) [workshop](https://workshop2023.gosim.org/) and [conference](https://conference2023.gosim.org/) in Shanghai, with Martin Robinson presenting one workshop and one talk:

* [**You can work on the web platform!**](https://workshop2023.gosim.org/schedule#mobile) — an introduction to hacking on Servo, on **24&#xA0;September** at **13:45 local time** (05:45 UTC)
* [**Servo: a web view from somewhere else**](https://conference2023.gosim.org/schedule#mobile) — a case for embeddable web engine diversity and Servo’s role in improving that, on **26&#xA0;September** at **14:45 local time** (06:45 UTC)
