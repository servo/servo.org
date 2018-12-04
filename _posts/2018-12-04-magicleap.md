---
layout:     post
title:      Experience porting Servo to the Magic Leap One
date:       2018-12-04 15:00:00
summary:    We now have nightly releases of Servo for Magic Leap, this post describes the process of making them
categories:
---

## Introduction

We now have nightly releases of Servo for the Magic Leap One augmented reality headset.
You can head over to [https://download.servo.org/](https://download.servo.org/), install the
application, and browse the web in a virtual browser.

![Magic Leap Servo]({{ site.url }}/images/magicleap-servo.jpg "Magic Leap Servo")

This is a developer preview release, designed for as a testbed for future products,
and as a venue for experimenting with UI design. What should the web look like in augmented
reality? We hope to use Servo to find out!

We are providing these nightly snapshots to encourage other developers to experiment with
AR web experiences. There are still many missing features, such as immersive or 3D content,
many types of user input, media, or a stable embedding API. We hope you forgive the rough edges.

This blog post will describe the experience of porting Servo to a new architecture,
and is intended for system developers.

## Magic Leap under the hood

The Magic Leap software development kit (SDK) is based on commonly-used open-source
technologies. In particular, it uses the clang compiler and the gcc toolchain
for support tools such as `ld`, `objcopy`, `ranlib` and friends.

The architecture is 64-bit ARM, using the same application binary interface as Android.
Together these give the target as being `aarch64-linux-android`, the same as for many
64-bit Android devices. Unlike Android, Magic Leap applications are
native programs, and do not require a Java Native Interface (JNI) to the OS.

Magic Leap provides a lot of support for developing AR applications, in the form of
the Lumin Runtime APIs, which include 3D scene descriptions, UI elements, input events
including device placement and orientation in 3D space, and rendering to displays
which provide users with 3D virtual visual and audio environments that interact with
the world around them.

The Magic Leap and Lumin Runtime SDKs are available from
[https://creator.magicleap.com/](https://creator.magicleap.com/) for Mac and Windows platforms.

## Building the Servo library

The Magic Leap library is built using `./mach build --magicleap`,
which under the hood calls `cargo build
--target=aarch64-linux-android`. For most of the Servo library and its
dependencies, this just works, but there are a couple of corner cases:
C/C++ libraries and crates with special treatment for Android.

Some of Servo's dependencies are crates which link against C/C++
libraries, notably `openssl-sys` and `mozjs-sys`. Each of these
libraries uses slightly different build environments (such as Make,
CMake or Autoconf, often with custom build scripts). The challenge for
software like Servo that uses many such libraries is to find a
configuration which will work for all the dependencies. This comes
down to finding the right settings for environment variables such as
`$CFLAGS`, and is complicated by cross-compiling the libraries which
often means ensuring that the Magic Leap libraries are included, not
the host libraries.

The other main source of issues with the build is that since Magic
Leap uses the same ABI as Android, its target is
`aarch64-linux-android`, which is the same as for 64-bit ARM Android
devices. As a result, many crates which need special treatment for
Android (for example for JNI or to use `libandroid`) will treat the
Magic Leap build as an Android build rather than a Linux build. Some
care is needed to undo all of this special treatment. For example,
the build scripts of Servo, SpiderMonkey and OpenSSL all contain code
to guess the directory layout of the Android SDK, which needs to be
undone when building for Magic Leap.

![Debugging in vscode]({{ site.url }}/images/magicleap-vscode.png "Debugging in vscode")

One thing that just worked turned out to be debugging Rust code on the
Magic Leap device. Magic Leap supports the Visual Studio Code IDE, and
remote debugging of code running natively. It was great to see the
debugging working out of the box for Rust code as well as it did for C++.

## Building the Magic Leap application

The first release of Servo for Magic Leap comes with a rudimentary
application for browsing 2D web content. This is missing many
features, such as immersive 3D content, audio or video media, or user
input by anything other than the controller.

Magic Leap applications come in two flavors: universe applications,
which are immersive experiences that have complete control over the
device, and landscape applications, which co-exist and present the
user with a blended experience where each application presents part of
a virtual scene. Currently, Servo is a landscape application, though
we expect to add a universe application for immersive web content.

Landscape applications can be designed using the Lumin Runtime Editor,
which gives a visual presentation of the various UI components in the
scene graph.

![Lumin Runtime Editor]({{ site.url }}/images/magicleap-lre.png "Lumin Runtime Editor")

The most important object in Servo's scene graph is the `content`
node, since it is a `Quad` that can contain a 2D resource. One of the
kinds of resource that a `Quad` can contain is an EGL context, that
Servo uses to render web content. The runtime editor generates C++
code that can be included in an application to render and access the
scene graph; Servo uses this to access the content node, and the EGL
context it contains.

The other hooks that the Magic Leap Servo application uses are for
events such as moving the laser pointer, which are mapped to mouse
events, a heartbeat for animations or other effects which must be
performed on the main thread, and a logger which bridges Rust's logging
API to Lumin's.

The Magic Leap application is built each night by Servo's CI system,
using the Mac builders since there is no Linux SDK for Magic
Leap. This builds the Servo library, and packages it is a Magic Leap
application, which is hosted on S3 and linked to from the Servo
download page.

## Summary

The pull request that added Magic Leap support to Servo is
[https://github.com/servo/servo/pull/21985](https://github.com/servo/servo/pull/21985)
which adds about 1600 lines to Servo, mostly in the build scripts and
the Magic Leap application. Work on the Magic Leap port of Servo started
in early September 2018, and the pull request was merged at the end of October,
so took about two person-months.

Much of the port was straightforward, due to the maturity of the Rust
cross-compilation and build tools, and the use of common open-source
technologies in the Magic Leap platform. Lumin OS contains many
innovative features in its treatment of blending physical and virtual
3D environments, but it is built on a solid open-source foundation,
which makes porting a complex application like Servo relatively
straightforward.

Servo is now making its first steps onto the Magic Leap One, and is
available for download and experimentation. Come try it out, and help
us design the immersive web!
