---
layout:     post
tags:       blog
title:      "April in Servo: and more!"
date:       2026-05-29
summary:    ao!! wrrrrao!!
categories:
---

## Work in progress

[TODO: write about experimental feature changes]

All of the features above are enabled in servoshell’s experimental mode.

Servo can now build a very basic **accessibility tree** for web contents, under `--pref accessibility­_enabled` (@alice, @delan, @lukewarlow, #42338, #43558, #44437, #44438).
This includes text runs, plus nine other non-interactive accessibility roles (@alice, @delan, #44255).

## Performance and stability

We’ve continued our long-running effort to **use the Rust type system** to make certain kinds of dynamic borrow failures impossible (@sagudev, @TimvdLippe, @Narfinger, @elomscansio, @Gae24, @rovertrack, @yezhizhen, @nodelpit, #43174, #43524, #43928, #43943, #43942, #43944, #43946, #43952, #43975, #44018, #44175, #44241, #44368, #44406, #44441, #44422, #44475, #44478, #44484, #44476, #44490, #44477, #44494, #44497, #44498, #44495, #44505, #44506, #44507, #44508, #44509, #44510, #44512, #44482, #44527, #44528, #44531, #44534, #44542, #44533, #44543, #44553, #44547, #44563, #44562, #44565, #44558, #44583, #44606, #44605, #44608, #44602, #44584, #44620, #44590, #44254, #44628, #44629, #44638, #44626).

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
