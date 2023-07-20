---
layout:     post
tags:       blog
title:      Servo and the Web Platform Tests
date:       2023-07-20
summary:    How we use the Web Platform Tests to guide Servo’s development.
categories:
---

With over 52000 tests and nearly two million subtests, the [Web Platform Tests](https://web-platform-tests.org) are one of the most important parts of the web’s interoperability and compatibility story. Servo has long used the WPT to catch regressions and [flakiness](/blog/2023/03/16/making-easier-to-contribute/), but the suite has also played a role in our [layout engine migration](/blog/2023/04/13/layout-2013-vs-2020/) and guiding our way towards CSS2 conformance.

You can find Servo on

## [wpt.fyi](https://wpt.fyi),

a dashboard for all browsers integrated with the Web Platform Tests, by clicking <span style="font-size: 87.5%;">EDIT</span>, <span style="font-size: 87.5%;">ADD PRODUCT</span>, choosing Servo, then clicking <span style="font-size: 87.5%;">SUBMIT</span>.

While fyi is not so great for tracking progress over time (though definitely [possible](https://wpt.fyi/runs?label=master&product=servo)), it has been very helpful for drilling down from specs to sections, tests, and subtests. This has made it easier for us to decide what to work on next.

But the key to this was our

## [Servo WPT dashboard](https://wpt.servo.org),

which you can find at [wpt.servo.org](https://wpt.servo.org), or a simplified version on [our about page](/about/).

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

<img src="/img/blog/wpt-dashboard-floats.png" style="width: 50%;"><img src="/img/blog/wpt-dashboard-floats-clear.png" style="width: 50%;">

And in the CSS2 positioning tests, we’ve surpassed legacy and built a healthy 5.5pp lead:

<img src="/img/blog/wpt-dashboard-positioning.png" style="width: 50%;">

Over time, as our pass rates improve, we’ll continue [adding new focus areas](https://github.com/servo/internal-wpt-dashboard/blob/461c573885c17f42687fb26131fe8ccd4213b826/process-wpt-results.js), and with the web platform continuously evolving, we probably won’t run out of areas any time soon.
