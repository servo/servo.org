---
layout:     post
tags:       blog
title:      "Your Donations at Work: One Year of Sponsored Servo Development"
date:       2026-08-24
summary:    Looking back on Servo's first donation-funded role.
categories:
---

Last September, the Servo project [announced](https://servo.org/blog/2025/09/17/your-donations-at-work-funding-jdm/) that long-time maintainer [Josh Bowman-Matthews (@jdm)](https://github.com/jdm) would work part-time on improving the Servo contributor experience, entirely funded by the monthly donations on [OpenCollective](https://opencollective.com/servo) and [GitHub](https://github.com/sponsors/servo).
In his own words, here is a look back over the past year!

---

First of all, I am enormously grateful to everyone who financially supports Servo, as those donations have enabled me to devote significant time to a project that I care a lot about.
Some highlights from that funded work that I'm proud of:

- I nominated **8 new [maintainers](https://github.com/servo/project/blob/main/governance/README.md#maintainers)**
- I reviewed **1150 pull requests**
- I filed **114 issues** targeted at newer contributors (92% of them have been fixed)
- I wrote **new documentation** about [borrow hazards](https://book.servo.org/design-documentation/script/garbage-collection-and-refcell.html), [experimental features](https://book.servo.org/design-documentation/experimental-features.html), the [AI policy](https://book.servo.org/contributing/getting-started.html#ai-policy-faq), [finding things to do](https://book.servo.org/contributing/finding-things-to-do.html), and fixing [stable](https://book.servo.org/contributing/guides/diagnosing-errors/stable-wpt-errors.html) and [intermittent](https://book.servo.org/contributing/guides/diagnosing-errors/intermittent-wpt-errors.html) test failures

On top of that, I spent time diagnosing unexpected failures in others' PRs and fixed numerous intermittent test failures that made merging PRs more difficult for everyone.

A few pieces of work from this period that stand out to me:
* supporting a [large scale rewrite](https://github.com/servo/servo/issues/40600) of the Servo's JS engine integration to address intermittent panics related to garbage collection—I reviewed lots of pull requests, but also filed many issues that enabled the work addressing the panics to be spread across many other contributors
* getting tagged in to help understand test failures, uncovering our [broken window.open behaviour](https://github.com/servo/servo/issues/43149), and eventually making [a lot of flaky tests](https://github.com/servo/servo/pull/46975) more stable
* supporting another contributor's grant proposal to work on Servo that [was approved!](https://nlnet.nl/project/Servo-Navigation_Downloads/)

This role I've carved out means a lot to me—I've found a healthy balance that allows me to spend time with my family as well as make meaningful contributions to Servo, and I get to spend a lot of time looking for ways to make the project more accessible for others.
A big thank you to everybody supporting the project and my work; each individual monthly donation makes a big difference!
I'm excited to see what's possible in the coming year.
