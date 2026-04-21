---
layout:     post
tags:       blog
title:      "March in Servo: and more!"
date:       2026-04-30
summary:    ao!! wrrrrao!!
categories:
---

[**Servo 0.1.0**](https://github.com/servo/servo/releases/tag/v0.1.0) represents Servo’s biggest month ever, with a record **530 commits** and [**our first ever release on crates.io**]({{ '/blog/2026/04/13/servo-0.1.0-release/' | url }})!

This release includes several new features:

- **‘::first-letter’** styling (@minghuaw, @xiaochengh, @Loirooriol, #43027)
- **‘::placeholder’** styling (@stevennovaryo, #43053)
- **‘background-blend-mode’** (@mrobinson, #43666)
- **‘content’** on **‘::marker’** (@niyabits, @Loirooriol, #43515)
- **&lt;input type=range>** (@BudiArb, @rayguo17, @mrobinson, #41562)
- the **accesskey** attribute (@mrobinson, #43031, #43144, #43434)
- partial support for **&lt;link rel=modulepreload>** (@Gae24, #42964)

Plus a bunch of new DOM APIs:

- **CommandEvent** (@lukewarlow, #43190)
- **moveBefore()** on **Node** (@lukewarlow, #41238)
- **relatedTarget** on **MouseEvent** and **PointerEvent** (@simonwuelker, #42989)
- **command** on **HTMLButtonElement** (@lukewarlow, #43190)
- **selectedOptions** on **HTMLSelectElement** (@jakubadamw, #43017)
- **url** on **LargestContentfulPaint** (@shubhamg13, #42901, #42949)
- **crypto.subtle.getPublicKey()** for **X25519**, **RSASSA-PKCS1-v1_5**, **RSA-PSS**, and **RSA-OAEP** (@kkoyung, #43073, #43093)

Servo now fires **‘pointerover’**, **‘pointerout’**, **‘pointerenter’**, and **‘pointerleave’** events on web content (@webbeef, #42736), **‘scroll’** events on **VisualViewport** (@stevennovaryo, #42771), and **‘scrollend’** events on **Document**, **Element**, and **VisualViewport** (@abdelrahman1234567, @mrobinson, #38773).

A great deal of work went into making the **crates.io release** possible, including renaming `libservo` to just `servo` (@jschwe, #43141), making each package self-contained (@jschwe, #43180, #43165), fixing build issues (@delan, @jschwe, #43170, #43458, #43463) and crates.io compliance issues (@jschwe, #43459), configuring package metadata (@jschwe, @StaySafe020, #43078, #43264, #43451, #43457, #43654), and organising our dependency tree (@jschwe, @yezhizhen, @webbeef, @mrobinson, #42916, #43243, #43263, #43516, #43526, #43552, #43615, #43622, #43273, #43092).
As a result, you can now take your first step towards [embedding Servo](https://book.servo.org/embedding/overview.html) in a Rust app with:

<figure>

```
$ cargo add servo
```
</figure>

## More on the web platform

Servo now exposes several attributes that have no direct effect, but are needed for web compatibility (@lukewarlow, #43500, #43499, #43502, #43518):

- **noHref** on **HTMLAreaElement**
- **hreflang**, **type**, **charset** on **HTMLAnchorElement**
- **useMap** on **HTMLInputElement** and **HTMLObjectElement**
- **longDesc** on **HTMLIFrameElement** and **HTMLFrameElement**

## Performance and stability

**DOM data structures** (`#[dom_struct]`) can refer to one another, with the help of [garbage collection](https://research.mozilla.org/2014/08/26/javascript-servos-only-garbage-collector/).
But when DOM objects are being destroyed, those references can become invalid for a brief moment, depending on the order the GC finalizers run in.
This can be unsound if those references are accessed, which is a very easy mistake to make if the type has an `impl Drop`.
To help prevent that class of bug, we’re reworking our DOM types so that none of them have `#[dom_struct]` and `impl Drop` at the same time (@willypuzzle, #42937, #42982, #43018, #43071, #43222, #43288, #43544, #43563, #43631).

We’ve continued our long-running effort to **use the Rust type system** to make certain kinds of dynamic borrow failures impossible (@Narfinger, @Gae24, @Uiniel, @TimvdLippe, @yezhizhen, @sagudev, @PuercoPop, @pylbrecht, @arabson99, @jayant911, #42957, #43108, #43130, #43215, #43183, #43219, #43245, #43220, #43252, #43268, #43184, #43277, #43278, #43284, #43302, #43312, #43348, #43327, #43362, #43365, #43383, #43432, #43259, #43439, #43473, #43481, #43480, #43479, #43525, #43535, #43543, #43549, #43570, #43571, #43569, #43579, #43584, #43657, #43713).

Thanks to a wide range of people, many of whom were contributing to Servo for their first time, we’ve also landed a bunch of architectural improvements (@elomscansio, @mukilan, #43646), cleanups (@simartin, @SharanRP, @TG199, @sabbCodes, @niyabits, #43276, #43285, #43532, #43778, #43771), and refactors (@sabbCodes, @arabson99, @jayant911, @StaySafe020, @saydmateen, @eerii, @TimvdLippe, @elomscansio, @CynthiaOketch, #43614, #43641, #43619, #43642, #43623, #43656, #43644, #43672, #43664, #43676, #43684, #43679, #43678, #43655, #43675, #43731, #43729, #43728, #43740, #43751, #43748, #43747, #43752, #43745, #43724, #43723, #43765, #43767, #43181, #43269, #43270, #43279, #43437, #43597, #43607, #43602, #43616, #43609, #43612, #43647, #43651, #43662, #43714, #43774).

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
