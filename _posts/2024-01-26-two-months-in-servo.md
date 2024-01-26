---
layout:     post
tags:       blog
title:      "Two months in Servo: better inline layout, stable Rust, and more!"
date:       2024-01-26
summary:    Improved control over typography, very early support for sticky positioning and tables, plus updates to our minibrowser and build tooling.
categories:
---

<figure class="_figr"><a href="{{ '/img/blog/layout-2020-justify.png' | url }}"><img src="{{ '/img/blog/layout-2020-justify.png' | url }}"
    alt="Servo nightly showing support for ‘text-align-last’, ‘text-align: justify’, ‘vertical-align: baseline’, and ‘position: sticky’"></a></figure>

Servo has had some exciting changes land in our nightly builds over the last month:

- as of 2023-12-27, the ‘text-align-last’ property is now supported ([@mrobinson](https://github.com/mrobinson), [#30905](https://github.com/servo/servo/pull/30905))
- as of 2023-12-27, ‘text-align: justify’ is now supported ([@mrobinson](https://github.com/mrobinson), [#30807](https://github.com/servo/servo/pull/30807), [#30866](https://github.com/servo/servo/pull/30866))
- as of 2024-01-09, ‘line-height’ and ‘vertical-align’ are now moderately supported ([@mrobinson](https://github.com/mrobinson), [#30902](https://github.com/servo/servo/pull/30902))
- as of 2024-01-24, ‘Event#composedPath()’ is now supported ([@gterzian](https://github.com/gterzian), [#31123](https://github.com/servo/servo/pull/31123))

<figure class="_figl"><a href="{{ '/img/blog/layout-2020-tables.png' | url }}"><img src="{{ '/img/blog/layout-2020-tables.png' | url }}"
    alt="Servo nightly showing rudimentary support for table layouts when the pref is enabled"></a></figure>

We’ve started working on support for **sticky positioning** and **tables** in the new layout engine, with some very early sticky positioning code landing in 2023-11-30 ([@mrobinson](https://github.com/mrobinson), [#30686](https://github.com/servo/servo/pull/30686)), the CSS tables tests now enabled ([@mrobinson](https://github.com/mrobinson), [#31131](https://github.com/servo/servo/pull/31131)), and rudimentary table layout landing in 2024-01-20 under the `layout.tables.enabled` pref ([@mrobinson](https://github.com/mrobinson), [@Loirooriol](https://github.com/Loirooriol), [@Manishearth](https://github.com/Manishearth), [#30799](https://github.com/servo/servo/pull/30799), [#30868](https://github.com/servo/servo/pull/30868), [#31121](https://github.com/servo/servo/pull/31121)).

Geometry in our new layout engine is now being migrated from floating-point coordinates (`f32`) to **fixed-point coordinates** (`i32` × 1/60) ([@atbrakhi](https://github.com/atbrakhi), [#30825](https://github.com/servo/servo/pull/30825), [#30894](https://github.com/servo/servo/pull/30894), [#31135](https://github.com/servo/servo/pull/31135)), similar to other engines like WebKit and Blink.
While floating-point geometry was thought to be better for transformation-heavy content like SVG, the fact that larger values are less precise than smaller values causes a variety of rendering problems and test failures ([#29819](https://github.com/servo/servo/issues/29819)).

As a result of these changes, we’ve made big strides in our WPT pass rates:

- **CSS2 floats** (+3.3pp to 84.9%) and **floats-clear** (+5.6pp to 78.9%) continue to surge
- we now surpass legacy layout in the **CSS2 linebox** tests (**61.1% → 87.9%**, legacy 86.4%)
- we now surpass legacy layout in the **css-flexbox** tests (49.5% → 52.7%, legacy 52.2%)
- we’ve closed 76% of the gap in **key CSS2 tests** (79.2% → 82.2%, legacy 83.1%)

## Updates, servoshell, and stability

**GStreamer** has been updated from 0.15 to 0.21 ([@mrobinson](https://github.com/mrobinson), [#30750](https://github.com/servo/servo/pull/30750)), fixing long-standing breakage of video playback.
**WebGPU** has been updated from 0.17 to 0.18 ([@sagudev](https://github.com/sagudev), [#30926](https://github.com/servo/servo/pull/30926), [#30954](https://github.com/servo/servo/pull/30954)), and **ANGLE** has been updated from [April 2019](https://chromium.googlesource.com/angle/angle/+/refs/heads/chromium/3729) to [August 2023](https://chromium.googlesource.com/angle/angle/+/refs/heads/chromium/5359) ([@sagudev](https://github.com/sagudev), [#30546](https://github.com/servo/servo/pull/30546)).

<figure class="_figr"><a href="{{ '/img/blog/back-forward.png' | url }}"><img src="{{ '/img/blog/back-forward.png' | url }}"
    alt="Servo nightly showing Back and Forward buttons in the minibrowser"></a></figure>

Servo’s example browser now has **Back and Forward buttons** ([@atbrakhi](https://github.com/atbrakhi), [#30805](https://github.com/servo/servo/pull/30805)), and no longer shows the incorrect location when navigation takes a long time ([@atbrakhi](https://github.com/atbrakhi), [#30518](https://github.com/servo/servo/pull/30518)).

Many stability improvements have landed, including fixes for a crash in inline layout ([@atbrakhi](https://github.com/atbrakhi), [#30897](https://github.com/servo/servo/pull/30897)), three WebGPU-related crashes ([@lucasMontenegro](https://github.com/lucasMontenegro), [@gterzian](https://github.com/gterzian), [@Taym95](https://github.com/Taym95), [#30888](https://github.com/servo/servo/pull/30888), [#30989](https://github.com/servo/servo/pull/30989), [#31002](https://github.com/servo/servo/pull/31002)), a crash in the PerformanceResourceTiming API ([@delan](https://github.com/delan), [#31063](https://github.com/servo/servo/pull/31063)), and several crashes due to script runtimes being dropped in the wrong order ([@gterzian](https://github.com/gterzian), [#30896](https://github.com/servo/servo/pull/30896)).

## CI, code health, and dev changes

The intermittent macOS build failures on CI should now be fixed ([@mrobinson](https://github.com/mrobinson), [#30975](https://github.com/servo/servo/pull/30975)).

Servo now has some preliminary Android build support ([@mukilan](https://github.com/mukilan), [#31086](https://github.com/servo/servo/pull/31086)), though more work needs to be done before Servo will run on Android.

The long-term effort to simplify how Servo is built continues ([@mrobinson](https://github.com/mrobinson), [#31075](https://github.com/servo/servo/pull/31075)), and we’ve replaced the `time` crate with `chrono` and `std::time` in much of Servo ([@Taym95](https://github.com/Taym95), [@augustebaum](https://github.com/augustebaum), [#30927](https://github.com/servo/servo/pull/30927), [#31020](https://github.com/servo/servo/pull/31020), [#30639](https://github.com/servo/servo/pull/30639), [#31079](https://github.com/servo/servo/pull/31079)).
We have also started migrating our DOM bindings to use typed arrays where possible ([@gterzian](https://github.com/gterzian), [#30990](https://github.com/servo/servo/pull/30990), [#31077](https://github.com/servo/servo/pull/31077), [#31087](https://github.com/servo/servo/pull/31087), [#31076](https://github.com/servo/servo/pull/31076), [#31106](https://github.com/servo/servo/pull/31106)), as part of an effort to **reduce our unsafe code surface** ([#30889](https://github.com/servo/servo/issues/30889), [#30862](https://github.com/servo/servo/issues/30862)).

Several crates have been moved into [our main repo](https://github.com/servo/servo):

* `hyper_serde` ([servo/hyper_serde](https://github.com/servo/hyper_serde)) was moved to `components/hyper_serde` ([@mrobinson](https://github.com/mrobinson), [#30803](https://github.com/servo/servo/pull/30803))
* `device` ([servo/devices](https://github.com/servo/devices)) was merged into `components/bluetooth` ([@mrobinson](https://github.com/mrobinson), [#30974](https://github.com/servo/servo/pull/30974))
* `blurmac` ([servo/devices](https://github.com/servo/devices)) was moved to `third_party/blurmac` ([@mrobinson](https://github.com/mrobinson), [#30974](https://github.com/servo/servo/pull/30974))

We’ve also made some dev changes:

- the default branch in [our main repo](https://github.com/servo/servo) is now `main` ([@mrobinson](https://github.com/mrobinson), [@atouchet](https://github.com/atouchet), [23add0c1e5c9c](https://github.com/servo/servo/commit/23add0c1e5c9cbdf0301b891d265e363d049532b), [#30877](https://github.com/servo/servo/pull/30877))
- we now target **Rust 1.74** stable, marking the first time ever we have built without unstable features ([@mrobinson](https://github.com/mrobinson), [#30831](https://github.com/servo/servo/pull/30831))
- we now require **Python 3.10** ([@mrobinson](https://github.com/mrobinson), [#31088](https://github.com/servo/servo/pull/31088)), and you no longer need to install virtualenv ([@frewsxcv](https://github.com/frewsxcv), [#30377](https://github.com/servo/servo/pull/30377))
- we’ve fixed problems building Servo on **Ubuntu 20.04** ([@mrobinson](https://github.com/mrobinson), [#31019](https://github.com/servo/servo/pull/31019)) and **NixOS** ([@delan](https://github.com/delan), [#31052](https://github.com/servo/servo/pull/31052), [#31055](https://github.com/servo/servo/pull/31055), [#30987](https://github.com/servo/servo/pull/30987))
- we now support **Visual Studio 2022** on Windows ([@mrobinson](https://github.com/mrobinson), [#31148](https://github.com/servo/servo/pull/31148)), the same version that rustup installs by default

### Linux build issues

Several people have reported problems building Servo on newer Linux distro versions, particularly [with clang 15](https://github.com/servo/servo/issues/31059) or [with clang 16](https://github.com/servo/servo/issues/30587).
While we’re still working on fixing the underlying issues, there are some workarounds.
If your distro lets you install older versions of clang with a package like `clang-14`, you can tell Servo to use it with:

```
export CC=/usr/bin/clang-14
export CXX=/usr/bin/clang++-14
```

Alternatively you can try our new Nix-based dev environment, which should now work on any Linux distro ([@delan](https://github.com/delan), [#31001](https://github.com/servo/servo/pull/31001)).
[Nix](https://nixos.org/manual/nix/stable/) is a package manager with some unusual benefits.
Servo can use Nix to find the correct versions of all of its compilers and build dependencies without needing you to install them or run `mach bootstrap`.
All you need to do is install Nix, and `export MACH_USE_NIX=` to your environment.
[See the wiki](https://github.com/servo/servo/wiki/Building#nix-on-other-distros) for more details!

<style>
    /* guaranteed minimum width for first paragraph after a float */
    ._floatmin {
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
        width: 21em;
        max-width: max-content;
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
</style>
