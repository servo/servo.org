---
layout:     post
tags:       blog
title:      "May in Servo: and more!"
date:       2026-06-30
summary:    ao!! wrrrrao!!
categories:
---

[**Servo 0.3.0**](https://github.com/servo/servo/releases/tag/v0.3.0) contains all of the changes we landed in May, which came out to **391 commits** (March: 534).
For security fixes, see [**§ Security**](#security).

- [**Security**](#security)

- [**Work in progress**](#work-in-progress)

- [**servoshell**](#servoshell)

- [**For developers**](#for-developers)

- [**Embedding API**](#embedding-api)

- [**More on the web platform**](#more-on-the-web-platform)

- [**Performance and stability**](#performance-and-stability)

<style>
    kbd {
        background: #00000020;
        margin: 0 0.125rem;
        padding: 0.125rem;
        border-radius: 0.25rem;
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
