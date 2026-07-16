---
layout: slides-new.html
title: Servo @ EclipseCon 2023
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

<br>

## What's Servo?

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

Servo is  
a **web rendering engine**  
written in **Rust**,  
with **WebGL** and **WebGPU** support,  
and adaptable to **desktop**, **mobile**,  
and **embedded** applications.

----

<!-- .slide: style="text-align: left;" -->

<div style="font-size: 100%; text-align: center;">

<img src="/img/hands.jpg" alt="An image of a handshake where one hand represents Rust and the other Servo" style="background: white; padding: 1em; width: 500px; margin: 3em 0;" />

</div>

<br>

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

<br>

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

<br>

----

<!-- .slide: style="text-align: left;" -->

<h3 style="line-height: 1.4;">Servo Embedding</h3>

<div style="width: 50px; height: 10px; background: #4fc066; margin-bottom: 50px;"></div>

* Previous decade has seen great decrease in the diversity of web engines
* Embedded web engine space is even less diverse
* WPE (WebKit) and CEF (Chromium) are the only major players

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
<img src="/img/onirologo.svg" alt="oniro logo" style="width: 350px;" />

</div>

<br>
-----

<!-- .slide: style="text-align: left;" -->

<br>

<h2 style="line-height: 1.4;">Join the project</h2>

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* GitHub: https://github.com/servo
* Chat: [servo.zulipchat.com](https://servo.zulipchat.com/)
* Email: <join@servo.org>

<img src="/img/servo-qr.png" style="width: 20%; margin-left: 16em;" alt="QR code with Servo logo pointing to servo.org website" />