---
layout:     post
tags:       blog
title:      Servo and SpiderMonkey
date:       2024-04-11
summary:    Overview of Servo's report on its integration of SpiderMonkey.
categories:
---

As a web engine, Servo embeds another engine for its script execution capabilities, including both JavaScript and Wasm: [SpiderMonkey](https://spidermonkey.dev/).
One of the goals of Servo is modularity, and the question of how modular it really was with regards to those capabilities came up.
For example, how easy would it be for Servo to use Chrome's V8 engine, or the next big script engine?
To answer that question, we’ve written a [short report](https://github.com/servo/servo/wiki/Servo-and-SpiderMonkey-Report) analysing the relationship between Servo and SpiderMonkey.

## The problem

Running a webpage happens inside the [`script`](https://github.com/servo/servo/tree/main/components/script) component of Servo; the loading process [starts there](https://github.com/servo/servo/blob/d9f067e998671d16a0274c2a7c8227fec96a4607/components/script/script_thread.rs#L3192), and the page continues to run its [HTML event loop](https://html.spec.whatwg.org/multipage/#event-loop-processing-model) there.
By its very nature, executing a script from within a webpage requires an integration between the script engine and the web engine that surrounds it.
Anything shared between the two, including the DOM itself and any other construct calling from one into the other, needs to be integrated somehow, and much but not all of that is done via [WebIDL](https://webidl.spec.whatwg.org/#introduction).
For example, an integration area that is left for web and script engines to implement as they see fit is that with a garbage collector (see example [in Rust for SpiderMonkey](https://github.com/servo/mozjs/blob/8603cbf35781ea8f2d57e4822a2b874f56a53914/mozjs-sys/src/jsgc.rs#L87)).

The need to integrate can result in tight coupling, but the classic ways of increasing [modularity](https://en.wikipedia.org/wiki/Modularity) — abstractions and interfaces — can be applied here as well, and that is where we found Servo lacking in some ways, but also on the right path.
Servo already comes with abstractions and interfaces for [a large surface area](https://github.com/servo/servo/tree/d9f067e998671d16a0274c2a7c8227fec96a4607/components/script/dom/bindings) of its [integration with SpiderMonkey](https://github.com/servo/mozjs), providing ease of use and clarity while preserving boundaries between the two.
Other parts of that integration rely on direct, and unsafe, calls into the [low-level SpiderMonkey APIs](https://github.com/servo/mozjs/tree/8603cbf35781ea8f2d57e4822a2b874f56a53914/mozjs-sys/src).

## The solution

The low-hanging fruit consists of removing these direct calls into low-level SpiderMonkey APIs, replacing them with safe and higher-level constructs.
Work on this has started, through a combination of efforts from maintainers and the enthusiasm of community members: [eri](https://github.com/eerii), [tannal](https://github.com/tannal), and [Taym Haddadi](https://github.com/Taym95).
These efforts have already resulted in the closing of several issues:

- [WedIDL: bring dom/bindings/typedarray further in line with spec](https://github.com/servo/servo/issues/31319)
- [WebIDL: use TypedArray](https://github.com/servo/servo/issues/31064)
- [Remove create_typed_array from dom/bindings](https://github.com/servo/servo/issues/31050)
- [WebIDL: use Float32Array in GamePad](https://github.com/servo/servo/issues/31049)
- [WebIDL: use Float32Array in XRRay](https://github.com/servo/servo/issues/31048)
- [WebIDL: use Float32Array in XRRigidTransform](https://github.com/servo/servo/issues/31047)
- [WebIDL: use Float32Array in XRView](https://github.com/servo/servo/issues/31046)
- [WebIDL impl: remove unsafe JSObject from return value of Document::NamedGetter](https://github.com/servo/servo/issues/30890)

Note that the safer higher-level constructs that replace low-level SpiderMonkey API calls are still [internally tightly coupled](https://github.com/servo/servo/blob/d9f067e998671d16a0274c2a7c8227fec96a4607/components/script/dom/bindings/buffer_source.rs) to SpiderMonkey.
By centralizing these calls, and hiding them from the rest of the codebase, it becomes possible to enumerate what exactly Servo is doing with SpiderMonkey, and to start thinking about a second layer of abstraction: one that would hide the underlying script engine.
An existing, and encouraging, example of such a layer comes from React Native in the form of its [JavaScript Interface (JSI)](https://reactnative.dev/docs/the-new-architecture/landing-page#fast-javascriptnative-interfacing).

## Call to action

If you are interested in contributing to these efforts, the issues below are good places to start:

- [Modular JS/execution engine](https://github.com/servo/servo/issues/30863)
- [WebIDL impl: remove unsafe JSObject when returning a ReadableStream](https://github.com/servo/servo/issues/30891)
- [WebIDL impl: remove unsafe JSObject from WebGLExtensionWrapper](https://github.com/servo/servo/issues/30892)
- [Support FinalizationRegistry](https://github.com/servo/servo/issues/31072)
- [WebIDL impl: Replace use of NonNull<JSObject>](https://github.com/servo/servo/issues/30889)

For more details, read [the full report](https://github.com/servo/servo/wiki/Servo-and-SpiderMonkey-Report) on our wiki.
