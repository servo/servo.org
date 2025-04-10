---
layout:     post
title:      Servo for Android: nightly builds available and contribution opportunities
date:       2018-08-22 09:00:00
summary:    Servo for Android: nightly builds available and contribution opportunities
categories:
---

We [recently revamped](https://github.com/servo/servo/pull/20912) Servo on Android. As we continue to work on new implementation techniques and support for new platforms and technologies, we'd like to make this build available for testing and feedback.

## Nightly builds

Android Nightly builds are now available for [download](https://download.servo.org) (apk).

The Android app is at an early stage. The user interface is minimal. Contributors are welcome to help us design a better interface, we would love to get some help (see [this issue](https://github.com/servo/servo/issues/21403)).

<img width="300" alt="Android Screenshot" src="https://user-images.githubusercontent.com/373579/44078722-87f2bd00-9fa7-11e8-998b-7c3f61991b8a.png">

## Servo Android library

We provide [nightly builds of an Android Servo view](https://download.servo.org/nightly/android/servo-latest.aar) (aar). The API is minimal and pretty straight forward. If you are interested in testing Servo in your Android project, see the [Servo application](https://github.com/servo/servo/tree/master/support/android/apk/servoapp) as an easy example to follow.

It's also a lot easier (and faster) to build Servo for Android now. See [instructions here](https://github.com/servo/servo/wiki/Building-for-Android#working-on-the-user-interface-without-building-servo).

<img width="300" alt="Android Studio Screenshot" src="https://user-images.githubusercontent.com/373579/40770306-e90e6c24-64ec-11e8-820f-306feb9512e7.png">

## How you can help

There is a lot of low hanging fruit. We need help filing and fixing issues.

### Test and file issues

We'd like to test Servo on as many Android configurations as possible. If you own an Android device, download and install the APK ([download.servo.org](https://download.servo.org)).

We are especially interested in startup crashes. If Servo crashes, please [file an issue](https://github.com/servo/servo/issues/new) and attach as many details about your Android version and device model. Ideally, please also include a crash log (`adb logcat`).

### Java code

Servo is written in Rust, but the Android UI is built in Java. You can find [Android specific issues under the `P-Android` label](https://github.com/servo/servo/issues?utf8=✓&q=is%3Aissue+is%3Aopen+label%3AP-android) files.

### Android UI design

As mentionned earlier, we need help polishing the interface. Please refer to [this issue](https://github.com/servo/servo/issues/21403) for details.
