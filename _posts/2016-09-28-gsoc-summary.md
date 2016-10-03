---
layout:     post
title:      Wrapping up Google Summer of Code 2016
date:       2016-09-28 20:00:00
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

# File/Blob support

The second project by [Zhen Zhang](https://github.com/izgzhen) was to implement most of
[the File specification](w3c.github.io/FileAPI/). The scope of the project included things like
file upload form controls, manipulating files from the DOM, and the creation/management of blob
URIs. As of now, almost all of the spec is implemented, except for the ability to construct and
serialize `Blob`s to/from `ArrayBuffer`s (due to the lack of `ArrayBuffer` bindings at the time),
`URL.createFor`, and handling fragments in blob URIs.

Notable pull requests include:

* The [`File`](https://github.com/servo/servo/pull/11076) and [`Blob`](https://github.com/servo/servo/pull/11716) DOM APIs
* [Filepicker](https://github.com/servo/servo/pull/11717) integration, from tinyfiledialog
* Support for [on-disk-file-backed `Blob`s](https://github.com/servo/servo/pull/11221)
* [Storing](https://github.com/servo/servo/pull/11534) and [loading](https://github.com/servo/servo/pull/11536) Blob URIs
* [Reference counting](https://github.com/servo/servo/pull/11875) logic for the blob store

Status updates and design docs live in [this repo](https://github.com/izgzhen/gsoc-file-support).
The [midterm summary](https://github.com/izgzhen/gsoc-file-support/blob/master/notes/midterm.md)
is a particularly good read, as it explains the preliminary design for the refcounted blob store.
Zhen was quite fun to work with; and showed lots of initiative in exploring solutions.
Thank you for your help, Zhen!
