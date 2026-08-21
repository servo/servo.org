---
layout:     post
tags:       blog
title:      "July in Servo: and more!"
date:       2026-08-31
summary:    ao!! wrrrrao!!
categories:
---

[**Servo 0.5.0**](https://github.com/servo/servo/releases/tag/v0.5.0) contains all of the changes we landed in July, which came out to **488 commits**.
For security fixes, see [**§ Security**](#security).

We’ve shipped several new web platform features:

Plus a bunch of new DOM APIs:

This is another big update, so here’s an outline:

- [**You can help!**](#you-can-help)

- [**Security**](#security)

- [**Real world compat**](#real-world-compat)

- [**Work in progress**](#work-in-progress)

- [**Embedding API**](#embedding-api)

- [**For users and developers**](#for-users-and-developers)

- [**More on the web platform**](#more-on-the-web-platform)

- [**Garbage collection safety**](#garbage-collection-safety)

- [**Performance and stability**](#performance-and-stability)

- [**New contributors**](#new-contributors)

## You can help!

If you’re working on a pull request that you think might be interesting for the next monthly update, even if you’re not 100% sure, tell us about it by following the steps below:

1. You add the <span style="padding: 0.1875lh; border-radius: calc(0.5lh + 2 * 1px); background: rgb(13, 17, 23);"><span style="padding: 0 0.25lh; border: thin solid rgba(85, 221, 126, 0.3); border-radius: 0.5lh; color: rgb(85, 221, 126); background-color: rgba(84, 222, 126, 0.18);">monthly update</span></span> label to your pull request, or comment <code style="display: /* allow wrapping only as last resort */ inline-block;">[@servo-highfive](https://github.com/servo-highfive) monthly update</code>

2. Highfive posts a comment asking you some questions

3. You answer those questions in a comment containing <code style="display: /* allow wrapping only as last resort */ inline-block;">[@servo-highfive](https://github.com/servo-highfive) monthly update answer</code>

## Security

## Real world compat

<style>
    ._spaced {
        margin: 1em 0;
    }
    ._halves {
        display: flex;
        flex-flow: row wrap;
    }
    ._halves > * {
        width: 50%;
    }
    ._peel {
        --default-position: 50%;
        position: relative;
        overflow: hidden;
        background: white;
        * {
            /* ensure ‘pointermove’ events always target the root */
            pointer-events: none;
            user-select: none;
        }
        img {
            background: white;
        }
        :not(:last-child) {
            position: absolute;
            inset: 0 auto 0 auto;
            width: var(--position, var(--default-position));
            height: 100%;
            object-fit: cover;
            object-position: top left;
        }
        ._line {
            z-index: 1;
            border-right: thin solid #1192e8;
            div {
                position: absolute;
                right: 0;
                width: 0;
            }
            div div {
                position: absolute;
                width: max-content;
                padding: 0 0.25em;
                background: #ffffff80;
            }
            ._left div {
                /* extend left of the line */
                right: 0;
            }
            ._right div {
                /* extend right of the line */
                left: 0;
            }
        }
    }
</style>

<script>
    for (const peel of document.querySelectorAll("._peel")) {
        peel.addEventListener("pointermove", event => {
            const position = Math.max(0, Math.min(1, event.offsetX / peel.offsetWidth));
            peel.style.setProperty("--position", `${position * 100}%`);
        }, true);
    }
</script>

We’re interested to hear how well your favourite websites run in Servo!
Report successes in [this Zulip thread](https://servo.zulipchat.com/#narrow/channel/263398-general/topic/Servo.20web.20compat.20success.20stories/with/612898341), and failures [in our GitHub issues](https://github.com/servo/servo/issues).

## Work in progress

All of the features above are enabled in servoshell’s [experimental mode](https://book.servo.org/design-documentation/experimental-features.html#experimental-web-platform-features).

## Embedding API

## For users and developers

## More on the web platform

## Garbage collection safety

## Performance and stability

## New contributors

A special thanks to the following people for landing their first patch in Servo:

Interested in helping build a web browser?
Take a look at our [curated list](https://starters.servo.org) of issues that are good for new contributors!

## Donations

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
