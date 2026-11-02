---
layout: slides-new.html
title: Servo
---

<!-- .slide: class="cover" -->

<img src="/img/servo-color-negative-no-container.svg" style="width: 50%; margin-bottom: 1em;" alt="Servo logo" />

<h4>
  The
  <span style="color: #4fc066;">embeddable</span>,
  <span style="color: #209e9b;">independent</span>,
  <span style="color: #f03278;">memory-safe</span>,
  <span style="color: #f68243;">modular</span>,
  <span style="color: #faae30;">parallel</span>
  Web Rendering Engine
  <br>
</h4>

<div style="font-size: 0.5em; float: left; padding-top: 1em; text-align: left; width: 50%;">

<div style="width: 50px; height: 10px; background: #712b97; margin-bottom: 20px;"></div>

Servo is a **web rendering engine** written in Rust, with WebGL and WebGPU support, and adaptable to desktop, mobile, and embedded applications.

</div>

<div style="font-size: 0.5em; float: left; padding-top: 1em; text-align: left; width: 30%; margin-left: 20%;">

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<span>https://**servo.org**</span>

<img src="/img/servo-qr.png" style="width: 50%; margin: 0;" alt="QR code with Servo logo pointing to servo.org website" />

</div>

-----


* Website: [servo.org](https://servo.org)
* Chat: [servo.zulipchat.com](https://servo.zulipchat.com/)
* Repository: [github.com/servo/servo](https://github.com/servo/servo)
* Email: <info@servo.org>

-----

## Description

* **Independent, modular, embeddable Web rendering engine**
* Written in **Rust**: memory safety & concurrency
* History:
  * 2012-2020: Mozilla Research
  * 2020-2023: Linux Foundation
  * 2023-: Linux Foundation Europe

Note:

* Servo aims to provide an **independent, modular, embeddable web rendering engine**, allowing developers to deliver content and applications using web standards.
* Unlike the rest of web rendering engines, Servo is written in **Rust**, taking advantage of the **memory safety** properties and **concurrency** features of the language.
* **History**:
  * Created by Mozilla Research in 2012, the Servo project is a research and development effort.
  * Stewardship of Servo moved from Mozilla Research to the **Linux Foundation in 2020**, where its mission remains unchanged.
  * June 2023 moved to **LF Europe**

-----

## Features

* **Speed** (concurrency)
* **Security** (memory safety)
* **API for embedders**
* **Cross-platform support** (currently Windows, Mac, Linux)
* **Modules** (crates) can be used outside of Servo too (e.g. Stylo, WebRender, etc.)
* **Vibrant ecosystem** (Rust)

-----

## Roadmap H2'23-H1'24

<div style="display: grid; grid-template-columns: repeat(4, 1fr); grid-template-rows: 1em; font-size: 0.5em; grid-gap: 0.1em; padding: 0.1em; background: white; margin: 1em;">

  <div style="background: #121329; text-align: center; font-size: 0.8em; grid-area: 1/1/10;">Q3'23</div>
  <div style="background: #121329; text-align: center; font-size: 0.8em; grid-area: 1/2/10;">Q4'23</div>
  <div style="background: #121329; text-align: center; font-size: 0.8em; grid-area: 1/3/10;">Q1'24</div>
  <div style="background: #121329; text-align: center; font-size: 0.8em; grid-area: 1/4/10;">Q2'24</div>
  <div style="padding: 0.2em; grid-column: 1 / 3; grid-row: 2; background: #42be65; text-align: center; border-radius: 0.3em; margin: 0.1em;">Project reactivation</div>
  <div style="padding: 0.2em; grid-column: 3 / 5; grid-row: 2; background: #1192e8; text-align: center; border-radius: 0.3em; margin: 0.1em;">Project maintenance and outreach</div>
  <div style="padding: 0.2em; grid-column: 1 / 3; grid-row: 3; background: #009d9a; text-align: center; border-radius: 0.3em; margin: 0.1em;">Project outreach</div>
  <div style="padding: 0.2em; grid-column: 1 / 3; grid-row: 4; background: #42be65; text-align: center; border-radius: 0.3em; margin: 0.1em;">Main dependencies upgrade</div>
  <div style="padding: 0.2em; grid-column: 1 / 3; grid-row: 5; background: #1192e8; text-align: center; border-radius: 0.3em; margin: 0.1em;">Progress towards basic CSS2 support</div>
  <div style="padding: 0.2em; grid-column: 3 / 5; grid-row: 5; background: #009d9a; text-align: center; border-radius: 0.3em; margin: 0.1em;">Improve CSS support</div>
  <div style="padding: 0.2em; grid-column: 2 / 3; grid-row: 6; background: #42be65; text-align: center; border-radius: 0.3em; margin: 0.1em;">Identify main areas of work to focus layout efforts in 2024</div>
  <div style="padding: 0.2em; grid-column: 1 / 3; grid-row: 7; background: #1192e8; text-align: center; border-radius: 0.3em; margin: 0.1em;">Explore Android support</div>
  <div style="padding: 0.2em; grid-column: 3 / 5; grid-row: 7; background: #009d9a; text-align: center; border-radius: 0.3em; margin: 0.1em;">Complete Android support</div>
  <div style="padding: 0.2em; grid-column: 1 / 3; grid-row: 8; background: #42be65; text-align: center; border-radius: 0.3em; margin: 0.1em;">Embeddable web engine experiments</div>
  <div style="padding: 0.2em; grid-column: 1 / 3; grid-row: 9; background: #1192e8; text-align: center; border-radius: 0.3em; margin: 0.1em;">Demos</div>

</div>


<https://github.com/servo/servo/wiki/Roadmap>

-----

## Use Cases

* Embedded devices that need a **small, fast and secure Web view**
* Simple embedded Web applications (**controlled environment**)
* **Advanced Web features** like WebGL, WebGPU, WebXR, etc.
* **Use cases**: kiosk mode applications, UI frameworks, ect.

Note:
* Servo is way smaller than the rest of web rendering engines and can be a potential alternatives for embedded devices that need a **small, fast and secure Web view**.
* Simple embedded Web applications that are run in a controlled environment (with a limited set of HTML & CSS features) can be run on Servo.
* Servo allows experimentation for **new advanced Web features** like WebGL, WebGPU, WebXR, etc. that can be showcased using Servo.
* **Use cases**:
  * Kiosk mode applications: Some displays showing a single application fullscreen where the developer controls the whole application code and can decide how to implement things. That case could use Servo if it’s enough to cover the needs of such apps (e.g. a WebGL application, a WebGPU application, some simple HTML&CSS app, etc.).
  * UI frameworks: There are different UI frameworks for developing applications on the Rust community (e.g. Dioxus, Tauri, etc.), that would be interested in having a Rust web rendering engine. These frameworks usually use different web components to define the UI, they have full control about how those components are written, and they could use Servo if they are supported.

-----

<!-- .slide: class="last" -->

## Thanks

