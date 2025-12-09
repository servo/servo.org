---
layout:     post
tags:       blog
title:      "November in Servo: ???"
date:       2025-12-12
summary:    ao!! wrrrrao!!
categories:
---

@kkoyung has landed some huge improvements in the [**SubtleCrypto API**](https://w3c.github.io/webcrypto/), including some of the more [modern algorithms in this WICG draft](https://wicg.github.io/webcrypto-modern-algos/), and a fix for constant-time base64 (#40334).
We now have full support for **SHA3-256**, **SHA3-384**, **SHA3-512** (@kkoyung, #40765), **cSHAKE128**, **cSHAKE256** (@kkoyung, #40832), **Argon2d**, **Argon2i**, **Argon2id**, **ChaCha20-Poly1305**, **ECDH**, **ECDSA**, and **X25519**:

<figure style="overflow-x: scroll;">

| Algorithm | deriveBits | exportKey | generateKey | importKey | sign | verify |
|---|---|---|---|---|---|---|
| Argon2d | #40936 | n/a | n/a | #40932 | n/a | n/a |
| Argon2i | #40936 | n/a | n/a | #40932 | n/a | n/a |
| Argon2id | #40936 | n/a | n/a | #40932 | n/a | n/a |
| ChaCha20-Poly1305 | n/a | #40948 | n/a | #40948 | n/a | n/a |
| ECDH | #40333 | #40298 | #40305 | #40253 | n/a | n/a |
| ECDSA | n/a | #40536 | #40553 | #40523 | #40591 | #40557 |
| X25519 | #40497 | #40421 | #40480 | #40398 | n/a | n/a |
</figure>

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
