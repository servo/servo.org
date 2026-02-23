---
layout:     post
tags:       blog
title:      "January in Servo: who knows?"
date:       2026-02-03
summary:    hurr durr
categories:
---

Our **developer tools** integration continues to improve.
Worker globals are now categorized correctly in the UI (@atbrakhi, #41929), and the Sources panel is populated for very short documents (@atbrakhi, #41983).
Servo will report console messages that were logged before the developer tools are opened (@eerii, @mrobinson, #41895).
Finally, we fixed a panic when selecting nodes in the layout inspector that have no style information (@eerii, #41800).

Pausing in the JS debugger now interrupts script execution (@eerii, @atbrakhi, @jdm, #42007), and breakpoints can be toggled through the UI (@eerii, @atbrakhi, #41925, #42154).
While the debugger is paused, hovering over JS objects will report the object's properties for builtin JS classes (@eerii, @atbrakhi, #42186).

Similarly, our **WebDriver server** is also maturing.
Evaluating a synchronous script that returns a Promise will wait until that promise settles (@yezhizhen, #41823).
`touchmove` events are sent for pointer actions when a button is pressed (@yezhizhen, #41801), and `touchcancel` events for canceled pointer action items (@yezhizhen, #41937).

The [`Element Clear`](https://w3c.github.io/webdriver/#element-clear) API now tests whether the element is interactable (@yezhizhen, #42124).
A null script execution timeout value will never trigger a timeout (@yezhizhen, #42184), and synthesized `pointermove` events have a consistent `pointerId` value (@yezhizhen, #41726).

Our nightly testing UI, **servoshell**, now respects any customized installation path on Windows (@yezhizhen, #41653).
We fixed a crash in the Android app when pausing the application (@NiklasMerz, #41827).
Additionally, clicking inside a webview in the app removes focus from any browser UI (@mrobinson, #42080).

## Stability & performance

We converted many uses of IPC channels in the engine to channels that are **more efficient** when multiprocess mode is disabled (@Narfinger, @jdm, @sagudev, @mrobinson, #41178, #41071, #41733, #41806, #41380, #41809, #41774, #42032, #42033).

Servo now sets a **socket timeout for HTTP conections** (@Narfinger, @mrobinson, #41710).
This is controlled by the `network_connection_timeout` preference and defaults to **15 seconds**.

Each instance of Servo now starts four fewer threads (@Narfinger, #41740).
Any network operations that trigger a synchronous UI operation (such as an HTTP authentication prompt) no longer blocks other network tasks from completing (@Narfinger, @jdm, #41965, #41857).

It's said that one of the hardest problems in computer science is cache invalidation.
We improved the memory usage of **dynamic inline SVG content** by evicting stale SVG tree data from a cache (@TomRCummings, #41675).
Meanwhile, we added a new cache to reduce memory usage and improve rendering performance for pages with animating images (@Narfinger, #41956).

Servo's JS engine now accounts for 2d and 3d canvas-related memory usage when deciding whether to perform a garbage collection operation.
This can reduce the risk of out of memory (OOM) errors on pages that create large numbers of short-lived WebGL or WebGPU objects.

To reduce the risk of panics involving the JS engine integration, we are using **the Rust type system** to make certain kinds of dynamic borrow failures impossible (@sagudev, #41692, #41782, #41756, #41808, #41879, #41878, #41955, #41971, #42123).
We also continue to identify and **forbid code patterns** that can trigger rare crashes during garbage collection when destroying a WebView (@willypuzzle, #41717, #41783, #41911, #41911, #41977, #41984, #42243).

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
