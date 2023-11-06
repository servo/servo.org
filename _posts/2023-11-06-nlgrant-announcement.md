---
layout:     post
tags:       blog
title:      "Servo announces grant from the NLnet Foundation"
date:       2023-11-06
summary:    Earlier this year in July, Servo received a NLNet grant to enhance several aspects of Servo.
categories:
---

We are excited to announce that earlier this year in July, Servo received a **[NLNet grant](https://nlnet.nl/project/Servo/)** to enhance several aspects of Servo. Under this grant, our primary focus is to:

* **Complete float support in Servo**
* **Support more languages in inline layout**
* **Add initial &lt;table> support**

<h2>Floats </h2>

Supporting floats in Servo is an ongoing effort since mid-2023. We’ve made significant progress on floats, but there are still some issues that need to be addressed before Servo can boast a fully-compliant implementation of CSS floats.

Our objective is to achieve an average pass rate of over 80% for <code>/css/CSS2/floats/</code> and <code>/css/CSS2/floats-clear/</code>. You can track the results on our **[WPT dashboard](https://wpt.servo.org)**

Last week, we surpassed this for the floats tests, with an 82.2% WPT pass rate:

<img src="{{ '/img/blog/floats.png' | url }}" style="width: 60%; margin: 1em;" alt="wpt floats" />

We’re also nearing the milestone for floats-clear, currently at a 73.3% pass rate:

<img src="{{ '/img/blog/floats-clear.png' | url }}" style="width: 60%; margin: 1em;" alt="wpt floats" />

<h2>More languages in inline layout </h2>

Servo’s layout engine lacks crucial features for rendering languages that don’t use the Latin alphabet. This includes proper font selection, support for right-to-left scripts, and logical properties. Our aim is to improve Servo’s support for displaying a wider variety of content.

<h2>Initial &lt;table> support </h2>

HTML tables are an important and widely used feature. Servo’s new layout engine doesn’t support tables yet, which leads to incorrect layout of many web pages. Under this scope, our main focus is to implement initial support for tables in Servo, so that it can render tables used on Wikipedia.

As we progress and achieve these milestones, we’ll cover them in more detail in subsequent blog posts. Stay tuned for more updates!