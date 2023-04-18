---
layout: slides.html
title: Servo
---

<!-- .slide: class="cover" -->

# Servo
## The Parallel Browser Engine

<div style="display: grid; grid-template-columns: auto auto; grid-gap: 1em; place-items: center;">

<div style="font-size: 0.5em;">

* Website: [servo.org](https://servo.org)
* Chat: [servo.zulipchat.com](https://servo.zulipchat.com/)
* Repository: [github.com/servo/servo](https://github.com/servo/servo)
* Email: <info@servo.org>

</div>

<img src="/img/servo-qr.png" style="width: 40%;" alt="QR code with Servo logo pointing to servo.org website" />

</div>

-----

## Description

* Servo aims to provide an **independent, modular, embeddable web rendering engine**, allowing developers to deliver content and applications using web standards.

* Servo is written in Rust, taking advantage of the **memory safety** properties and **concurrency** features of the language.

-----

## Features

* **Speed** (concurrency)
* **Security** (memory safety)
* **API for embedders**
* **Cross-platform support** (currently Windows, Mac, Linux)
* **Modules** (crates) can be used outside of Servo too (e.g. Stylo, WebRender, etc.)
* **Vibrant ecosystem** (Rust)

-----

## History

* Created by Mozilla Research in 2012, the Servo project is a research and development effort.

* Stewardship of Servo moved from Mozilla Research to the **Linux Foundation in 2020**, where its mission remains unchanged.

-----

## 2023 Roadmap

<div style="display: grid; grid-template-columns: repeat(4, 1fr); grid-template-rows: 1em; font-size: 0.5em; grid-gap: 0.1em; padding: 0.1em; background: white; margin: 1em;">

  <div style="background: #121619; text-align: center; font-size: 0.8em; grid-area: 1/1/9;">Q1</div>
  <div style="background: #121619; text-align: center; font-size: 0.8em; grid-area: 1/2/9;">Q2</div>
  <div style="background: #121619; text-align: center; font-size: 0.8em; grid-area: 1/3/9;">Q3</div>
  <div style="background: #121619; text-align: center; font-size: 0.8em; grid-area: 1/4/9;">Q4</div>
  <div style="padding: 0.2em; grid-column: 1 / 5; grid-row: 2; background: #42be65; text-align: center; border-radius: 0.3em; margin: 0.1em;">Project reactivation</div>
  <div style="padding: 0.2em; grid-column: 1 / 5; grid-row: 3; background: #009d9a; text-align: center; border-radius: 0.3em; margin: 0.1em;">Project outreach</div>
  <div style="padding: 0.2em; grid-column: 1 / 4; grid-row: 4; background: #1192e8; text-align: center; border-radius: 0.3em; margin: 0.1em;">Main dependencies upgrade</div>
  <div style="padding: 0.2em; grid-column: 1 / 3; grid-row: 5; background: #42be65; text-align: center; border-radius: 0.3em; margin: 0.1em;">Layout engine selection</div>
  <div style="padding: 0.2em; grid-column: 3 / 5; grid-row: 6; background: #009d9a; text-align: center; border-radius: 0.3em; margin: 0.1em;">Progress towards basic CSS2 support</div>
  <div style="padding: 0.2em; grid-column: 3 / 5; grid-row: 7; background: #1192e8; text-align: center; border-radius: 0.3em; margin: 0.1em;">Explore Android support</div>
  <div style="padding: 0.2em; grid-column: 4 / 5; grid-row: 8; background: #42be65; text-align: center; border-radius: 0.3em; margin: 0.1em;">Embeddable web engine experiments</div>

</div>

<https://github.com/servo/servo/wiki/Roadmap>

-----

## Use Cases

* Embedded devices that need a small, fast and secure web view.
* Narrow scenarios with simple embedded web applications running on Servo.
* Showcase of some advanced web features like WebGL, WebGPU, WebXR, etc.

-----

<!-- .slide: class="last" -->

## Thanks

