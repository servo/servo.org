---
layout:     post
tags:       blog
title:      "You can now sponsor Servo on GitHub and Open Collective!"
date:       2024-03-12
summary:    Be sure to update your recurring donations, because we will stop taking donations on LFX soon.
categories:
---

<figure class="_figr"><a href="https://github.com/sponsors/servo"><img src="{{ '/img/blog/sponsor-on-github.png' | url }}"
    alt="Servo’s donation page on GitHub Sponsors"></a>
<br><a href="https://opencollective.com/servo"><img src="{{ '/img/blog/sponsor-on-open-collective.png' | url }}"
    alt="Servo’s donation page on Open Collective"></a></figure>

<span class=_floatmin></span>Over the past year, Servo has [gone a long way](https://servo.org/blog/2023/12/18/this-year-in-servo/) towards reigniting the dream of a web rendering engine in Rust. This comes with a lot of potential, and not just towards becoming a viable alternative to WebKit and Chromium for embedded webviews. If we can make the web platform more modular and easily reusable in both familiar and novel ways, and help build web-platform-grade libraries in underlying areas like networking, graphics, and typography, we could really change the Rust ecosystem.

In theory, anything is possible in a free and open source project like ours, and we think projects like Servo and [Ladybird](https://ladybird.dev) have shown that building a web browser with limited resources is more achievable than many have assumed. But doing those things well does take time and money, and we can only achieve Servo’s full potential with your help.

You can now help fund the Servo project by [**sponsoring us on GitHub**](https://github.com/sponsors/servo) or [**Open Collective**](https://opencollective.com/servo).

<aside class="_note">

In both cases, donations are handled by [Open Source Collective](https://opencollective.com/opensource). We are not affected by the [dissolution](https://blog.opencollective.com/open-collective-official-statement-ocf-dissolution/) of [Open Collective Foundation](https://opencollective.com/foundation), who are a separate organisation with a similar name.
</aside>

**We will stop accepting donations [on LFX](https://crowdfunding.lfx.linuxfoundation.org/projects/servo) soon.** Any funds left over will also be transferred to the Servo project, but recurring donations will be cancelled, so if you would like to continue your recurring donation, please do so on GitHub or Open Collective.

Both one-time and monthly donations are appreciated, and **over 94%** of the amount will go directly towards improving Servo, with the remaining 6% going to processing fees. The way the funds are used is decided in public via the [Technical Steering Committee](https://servo.org/governance/), but to give you a sense of scale…

<ul style="max-width: 45em;">
<li>at <strong>100 USD/month</strong>, we can cover the costs of our website and other core infrastructure
<li>at <strong>1,000 USD/month</strong>, we can set up dedicated servers for faster Windows and macOS builds, better test coverage and reliability, and new techniques like fuzzing and performance testing
<li>at <strong>10,000 USD/month</strong>, we can sponsor a developer to make Servo their top priority
</ul>

If you or your company are interested in making a bigger donation or funding specific work that would make Servo more useful to your needs, you can also reach out to us at [join@servo.org](mailto:join@servo.org).

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
    ._fig._min {
        width: min-content;
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
    }
    ._figr {
        float: right;
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
        max-width: 33em;
        margin: 1em 1em;
        border-left: 1px solid;
        padding-left: 1em;
        opacity: 0.75;
    }
</style>
