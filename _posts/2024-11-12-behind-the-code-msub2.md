---
layout:     post
tags:       blog
title:      "Behind the code: an interview with msub2"
date:       2024-11-12
summary:    Q&A with Servo contributor msub2.
categories:
---

Behind the Code is a new series of interviews with the contributors who help propel Servo forward. Ever wondered why people
choose to work on web browsers, or how they get started? We invite you to look beyond the project's pull requests and issue
reports, and get to know the humans who make it happen.

<hr>

## <img src="https://avatars.githubusercontent.com/u/70986246?v=4" width=60> [msub2](https://github.com/msub2)

Some representative contributions:
* [OpenXR: Separate graphics handling from main OpenXR code](https://github.com/servo/webxr/pull/243)
* [Surface supported interaction profiles from OpenXR runtime](https://github.com/servo/webxr/pull/229)
* [Support OpenXR runtimes that do not support fovMutable](https://github.com/servo/webxr/pull/224)
* [crypto: Begin SubtleCrypto implementation](https://github.com/servo/servo/pull/33628)
* [bindings: Allow Guard to take multiple conditions, check for SecureContext in ConstructorEnabled](https://github.com/servo/servo/pull/33508)
* [Implement non-XR Gamepad discovery and input](https://github.com/servo/servo/pull/31200)

### Tell us about yourself!

My name is Daniel, though I more commonly go by my online handle "msub2". I'm something of a generalist, but my primary interests
are developing for the web, XR, and games. I created and run the [WebXR Discord](https://discord.gg/webxr), which has members from both the Immersive Web Working
Group and the Meta Browser team, among others. In my free time (when I'm not working, doing Servo things, or tending to my other
programming projects) I'm typically watching videos from YouTube/Dropout/Nebula/etc and playing video games.

### Why did you start contributing to Servo?

A confluence of interests, to put it simply. I was just starting to really get into Rust, having built a CHIP-8 emulator and an
NES emulator to get my hands dirty, but I also had prior experience contributing to other browser projects like Chromium and Gecko.
I was also eyeing Servo's WebXR implementation (which I had submitted a couple small fixes for last year) as I could see there was
still plenty of work that could be done there. To get started though, I looked for an adjacent area that I could work on to get
familiar with the main Servo codebase, which led to my first contribution being support for non-XR gamepads!

### What was challenging about your first contribution?

I'd say the most challenging part of my first contribution was twofold: the first was just getting oriented with how data flows
in and out of Servo via the embedding API and the second was understanding how DOM structs, methods, and codegen all worked together
in the script crate. Servo is a big project, but luckily I got lots of good help and feedback as I was working through it, which
definitely made things easier. Looking at existing examples in the codebase of the things I was trying to do got me the rest of the
way there I'd say.

### What do you like about contributing to the project? What do you get out of it?

The thing I like most about Servo (and perhaps the web platform as an extension) is the amount of interesting problems that there
are to solve when it comes to implementing/supporting all of its different features. While most of my contributions so far have been
focused around Gamepad and WebXR, recently I've been working to help implement SubtleCrypto alongside another community member, which
has been really interesting! In addition to the satisfaction I get just from being able to solve interesting problems, I also rather
enjoy the feeling of contributing to a large, communal, open-source project.

### Any final thoughts you'd like to share?

I'd encourage anyone who's intrigued by the idea of contributing to Servo to give it a shot! The recent waves of attention for projects
like Verso and Ladybird have shown that there is an appetite for new browsers and browser engines, and with Servo's history it just
feels right that it should finally be able to rise to a more prominent status in the ecosystem.
