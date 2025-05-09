---
layout: slides-new.html
title: Servo @ Open Harmony Summit 2025 Rotterdam
---
<!-- .slide: class="cover" -->

<img src="/img/servo-color-negative-no-container-600.png" style="margin: 2em;" alt="Servo logo" />

<h4 style="line-height: 1.4">
  The
  <span style="color: #4fc066;">embeddable</span>,
  <span style="color: #209e9b;">independent</span>,
  <span style="color: #f03278;">memory-safe</span>,
  <span style="color: #f68243;">modular</span>,
  <span style="color: #faae30;">parallel</span>
  web rendering engine
  <br>
</h4>
<div style="font-size: 60%; margin-top: 4em;">

Rakhi Sharma (She/her) <atbrakhi@igalia.com>

</div>
-----
<!-- .slide: style="text-align: left;" -->
## About me

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* **Open Source Engineer** working on Servo

* **Igalia** Web Platform Team

* **Servo** Technical Steering Committee (TSC) member

* **atbrakhi** on internet

<div style="float: left; width: 30%; margin-inline: 3%;">

-----
<!-- .slide: style="text-align: left;" -->
## Web engine for the future 🔮

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* written in <span style="color: #4fc066;">**Rust**</span>,  
* with <span style="color: #209e9b;">**WebGL**</span> and <span style="color: #209e9b;">**WebGPU**</span> support,  
* and adaptable to <span style="color: #f03278;">**desktop**</span>, <span style="color: #f03278;">**mobile**, **Rpi**</span>
* and <span style="color: #faae30;">**embedded**</span> applications.

<div style="float: left; width: 30%; margin-inline: 3%;">

-----
<!-- .slide: style="text-align: left;" -->

## Journey so far 📈
<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* 2012: Started at Mozilla
* 2020: Servo Team was laid off. Servo joins LF
* 2023: Servo restarted at Igalia
* 2024: Layout, Embedding, Android, Benchmarking
* 2025: Embedding, Incremental Layout, Devtools, Open Harmony

<div style="font-size: 80%; margin-inline: -3.5em; margin-top: 1.5em;">
-----
<!-- .slide: style="text-align: left;" -->
## Servo 💚 Rust

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

Rust and Servo Team at Mozilla Research


 <iframe src="https://giphy.com/embed/ru7IH0oTmfIK6tRTId" width="480" height="398" style="display: block; margin: auto;" frameBorder="0" class="giphy-embed" allowFullScreen></iframe>

<div style="float: left; width: 30%; margin-inline: 3%;">
-----

<!-- .slide: style="text-align: left;" -->

## Contributions over time
<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<img src="/img/commits-03-2024.png" alt="Contributors graph from https://github.com/servo/servo/graphs/contributors showing a very slow period from mid-2020 to end of 2023, and a bigger activity in 2023, 2024 & 2025" />

<div style="font-size: 80%; margin-inline: -3.5em; margin-top: 1.5em;">

-----
<!-- .slide: style="text-align: left;" -->

## What are we up to?

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* Embedding API
* Open Harmony Support
* Servo Devtools
* Incremental Layout

<div style="float: left; width: 30%; margin-inline: 3%;">

-----
<!-- .slide: style="text-align: left;" -->

### Embedding 🔗
<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* Embed Servo in applications
* Applications can use Servo to render web content
* Provide good API for embedders
* Servo on embedded devices (e.g. Raspberry Pi, OpenHarmony)

<div style="float: left; width: 30%; margin-inline: 3%;">
-----

<!-- .slide: style="text-align: left;" -->

## Verso: browser using Servo as a web engine!
<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>


<a href="https://github.com/versotile-org/verso/">
  <img src="/img/servo-verso-example.gif" alt="Example of Verso browser based on Servo" />
</a>
</div>

-----
<!-- .slide: style="text-align: left;" -->

## KDAB QT

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<div style="float: left; width: 40%;">

  * Servo inside Qt, using KDAB's CXX-Qt library as bridge
  * CXX-Qt is a safe interop between Rust and Qt

</div>
<div style="float: right; width: 55%; margin-top: 3%;">
 <img src="/img/2024-04-16-OSS-NA-KDAB.png" alt="image showing Servo running using KDAB QT" />
</div>

<div style="float: left; width: 30%; margin-inline: 3%;">

-----
<!-- .slide: style="text-align: left;" -->

## Minibrowser

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<img src="/img/2024-02-fosdem-minibrowser.png" alt="image showing Servo minibrowser" />

<div style="float: left; width: 30%; margin-inline: 3%;">

-----

## Projects built with Servo

<!-- <div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div> -->

 <img src="/img/browser-ui-servo.png" alt="image showing projects that are built with Servo components" />

<div style="float: left; width: 30%; margin-inline: 3%;">

-----

## With Servo Component
<!-- <div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div> -->

 <img src="/img/made-with-servo-component.png" alt="image showing projects that are built with Servo components" />

<div style="float: left; width: 30%; margin-inline: 3%;">

-----

## Web Platform tests
<!-- <div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div> -->

 <img src="/img/servo-wpt-03-2025.png" alt="image showing wpt test results for servo" />

  There are more than 2 million subtests
<div style="float: left; width: 30%; margin-inline: 3%;">

-----

<!-- .slide: style="text-align: left;" -->

## Benchmarking

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

 * Support for tracing and perfetto
 * Support for Speedometer
 * Track binary size with each commit

<div style="float: left; width: 30%; margin-inline: 3%;">
-----

<!-- .slide: style="text-align: left;" -->

## Benchmarking

<!-- <div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div> -->

<img src="/img/bencher-dev-servo.png" alt="image showing servo on bencher dev" />

<div style="float: left; width: 30%; margin-inline: 3%;">
-----

<!-- .slide: style="text-align: left;" -->

### Open Harmony 📱

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<div class="ffragment" style="float: left; width: 65%;">

* Servo running on OH ✅
* OH nightly ✅
* Build, CI & Documentation ✅

<img style="margin-block: 0;" src="/img/nightly.png" alt="image showing Servo nightly" />
</div>

<div class="ffragment" style="float: right; width: 30%;">

<img style="margin-block: 0; height: 14em;" src="/img/servo-openharmony-2024-09.jpg" alt="Screenshot of Servo running on OpenHarmony opening Servo's wikipedia page" />

</div>

-----

<!-- .slide: style="text-align: left;" -->

### Open Harmony <> Mini-apps <> Goals

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* A browser requires support for all web standards for all websites a user might visit.
* Mini-apps on the other hand have a reduced subset of CSS and html features that need to be supported, and could opt-in on a per-miniapp basis to use servo
* Servo aims for performance similar to or even better than Chromium

<div style="float: left; width: 30%; margin-inline: 3%;"></div>

-----
<!-- .slide: style="text-align: left;" -->

### Future: Open Harmony and Mini-apps
<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* Improving the Embedding API: Exposing a C-API for servo with OpenHarmony webview as the first major consumer
* Implement support for Mini-apps: Adding support for Web APIs that are required to support the mini-apps (e.g. Service Workers)

</div>
<div style="float: left; width: 30%;">

-----

<!-- .slide: style="text-align: left;" -->

### Future: Layout and Performance

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* Incremental layout: improve performance by reducing unnecessary computations and rendering by caching fragment tree layout and incrementally updating the box and fragment tree
* Parallelism: increase energy efficiency by utilizing multiple smaller cores instead of one big core on smartphones for better performance

</div>
<div style="float: left; width: 30%;">

-----
<!-- .slide: style="text-align: left;" -->

### Future: Debugging, HTML, CSS
<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* Servo Devtool Support: Inspecting, Networking, Performance Recording, Javascript debugging
* Continue development of missing CSS & HTML Feature

</div>
<div style="float: left; width: 30%;">

-----
<!-- .slide: style="text-align: left;" -->
## Join the project 🤝
<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* GitHub: <a href="https://github.com/servo"><code>github.com/servo</code></a>
* Chat: <a href="https://servo.zulipchat.com/"><code>servo.zulipchat.com</code></a>
* Email: <a href="mailto:join@servo.org"><code>join@servo.org</code></a>
* Sponsor: [GitHub](https://github.com/sponsors/servo) & [Open Collective](https://opencollective.com/servo)

<br>
<br>

> Looking into **growing the community around the project**

-----

<!-- .slide: class="last" style="text-align: left;" -->

<div style="float: left; font-size: 80%; margin-bottom: 5em;">

<a href="https://servo.org" style="color: #4fc066;"><code>https://</code><code style="font-weight: 700;">servo.org</code></a>

<a href="https://floss.social/@servo" style="color: #4fc066;"><code>https://floss.social/</code><code style="font-weight: 700;">@servo</code></a>

<a href="https://bsky.app/profile/servo.org" style="color: #4fc066;"><code>https://bsky.app/</code><code style="font-weight: 700;">servo.org</code></a>

</div>

<img src="/img/servo-qr.png" style="width: 20%; margin-left: 3em;" alt="QR code with Servo logo pointing to servo.org website" />

