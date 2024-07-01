---
layout: slides-new-servo.html
title: "Servo: a web rendering engine for the future"
---

<!-- .slide: class="cover" -->

<img src="/img/servo-color-negative-no-container-600.png" style="margin: 2em; margin-bottom: 1em;" alt="Servo logo" />

<h2>A web rendering engine<br>for the future 🔮</h2>

<p style="font-weight: 700; font-size: 80%; margin: 1em; margin-top: 2em;">Manuel Rego (he/him) &nbsp;&nbsp;<a href="mailto:rego@igalia.com"><code>rego@igalia.com</code></a></p>

<p style="font-weight: 700; font-size: 60%;">Global Software Technology Summit 2024</p>

<img src="/img/lf-europe-logo.png" style="width: 200px; position: absolute; left: -120px; top: 626px;" alt="Linux Foundation Europe logo" />

<img src="/img/igalia.png" style="width: 200px; position: absolute; right: -100px; top: 597px;" alt="Igalia logo" />

-----

<!-- .slide: style="text-align: left;" -->

<br>

## Index

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

* Introduction
* What's Servo? (and what's not)
* Servo features
* Status
* Long-term vision
* Wrap up

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

-----

<!-- .slide: style="text-align: left;" -->

<br>

## About me

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* **Igalia** Web Platform Team
* **Web engines hacker** with experience in Chromium/Blink and Safari/WebKit
* **CSS Working Group** member since 2017
* **Servo** Technical Steering Committee (TSC) chair since 2023

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

## About Igalia

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* **Open Source Consultancy** founded in 2001
* 140 people, fully remote (25 countires)
* **Flat structure** (cooperative like model)
* Top contributors to **Chromium, WebKit, Gecko and Servo**

<div style="text-align: center;">

<img src="/img/igalia.png" style="width: 300px;" alt="Igalia logo" />

</div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

-----

<!-- .slide: style="text-align: left;" -->

<br>

## What's Servo?

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

## What's Servo?

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<div>Servo is</div>
<div class="fragment">a <strong>web rendering engine</strong></div>
<div class="fragment">written in <strong>Rust</strong>,</div>
<div class="fragment">with <strong>WebGL</strong> and <strong>WebGPU</strong> support,</div>
<div class="fragment">and adaptable to <strong>desktop</strong>, <strong>mobile</strong>,</div>
<div class="fragment">and <strong>embedded</strong> applications.</div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Web Rendering Engine</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

<div style="font-size: 50%; text-align: center;">

<img src="/img/web-rendering-engine.png" alt="Image showing a HTML and CSS file with an arrow that shows some text and cat pictures on a screen" style="background: white; padding: 1em; width: 600px; margin: 0.5em 0 2em;" />

</div>

* **Blink** (Chrome), **Gecko** (Firefox), **WebKit** (Safari)
* Huge projects: **millions lines of code**
* Big teams: >100 engineers

<br>

<div style="font-size: 40%; margin-top: 3.2em; text-align: right;">

<a href="https://hacks.mozilla.org/2017/08/inside-a-super-fast-css-engine-quantum-css-aka-stylo/">
Picture by Lin Clark<br><code style="font-size: 75%;">https://hacks.mozilla.org/2017/08/inside-a-super-fast-css-engine-quantum-css-aka-stylo/</code></a>

</div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Rendering Engine Main Phases</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

<div style="font-size: 50%; text-align: center;">

<img src="/img/phases.png" alt="Image showing the phases of a web rendering engine: parsing, style, layout, paint, composite & render" style="background: white; padding: 0.5em; width: 850px; margin: 0;" />

</div>

<div style="font-size: 40%; margin-top: 0.5em; text-align: right;">

<a href="https://hacks.mozilla.org/2017/08/inside-a-super-fast-css-engine-quantum-css-aka-stylo/">
Pictures by Lin Clark<br><code style="font-size: 75%;">https://hacks.mozilla.org/2017/08/inside-a-super-fast-css-engine-quantum-css-aka-stylo/</code></a>

</div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Servo Phases & Modules</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* Parsing: html5ever, **rust-cssparser**
* Style: **Stylo**
* Layout
* Painting
* Compositing: **WebRender**

<br>
<br>

<p style="text-align: center;">JavaScript engine: <strong>SpiderMonkey</strong> (C++)</p>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">What's not Servo right now?</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* A web browser.  
  Servo is a **web rendering engine**
* A production ready rendering engine.  
  Servo is **experimental**
* An engine to browse the general web.  
  Servo can render a **controlled environment**

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

-----

<!-- .slide: style="text-align: left;" -->

<br>

## Features

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Independent</h3>

<div style="width: 50px; height: 10px; background: #209e9b; margin-bottom: 20px;"></div>

* 2012-2020: Mozilla Research
* 2020-2023: Linux Foundation
* 2023-: **Linux Foundation Europe**

<div style="text-align: center; padding: 1em;">

<img src="/img/lf-europe-logo.png" style="width: 400px;" alt="Linux Foundation Europe logo" />

</div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Independent</h3>

<div style="width: 50px; height: 10px; background: #209e9b; margin-bottom: 20px;"></div>

<div style="text-align: center;">

<img src="/img/github-2024-06.png" style="margin: 0;" alt="Contributors graph from https://github.com/servo/servo/graphs/contributors showing a very slow period from mid-2020 to end of 2023, and a bigger activity in 2023 & 2024." />

</div>

<div style="font-size: smaller;">

| | 2022 | 2023 | 2024 H1 |
|---|---:|---:|---:|
| **PRs (total)** | 215 | 1094 | 1192 |
| **PRs (no bots)** | 65 | 673 | 734 |
| **Contributors** | 20 | 54 | 75 |

</div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Independent</h3>

<div style="width: 50px; height: 10px; background: #209e9b; margin-bottom: 20px;"></div>

* Main web engines are managed  
  by **big corporations** (Apple, Google, Mozilla)
* Funding comes from **Google Search & Ads**
* Servo:
  * **Open governance** at LF Europe
  * Managed by the **TSC** (Technical Steering Committee)

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Parallel</h3>

<div style="width: 50px; height: 10px; background: #faae30; margin-bottom: 20px;"></div>

* Since project's inception **parallelism**  
  has been a foundation (Rust)
* Servo has a **parallel layout engine**  
  (despite its complexity)
* Potentially **faster and more energy-efficient** taking advantage of **multiple cores**

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Parallel</h3>

<div style="width: 50px; height: 10px; background: #faae30; margin-bottom: 20px;"></div>

* No recent **performance work**
* Pending to do **proper benchmarking**
* Initial results are **quite promising**

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Parallel</h3>

<div style="width: 50px; height: 10px; background: #faae30; margin-bottom: 20px;"></div>

<div style="text-align: center;">
  <video id="servo-chromium-video" autoplay loop muted style="width: 80%;">
    <source src="/img/servo-chromium-video.webm" type="video/webm">
  </video>
</div>

<div style="position: absolute; left: 250px; top: 620px;">Servo</div>
<div style="position: absolute; left: 580px; top: 620px;">Chromium</div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Embeddable</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* Provide a **webview** for other applications
  * **API for embedders** is still evolving
  * **Use cases**: UI frameworks, other apps
* Valid alternative for **embedded devices**

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Embeddable</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

<div style="text-align: center;">

<iframe src="/img/blog/embedding-2024-01/demo-with-decorations-too.html" style="width: 800px; height: 420px; margin: 0;"></iframe>

<p style="margin-top: 0;">Tauri using Servo underneath</p>

</div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Memory-safe</h3>

<div style="width: 50px; height: 10px; background: #f03278; margin-bottom: 20px;"></div>

<div style="text-align: center;">
<img src="/img/rust-logo-blk-300.png" alt="Rust logo" style="background: white; padding: 0; margin: 0; width: 200px;" />
</div>

* **Rust** programming language
* **Fewer vulnerabilities** related to **memory** and **concurrency**
* Other web rendering engines use **C++**

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Modular</h3>

<div style="width: 50px; height: 10px; background: #f68243; margin-bottom: 20px;"></div>

* Several Servo modules (**crates**) are popular in the **Rust ecosystem**
* 🦊 **Firefox** uses some Servo modules:
  * rust-cssparser
  * Stylo
  * WebRender

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

-----

<!-- .slide: style="text-align: left;" -->

<br>

## Status

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">CSS</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

<div style="text-align: center;">
  <img src="/img/wpt-css-202406.png" style="margin: 0; width: 90%;" alt="Chart from wpt.servo.org showing progress in /css/ folder since April 2023. Servo has went up from 42.6% to 66.4% pass-rate in that period." />
</div>

<div style="font-size: 40%; margin-top: 1em; text-align: right;">
  <a href="https://wpt.servo.org"><code style="font-size: 75%;">https://wpt.servo.org</code></a>
</div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Acid1 test</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

<div style="float: left; width: 45%; margin: 1.5%; height: 450px; text-align: center;">

  <img src="/img/servo-acid1-202301.png" alt="Screenshot of Servo acid1 test result in Jan'23" />

  January 2023

</div>

<div style="float: left; width: 45%; margin: 1.5%; height: 450px; text-align: center;">

  <img src="/img/servo-acid1-202406.png" alt="Screenshot of Servo acid1 test result in Jun'24" />

  June 2024

</div>

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Acid2 test</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

<div style="float: left; width: 45%; margin: 1.5%; height: 450px; text-align: center;">

  <img src="/img/servo-acid2-202301.png" alt="Screenshot of Servo acid2 test result in Jan'23" />

  January 2023

</div>

<div style="float: left; width: 45%; margin: 1.5%; height: 450px; text-align: center;">

  <img src="/img/servo-acid2-202406.png" alt="Screenshot of Servo acid2 test result in Jun'24" />

  June 2024

</div>

-----

<!-- .slide: style="text-align: left;" -->

<br>

## Long-term vision

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<div style="font-weight: 700; margin: 3em 1em;">
  The
  <span style="color: #4fc066;">embeddable</span>,
  <span style="color: #209e9b;">independent</span>,
  <span style="color: #f03278;">memory-safe</span>,
  <span style="color: #f68243;">modular</span>,
  <span style="color: #faae30;">parallel</span>
  web rendering engine
</div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">HTML & CSS support</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* Servo layout engine **lacks several features**
* Requires a **lot of work** to make it web compatible
* This is a **years-long effort**

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Performance</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* Servo **has not been optimized yet in most cases**
* Most of the existing optimization work has been done in **modules that are shared with Firefox** (e.g. Stylo, WebRender)
* There's still **a lot of work to do** in other parts of Servo (e.g. incremental layout)

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Binary size & memory footprint</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* Servo is expected to be a **lightweight and modular web rendering engine**
* Lots of work to do:
  * **Reduce binary size**
  * **Memory usage** fine tuning
  * Allow **customizations** (disabling some parts)
* **No recent work** regarding these topics

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Accessibility (a11y)</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* A11y in other rendering engines usually have a **negative performance impact**
* Servo aims to have **a11y support without impacting the end user**
* Servo currently **does not have any a11y support**

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Popular frameworks</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* Servo **does not support popular development frameworks** (e.g. React, Vue)
* Required work **implementing different web platform specs** to support them
* **Complements the work related to HTML & CSS** including other standards

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Popular websites</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* Similar to the previous point
* Servo **cannot render popular websites** due to missing features (e.g. WebRTC)
* **Adding support for features** to be able to use some websites or web apps in Servo

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

-----

<!-- .slide: style="text-align: left;" -->

<br>

## Wrap up

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Servo rendering engine</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* Strong points:
  * **Independent**: Open governance at LF EU
  * **Performant**: Web content parallelization
  * **Secure**: Rust language
* Not so good:
  * Still **experimental**
  * **Missing features**

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">A rendering engine for the future 🔮</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* How to get there:
  * Growing a **healthy ecosystem around the project**
  * With **multiple organizations joining efforts**
  * Public and private sector **funding the project**

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Opportunities</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* **Simple applications** that need to render web content
  * Known and controlled environment
  * Specific features: WebGL, WebGPU, CSS
* Allowing **UI frameworks** to use Servo
* **Default web engine** in the Rust ecosystem
* Eventually growing to **support a web browser**

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Challenges</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* Huge **competitors**
* The web platform is **always evolving**
* Not big enough **team**
* Lack of **funding**

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Join the project</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* GitHub: <a href="https://github.com/servo"><code>github.com/servo</code></a>
* Chat: <a href="https://servo.zulipchat.com/"><code>servo.zulipchat.com</code></a>
* Email: <a href="mailto:join@servo.org"><code>join@servo.org</code></a>
* Sponsor: [GitHub](https://github.com/sponsors/servo) & [Open Collective](https://opencollective.com/servo)

<div style="text-align: center; margin: 1em;">

Looking into **growing the community  
around the project**

</div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

-----

<!-- .slide: class="last" style="text-align: left;" -->

<br>

<div style="float: left; font-size: 80%;">
<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<a href="https://servo.org" style="color: #4fc066;"><code>https://</code><code style="font-weight: 700;">servo.org</code></a>

<a href="https://floss.social/@servo" style="color: #4fc066;"><code>https://floss.social/</code><code style="font-weight: 700;">@servo</code></a>

<a href="https://twitter.com/ServoDev" style="color: #4fc066;"><code>https://twitter.com/</code><code style="font-weight: 700;">ServoDev</code></a>

</div>

<img src="/img/servo-qr.png" style="width: 20%; margin-left: 3em;" alt="QR code with Servo logo pointing to servo.org website" />

<div style="text-align: center;">

<img src="/img/servo-color-negative-no-container-600.png" alt="Servo logo" style="margin: 1em;" />

<img src="/img/lf-europe-logo.png" alt="Linux Foundation Europe logo" style="width: 400px; margin: 1em;" />

</div>

