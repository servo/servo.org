---
layout:     post
title:      Servo developer tools overview
date:       2015-07-22 12:00:00
summary:    Overview of the Servo development environment
categories:
---

# Servo developer tools overview

[Servo](https://github.com/servo/servo) is a new web browser engine. It is one of the largest Rust-based projects, but the total Rust code is still dwarfed by the size of the code provided in native C and C++ libraries. This post is an overview of how we have structured our development environment in order to integrate the Cargo build system, with its "many small and distributed dependencies" model with our needs to provide many additional features not often found in smaller Rust-only projects.

## Mach

[Mach](https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/mach) is a python driver program that provides a frontend to Servo's development environment that both reduces the number of steps required and integrates our various tools into a single frontend harness. Similar to its purpose in the Firefox build, we use it to centralize and simplify the number of commands that a developer has to perform.

### mach bootstrap

The steps that mach will handle before issuing a normal `cargo build` command are:

* Downloading the correct versions of the cargo and rustc tools. Servo uses many unstable features in Rust, most problematically those that change pretty frequently. We also test the edges of feature compatibility and so are the first ones to notice many changes that did not at first seem as if they would break anyone. Further, we build a custom version of the tools that additionally supports cross-compilation targeting Android (and ARM in the near future). A random local install of the Rust toolchain is pretty unlikely to work with Servo.

* Updating git submodules. Some of Servo's dependencies cannot be downloaded as Cargo dependencies because they need to be directly referenced in the build process, and Cargo adds a hash that makes it difficult to locate those files. For such code, we add them as submodules.

### mach build & run

The build itself also verifies that the user has explicitly requested either a `dev` or `release` build --- the Servo dev build is debuggable but quite slow, and it's not clear which build should be the default.

Additionally, there's the question of _which_ `cargo build` to run. Servo has three different "toplevel" Cargo.toml files.

* `components/servo/Cargo.toml` is used to build an executable binary named `servo` and is used on Linux and OSX. There are also horrible linker hacks in place that will cause an Android-targeted build to instead produce a file named `servo` that is actually an APK file that can be loaded onto Android devices.

* `ports/gonk/Cargo.toml` produces a binary that can run on the Firefox OS Boot2Gecko mobile platform.

* `ports/cef/Cargo.toml` produces a shared library that can be loaded within the Chromium Embedding Framework to provide a hostable web rendering engine.

The presence of these three different toplevel binaries and the curious directory structure means that mach also provides a `run` command that will execute the correct binary with any provided arguments.

### mach test

Servo has several testing tools that can be executed via mach.

* `mach tidy` will verify that there are no trivial syntactic errors in source files. It checks for valid license headers in each file, no tab characters, no trailing whitespaces, etc.

* `mach test-ref` will run the Servo-specific reference tests. These tests render a pair of web pages that implement the same final layout using different CSS features to images. If the images are not pixel-identically, the test fails.

* `mach test-wpt` runs the cross-browser W3C Web Platform Tests, which primarily test DOM features.

* `mach test-css` runs the cross-browser CSS WG reference tests, which are a version of the reference tests that are intended to work across many browsers.

* `mach test-unit` runs the Rust unit tests embedded in Servo crates. We do not have many of these, except for basic tests of per-crate functionality, as we rely on the WPT and CSS tests for most of our coverage. Philosophically, we prefer to write and upstream a cross-browser test where one does not exist instead of writing a Servo-specific test.

## cargo

While the code that we have written for Servo is primarily in Rust, we estimate that at least 2/3 of the code that will run inside of Servo will be written in C/C++, even when we ship. From the SpiderMonkey JavaScript engine to the Skia and Azure/Moz2D graphics pipeline to WebRTC, media extensions, and proprietary video codecs, there is a huge portion of the browser that is integrated and wrapped into Servo, rather than rewritten. For each of these projects, we have a crate that has a `build.rs` file that performs the custom build steps to produce a static library and then produce a Rust `rlib` file to link into Servo.

The rest of Servo is a significant amount of code (~150k lines of Rust; ~250k if you include autogenerated DOM bindings), but follows the standard conventions of Cargo and Rust as far as producing crates. For the many crates within the Servo repo, we simply have a `Cargo.toml` file next to a `lib.rs` that defines the module structure. When we break them out into a separate GitHub repository, though, we follow the convention of a toplevel `Cargo.toml` file with a `src` directory that holds all of the Rust code.

![Servo's dependency graph](https://raw.githubusercontent.com/maxsnew/cargo-dot/master/etc/servo.png "Servo dependency graph")

### Updating dependencies

Since there are three toplevel `Cargo.toml` files, there are correspondingly three `Cargo.lock` files. This configuration makes the already challenging updates of dependencies even moreso. We have added a command, `mach update-cargo -p {package} --precise {version}` to handle updates across all three of the lockfiles. While running this command without any arguments does attempt to upgrade all dependencies to the highest SemVer-compatible versions, in practice that operation is unlikely to work, due to a mixture of:

* git-only dependencies, which do not have a version number

* Dependencies with different version constraints on a common dependency, resulting in two copies of a library and conflicting types

* Hidden Rust compiler version dependencies

## Things we'd like to fix in the future

It would be great if there was a [single Cargo.toml](https://github.com/servo/servo/issues/5973) file and it was at the toplevel of the Servo repo. It's confusing to people familiar with Rust projects, who go looking for a Cargo.toml file and can't find them.

Cross-compilation to Android with linker hacks feels a bit awkward. We'd like to clean that up, remove the submodule that performs that linker hackery, and have a more clean/consistent feel to our cross-targeted builds.

Managing the dependencies --- particularly if there is a cross-repo update like a Rust upgrade --- is both a real pain and requires network access in order to clone the dependency that you would like to edit. The proposed [`cargo clone`](https://github.com/rust-lang/cargo/issues/1545) command would be a huge help here.
