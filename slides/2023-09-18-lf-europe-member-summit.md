---
layout: slides-new.html
title: Servo
---

<!-- .slide: class="cover" -->

<img src="/img/slides/servo-color-negative-no-container-600.png" style="margin: 2em;" alt="Servo logo" />

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

Manuel Rego (he/him) <rego@igalia.com>

</div>

<div style="font-size: 50%;">

Linux Foundation Europe Member Summit 2023

</div>

<img src="/img/lf-europe-logo.png" style="width: 200px; position: absolute; left: -120px;" alt="Linux Foundation Europe logo" />

-----

<!-- .slide: style="text-align: left;" -->

<br>

## What's Servo?

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

----

<!-- .slide: style="text-align: left;" -->

<br>

## What's Servo?

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

Servo is  
a **web rendering engine**  
written in **Rust**,  
**WebGL** and **WebGPU** capable,  
and adaptable to **desktop**, **mobile**,  
and **embedded** applications.

----


<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Web Rendering Engine</h3>

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<div style="font-size: 50%; text-align: center;">

<img src="/img/web-rendering-engine.png" alt="Image showing a HTML and CSS file with an arrow that shows some text and cat pictures on a screen" style="background: white; padding: 1em; width: 600px; margin: 3em 0;" />

</div>

<br>

<div style="font-size: 50%; margin-top: 4em;">

[Picture by Lin Clark](https://hacks.mozilla.org/2017/08/inside-a-super-fast-css-engine-quantum-css-aka-stylo/)

</div>

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Rust Programming Language</h3>

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<div style="text-align: center;">
<img src="/img/rust-logo-blk-300.png" alt="Rust logo" style="background: white; padding: 1em; width: 200px;" />
</div>

* <strong><span style="color: #f03278;">Memory-safe</span></strong>: Fewer vulnerabilities
* <strong><span style="color: #faae30;">Concurrency</span></strong>: Faster & more energy-efficient

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">WebGL</h3>

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<div style="text-align: center;">

<iframe width="800px" height="500px" src="https://demo.servo.org/experiments/twgl-tunnel/"></iframe>

</div>

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">WebGPU</h3>

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<div style="text-align: center;">

<iframe width="600px" height="500px" src="/slides/webgpu-game-of-life.html"></iframe>

</div>

----

<!--

TODO: Not sure about this slide

### Examples

More examples at <demo.servo.org>

TODO: demo.servo.org screenshot or iframe

-->


<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Desktop</h3>

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<div style="position: absolute; left: -100px; right: -150px;">

<div style="float: left; width: 30%; margin: 1.5%;">

  Linux

  <img src="/img/servo-linux.png" alt="Screenshot of Servo running on Linux opening Servo's wikipedia page" />

</div>

<div style="float: left; width: 30%; margin: 1.5%;">

  MacOS

  <img src="/img/servo-mac.png" alt="Screenshot of Servo running on MacOS opening Servo's wikipedia page" />

</div>

<div style="float: left; width: 30%; margin: 1.5%;">

  Windows 

  <img src="/img/servo-windows.png" alt="Screenshot of Servo running on Windows opening Servo's wikipedia page" />

</div>

</div>

----


<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4; display: inline-block;">Mobile</h3>
<div style="display: inline-block; line-height: 1.4; margin-left: 2em; margin-top: 0.3em;">Android & Linux (PinePhone Pro)</div>

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<div style="float: left; width: 45%; margin: 1.5%; height: 450px; text-align: center;">

  <img src="/img/servo-android.jpg" alt="Screenshot of Servo running on Android opening Servo's wikipedia page" />

</div>

<div style="float: left; width: 45%; margin: 1.5%; height: 450px; text-align: center;">

  <img src="/img/servo-pinephone.png" alt="Screenshot of Servo running on Linux mobile (PinePhone Pro) opening a wikipedia page" />

</div>

<div style="font-size: 50%; text-align: right;">

[PinePhone Pro screenshot by Capyloon](https://floss.social/@capyloon@fosstodon.org/111032248649111871)

</div>

----


<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Embedded applications</h3>

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<div style="float: left; text-align: center; width: 45%;">

UI frameworks

<img src="/img/dioxus.png" alt="Dioxus logo" style="width: 300px;" />
<img src="/img/tauri.png" alt="Tauri logo" style="width: 300px;" />

</div>

<div style="float: left; text-align: center; width: 45%; margin-left: 10%;">

Other applications

<img src="/img/delta-chat.png" alt="Delta Chat logo" style="width: 150px;" />

<img src="/img/webxdc.png" alt="webxdc logo" style="width: 150px;" />

</div>


-----


<!-- .slide: style="text-align: left;" -->

<br>

## Features

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* <span style="color: #4fc066;">Embeddable</span>
* <span style="color: #209e9b;">Independent</span>
* <span style="color: #f03278;">Memory-safe</span>
* <span style="color: #f68243;">Modular</span>
* <span style="color: #faae30;">Parallel</span>

-----


<!-- .slide: style="text-align: left;" -->

<br>

## Use cases

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* **Embedded applications** with web technologies
* Applications that use **WebGL, WebGPU or CSS-based ones**
* Basis for Rust-based **native UI frameworks**

-----


<!-- .slide: style="text-align: left;" -->

<br>

## Status

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">2023 Roadmap</h3>

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<div style="position: absolute; left: -100px; right: -150px;">

<img src="/img/servo-2023-roadmap.png" />

</div>

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">WPT Progress</h3>

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<img src="/img/wpt.png" alt="Chart from wpt.servo.org showing progress since April 2023 in the CSS2 focus areas comparing the new Servo layout engine with the legacy one. The new engine went up from 63% to 78% in that period. The legacy engine is stable around 83%." />

----


<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">2024 Plan</h3>

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* Project maintenance and outreach
* Improve CSS support
* Complete Android support
* Demos of embedded applications

-----


<!-- .slide: style="text-align: left;" -->

<br>

<h2 style="line-height: 1.4;">Join the project</h2>

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* GitHub: https://github.com/servo
* Chat: [servo.zulipchat.com](https://servo.zulipchat.com/)
* Email: <join@servo.org>

-----

<!-- .slide: class="last" style="text-align: left;" -->

<br>

<div style="float: left;">
<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

https://**servo.org**

</div>

<img src="/img/servo-qr.png" style="width: 20%; margin-left: 10em;" alt="QR code with Servo logo pointing to servo.org website" />

<div style="text-align: center;">

<img src="/img/servo-color-negative-no-container-600.png" alt="Servo logo" style="margin: 1em;" />

<img src="/img/lf-europe-logo.png" alt="Linux Foundation Europe logo" style="width: 400px; margin: 1em;" />

</div>
