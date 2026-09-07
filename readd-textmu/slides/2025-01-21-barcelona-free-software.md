---
layout: slides-no-svg-no-lf-logo.html
title: Why build a new web browser engine in Rust?
---

<!-- .slide: class="cover" -->

# Why build a new web browser engine in Rust?

<div style="font-size: 60%; margin-top: 3em;">

Martin Robinson <mrobinson@igalia.com>

</div>

<div style="font-size: 50%;">

Barcelona Free Software / January 2025

</div>

-----

## About Me
- Partner at Igalia and member of the Web Platform team
- Long-time contributor to WebKit, Chrome, Firefox and other browsers
- Now working on Servo

-----

## The First Browsers
- WorldWideWeb (1990): For NeXT computers
- LineModeBrowser (1991): Cross-platform text-based
- NCSA Mosaic (1993): Graphical cross-platform, images
- Microsoft Internet Explorer (1994)
- Netscape Navigator (1994)

-----

<div style="text-align: left; font-weight: bold; font-size: 150px;">Not the Whole Story</div>

-----

## The First Browsers

<table>
<tr>
<td style="vertical-align: top;">
<ul>
<li>ViolaWWW (1991)
<li>Erwise (1992)
<li>MacWWW (1992)
<li>MidasWWW (1992)
<li>tkWWW (1992)
<li>Arena (1993)
<li>Cello (1993)
</ul>
</td>
<td style="vertical-align: top;">
<ul>
<li>Lynx (1993)
<li>Agora (1994)
<li>Grail (1995) 
<li>IBM WebExplorer (1995)
<li>UdiWWW (1995)
<li>Amaya (1996)
</ul>
</td>
</tr><table>

-----

## First Browser Wars

- Two major browser emerged between 1995 and 2001
  - Netscape Navigator
  - Microsoft Internet Explorer
- War fought with features
  - JavaScript (Netscape) & JScript (IE)
  - `<marquee>` and `<blink>`
  - Cascading Style Sheets

-----

## First Browser Wars

 - Internet Explorer market peak around 90% in 2000.
   - Microsoft has almost complete control of browser market for years
 - Web platform stagnates
   - Flash: Animation / interactive content
   - RealPlayer: Streamed video

-----

## Second Browser Wars

- AOL purchases Netscape
   - Mozilla branches off 
   - Upstart project within Mozilla: Firefox (2004)
- Opera becomes freeware
- Apple forks KHTML to create WebKit / Safari (open source)
- Chrome released based on WebKit (2009)

-----

## Open Source & Standards

- Browser engines increasingly open source
- Standards bodies arbiter of Web Platform evolution
- Rapid feature development: tabs, HTML5, CSS 2.1, transforms, transitions, animations, WebGL, audio, video
- Plugins are dead or dying

-----

## Today

 - Chrome has 65% of market share today.
    - No other browser has over 20% share.
    - iOS limits Chrome’s market share
 - Browser vendors also online service providers

-----

## The Browser Engine

 - Open source engine, but used to build closed source browser 
 - Written in C++ / Objective-C / small amounts of Rust
 - Innovation expensive and risky
 - Engines are interoperable and follow standards
 - Engine providers gatekeepers on standards bodies

-----

##  Endangered

 - Presto (abandoned 2013)
 - Trident (abandoned 2015)
 - Edge HTML (abandoned 2020)

-----

## A Special Moment

-----

<img src="/img/2025-01-barcelona-free-software/special-moment.png" style="margin: 2em;" />


-----

## Build a new browser engine!

- Prevent control of standards bodies by a small number of browser vendors
- Offer a place to innovate
- New platforms
- New web technology

-----

## The Ideal Browser Engine

- Independent
- Safe
- Concurrent
- Embeddable
- Modular & Light-weight

-----

<img src="/img/servo-color-negative-no-container-600.png" style="margin: 2em;" alt="Servo logo" />

<div style="font-size: 50px; font-weight: bold; line-height: 1.4">
  The
  <span style="color: #4fc066;">embeddable</span>,
  <span style="color: #209e9b;">independent</span>,
  <span style="color: #f03278;">memory-safe</span>,
  <span style="color: #f68243;">modular</span>,
  <span style="color: #faae30;">parallel</span>
  web rendering engine
  <br>
</h4>

-----

## Independent

- History
   - 2012 - 2020: Mozilla Research
   - 2020 - 2023: Linux Foundation
   - 2023 - Today: Linux Foundation Europe
- Community run
   - Decisions made by Technical Steering Committee
   - No one company decides project direction

-----

## Safe

- Written in the Rust programming language
- Memory safety insured with borrow checker and ownership system
- Built-in concurrent data structures
- Avoid use-after-free and data races

-----

## Taking a Reference

```rust
fn main() {
    let variable = 42;
    let variable_ref1 = &variable;
    let variable_ref2 = &variable;
    println!("{variable_ref1} {variable_ref2}");
}
```
-----

## Borrow Checking

```rust
fn main() {
    let mut variable = 42;
    let variable_ref1 = &mut variable;
    let variable_ref2 = &variable;
    println!("{variable_ref1} {variable_ref2}");
}
```

-----

## Borrow Checking

```text
error[E0502]: cannot borrow `variable` as immutable because it is also borrowed as mutable
 --> src/main.rs:5:25
  |
4 |     let variable_ref1 = &mut variable;
  |                         ^^^^^^^^^^^^^ mutable borrow occurs here
5 |     let variable_ref2 = &variable;
  |                         ^^^^^^^^^ immutable borrow occurs here
6 |     println!("{variable_ref1} {variable_ref2}");
  |               ^^^^^^^^^^^^^^^ mutable borrow later used here

For more information about this error, try `rustc --explain E0502`.
error: could not compile `playground` (bin "playground") due to 1 previous error
```

-----


<div style="text-align: left; font-weight: bold; font-size: 150px;">Zero-cost Safety</div>

-----

# Concurrent

- Devices have multiple CPU cores, yet layout typically only runs on one core
- Servo uses parallelism to provide faster and more energy-efficient rendering
- Rust unlocks parallelism through fearless concurrency
- Unique to Servo

-----

# Threads & Mutability

```rust
use std::thread;

#[derive(Debug)]
struct DataStructure {
    value: i32
}

fn main() {
    let mut structure = DataStructure { value: 100 };
    thread::spawn(move || {
        for _ in 0..10 {
            structure.value += 1;
        }
        println!("in thread: {structure:?}");
    });
    println!("{:?}", structure);
}
```

-----

# Threads & Mutability

```text
   error[E0382]: borrow of moved value: `structure`
     --> src/main.rs:16:22
      |
   9  |     let mut structure = DataStructure { value: 100 };
      |         ^^^^^^^^^^^^^ move occurs because `structure` has type
      |     `DataStructure`, which does not implement the `Copy` trait
   10 |     thread::spawn(move || {
      |                   ^^^^^^^ value moved into closure here
   ...
   14 |         println!("in thread: {structure:?}");
      |                               ^^^^^^^^^ variable moved due to use in closure
   15 |     });
   16 |     println!("{:?}", structure);
      |                      ^^^^^^^^^ value borrowed here after move
      |
    note: if `DataStructure` implemented `Clone`, you could clone the value
     --> src/main.rs:4:1
      |
   4  | struct DataStructure {
      | ^^^^^^^^^^^^^^^^^^^^ consider implementing `Clone` for this type
   ...
   14 |         println!("in thread: {structure:?}");
      |                               ^^^^^^^^^ you could clone this value
```

-----

# Threads & Mutability

```rust
use std::thread;

#[derive(Debug)]
struct DataStructure {
    value: i32
}

fn main() {
    let mut structure = DataStructure { value: 100 };
    let handler = thread::spawn(move || {
        for _ in 0..10 {
            structure.value += 1;
        }
        structure
    });

    let structure = handler.join().unwrap();
    println!("{:?}", structure);
}
````


-----

<div style="text-align: left; font-weight: bold; font-size: 150px;">Fearless Concurrency</div>

-----

# Embeddable

- Servo seeks to be an embedding-first web engin
- Not *just* a browser, but an engine for applications
- Expose an API rich enough for browsers

-----

# Modular & Light-weight

- Composed of reusable Rust components. Many available on `crates.io`.
- Parts of Servo already used in Firefox
- Components can be rewritten and replaced
- Newer codebase means it is much easier to make larger architectural changes

-----

<div style="font-size: 50px; font-weight: bold; line-height: 1.4">
  We want to create an
  <span style="color: #209e9b;">independent</span>
  and
  <span style="color: #f03278;">advanced</span>
  browser engine that 
  <span style="color: #f68243;">disrupts</span>
  the <span style="color: #faae30;">web platform</span>.
</h4>

-----

<div style="font-size: 50px; font-weight: bold; line-height: 1.4">
  We want to foster a
  <span style="color: #209e9b;">vibrant</span>,
  <span style="color: #f03278;">active</span>,
  and
  <span style="color: #f68243;">curious</span>,
  community of 
  <span style="color: #faae30;">tinkerers</span>
  and
  <span style="color: #4fc066">web engine developers</span>
</h4>

-----

## Collaborate

- Try an experimental build of Servo
- Get in touch:
  - Mastodon: https://floss.social/@servo
  - GitHub: https://github.com/servo
  - Chat: servo.zulipchat.com
  - Email: join@servo.org

-----

<div style="text-align: left; font-weight: bold; font-size: 150px;">Questions?</div>

