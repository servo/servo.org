---
layout:     post
title:      Mozilla’s Servo team joining Mixed Reality
date:       2018-03-09 12:00:00 +0530
summary:    "Mozilla's Servo team joining Mixed Reality"
categories:
---

Servo had amazing year in 2017. We saw the style system ship and deliver [performance improvements](https://hacks.mozilla.org/2017/08/inside-a-super-fast-css-engine-quantum-css-aka-stylo/) as a flagship element of the highly regarded Firefox Quantum release. And we’ve continued to build out the engine platform and experiment with new embedding APIs, innovations in graphics and font rendering, and graduate subsystems to production readiness for inclusion in Firefox. Consistently throughout those efforts, we saw work in Servo demonstrate breakthrough advances in parallelism, graphics rendering, and robustness.

Coming in to 2018, we see virtual and augmented reality devices transitioning from something just for hardcore gamers and enterprises into broad consumer adoption. These platforms will transform the way that users create and consume content on the internet. As part of the Emerging Technologies and Mozilla Research missions to enable the web platform on these new systems, we will be adopting the Mozilla Servo team as part of the Mixed Reality team and doubling down on our investigations in virtual and augmented reality. Servo is already the platform where we first implemented support for [mobile VR](https://blog.mozvr.com/samsung-gear-vr-support-lands-in-servo/), extensions, such as, [WebGL MultiView](https://blog.mozvr.com/multiview-servo-architecture/), and even our sneak peak running on the [Qualcomm Snapdragon 835 developer kit](https://img.youtube.com/vi/QJPkID53AYc/0.jpg) and compatible AR glasses from last September. Servo's lean, modern code base and leading-edge strengths in parallelism and graphics are ideal for prototyping new technology for the web and growing the results into production code usable both inside and outside of Servo.

[![Servo 6DOF A-Blast from September 2017](https://img.youtube.com/vi/QJPkID53AYc/0.jpg)](https://www.youtube.com/watch?v=QJPkID53AYc)

What does this look like concretely? The first thing we will do is get Servo implementing the [GeckoView](https://wiki.mozilla.org/Mobile/GeckoView ) API, working inside one of our existing mobile browser shell apps, and working with a ton of VR and AR devices so that it can run hand-in-hand with our existing use of Gecko in our Mixed Reality Browser. Like our [WebXR iOS Viewer](https://blog.mozvr.com/experimenting-with-ar-and-the-web-on-ios/ ), this will give us a platform where we can experiment, drive standards forward, and build compelling pilot experiences. 

Some of the experiments we’re looking to invest more in during 2018:

- Declarative VR. We have libraries like Three.js, Babylon.js, A-Frame, and ReactVR and tools like PlayCanvas and Unity to produce 3D content, but there are no standards yet for how traditional web pages should behave when loaded into a headset.

- We will continue to experiment with things like DOM to texture. It is still difficult to allow web content to be part of a 3D scene. 

- Higher quality text rendering with WebRender and Pathfinder, originally designed for desktop but now tuned for VR and AR hardware.

- Experiment with new AR APIs and computer vision.

- Experiment with new WebGL extensions (multiview, lens-matched shading, etc.)

- Experiments with device & voice APIs (WebBluetooth, Physical Web/Beacon successors, etc.)

Keep tuned here and to the [Mozilla Mixed Reality blog](https://blog.mozvr.com/) for more updates! It’s going to be a thrilling year.
