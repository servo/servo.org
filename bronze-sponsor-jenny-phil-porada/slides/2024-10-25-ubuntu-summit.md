---
layout: slides-new.html
title: Servo @ Ubuntu Summit 2024
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
* and adaptable to <span style="color: #f03278;">**desktop**</span>, <span style="color: #f03278;">**mobile**, **Rpi**</span>,  
* and <span style="color: #faae30;">**embedded**</span> applications.

<div style="float: left; width: 30%; margin-inline: 3%;">

-----
<!-- .slide: style="text-align: left;" -->

## Journey so far 📈
<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* 2012: Started at Mozilla
* 2020: Mozilla's layoffs impacted the Servo team
* 2020: Joined Linux Foundation
* 2022: Talks about restarting Servo, but how?
* 2023: Team formed and restarted at Igalia
* 2024: Continuous work on Layout, Embedding, Android

<div style="font-size: 80%; margin-inline: -3.5em; margin-top: 1.5em;">
-----
<!-- .slide: style="text-align: left;" -->
## Servo 💚 Rust

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

2012: Rust and Servo Team at Mozilla Research


 <iframe src="https://giphy.com/embed/ru7IH0oTmfIK6tRTId" width="480" height="398" style="display: block; margin: auto;" frameBorder="0" class="giphy-embed" allowFullScreen></iframe>

<div style="float: left; width: 30%; margin-inline: 3%;">
-----

<!-- .slide: style="text-align: left;" -->

## Contributions over time
<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<img src="/img/commit-numbers-ubuntu-summit.png" alt="Contributors graph from https://github.com/servo/servo/graphs/contributors showing a very slow period from mid-2020 to end of 2023, and a bigger activity in 2023 & 2024." />

<div style="font-size: 80%; margin-inline: -3.5em; margin-top: 1.5em;">

-----
<!-- .slide: style="text-align: left;" -->

## What are we up to?

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* Embedding
* Layout
* Benchmarking

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

### Tauri <> Wry <> Servo 🔗

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<figure class=_fig id=_wry_demo_fig>
<iframe src="/img/blog/embedding-2024-01/demo-with-decorations-too.html" id=_wry_demo></iframe>
</figure>

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

## Dioxus (Stylo-Blitz)
<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

Use Stylo for CSS styles and selectors matching

<img src="/img/2024-02-fosdem-dioxus.png" alt="image showing stylo-dioxus experiment"/>

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

<!-- .slide: style="text-align: left;" -->

## Recent Layout work

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* Flexbox, parllel table, Floats, Font Fallback
* Right-to-left languages Support


<div style="float: left; margin-left: 1em;">
<div style="float: left; margin-left: 1em;">
  <img style="width: 9em; height:11em; margin: 0;" src="/img/blog/features-august-2024.png" alt="Example of Servo rendering a table using flexbox" />
  <img style="width: 9em;  height:11em; margin: 0;" src="/img/blog/font-fallback.png" alt="Example of Servo rendering chinese, korean and japanese characters" />
</div>
</div>

-----

<!-- .slide: style="text-align: left;" -->

## Benchmarking
<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* New experimental profiling support
* Servo Benchmarking report on Servo wiki: https://github.com/servo/servo/wiki

<img src="/img/trace-twgl.jpg" alt="Screenshot of servo's demo benchmarking using tracing perfetto" />

<div style="float: left; width: 30%; margin-inline: 3%;">
-----

<!-- .slide: style="text-align: left;" -->

### Future is here 📱

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<div class="ffragment" style="float: left; width: 49%; margin-right: 2%;">

<img style="margin-block: 0; height: 14em;" src="/img/servo-android-2024-09.jpg" alt="Screenshot of Servo running on Android opening servo.org homepage" />

<blockquote style="background: rgba(0, 0, 0, 0.75); position: relative; top: -4em; font-size: 80%; width: 70%; padding-inline: 20px;">
Android
</blockquote>

</div>

<div class="ffragment" style="float: left; width: 49%;">

<img style="margin-block: 0; height: 14em;" src="/img/servo-openharmony-2024-09.jpg" alt="Screenshot of Servo running on OpenHarmony opening Servo's wikipedia page" />

<blockquote style="background: rgba(0, 0, 0, 0.75); position: relative; top: -4em; font-size: 80%; width: 70%; padding-inline: 20px;">
OpenHarmony
</blockquote>

</div>

-----

<!-- .slide: style="text-align: left;" -->

## Community <3

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* Servo participated in Outreachy last round
* Participating again in winter cohort
* Outreachy is a 3 month paid remote internship program

> New **contributors are welcomed**

<div style="float: left; width: 30%; margin-inline: 3%;">
-----
<!-- .slide: style="text-align: left;" -->

### What's Next?
<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* Growing a **healthy ecosystem**
* Multiple organizations  **joining efforts**
* Public and private sector **funding**
* Performance, Benchmarking, HTML & CSS features

</div>
<div style="float: left; width: 30%;">

-----

<!-- .slide: style="text-align: left;" -->

### Support us 💚

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* GitHub sponsors:  
  https://github.com/sponsors/servo
* OpenCollective:  
  https://opencollective.com/servo

> 350 people and organizations donating more than 16,000 USD!

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

<a href="https://twitter.com/ServoDev" style="color: #4fc066;"><code>https://twitter.com/</code><code style="font-weight: 700;">ServoDev</code></a>

<a href="https://bsky.app/profile/servo.org" style="color: #4fc066;"><code>https://bsky.app/</code><code style="font-weight: 700;">servo.org</code></a>

</div>

<img src="/img/servo-qr.png" style="width: 20%; margin-left: 3em;" alt="QR code with Servo logo pointing to servo.org website" />


<style>
    /* guaranteed minimum width for first paragraph after a float */
    .
_floatmin {
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
    ._figl > iframe,
    ._figr > iframe,
    ._figl > a > img,
    ._figr > a > img {
        width: 17em;
        max-width: max-content;
    }
    ._figl._default > iframe,
    ._figr._default > iframe,
    ._figl._default > a > img,
    ._figr._default > a > img {
        width: auto;
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
    #_wry_demo_fig:not(#specificity) {
        width: 100%;
    }
    #_wry_demo {
        margin: 0 auto;
        display: block;
        height: min(calc(100vh - 9em), 400px);
        width: 100%;
    }
</style>
