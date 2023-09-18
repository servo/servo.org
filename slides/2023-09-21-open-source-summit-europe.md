---
layout: slides-new.html
title: Servo
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

Manuel Rego (he/him) <rego@igalia.com>

</div>

<div style="font-size: 50%;">

Open Source Summit Europe 2023

</div>

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
* Plans
* Conclusion

-----

<!-- .slide: style="text-align: left;" -->

<br>

## About me

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* **Igalia** Web Platform Team
* **Web engines hacker** with experience in Chromium/Blink and Safari/WebKit
* **CSS Working Group** member since 2017
* **Servo** Technical Steering Committee (TSC) chair

<div style="text-align: center; padding: 1em;">

<img src="/img/igalia.png" style="width: 300px;" alt="Igalia logo" />

</div>

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

Servo is  
a **web rendering engine**  
written in **Rust**,  
**WebGL** and **WebGPU** capable,  
and adaptable to **desktop**, **mobile**,  
and **embedded** applications.

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Web Rendering Engine</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

<div style="font-size: 50%; text-align: center;">

<img src="/img/web-rendering-engine.png" alt="Image showing a HTML and CSS file with an arrow that shows some text and cat pictures on a screen" style="background: white; padding: 1em; width: 600px; margin: 3em 0;" />

</div>

<br>

<div style="font-size: 50%; margin-top: 3.5em; text-align: right;">

<a href="https://hacks.mozilla.org/2017/08/inside-a-super-fast-css-engine-quantum-css-aka-stylo/">
Picture by Lin Clark<br>https://hacks.mozilla.org/2017/08/inside-a-super-fast-css-engine-quantum-css-aka-stylo/</a>

</div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Rendering Engine Main Phases</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* Parsing: DOM Tree
* Style
* Layout: Layout Tree
* Painting
* Compositing

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Rust Programming Language</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

<div style="text-align: center;">
<img src="/img/rust-logo-blk-300.png" alt="Rust logo" style="background: white; padding: 1em; width: 200px;" />
</div>

* <strong><span style="color: #f03278;">Memory safety</span></strong>: Fewer vulnerabilities
* <strong><span style="color: #faae30;">Concurrency</span></strong>: Faster & more energy-efficient

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">WebGL</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

<img src="/img/webgl.png" style="width: 300px; background: white; padding: 1em; float: right; margin-left: 1em;" alt="WebGL logo" />

WebGL is a JavaScript API for rendering interactive 2D and 3D graphics.

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">WebGL</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

<div style="text-align: center;">

<iframe width="800px" height="500px" src="https://demo.servo.org/experiments/twgl-tunnel/"></iframe>

</div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">WebGPU</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

<img src="/img/webgpu.png" style="width: 250px; background: white; padding: 1em; float: right;" alt="WebGPU logo" />

WebGPU is the successor to WebGL providing modern 3D graphics and computation capabilities.

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;" onclick="document.getElementById('webgpuiframe').contentWindow.location.reload()">WebGPU</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

<div style="text-align: center;">

<iframe id="webgpuiframe" width="600px" height="500px" src="/slides/webgpu-game-of-life.html"></iframe>

</div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Desktop</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

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

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----


<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4; display: inline-block;">Mobile</h3>
<div style="display: inline-block; line-height: 1.4; margin-left: 2em; margin-top: 0.3em;">Android & Linux (PinePhone Pro)</div>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

<div style="float: left; width: 45%; margin: 1.5%; height: 450px; text-align: center;">

  <img src="/img/servo-android.jpg" alt="Screenshot of Servo running on Android opening Servo's wikipedia page" />

</div>

<div style="float: left; width: 45%; margin: 1.5%; height: 450px; text-align: center;">

  <img src="/img/servo-pinephone.png" alt="Screenshot of Servo running on Linux mobile (PinePhone Pro) opening a wikipedia page" />

</div>

<div style="font-size: 50%; text-align: right;">

<a href="https://fosstodon.org/@capyloon/111032248243803371">
PinePhone Pro screenshot by Capyloon<br>https://floss.social/@capyloon@fosstodon.org/111032248649111871</a>

</div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Embedded applications</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

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

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">What's not Servo right now?</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* A production ready rendering engine.  
  Servo is **experimental**
* An engine to browse the general web.  
  Servo can render a **controlled environment**

-----

<!-- .slide: style="text-align: left;" -->

<br>

## Features

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* **Embeddable** <!-- .element: style="color: #4fc066;" -->
* **Independent** <!-- .element: style="color: #209e9b;" -->
* **Memory-safe** <!-- .element: style="color: #f03278;" -->
* **Modular** <!-- .element: style="color: #f68243;" -->
* **Parallel** <!-- .element: style="color: #faae30;" -->

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Embeddable</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* Applications can use Servo to render **web content**
* Servo is working on providing a good **API for embedders** (a webview library)
* Servo works on **embedded devices** (e.g. Raspberry Pi)

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Independent</h3>

<div style="width: 50px; height: 10px; background: #209e9b; margin-bottom: 20px;"></div>

* 2012-2020: Mozilla Research
* 2020-2023: Linux Foundation
* 2023-: **Linux Foundation Europe**

<div style="text-align: center; padding: 3em;">

<img src="/img/lf-europe-logo.png" style="width: 400px;" alt="Linux Foundation Europe logo" />

</div>

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Memory-safe</h3>

<div style="width: 50px; height: 10px; background: #f03278; margin-bottom: 20px;"></div>

* **Rust** programming language
* Borrow checker and ownership system
* Built-in safe concurrent data structures
* **Eliminate vulnerabilities** related to **memory** (e.g. *use-after-free*) and **concurrency** (e.g. race conditions)

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Modular</h3>

<div style="width: 50px; height: 10px; background: #f68243; margin-bottom: 20px;"></div>

* Several Servo modules have become popular in the **Rust ecosystem**
* **Firefox** uses some modules (e.g. html5ever, rust-cssparser, Stylo, WebRender)

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Parallel</h3>

<div style="width: 50px; height: 10px; background: #faae30; margin-bottom: 20px;"></div>

* Devices have **multiple cores** in both CPU and GPU
* Servo uses parallelism to provide **faster and more energy-efficient** rendering
* **Rust** programming language makes easier to implement concurrency

-----

<!-- .slide: style="text-align: left;" -->

<br>

## Status

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">2023 Roadmap</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

<div style="position: absolute; left: -100px; right: -150px;">

<img src="/img/servo-2023-roadmap.png" />

</div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Project reactivation</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

<img src="/img/github.png" alt="Contributors graph from https://github.com/servo/servo/graphs/contributors showing a very slow period from mid-2020 to end of 2023, and a bigger activity in 2023." />

* 1682 commits (523 in 2022)
* 77 committers (22 in 2022)
* Monthly TSC meetings

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Project outreach</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* **Blog pots** with updates around the project: <https://servo.org/blog/>
* **Events**: RustNL, Web Engines Hackfest, Embedded Open Source Summit, W3C TPAC, Linux Foundation Europe Member Summit, Open Source Summit Europe, GOSIM

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Main dependencies upgrade</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* **WebRender** has been upgraded to mid 2021
* **Stylo** has upgrade is at ~50% (landing in batches)
* **SpiderMonkey** hasn't been upgraded yet

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Layout engine selection</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* Servo has **two layout engines**, the original one (called legacy) and the new one (started in 2020)
* [**Servo Layout Engines Report**](https://github.com/servo/servo/wiki/Servo-Layout-Engines-Report)
* Proposal to move forward with the **new layout engine**

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Progress towards basic CSS2 support</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

<img src="/img/wpt.png" style="margin-left: 50px; margin-top: 0px;" alt="Chart from wpt.servo.org showing progress since April 2023 in the CSS2 focus areas comparing the new Servo layout engine with the legacy one. The new engine went up from 63% to 78% in that period. The legacy engine is stable around 83%." />

<div style="font-size: 50%; margin-top: -0.5em; text-align: right;">

<a href="https://wpt.servo.org">https://wpt.servo.org</a>

</div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">CSS floats</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

<img src="/img/wpt-floats.png" style="margin-left: 50px; margin-top: 0px;" alt="Chart from wpt.servo.org showing progress in /css/CSS2/floats/ folder since April comparing the new Servo layout engine with the legacy one. The new engine went up from 17% to 76% in that period. The legacy engine moved from 47% to 53%." />

<div style="font-size: 50%; margin-top: -0.5em; text-align: right;">

<a href="https://wpt.servo.org">https://wpt.servo.org</a>

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

  <img src="/img/servo-acid1-202309.png" alt="Screenshot of Servo acid1 test result in Sep'23" />

  September 2023

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

  <img src="/img/servo-acid2-202309.png" alt="Screenshot of Servo acid2 test result in Sep'23" />

  September 2023

</div>

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Explore Android support</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* Experimental **prototype running in Android**

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

<div style="float: left; width: 45%; margin: 1.5%; height: 400px; text-align: center;">

  <img src="/img/servo-android.jpg" alt="Screenshot of Servo running on Android phone opening Servo's wikipedia page" />

</div>

<div style="float: left; width: 45%; margin: 1.5%; height: 400px; text-align: center;">

  <img src="/img/servo-android-emulator.png" alt="Screenshot of Servo running on Android emultator opening Servo's wikipedia page" />

</div>

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Embeddable web engine experiments</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

* Servo running on **Raspberry Pi** and **PinePhone Pro**
* Discussions about the **embedding API** design
* More work on the API to come soon

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Other</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

* **Make easier to contribute to Servo** by simplifying the build, reducing build and CI times, etc.
* Servo **minibrowser** to test it easily (URL bar)
* Bring **WebGPU** support back to life
* **Servo experiments**: <https://demo.servo.org/>
* ...

-----

<!-- .slide: style="text-align: left;" -->

<br>

## Plans

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Embedding API</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* Very important task to **start getting applications using Servo**
* **Design** has been agreed in the TSC calls
* Plan to start working on this in **Q4**
* Goal: create some prototype applications using the new API

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">More CSS improvements</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* Carry on with floats, inline layout, ...
* More to come: line-height, vertical-align, tables, writing modes, ...
* Identify main **areas of work** to focus **layout efforts in 2024**

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Complete Android support</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* So far we have a **first experimental prototype**
* Look into having **proper Android support**
* Applications could also **use Servo in Android**

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">And more</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* Carry on **maintenance and project outreach**
* **Lots of things to work on**
* Plans to experiment with Servo in **more platforms and boards**
* ...

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

-----

<!-- .slide: style="text-align: left;" -->

<br>

## Conclusion

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Servo is looking great</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* **Renewed project activity** has been successful
* **New layout engine** is paving the path for more feature support and better interoperability
* **Great progress** during 2023 in many areas
* **Servo is still an experimental** and big project with lots of work everywhere

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h3 style="line-height: 1.4;">Use cases</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* **Embedded applications** with web technologies
* Applications that use **WebGL, WebGPU or CSS-based ones**
* Basis for Rust-based **native UI frameworks**

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

----

<!-- .slide: style="text-align: left;" -->

<br>

<h2 style="line-height: 1.4;">Join the project</h2>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 20px;"></div>

* GitHub: https://github.com/servo
* Chat: [servo.zulipchat.com](https://servo.zulipchat.com/)
* Email: <join@servo.org>

Looking into **growing the community around the project**.

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

-----

<!-- .slide: class="last" style="text-align: left;" -->

<br>

<div style="float: left;">
<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

https://**servo.org**

<span>https://floss.social/<strong>@servo</strong></span>

<span>https://twitter.com/<strong>ServoDev</strong></span>

</div>

<img src="/img/servo-qr.png" style="width: 20%; margin-left: 3em;" alt="QR code with Servo logo pointing to servo.org website" />

<div style="text-align: center;">

<img src="/img/servo-color-negative-no-container-600.png" alt="Servo logo" style="margin: 1em;" />

<img src="/img/lf-europe-logo.png" alt="Linux Foundation Europe logo" style="width: 400px; margin: 1em;" />

</div>

