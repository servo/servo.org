---
layout: slides-no-svg.html
title: Servo Project Updates
---

<!-- .slide: class="cover" -->

<img src="/img/servo-color-negative-no-container-600.png" style="margin: 1em;" alt="Servo logo" />

<div style="font-weight: 700;">
  The
  <span style="color: #4fc066;">embeddable</span>,
  <span style="color: #209e9b;">independent</span>,
  <span style="color: #f03278;">memory-safe</span>,
  <span style="color: #f68243;">modular</span>,
  <span style="color: #faae30;">parallel</span>
  web browser engine
  <br>
</div>

<div style="font-size: 60%; margin-top: 3em;">

Manuel Rego (he/him) <rego@igalia.com>

</div>

<div style="font-size: 50%;">

Linux Foundation Europe Member Summit 2024

</div>

-----

## Project Updates 🗞️

----

<video autoplay controls loop muted>
  <source src="/img/servoshell-2024-09.webm" type="video/webm">
  <p>Servoshell (the Servo mini browser) browsing servo.org, and opening a new tab to browse frontpage of en.wikipedia.org. The video finished coming back to the first tab and loading servo.org homepage again.</p>
</video>

----

### Communication 📢

* [Monthly blog posts](https://servo.org/blog) that make it to
  [Hacker News](https://news.ycombinator.com/) and [Phoronix](https://www.phoronix.com/)
* Weekly updates on [Mastodon](https://floss.social/@servo) and [Twitter](https://x.com/servodev)
* Talks in many events: [FOSDEM](https://fosdem.org/2024/schedule/event/fosdem-2024-2321-embedding-servo-in-rust-projects/), [Open Source Summit North America](https://youtu.be/RdtlD_7JAs8), [Seattle Rust User Group](https://servo.org/slides/2024-04-16-seattle-rust-user-group/), [GOSIM Europe 2024](https://www.youtube.com/watch?v=EA_1jxzR85M), [Global Software Technology Summit](https://www.youtube.com/watch?v=SamA5Oz-G5w)

----

<!-- TODO: Update chart on Thursday's morning -->

<img src="/img/github-2024-09.png" style="padding: 1em 0.5em; background: white; height: 300px;" alt="Contributors graph from https://github.com/servo/servo/graphs/contributors showing a very slow period from mid-2020 to end of 2023, and a bigger activity in 2023 & 2024." />

<div style="font-size: smaller;">

| | 2022 | 2023 | 2024 |
|---|---:|---:|---:|
| **PRs (total)** | 215 | 1094 | 1761 |
| **PRs (no bots)** | 65 | 673 | 1118 |
| **Contributors** | 20 | 54 | 102 |

</div>

----

<a href="https://star-history.com/#servo/servo&Date">
<img style="width: 80%;" alt="GitHub Stars History Chart. Servo going up since in a 40-45 degree angle, getting up over 25,000 stars" src="/img/servo-github-star-history-2024-september.png" />
</a>

----

### Donations 🙏

* GitHub sponsors:  
  https://github.com/sponsors/servo
* OpenCollective:  
  https://opencollective.com/servo

> 350 people and organizations donating more than 16,000 USD!


----

### New platforms 📱


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


----

### Usage examples 🔗

<div style="float: left; margin-left: 2em;">
<a href="https://github.com/tauri-apps/wry/tree/servo-wry-demo">
  <img style="width: 9em; margin: 0;" src="/img/servo-tauri-example.png" alt="Example of Servo and wry (Tauri) integration" />
</a>
<br>
<a href="https://github.com/KDABLabs/cxx-qt-servo-webview">
  <img style="width: 9em; margin: 0;" src="/img/servo-qt-example.png" alt="Example of Servo WebView for Qt using CXX-Qt" />
</a>
</div>
<div style="float: left;">
<a href="https://github.com/DioxusLabs/blitz">
  <img style="width: 9em; margin: 0; margin-left: 1em;" src="/img/servo-blitz-example.png" alt="Example of Blitz integration with Servo" />
</a>
<br>
<a href="https://github.com/versotile-org/verso/">
  <img style="width: 9em; margin: 0; margin-left: 1em;" src="/img/servo-verso-example.gif" alt="Example of Verso browser based on Servo" />
</a>
</div>

<div style="position: absolute; font-size: smaller; top: 5.5em; left: 0.5em;"><a href="https://github.com/tauri-apps/wry/tree/servo-wry-demo">Tauri</a></div>
<div style="position: absolute; font-size: smaller; top: 12.5em; left: -3.2em;"><a href="">Qt WebView</a></div>
<div style="position: absolute; font-size: smaller; top: 7em; right: -0.2em;"><a href="https://github.com/DioxusLabs/blitz">Blitz</a></div>
<div style="position: absolute; font-size: smaller; top: 13.7em; right: -1.2em;"><a href="https://github.com/versotile-org/verso/">Verso</a></div>

----

### And more ➕

* servoshell
* HTML&CSS support: tables & flexbox
* WebXR
* Gamepad API
* DevTools
* ...

-----

## A web engine for the future 🔮 <!-- .element style="font-size: 1.4em;" -->

<div style="font-size: 80%; margin-inline: -3.5em; margin-top: 1.5em;">

<div style="float: left; width: 30%;">

### Highlights ✨

* **Independent**:  
  Open governance
* **Performant**:  
  Web content parallelization
* **Secure**:  
  Rust language

</div>

<div style="float: left; width: 30%; margin-inline: 3%;">

### Plan 📆

* Growing a  
  **healthy ecosystem**
* Multiple organizations  
  **joining efforts**
* Public and private sector **funding**

</div>

<div style="float: left; width: 30%;">

### Opportunities 🌈

* **Simple applications** (controlled environment)
* **UI frameworks**
* **Default web engine** for Rust apps

</div>

</div>

-----

## Join the project 🤝

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

</div>

<img src="/img/servo-qr.png" style="width: 20%; margin-left: 3em;" alt="QR code with Servo logo pointing to servo.org website" />

