---
layout:     post
tags:       blog
title:      "October in Servo: who even knows?"
date:       2026-11-19
summary:    ??????????
categories:
---

<style>
code {
  white-space: nowrap;
}
</style>

[**Servo 0.8.0**](https://github.com/servo/servo/releases/tag/v0.8.0) contains all of the changes we landed in October, spanning 588 commits (a new record)!

<figure>
    <a href="{{ '/img/blog/.png' | url }}"><img src="{{ '/img/blog/.png' | url }}" alt="a black and white cat named Gary showing off new visual web platform features"></a>
</figure>

Servo now renders text track cues over `&lt;video>` elements (@TimvdLippe, #48809)!

We've shipped new web platform features:
* the **spelling-error** and **grammar-error** values for **text-decoration-line** (@yezhizhen, #48883)
* the [**progress()**](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Values/progress) CSS math function (@Loirooriol, #48474)
* `&lt;input type=image>` (@SilvioPilato, #48265)
* the **:focus-visible** pseudoclass (@TimvdLippe, #49255)
* the **beforeinput** event (@dzfrias, #48519)
* the **&wbr>** element (@mrobinson, #48755)
* the **auto** and **stable** values for the **text-wrap-style** property (@nicoburns, #48958)re
* **inert** trees and the **interactivity** property (@skyz1, @TimvdLippe, #48967)

Plus a bunch of new DOM APIs:
* the **DelayNode** and **ConvolverNode** WebAudio nodes (@kevlu93, @TimvdLippe, #48658, #47957)
* the **timeout** property of **XMLHTTPRequest** in worker globals (@CynthiaOketch, #48854, #49023)
* the **hspace** and **vspace** attributes on **&lt;img>** (@TimvdLippe, #48605)
* the **hspace**, **vspace**, **width**, and **height** attributes on **&lt;input>** (@TimvdLippe, #49031)
* the **target** property of **HTMLBaseElement** (@sabbCodes, #48985)
* the **CloseWatcher** interface, and the **closedBy** and **requestClose()** members of **HTMLDialogElement** (@skyz1, @lukewarlow, @TimvdLippe, #48955)

## Security


## Real world compat

We’re interested to hear how well your favourite websites run in Servo! Report successes in [this Zulip thread](https://servo.zulipchat.com/#narrow/channel/263398-general/topic/Servo.20web.20compat.20success.20stories/with/612898341) or [this Github discussion](https://github.com/servo/servo/discussions/49037), and failures [in our GitHub issues](https://github.com/servo/servo/issues).

## Work in progress

## Embedding API

## For users and developers

Double and triple clicking on selected text will extend the selection to the current word and line, respectively (@mrobinson, @SimonSapin, #48767).

Range inputs can now be dragged with the mouse (@webbeef, #48342).

## Performance and stability

Pinch zoom operations no longer have to rebuild a full display list, making zooming on complex pages much smoother (@stevennovaryo, @mrobinson, #43561).

## More on the web platform

## New contributors

A special thanks to the following people for landing their first patch in Servo:

* 

Interested in helping build a web browser?
Take a look at our [curated list](https://starters.servo.org) of issues that are good for new contributors!

## Donations

Thanks again for your generous support!
We are now receiving **8144 USD/month** (+1% from August) in recurring donations.
This helps us cover the cost of our **[speedy](https://ci0.servo.org) [CI](https://ci1.servo.org) [and](https://ci2.servo.org) [benchmarking](https://ci3.servo.org) [servers](https://ci4.servo.org)**, one of our latest **[Outreachy interns](https://www.outreachy.org/alums/2026-05/#:~:text=Servo)**, and funding **[maintainer work]({{ '/blog/2026/09/15/one-year-of-sponsorship/' | url }})** that helps more people contribute to Servo.

Servo is also on [thanks.dev](https://thanks.dev), and already **37 GitHub users** (+1 from August) that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

We now have [**sponsorship tiers**]({{ '/blog/2025/11/21/sponsorship-tiers/' | url }}) that allow you or your organisation to donate to the Servo project with public acknowlegement of your support.
If you’re interested in this kind of sponsorship, please contact us at [join@servo.org](mailto:join@servo.org).

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; right: calc(100% - 100% * 8144 / 10000); padding-right: 0.5em;"><strong>8128</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 8144 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
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
