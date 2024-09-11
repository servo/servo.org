---
layout:     post
tags:       blog
title:      "Building a browser using Servo as a web engine!"
date:       2024-09-11
summary:    Let's build another web browser based on Servo!
categories:
---

As a web engine, Servo primarily handles everything around scripting and layout.
For embedding use cases, the [Tauri](https://tauri.app) community experimented with [adding a new Servo backend]({{ '/blog/2024/01/19/embedding-update/' | url }}), but Servo can also be used to build a browser.

We have a reference browser in the form of [servoshell](https://github.com/servo/servo/tree/main/ports/servoshell), which has historically been used as a minimal example and as a test harness for the [Web Platform Tests](https://wpt.servo.org).
Nevertheless, the Servo community has steadily worked towards making it a browser in its own right, starting with [our new browser UI]({{ '/blog/2023/09/15/upcoming-events-and-new-browser-ui/' | url }}) based on [egui](https://www.egui.rs) last year.

This year, [@wusyong](https://github.com/wusyong), a member of [Servo TSC](https://servo.org/governance/), created the [Verso](https://github.com/versotile-org/verso) project as a way to explore the features Servo needs to power a robust web browser.
In this post, we’ll explain what we tried to achieve, what we found, and what’s next for building a browser using Servo as a web engine.

## Multi-view

Of course, the first major feature we want to achieve is multiple webviews.
A webview is a term abstracted from the [top-level browsing context](https://doc.servo.org/servo/struct.TopLevelBrowsingContextId.html).
This is what people refer to as a web page.
With multi-view support, we can create multiple web pages as tabs in a single window.
Most importantly, we can draw our UI with additional webviews.
The main reason we want to write UI using Servo itself is that we can dogfood our own stack and verify that it can meet practical requirements, such as prompt windows, context menus, file selectors, and more.

Basic multi-view support was reviewed and merged into Servo earlier this year thanks to [@delan](https://github.com/delan) ([#30840](https://github.com/servo/servo/pull/30840), [#30841](https://github.com/servo/servo/pull/30841), [#30842](https://github.com/servo/servo/pull/30842)).
Verso refined that into a specific type called [WebView](https://docs.versotile.org/verso/webview/struct.WebView.html).
From there, any function that owns webviews can decide how to present them depending on their IDs.
In a Verso window, two webviews are created at the moment—one for [handling regular web pages](https://docs.versotile.org/verso/window/struct.Window.html#method.handle_servo_messages_with_webview) and the other for [handling the UI](https://docs.versotile.org/verso/window/struct.Window.html#method.handle_servo_messages_with_panel), which is currently called the Panel.
The result of the [showcase](https://github.com/versotile-org/verso?tab=readme-ov-file#verso) in Verso’s README.md looks like this:

<figure class="_fig"><a href="{{ '/img/blog/verso-crt-demo.webp' | url }}"><img src="{{ '/img/blog/verso-crt-demo.webp' | url }}"
    alt="Verso displaying ASCII text in a CRT style"></a>
<figcaption>Figure 1: Verso window displaying two different webviews. One for the UI, the other for the web page.</figcaption></figure>

For now, the inter-process communication is done via Servo’s existing channel messages like [EmbedderMsg](https://doc.servo.org/embedder_traits/enum.EmbedderMsg.html) and [EmbedderEvent](https://doc.servo.org/compositing/windowing/enum.EmbedderEvent.html).
We are looking to improve the IPC mechanism with more granular control over DOM elements.
So, the panel UI can be updated based on the status of web pages.
One example is when the page URL is changed and the navigation bar needs to be updated.
There are some candidates for this, such as [WebDriverCommandMsg](https://doc.servo.org/script_traits/enum.WebDriverCommandMsg.html).
[@webbeef](https://github.com/webbeef) also started a discussion about [defining custom elements](https://github.com/servo/servo/discussions/32883) like `<webview>` for better ergonomics.
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
<figcaption>Figure 2: Verso creates two separate windows with the same OpenGL context.</figcaption></figure>

There is still room for improvement.
For example, WebRender currently [only supports rendering a single “document”](https://github.com/servo/webrender/blob/0.64/webrender/src/renderer/mod.rs#L1228).
Unless we create multiple WebRender instances, like Firefox does, we have one WebRender document that has to constantly update all of its display lists to show on all of our windows.
This could potentially lead to race conditions where a webview may draw to the wrong window for a split second.

There are also different OpenGL versions across multiple platforms, which can be challenging to configure and link.
Verso is experimenting with using [Glutin](https://docs.rs/glutin/latest/glutin/) for better configuration and attempting to get closer to the general Rust ecosystem.

## What’s next?

With multi-view and multi-window support as the fundamental building blocks, we could create more UI elements to keep pushing the envelope of our browser and embedding research.
At the same time, Servo is a huge project, with many potential improvements still to come, so we want to reflect on our progress and decide on our priorities.
Here are some directions that are worth pursuing.

### Benchmarking and metrics

We want to gather the strength of the community to help us track the statistics of supported CSS properties and web APIs in Servo by [popularity order](https://chromestatus.com/metrics/css/popularity) and benchmark results such as jetstream2 and speedometer3.
[@sagudev](https://github.com/sagudev) already started [a subset of speedometer3](https://servospeedometer.netlify.app/) to experiment.
We hope this will eventually give newcomers a better overview of Servo.

### Script triage

There’s a [Servo triage meeting](https://github.com/servo/project/issues/100) every two weeks to triage any issues around the script crate and more.
Once we get the statistics of supported web APIs, we can find the most popular ones that haven’t been implemented or fixed yet.
We are already fixing some issues around loading the order and re-implementing [ReadableStream](https://developer.mozilla.org/en-US/docs/Web/API/ReadableStream) in Rust.
If you are interested in implementing web APIs in Servo, feel free to join the next meeting.

### Multi-process and sandboxing

Some features are crucial to the browser but not visible to users.
Multi-process architecture and sandboxing belong to this category.
Both of these are implemented in Servo to some extent, but only on Linux and macOS right now, and neither of the features are enabled by default.

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
