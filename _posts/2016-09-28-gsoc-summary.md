---
layout:     post
title:      Wrapping up Google Summer of Code 2016
date:       2016-06-30 20:00:00
summary:    Summaries of Servo's GSoC projects
categories:
---
This year Servo had two students working on projects as part of the Google Summer of Code program.
Rahul Sharma ([creativcoder](https://github.com/creativcoder)) tackled the daunting project of
implementing initial support for the new [ServiceWorker API](https://w3c.github.io/ServiceWorker/),
while Zhen Zhang ([izgzhen](https://github.com/izgzhen)) implemented missing support for files,
blobs, and [related APIs](http://dev.w3.org/2006/webapi/FileAPI/). Let's see how they did!

# ServiceWorker support

Three months is not enough time for a single student to implement the entire set of features
defined by the [ServiceWorker specification](https://w3c.github.io/ServiceWorker/), so the goal
of this project was to implement the fundamental pieces required for sharing workers between
multiple pages, along with the related DOM APIs for registering and interacting with the
workers, and finally enabling interception of network requests to support the worker's `fetch`
event. Notable pull requests include:
* network request [interception](https://github.com/servo/servo/commit/3766cd167365187bfabbb00f5dc41ba923fe23d4)
* the DOM API for [registration](https://github.com/servo/servo/commit/15a2064c0d7b468724b43d1cb6157d506ad19093)
* a [new thread](https://github.com/servo/servo/commit/1e6293ea1d06120c9f3488d7d32c24d8d92df6b1) for
coordinating ServiceWorker instances

Rahul put together a [full writeup](https://github.com/creativcoder/gsoc16) of his activities
as part of GSoC; please check it out! His mentor (jdm) was very pleased with Rahul's work over the
course of the summer - it was a large, complex task, and he tackled it with enthusiasm and diligence.
Congratulations on completing the project, and thank you for your efforts, Rahul!

# File/Blob etc.

TODO?
