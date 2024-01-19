---
layout:     post
tags:       blog
title:      "Embedding update"
date:       2023-12-18
summary:    "ao!! wrrrrao!!"
categories:
---

[Back in November]({{ '/blog/2023/11/30/embedding-floats-color-mix/' | url }}), we highlighted our ongoing efforts to make Servo more embeddable, and today we are a few steps closer!

[Tauri](https://tauri.app) is a framework for building desktop apps that combine a web frontend with a Rust backend, and work is already ongoing to expand it to mobile apps and other backend languages.
But unlike say, Electron or React Native, Tauri is both frontend-agnostic and engine-agnostic, allowing you to use any frontend tooling you like and whichever web engine makes the most sense for your users.

To integrate Servo with Tauri, we need to add **support for Servo in [WRY](https://github.com/tauri-apps/wry)**, the underlying webview library, and the developers of Tauri have created a proof of concept doing exactly that!
While this is definitely not production-ready yet, you can play around with it by checking out the [servo-wry-demo](https://github.com/tauri-apps/wry/tree/servo-wry-demo) branch ([permalink](https://github.com/tauri-apps/wry/tree/305220efbe4e8b5813543a7b8f5d8e0a8abb7fbc)) and following the README.

<figure class=_fig id=_wry_demo_fig>
<iframe src="{{ '/img/blog/embedding-2024-01/demo-with-decorations-too.html' | url }}"
        id=_wry_demo></iframe>
</figure>

While servoshell, [our example browser]({{ '/blog/2023/09/15/upcoming-events-and-new-browser-ui/' | url }}), continues to be the “reference” for embedding Servo, this has its limitations in that servoshell’s needs are often simpler than those of a general-purpose embeddable webview.
For example, the “minibrowser” UI needs the ability to reserve space at the top of the window, and hook the presenting of new frames to do extra drawing, but it doesn’t currently need multiple webviews.

This is where working with the Tauri team has been especially invaluable for Servo — they’ve used their experience integrating with other embeddable webviews to guide changes on the Servo side.
Early changes include making it possible to **position Servo webviews** anywhere within a native window ([@wusyong](https://github.com/wusyong), [#30088](https://github.com/servo/servo/pull/30088)), and give them **translucent or transparent backgrounds** ([@wusyong](https://github.com/wusyong), [#30488](https://github.com/servo/servo/pull/30488)).

Support for **multiple webviews** in one window is needed for parity with the other WRY backends.
Servo currently has a fairly pervasive assumption that only one webview is active at a time.
We’ve found almost all of the places where this assumption was made ([@delan](https://github.com/delan), [#30648](https://github.com/servo/servo/pull/30648)), and now we’re breaking those findings into changes that can actually be reviewed and landed ([@delan](https://github.com/delan), [#30840](https://github.com/servo/servo/pull/30840), [#30841](https://github.com/servo/servo/pull/30841), [#30842](https://github.com/servo/servo/pull/30842)).

Support for **multiple windows** sounds similar, but it’s a lot harder.
Servo handles user input and drawing with a component known for historical reasons as the “compositor”.
Since the constellation — the heart of Servo — is currently associated with exactly one compositor, and the compositor is currently tightly coupled with the event loop of exactly one window, supporting multiple windows will require some big architectural changes.
[@paulrouget](https://github.com/paulrouget)’s extensive research and prior work on making Servo embeddable will prove especially helpful.

**Offscreen rendering** is critical for integrating Servo with apps containing non-Servo components.
For example, you might have a native app that uses Servo for online help or an OAuth flow, or a game that uses Servo for purchases or social features.
We can now draw Servo to an offscreen framebuffer and let the app decide how to present it ([@delan](https://github.com/delan), [#30767](https://github.com/servo/servo/pull/30767)), rather than assuming control of the whole window, and servoshell now uses this ability except when the minibrowser is disabled (`--no-minibrowser`).

**Precompiling [mozangle](https://github.com/servo/mozangle)** and [**mozjs**](https://github.com/servo/mozjs) would improve developer experience by reducing initial build times.
We can now build the C++ parts of mozangle as a dynamic library (.so/.dylib/.dll) on Linux and macOS ([@atbrakhi](https://github.com/atbrakhi), [mozangle#71](https://github.com/servo/mozangle/pull/71)), though more work is needed to distribute and make use of them.

We’re exploring two approaches to precompiling mozjs.
The easier approach is to build the C++ parts as a static library (.a/.lib) and cache the generated Rust bindings ([@wusyong](https://github.com/wusyong), [mozjs#439](https://github.com/servo/mozjs/issues/439)).
Building a dynamic library ([@atbrakhi](https://github.com/atbrakhi), [mozjs#432](https://github.com/servo/mozjs/pull/432)) will be more difficult, but it should reduce build times even further.

Many thanks to [**NLnet**](https://nlnet.nl) for [sponsoring this work](https://nlnet.nl/project/Tauri-Servo/).

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
    ._fig._min {
        width: min-content;
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
    }
    ._figr {
        float: right;
    }
    ._figl > iframe,
    ._figr > iframe,
    ._figl > a > img,
    ._figr > a > img {
        width: 17em;
        max-width: max-content;
    }
    ._figl._default > iframe,
    ._figr._default > iframe,
    ._figl._default > a > img,
    ._figr._default > a > img {
        width: auto;
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
    #_wry_demo_fig:not(#specificity) {
        width: 100%;
    }
    #_wry_demo {
        margin: 0 auto;
        display: block;
        height: min(calc(100vh - 9em), 400px);
        width: 100%;
    }
</style>
