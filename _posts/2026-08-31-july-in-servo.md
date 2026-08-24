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

- **‘Cache-Control: stale-while-revalidate’** (@arayaryoma, #46060)
- **‘text-decoration-thickness’** (@nicoburns, #46592)
- **‘box-decoration-break’**, for the most part (@Psychpsyo, #45492)
- **‘@font-feature-values’**, for the most part (@simonwuelker, #45308)
- **‘font-language-override’**, for the most part (@simonwuelker, #46618)
- **‘font-variant-alternates’**, for the most part (@simonwuelker, #45308)

Plus a bunch of new DOM APIs:

- [**Ed448**](https://wicg.github.io/webcrypto-secure-curves/#ed448), [**X448**](https://wicg.github.io/webcrypto-secure-curves/#x448), and [**KMAC**](https://wicg.github.io/webcrypto-modern-algos/#kmac) algorithms in **Subtle­Crypto** (@kkoyung, #46402, #46141, #46180, #46583, #46606, #46622, #46334, #46376)
- **‘insert­Horizontal­Rule’**, **‘insert­Image’**, **‘insert­Text’**, and **‘forward­Delete’** commands in **document.exec­Command()** (@Psychpsyo, #46608, #46597, #46538, #46838)
- **Animation­Effect** (@simonwuelker, #46677)
- **new Touch()** (@yezhizhen, #46741)
- **duplex** property on **Request** (@Taym95, #46858)
- **effect** property on **Animation** (@simonwuelker, #46677)
- **get­Keyframes()** and **set­Keyframes()** on **Keyframe­Effect** (@simonwuelker, #46118)
- **id** property on **Largest­Contentful­Paint** (@shubhamg13, #46828)

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

**Web­GPU** content can now use **GPU­External­Texture** and **import­External­Texture()** on **GPU­Device**, under `--pref dom­_webgpu­_enabled` (@sagudev, #45873).

**Indexed­DB** content can now use the **name** property on **IDB­Index**, under `--pref dom­_indexeddb­_enabled` (@skyz1, #45512).

All of the features above are enabled in servoshell’s [experimental mode](https://book.servo.org/design-documentation/experimental-features.html#experimental-web-platform-features).

## Embedding API

We’ve improved the docs for the [`servo`](https://doc.servo.org/servo/index.html) crate, and for [Web­View­Delegate](https://doc.servo.org/servo/trait.WebViewDelegate.html) (@mukilan, #46193).

## For users and developers

## More on the web platform

We’re implementing the **SVG DOM**, starting with stub interfaces for **SVG­Element**, SVG­Circle­Element, SVG­Defs­Element, SVG­Ellipse­Element, SVG­Line­Element, SVG­Linear­Gradient­Element, SVG­Path­Element, SVG­Polygon­Element, SVG­Polyline­Element, SVG­Radial­Gradient­Element, SVG­Stop­Element, SVG­Rect­Element, SVG­Symbol­Element, and SVG­Use­Element (@mu-mostafa98, #46558).

## Garbage collection safety

## Performance and stability

We’ve also reduced allocations, GC rooting steps, and other operations in many parts of Servo (@Narfinger, @mrobinson, @Gae24, @SimonSapin, @Taym95, @cychronex-labs, @yezhizhen, #45758, #46440, #46762, #46301, #46349, #46419, #46418, #46420, #46460, #46633, #46638, #46690, #46745, #46726, #46564, #46144, #46664, #46462, #46139, #46430, #46446, #46498, #46548, #46598, #46632, #46656, #46678, #46718).

We’ve fixed a crash regression with memory corruption (@mrobinson, #46316), several dynamic-borrow-related crashes (@Narfinger, @SharanRP, @Taym95, @agrawalx, @amittenak47, @sungmen, #46381, #46384, #46405, #46684, #46452, #46770, #46830, #46763), plus crashes related to:

- **&lt;area>** without **&lt;area href>** (@simonwuelker, #46341)
- **&lt;progress>** or shadow DOM (@mrobinson, @simonwuelker, #46188)
- **&lt;table>** layout (@mrobinson, #46775)
- **&lt;td rowspan>** (@mrobinson, #46841)
- **&lt;svg>** without **&lt;svg viewBox>** (@Narfinger, @mrobinson, #46199)
- **&lt;use>** in SVG (@mrobinson, @Loirooriol, #46261)
- **‘animation’** (@mrobinson, @Loirooriol, #46689)
- **‘content’** (@Loirooriol, @mrobinson, #46314)
- **‘mix-blend-mode’** (@mrobinson, #45624)
- **Array­Buffer** (@jdm, #46504)
- **adopted­Style­Sheets** on **Document** (@TimvdLippe, #46373)
- **exec­Command(`"delete"`)** on **Document** (@TimvdLippe, #46265)
- removing DOM nodes (@SimonSapin, #46866)

We’ve continued our long-running effort to use the Rust type system to make Servo’s integration with SpiderMonkey safer and more reliable (@Gae24, @Narfinger, @TimvdLippe, @jdm, @kunalmohan, @lumiscosity, @simonwuelker, #46191, #46777, #46890, #46243, #46248, #46246, #46310, #46312, #46333, #46147, #46150, #46151, #46229, #46262, #46375, #46374, #46529, #46584, #46585, #46593, #46693, #46166, #46156, #46254, #46267, #46268, #46269, #46270, #46284, #46285, #46318, #46435).

## New contributors

A special thanks to the following people for landing their first patch in Servo:

Interested in helping build a web browser?
Take a look at our [curated list](https://starters.servo.org) of issues that are good for new contributors!

## Donations

<!--
7681/month → 7824/month
- 3585.07/month opencollective
- 4103.00/month github
- 135.93/month thanks.dev
    - 35 → 35 donors
-->

Thanks again for your generous support!
We are now receiving **7824 USD/month** (+1.8% from June) in recurring donations.
This helps us cover the cost of our **[speedy](https://ci0.servo.org) [CI](https://ci1.servo.org) [and](https://ci2.servo.org) [benchmarking](https://ci3.servo.org) [servers](https://ci4.servo.org)**, one of our latest **[Outreachy interns](https://www.outreachy.org/alums/2026-05/#:~:text=Servo)**, and funding **[maintainer work]({{ '/blog/2025/09/17/your-donations-at-work-funding-jdm/' | url }})** that helps more people contribute to Servo.

Servo is also on [thanks.dev](https://thanks.dev), and already **35 GitHub users** (same as June) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

We now have [**sponsorship tiers**]({{ '/blog/2025/11/21/sponsorship-tiers/' | url }}) that allow you or your organisation to donate to the Servo project with public acknowlegement of your support.
If you’re interested in this kind of sponsorship, please contact us at [join@servo.org](mailto:join@servo.org).

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; right: calc(100% - 100% * 7824 / 10000); padding-right: 0.5em;"><strong>7824</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 7824 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="7824" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

Use of donations is decided transparently via the Technical Steering Committee’s public **[funding request process](https://github.com/servo/project/blob/main/FUNDING_REQUEST.md)**, and active proposals are tracked in [servo/project#187](https://github.com/servo/project/issues/187).
For more details, head to our [Sponsorship page]({{ '/sponsorship/' | url }}).

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
