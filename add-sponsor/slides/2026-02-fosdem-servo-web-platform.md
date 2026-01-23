---
layout: slides-2026.html
title: "The Servo project and its impact on the web platform ecosystem"
---
<!-- .slide: class="cover" -->

<h1 style="font-size: 150%">The Servo project and<br>its impact on<br>the web platform ecosystem</h1>
<img src="/img/servo-color-positive-no-container.svg" style="width: 5em;" alt="Servo logo" />
<div style="font-size: 75%">

Manuel Rego (he/him) <rego@igalia.com>

**FOSDEM 2026**

</div>

-----

## About me 🧑‍💻

<div style="display: flex; font-size: 80%">
<div style="flex: 1;">

<img src="/img/rego.png" alt="Igalia logo" style="height: 4em; border-radius: 50%;" />

* **Manuel Rego**
* Igalia Web Platform Team
* Web engines hacker (Chromium & WebKit)
* CSS WG since 2017
* **Servo TSC chair since 2023**

</div>
<div style="flex: 1;">

<img src="/img/igalia-black.png" alt="Igalia logo" style="height: 3em; padding: 0.5em;" />

* **Open Source** Consultancy
* 170 people, fully remote
* **Flat structure** (cooperative-like model)
* **Top contributors** to Chromium, WebKit, Gecko and Servo

</div>
</div>

-----

<img src="/img/servo-color-positive-no-container.svg" style="width: 10em; padding-top: 1em;" alt="Servo logo" />

----

### What is Servo❓

A **web rendering engine** written in **Rust**

<div style="display: flex; flex-wrap: wrap; width: 15em; gap: 1em; margin-inline: auto; margin-block: 1em; background: white; padding: 1em; padding-top: 0.5em; border-radius: 1em;">
  <div class="feature">
    <img src="/img/home-embeddable.png" alt="Embeddable icon"/>
    <strong style="color: #4fc066;">Embeddable</strong>
  </div>
  <div class="feature">
    <img src="/img/home-memory-safe.png" alt="Embeddable icon"/>
    <strong style="color: #f03278;">Memory-safe</strong>
  </div>
  <div class="feature">
    <img src="/img/home-modular.png" alt="Embeddable icon"/>
    <strong style="color: #f68243;">Modular</strong>
  </div>
  <div class="feature">
    <img src="/img/home-parallel.png" alt="Embeddable icon"/>
    <strong style="color: #faae30;">Parallel</strong>
  </div>
  <div class="feature">
    <img src="/img/home-multi-platform.png" alt="Embeddable icon"/>
    <strong style="color: #6840CE;">Cross platform</strong>
  </div>
  <div class="feature">
    <img src="/img/home-independent.png" alt="Embeddable icon"/>
    <strong style="color: #1B8381;">Independent</strong>
  </div>
</div>
<style>
.feature {
  display: flex;
  flex-direction: column;
  flex: 4em;
  height: 4em;
}
.feature > img {
  height: 2.5em;
  margin-inline: auto;
  margin-bottom: 0.5em;
  flex: 0;
}
.feature > strong {
  font-size: 50%;
}
</style>

----

TODO: Video showing Servo opening some pages and windows

----

### Main highlights (2023-) ✨

* **Layout engine**: floats, tables, flexbox, etc.
* **Features**: Gamepad API, Streams, Web Crypto API, WebDriver, WebXR, etc.
* **WebView API**
* **DevTools**
* **SVG**
* ...

----

### Plans 🎯

* **Accessibility** support
* Complete the **WebView API**
* **Performance** optimizations
* **Editability and interactivity** enhancements
* **Layout** improvements
* ...

----

### Stats 2018-2025 📈

![Chart showing Servo stats from 2018-2025 in merged PRs, average monthly contributors and average monthly contributors with 10 or more PRs in a month. Last 3 years project has been growing a lot. All the data and details in the blog post: https://blogs.igalia.com/mrego/servo-2025-stats/](/img/servo-stats-2025.png)

----

TODO: WebDriver demo

-----

## Impact on the  
## web platform ecosystem

----

### Wider scope 🦀

* **Rust programming language**
  * Started by Mozilla in parallel with the Servo project
  * Language has been influenced by Servo's needs
  * Servo as a proof that is a serious systems programming language
* [**Popular Servo crates/libraries**](https://crates.io/teams/github:servo:cargo-publish): rust-url, html5ever, etc.
* Chromium is **starting to use Rust**

----

### New web engines 🌱

* **Show it is possible** to start from scratch
* **Similar principles**: closely follow specs terminology and structure
* **Innovation**:
  * Architectural: multi-core and parallel since the beginning
  * Allow experimentation
  * New ways to implement the web platform

----

### Mozilla Firefox Symbiosis 🦠

* Shared components:
  * cssparser
  * selectors
  * Stylo
  * WebRender
  * ...

----

### WPT (Web Platform Tests) ✅

* Shared test suite for the web platform
* Servo auto-syncs WPT in both directions ↔️
* More than **450 PRs** by `servo-wpt-sync` (261 in 2025)
* Infra: Update docker image to Ubuntu 22.04

----

### Standards 📜

* Multiple issues and improvements to specs
  * CSS
  * HTML
  * DOM
  * Fetch
  * WebDriver
  * ...

----

TODO Examples

https://github.com/whatwg/html/issues/1454#issuecomment-241317285

https://github.com/w3c/css-houdini-drafts/issues?q=is%3Aissue%20state%3Aclosed%20author%3Aasajeffrey

https://github.com/whatwg/html/issues/12016

https://github.com/w3c/csswg-drafts/issues/13149

https://github.com/w3c/csswg-drafts/issues/12852

----

### Conclusions 📌

* New web engines **help the wider ecosystem**
* **Improve specs** and identify interop issues
* **Increase test coverage** covering corner cases
* Provide **new ways to use the web platform**
* **Diversification**: healthier platform

-----

## Join the project 🤝

* GitHub: [`github.com/servo`](https://github.com/servo)
* Chat: [`servo.zulipchat.com`](https://servo.zulipchat.com/)
* Email: [`join@servo.org`](mailto:join@servo.org)
* Sponsor: [GitHub](https://github.com/sponsors/servo) & [Open Collective](https://opencollective.com/servo)

<div style="text-align: center; margin: 1em;">

Looking into **growing a healthy community around the project**

</div>

-----

## Test Servo & Report issues 🧪

* Download: [`servo.org/download`](https://servo.org/download)
* Issues: [`github.com/servo/servo/issues`](https://github.com/servo/servo/issues)
* Discussions: [`github.com/servo/servo/discussions`](https://github.com/servo/servo/discussions)

<div style="text-align: center; margin: 1em;">

**Play with Servo** and  
**let us know your experience**

</div>

-----

<!-- .slide: class="last" -->

## Thanks 🙏

<div style="float: left; font-size: 70%; text-align: left; padding: 0.5em;">

**[`servo.org`](https://servo.org)**

**[`floss.social/@servo`](https://floss.social/@servo)**

**[`bsky.app/profile/servo.org`](bsky.app/profile/servo.org)**

</div>

<img src="/img/servo-qr.png" style="width: 20%; margin-left: 3em;" alt="QR code with Servo logo pointing to servo.org website" />

<img src="/img/servo-color-positive-no-container.svg" style="width: 30%; margin: 1em;" alt="Servo logo" />

<br>

<img src="/img/lf-europe-color.svg" style="width: 20%;" alt="Linux Foundation Europe logo" />

