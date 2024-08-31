---
layout:     post
tags:       blog
title:      "Building a browser using Servo as a web engine!"
date:       2024-08-27
summary:    It's time to build a web browser based on Servo!
categories:
---


As a web engine, Servo primarily handles everything around scripting and layout. Despite having [servoshell](https://github.com/servo/servo/tree/main/ports/servoshell) as a minimum browser reference, it didn’t explore beyond basic functionalities and the test harness for the [web platform test](https://wpt.servo.org/). But fortunately, the Servo community did try to push it bit by bit. The servo shell itself got a [new browser UI](https://servo.org/blog/2023/09/15/upcoming-events-and-new-browser-ui/) from [Egui](https://www.egui.rs/) last year. The [Tauri](https://tauri.app/) community also attempted to [embed](https://servo.org/blog/2024/01/19/embedding-update/) Servo as a backend for proof of concept. This year, [@wusyong](https://github.com/wusyong) created the [Verso](https://github.com/versotile-org/verso) project as an experiment to explore full browser story for Servo. In this post, we will explain what we try to achieve, what we found, and what’s next for building a browser using Servo as a web engine.

## Multi-view

Of course, the first major feature we want to achieve is multiple web views. A web view is a term abstracted from the [top-level browsing context](https://doc.servo.org/servo/struct.TopLevelBrowsingContextId.html). This is what people refer to as a web page. With multi-view support, we can create multiple web pages as tabs in a single window. Most importantly, we can draw our UI with additional web views. The main reason we want to write UI using Servo itself is that we can dog food eating our own stacks and verify if it can meet the practical requirements, such as prompt window, context menu, file selector, and more.

The fundamental support of multi-view was reviewed and merged into Servo earlier this year thanks to [@delan](https://github.com/delan) ([#30840](https://github.com/servo/servo/pull/30840), [#30841](https://github.com/servo/servo/pull/30841), [#30842](https://github.com/servo/servo/pull/30842)). Verso polished it as a specific type called [WebView](https://docs.versotile.org/verso/webview/struct.WebView.html).  And then, any type who owns web views can decide how to present them depending on their IDs. In Verso’s window, two webviews are created at the moment—one for [handling regular web pages](https://docs.versotile.org/verso/window/struct.Window.html#method.handle_servo_messages_with_webview) and the other for [handling the UI](https://docs.versotile.org/verso/window/struct.Window.html#method.handle_servo_messages_with_panel), which is currently called the Panel. The result of the [showcase](https://github.com/versotile-org/verso?tab=readme-ov-file#verso) in Verso’s README.md looks like this:

<figure class="_fig"><a href="{{ '/img/blog/crt-demo.gif' | url }}"><img src="{{ '/img/blog/crt-demo.gif' | url }}"
    alt="Verso displaying ASCII texts with CRT style"></a>
<figcaption>Figure 1: Verso window displaying two different webviews. One for UI, the other for webpage.</figcaption></figure>

For now, the internal process communication is done via Servo’s existing channel messages like [EmbedderMsg](https://doc.servo.org/embedder_traits/enum.EmbedderMsg.html) and [EmbedderEvent](https://doc.servo.org/compositing/windowing/enum.EmbedderEvent.html). We are looking for more granular control to improve the IPC mechanism. There are some candidates like [WebDriverCommandMsg](https://doc.servo.org/script_traits/enum.WebDriverCommandMsg.html). [@webbeef](https://github.com/webbeef) also opened a discussion about [defining custom elements](https://github.com/servo/servo/discussions/32883) like `<web-view>` for ergonomic usage. Overall, improving IPC will be the next target to research after initial multi-view support. We will also define more specific webview types to satisfy different purposes in the future.

## Multi-window

The other prominent feature after multi-view is the ability to support multiple windows. This one wasn’t planned in the early stage, but because it’s related to too many components, we ended up resolving them together from the ground up.


Servo uses [WebRender](https://github.com/servo/webrender), based on OpenGL, to render its layout. To support multiple windows, we need to support various OpenGL surfaces. We can simply choose to create numerous OpenGL contexts for different windows. However, due to the implementations of WebGL, WebGPU, and WebXR, all tight to a WebRender instance, which can only hold one OpenGL context for now, we chose the solution for a single context with multiple surfaces. This could also save us several memory usages and thread spawning. [@wusyong](https://github.com/wusyong) wrote [a series of blog posts](https://wusyong.github.io/posts/verso-compositor-part3/) explaining how all of these work in detail.


<figure class="_fig"><a href="{{ '/img/blog/multiwindow.png' | url }}"><img src="{{ '/img/blog/multiwindow.png' | url }}"
    alt="Verso displaying two windows"></a>
<figcaption>Figure 2: Verso creates two different windows with same OpenGL context.</figcaption></figure>

There is still room for improvement. For example, WebRender currently [only supports rendering a single document](https://github.com/servo/webrender/blob/0.64/webrender/src/renderer/mod.rs#L1228). This means this document has to constantly update different display lists to show on other windows, which may cause race conditions and let unintended webview display on the wrong window in a slip second. There are also different OpenGL versions across multiple platforms, which is challenging to configure and link them. Verso is experimenting with using [Glutin](https://docs.rs/glutin/latest/glutin/) for better configuration and attempting to get closer to the general Rust ecosystem.

## What’s next?

With multi-view and multi-window support as the fundamental building blocks, we could create more UI elements to keep pushing the browser and embedding research. At the same time, we want to reflect on our progress and sort out the priorities. Servo is a huge project, and many potential improvements are still awaiting. Here are some directions that are worth pushing.

#### Are we browser yet?

We are preparing a site, [arewebrowseryet.com](https://servo.zulipchat.com/#narrow/stream/263398-general/topic/arewebrowseryet.2Ecom), in the hope of gathering the strength of the community to help us display the statistics of supported CSS properties and Web APIs in Servo by [popularity order](https://chromestatus.com/metrics/css/popularity) and benchmark results like jetstream2, speedometer3, …etc. We hope this will eventually give newcomers a better overview of Servo.

#### Script triage

There’s a [script triage meeting](https://github.com/servo/project/issues/99) bi-weekly to triage any issues around the script crate and more. Once we get the statistics of supported WebAPIs, we can find the most popular ones that haven’t been implemented or fixed yet. We are already fixing some issues around loading the order and re-implementing [ReadableStream](https://developer.mozilla.org/en-US/docs/Web/API/ReadableStream) in Rust. If you are interested in implementing WebAPIs in Servo, feel free to join the meeting and listen.

#### Multi-process and Sandbox

Some features are crucial to the browser but not visible to users. Multi-process mode and sandbox mode belong to this category. They are already in Servo but are not enabled by default. They also only support Linux and macOS for now. We would like to improve these features and validate them in CICD workflows. In the meantime, we are looking for people who can add Windows support via [Named Pipes](https://learn.microsoft.com/en-us/windows/win32/ipc/named-pipes) and [AppContainer Isolation](https://learn.microsoft.com/en-us/windows/win32/secauthz/appcontainer-isolation).

## Acknowledgment

This work is [sponsored](https://nlnet.nl/project/Servo-Multibrowsing/) by [NLNet](https://nlnet.nl/) and the [Next Generation Internet initiative](https://ngi.eu/). We are grateful the European Commission shares the same vision to push a better and more open browser ecosystem.

<figure class="_fig"><img src="{{ '/img/nlnet-logo.png' | url }}" alt="NLNet Logo" style="vertical-align: middle; margin: 15px; width: 100px;">
  <img src="{{ '/img/blog/NGI-logo.png' | url }}" alt="NGI Logo" style="vertical-align: middle; margin: 15px; width: 100px;"></figure>

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
