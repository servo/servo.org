---
layout:     post
tags:       blog
title:      "March in Servo: and more!"
date:       2026-04-30
summary:    ao!! wrrrrao!!
categories:
---

[**Servo 0.1.0**](https://github.com/servo/servo/releases/tag/v0.1.0) represents Servo’s biggest month ever, with a record **530 commits** and [**our first ever release on crates.io**]({{ '/blog/2026/04/13/servo-0.1.0-release/' | url }})!

A great deal of work went into making this possible, including renaming `libservo` to just `servo` (@jschwe, #43141), making each package self-contained (@jschwe, #43180, #43165), fixing build issues (@delan, @jschwe, #43170, #43458, #43463) and crates.io compliance issues (@jschwe, #43459), configuring package metadata (@jschwe, @StaySafe020, #43078, #43264, #43451, #43457, #43654), and organising our dependency tree (@jschwe, @yezhizhen, @webbeef, @mrobinson, #42916, #43243, #43263, #43516, #43526, #43552, #43615, #43622, #43273, #43092).
As a result, you can now take your first step towards [embedding Servo](https://book.servo.org/embedding/overview.html) in a Rust app with:

```
$ cargo add servo
```

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
