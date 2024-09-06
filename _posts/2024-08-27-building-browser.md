---
layout:     post
tags:       blog
title:      "Building a browser using Servo as a web engine!"
date:       2024-08-27
summary:    Let's build another web browser based on Servo!
categories:
---

As a web engine, Servo primarily handles everything around scripting and layout.
It has a [servoshell](https://github.com/servo/servo/tree/main/ports/servoshell) as a minimal reference browser.
Right now it's mostly used for demo purposes and as a test harness for the [Web Platform Tests](https://wpt.servo.org).
But fortunately, the Servo community has been trying to push it bit by bit.
servoshell itself got a [new browser UI](https://servo.org/blog/2023/09/15/upcoming-events-and-new-browser-ui/) with [egui](https://www.egui.rs) last year.
The [Tauri](https://tauri.app) community also attempted to [add a new Servo backend](https://servo.org/blog/2024/01/19/embedding-update/), as a proof of concept.
This year, [@wusyong](https://github.com/wusyong) created the [Verso](https://github.com/versotile-org/verso) project as an experiment to explore the development of more browser features for Servo.
In this post, we will explain what we tried to achieve, what we found, and what’s next for building a browser using Servo as a web engine.

## Multi-view

Of course, the first major feature we want to achieve is multiple webviews.
A webview is a term abstracted from the [top-level browsing context](https://doc.servo.org/servo/struct.TopLevelBrowsingContextId.html).
This is what people refer to as a web page.
With multi-view support, we can create multiple web pages as tabs in a single window.
Most importantly, we can draw our UI with additional webviews.
The main reason we want to write UI using Servo itself is that we can dogfood our own stack and verify that it can meet the practical requirements <!-- of what? or remove “the” -->, such as prompt windows, context menus, file selectors, and more.

Basic multi-view support was reviewed and merged into Servo earlier this year thanks to [@delan](https://github.com/delan) ([#30840](https://github.com/servo/servo/pull/30840), [#30841](https://github.com/servo/servo/pull/30841), [#30842](https://github.com/servo/servo/pull/30842)).
Verso refined that into a specific type called [WebView](https://docs.versotile.org/verso/webview/struct.WebView.html).
From there, any function that owns webviews can decide how to present them depending on their IDs.
In a Verso window, two webviews are created at the moment—one for [handling regular web pages](https://docs.versotile.org/verso/window/struct.Window.html#method.handle_servo_messages_with_webview) and the other for [handling the UI](https://docs.versotile.org/verso/window/struct.Window.html#method.handle_servo_messages_with_panel), which is currently called the Panel.
The result of the [showcase](https://github.com/versotile-org/verso?tab=readme-ov-file#verso) in Verso’s README.md looks like this:

<figure class="_fig"><a href="{{ '/img/blog/crt-demo.gif' | url }}"><img src="{{ '/img/blog/crt-demo.gif' | url }}"
    alt="Verso displaying ASCII texts with CRT style"></a>
<figcaption>Figure 1: Verso window displaying two different webviews. One for UI, the other for webpage.</figcaption></figure>

For now, the inter-process communication is done via Servo’s existing channel messages like [EmbedderMsg](https://doc.servo.org/embedder_traits/enum.EmbedderMsg.html) and [EmbedderEvent](https://doc.servo.org/compositing/windowing/enum.EmbedderEvent.html).
We are looking to improve the IPC mechanism with more granular control <!-- over what? -->.
There are some candidates for this, such as [WebDriverCommandMsg](https://doc.servo.org/script_traits/enum.WebDriverCommandMsg.html).
[@webbeef](https://github.com/webbeef) also started a discussion about [defining custom elements](https://github.com/servo/servo/discussions/32883) like `<web-view>` for better ergonomics.
Overall, improving IPC will be the next target to research after initial multi-view support.
We will also define more specific webview types to satisfy different purposes in the future.

## Multi-window

The other prominent feature after multi-view is the ability to support multiple windows.
This one wasn’t planned at first, but because it affects too many components, we ended up resolving them together from the ground up.

Servo uses [WebRender](https://github.com/servo/webrender), based on OpenGL, to render its layout.
To support multiple windows, we need to support multiple OpenGL surfaces.
One approach would be to create separate OpenGL contexts for each window.
But since our implementations of WebGL, WebGPU, and WebXR are all tied to a single WebRender instance, which in turn only supports a single OpenGL context for now, we chose to use a single context with multiple surfaces.
This alternative approach could potentially use less memory and spawn fewer threads.
For more details, see [this series of blog posts](https://wusyong.github.io/posts/verso-compositor-part3/) by [@wusyong](https://github.com/wusyong).

<figure class="_fig"><a href="{{ '/img/blog/multiwindow.png' | url }}"><img src="{{ '/img/blog/multiwindow.png' | url }}"
    alt="Verso displaying two windows"></a>
<figcaption>Figure 2: Verso creates two different windows with same OpenGL context.</figcaption></figure>

There is still room for improvement.
For example, WebRender currently [only supports rendering a single “document”](https://github.com/servo/webrender/blob/0.64/webrender/src/renderer/mod.rs#L1228).
This means this document has to constantly update different display lists to show on other windows, which may cause race conditions and let unintended webview display on the wrong window in a slip second.
<!-- why is this not a problem in Firefox? -->

There are also different OpenGL versions across multiple platforms, which can be challenging to configure and link.
Verso is experimenting with using [Glutin](https://docs.rs/glutin/latest/glutin/) for better configuration and attempting to get closer to the general Rust ecosystem.

## What’s next?

With multi-view and multi-window support as the fundamental building blocks, we could create more UI elements to keep pushing the envelope of our browser and embedding research.
At the same time, Servo is a huge project, with many potential improvements still to come, so we want to reflect on our progress and decide on our priorities.
Here are some directions that are worth pursuing.

### Are we browser yet?

We are building a page, [arewebrowseryet.com](https://servo.zulipchat.com/#narrow/stream/263398-general/topic/arewebrowseryet.2Ecom), in the hope of gathering the strength of the community to help us display the statistics of supported CSS properties and web APIs in Servo by [popularity order](https://chromestatus.com/metrics/css/popularity) and benchmark results such as jetstream2 and speedometer3.
We hope this will eventually give newcomers a better overview of Servo.

### Script triage

There’s a [Servo triage meeting](https://github.com/servo/project/issues/100) every two weeks to triage any issues around the script crate and more.
Once we get the statistics of supported web APIs, we can find the most popular ones that haven’t been implemented or fixed yet.
We are already fixing some issues around loading the order and re-implementing [ReadableStream](https://developer.mozilla.org/en-US/docs/Web/API/ReadableStream) in Rust.
If you are interested in implementing web APIs in Servo, feel free to join the next meeting.

### Multi-process and sandboxing

Some features are crucial to the browser but not visible to users.
Multi-process architecture and sandboxing belong to this category.
Both of these are implemented in Servo to some extent, but are not enabled by default <!-- is this true for both? i know it’s true for multiprocess, but what about sandboxing? -->.
They also only support Linux and macOS for now <!-- is this true for both? i know it’s true for sandboxing, but what about multiprocess? -->.

We would like to improve these features and validate them in CI workflows.
In the meantime, we are looking for people who can extend our sandbox to Windows via [Named Pipes](https://learn.microsoft.com/en-us/windows/win32/ipc/named-pipes) and [AppContainer Isolation](https://learn.microsoft.com/en-us/windows/win32/secauthz/appcontainer-isolation).

## Acknowledgments

This work was [sponsored](https://nlnet.nl/project/Servo-Multibrowsing/) by [NLNet](https://nlnet.nl/) and the [Next Generation Internet initiative](https://ngi.eu/).
We are grateful the European Commission shares the same vision for a better and more open browser ecosystem.

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
