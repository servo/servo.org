---
layout:     post
tags:       blog
title:      Servo and the Web Platform Tests
date:       2023-07-20
summary:    How we use the Web Platform Tests to guide Servo’s development.
categories:
---

With over 52000 tests and nearly two million subtests, the [Web Platform Tests](https://web-platform-tests.org) are one of the most important parts of the web’s interoperability and compatibility story. Servo has long used the WPT to catch regressions and [flakiness](/blog/2023/03/16/making-easier-to-contribute/), but the suite has also played a role in our [layout engine migration](/blog/2023/04/13/layout-2013-vs-2020/) and guiding our way towards CSS2 conformance.

<style>
    ._runin {
        margin-bottom: 1em;
    }
    ._runin > p,
    ._runin > h2 {
        display: inline;
    }
</style>

<div class="_runin"><p>You can find Servo on </p><h2><a href="https://wpt.fyi">wpt.fyi</a></h2><p>, a dashboard for all browsers integrated with the Web Platform Tests.</p></div>

To see the pass rates for Servo, follow [this direct link](https://wpt.fyi/results/?label=master&label=experimental&product=servo), or click <span style="font-size: 87.5%;">EDIT</span>, <span style="font-size: 87.5%;">ADD PRODUCT</span>, choose Servo, then click <span style="font-size: 87.5%;">SUBMIT</span>.

While fyi is not so great for tracking progress over time (though definitely [possible](https://wpt.fyi/runs?label=master&product=servo)), it has been very helpful for drilling down from specs to sections, tests, and subtests. This has made it easier for us to decide what to work on next.

<div class="_runin"><p>But the key to this was our </p><h2><a href="https://wpt.servo.org">Servo WPT dashboard</a></h2><p>.</p></div>

The full dashboard can be found at [wpt.servo.org](https://wpt.servo.org), and there’s a simplified version [on our about page](/about/#wpt-pass-rates).

Built in April, the dashboard has since tracked Servo’s pass rate over time, not just over the suite as a whole but also over several *focus areas*:

<table style="width: auto;">
<tr>
<td>
<ul>
<li>CSS overall
    <ul>
    <li>our CSS2 focus areas →
    <li>CSS position module
    <li>CSS flexbox module
    <li>CSSOM
    </ul>
</ul>
<td>
<ul>
<li>abspos
<li>box-display
<li>floats
<li>floats-clear
<li>linebox
<li>margin-padding-clear
<li>normal-flow
<li>positioning
</ul>
</table>

The dashboard has data for both our [legacy and new layout engines](/blog/2023/04/13/layout-2013-vs-2020/), which made it easy to see where the new engine most needed catching up.

Over the last three months, we’ve halved the gap with legacy or better in several of those areas:

* CSS overall (7.7pp → 3.7pp)
* our CSS2 focus areas (19.0pp → 8.2pp)
* margin-padding-clear (33.0pp → 10.3pp)
* CSS flexbox module (10.5pp → 3.1pp)
* CSS position module (2.5pp → 0.2pp(!))

We’re two thirds of the way to legacy in floats (31.5pp → 10.8pp) and floats-clear (48.3pp → 3.3pp(!)):

<img src="{{ '/img/blog/wpt-dashboard-floats.png' | url }}"
    alt="floats: 18 (legacy 50) on 1 april, 23 (legacy 52) on 15 june, 33 on 17 june, 37 (legacy 53) on 18 july, 42 on 19 july"
    style="width: 50%;"><img src="{{ '/img/blog/wpt-dashboard-floats-clear.png' | url }}"
    alt="floats-clear: 18 (legacy 66) on 1 april, 20 (legacy 67) on 15 june, 51 on 16 june, 57 on 22 june, 63 on 1 july, 64 on 20 july"
    style="width: 50%;">

And in the CSS2 positioning tests, we’ve surpassed legacy and built a healthy 5.5pp lead:

<img src="{{ '/img/blog/wpt-dashboard-positioning.png' | url }}"
    alt="positioning: 77.7 (legacy 80.9) on 1 april, 81.7 (legacy 81.1) on 13 april, 85.7 on 1 july, 86.6 on 20 july"
    style="width: 50%;">

Over time, as our pass rates improve or people start working on new things, we’ll continue [adding new focus areas](https://github.com/servo/internal-wpt-dashboard/blob/461c573885c17f42687fb26131fe8ccd4213b826/process-wpt-results.js), and with the web platform continuously evolving, we probably won’t run out of areas any time soon.
