---
layout: slides-new.html
title: Servo @ Open Source Summit NA 2024
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

-----
<!-- .slide: style="text-align: left;" -->

## About Igalia

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* **Open Source Consultancy** founded in 2001
* 140 people, fully remote (25 countires)
* **Flat structure** (cooperative like model)
* Top contributors to **Chromium, WebKit and Gecko**

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

<img src="/img/servo-color-negative-no-container-600.png" style="width: 150px; position: absolute; left: -120px; top: 633px;" alt="Servo logo" />

-----
<!-- .slide: style="text-align: left;" -->

## Servo's Journey So Far
<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

2012: Started at Mozilla

2020: Mozilla's layoffs impacted the Servo team

2020: Joined Linux Foundation

2022: Talks about restarting Servo, but how?

2023: Team formed and restarted at Igalia

-----
<!-- .slide: style="text-align: left;" -->

## Servo's Restart Announcement
<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<img src="/img/2024-04-16-OSS-NA-servo-announcement.png" alt="image showing the announcement `Servo to Advance in 2023`" />
-----
<img src="/img/2024-02-fosdem-servo.jpg" alt="What is the status of servo? Is it alive? Is it dead?" />
-----
<!-- .slide: style="text-align: left;" -->

## Servo in 2023

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* Restarted the Project/Maintainence/Outreach
* Layout Engine, CSS2 Support
* Built [internal WPT](https://wpt.servo.org) and [Servo demos](https://demo.servo.org)
* Embedding, Minibrowser

-----
<!-- .slide: style="text-align: left;" -->

## Restarting Servo

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>
<img src="/img/2024-04-16-OSS-NA-github-graph.png"alt="Github activity graph" />

* 2485 commits (+375% over 523 in 2022)
* 1037 pull requests (+382% over 215 in 2022)
* 53 unique contributors (+140% over 22 in 2022),

-----
<!-- .slide: style="text-align: left;" -->

## Servo Demos, where?

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* https://demo.servo.org/

<img src="/img/2024-04-16-OSS-NA-demo3.png" alt="servo demo https://demo.servo.org/" />

-----
<!-- .slide: style="text-align: left;" -->

## Internal WPT dashboard?

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

 * Internal WPT https://wpt.servo.org/

<div style="float: left; width: 45%; margin: 1.5%; height: 250px; text-align: center;">
  <img src="/img/2024-04-16-OSS-NA-wpt2.png" alt="wpt https://wpt.servo.org/" />
</div>
<div style="float: left; width: 45%; margin: 1.5%; height: 250px; text-align: center;">
  <img src="/img/2024-04-16-OSS-NA-wpt1.png" alt="wpt https://wpt.servo.org/" />
</div>

-----
<!-- .slide: style="text-align: left;" -->

## Choosing a layout Engine

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* Layout 2013 (legacy) vs Layout2020 (started in 2020)
* [Servo Layout Engines Report](https://github.com/servo/servo/wiki/Servo-Layout-Engines-Report)
* Moving forward with Layout2020

-----
<!-- .slide: style="text-align: left;" -->

## Layout: Support for Floats

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<div style="float: left; width: 85%; text-align: center;">
  <img src="/img/2024-04-16-OSS-NA-floats-wpt.png" alt="image showing wpt score for floats in servo layout" />
</div>
-----
<!-- .slide: style="text-align: left;" -->

## Layout: Support for Tables

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>
<div style="float: left; width: 15%; height:40%; margin: 1.5%; text-align: center;">
<!-- Enabled by default -->
</div>
<div style="float: left; width: 50%; height:50%; margin-bottom: 1%; text-align: center;">
  <img src="/img/2024-04-16-OSS-NA-spacejam.png"  alt="picture of spacejam website running on servo" />
</div>

-----
<!-- .slide: style="text-align: left;" -->

## Layout: WPT for Tables

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<div style="float: left; width: 85%; text-align: center;">
  <img src="/img/2024-04-16-OSS-NA-table-wpt.png" alt="image showing wpt score for tables in servo layout" />
</div>

-----
<!-- .slide: style="text-align: left;" -->

## Layout: Many more

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* font fallback
* `<div align>`, `<center>`, sticky positioning
* text-align-last, text-align: justify’, vertical-align
* Migration from floating-point coordinates (f32) to fixed-point coordinates (Au)

-----
<!-- .slide: style="text-align: left;" -->

## Embedding Servo

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* Start getting applications using Servo
* Applications can use Servo to render web content
* Provide good API for embedders
* Servo on embedded devices (e.g. Raspberry Pi)

-----
<!-- .slide: style="text-align: left;" -->

## Minibrowser

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<img src="/img/2024-02-fosdem-minibrowser.png" alt="image showing Servo minibrowser" />
-----
<!-- .slide: style="text-align: left;" -->

## No-Minibrowser
<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>
Run servo with --no-minibrowser

<img src="/img/2024-02-fosdem-minibrowser.png" alt="image showing Servo running without minibrowser" />


-----
<!-- .slide: style="text-align: left;" -->

## Collaboration with Tauri

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

Thank you NLnet for sponsoring this collboration
<figure class=_fig id=_wry_demo_fig>
<iframe src="/img/blog/embedding-2024-01/demo-with-decorations-too.html" id=_wry_demo></iframe>
</figure>

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

<img src="/img/2024-04-16-OSS-NA-KDAB.png" style="width: 70%;" alt="image showing Servo running using KDAB QT" />
-----
<!-- .slide: style="text-align: left;" -->

## Servo on Android.

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>


<div style="float: left; width: 45%; margin: 1.5%; height: 250px; text-align: center;">

  * Support for x86_64 images

  * Servo running in Android emulators

  * Preliminary Android build support

</div>
<div style="float: left; width: 45%; margin-left: 1.5%; height: 550px; text-align: center;">
 <img src="/img/2024-04-16-OSS-NA-android.jpeg" alt="image showing servo running on Android" />
</div>

-----
<!-- .slide: style="text-align: left;" -->

## Servo and Outreachy

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

* Servo participated in Outreachy this year
* Outreachy is a 3 month paid remote internship program
* Many new contributors during contribution phase
* Helping improve code health, layout and docs

-----
<!-- .slide: style="text-align: left;" -->

## Future Roadmap

<div style="width: 50px; height: 10px; background: #488bd1; margin-bottom: 20px;"></div>

<img src="/img/2024-04-16-OSS-NA-2024-roadmap.png" alt="Servo’s roadmap for 2024" />

-----

<!-- .slide: class="last" -->

## Thanks
<div style="font-size: 60%; margin-bottom: 4em;">

Rakhi Sharma (She/her) <atbrakhi@igalia.com>

</div>

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
