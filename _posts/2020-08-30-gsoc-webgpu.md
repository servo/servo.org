---
layout:     post
title:      GSoC wrap-up - Implementing WebGPU in Servo
date:       2020-08-30 00:30:00
summary:    A walk through the implementation of WebGPU in Servo
categories:
---

## Introduction
Hello everyone! I am Kunal([@kunalmohan](https://github.com/kunalmohan)), an undergrad student at Indian Institute of Technology Roorkee, India. As a part of Google Summer of Code(GSoC) 2020, I worked on implementing WebGPU in Servo under the mentorship of Mr. Dzmitry Malyshau([@kvark](https://github.com/kvark)). I devoted the past 3 months working on ways to bring the API to fruition in Servo, so that Servo is able to run the existing examples and pass the Conformance Test Suite(CTS). This is going to be a brief account of how I started with the project, what challenges I faced, and how I overcame them.

## What is WebGPU?
WebGPU is a future web standard, cross-platform graphics API aimed to make GPU capabilities more accessible on the web. WebGPU is designed from the ground up to efficiently map to the Vulkan, Direct3D 12, and Metal native GPU APIs. A native implementation of the API in Rust is developed in the [wgpu project](https://github.com/gfx-rs/wgpu). Servo implementation of the API uses this crate.

## The Project
At the start of the project the implementation was in a pretty raw state- Servo was only able to accept shaders as SPIRV binary and ran just the compute example. I had the following tasks in front of me:
- Implement the various [DOM interfaces](https://gpuweb.github.io/gpuweb/#idl-index) that build up the API.
- Setup a proper Id rotation for the GPU resources.
- Integrate WebGPU with WebRender for presenting the rendering to HTML canvas.
- Setup proper model model for async error recording.

The final goal was to be able to run the live examples at https://austineng.github.io/webgpu-samples/ and pass a fair amount of the CTS.

## Implementation
Since Servo is a multi-process browser, GPU is accessed from a different process(server-side) than the one running the page content and scripts(content process). For better performance and asynchronous behaviour, we have a separate wgpu thread for each content process.

Setting up a proper Id rotation for the GPU resources was our first priority. I had to ensure that each Id generated was unique. This meant sharing the [Identity Hub](https://github.com/servo/servo/blob/a5a21a59addae0df6d9e050f17d44399db04fec3/components/script/dom/identityhub.rs#L56-L67) among all threads via `Arc` and `Mutex`. For recycling the Ids, wgpu exposes an `IdentityHandler` trait that must be implemented on the server-side interface of the browser and wgpu. This facilitates the following: when wgpu detects that an object has been dropped by the user (which is some time after the actual drop/garbage collection), wgpu calls the trait methods that are responsible for releasing the Id. In our case they send a message to the content process to free the Id and make it available for reuse.

Implementing the DOM Interfaces was pretty straight forward. A DOM object is just an opaque handle to an actual GPU resource. Whenever a method, that performs an operation, is called on a DOM object there are 2 things to be done- convert the IDL types to wgpu types. And send a message to the server to perform the operation. Most of the validation is done within wgpu.

## Presentation
WebGPU textures can be rendered to HTML canvas via `GPUCanvasContext`, which can be obtained from `canvas.getContext('gpupresent')`. All rendered images are served to WebRender as `ExternalImages` for rendering purpose. This is done via an async software presentation path. Each new `GPUCanvasContext` object is assigned a new `ExternalImageId` and a new swap chain is assigned a new `ImageKey`. Since WebGPU threads are spawned on-demand, an image handler for WebGPU is initialized at startup, stored in `Constellation`, and supplied to threads at the time of spawn. Each time `GPUSwapChain.getCurrentTexture()` is called the canvas is marked as dirty which is then flushed at the time of reflow. At the time of flush, a message is sent to the wgpu server to update the image data provided to WebRender. The following happens after this:
- The contents of the rendered texture are copied to a buffer.
- Buffer is mapped asynchronously for read.
- The data read from the buffer is copied to a staging area in [`PresentionData`](https://github.com/servo/servo/blob/669b16f2c054bd038b7a3c69985076607e140b7f/components/webgpu/lib.rs#L1353-L1365). `PresentationData` stores the data and all the required machinery for this async presentation belt.
- When WebRender wants to read the data, it locks on the data to prevent it from being altered during read. Data is served in the form of raw bytes.

The above process is not the best one, but the only option available to us for now. This also causes a few empty frames to be rendered at the start.
A good thing, though, is that this works on all platforms and is a great fallback path while we'll be adding hardware accelerate presentation in the future.

## Buffer Mapping
When the user issues an async buffer map operation, the operation is queued on the server-side and all devices polled at a regular interval of 100ms for the same. As soon as the map operation is complete, data is read and sent to the content process where it is stored in the Heap. The user can read and edit this data by accessing it's subranges via `GPUBuffer.getMappedRange()` which returns `ExternalArrayBuffer` pointing to the data in the Heap. On unmap, all the `ExternalArrayBuffer`s are detached, and if the buffer was mapped for write, data sent back to server for write to the actual resource.

## Error Reporting
To achieve maximum efficiency, WebGPU supports an asynchronous error model. The implementation keeps a stack of `ErrorScope`s that are responsible for capturing the errors that occur during operations performed in their scope. The user is responsible for pushing and popping an `ErrorScope` in the stack. Popping an `ErrorScope` returns a promise that is resolved to null if all the operations were successfull, otherwise it resolves to the first error that occurred.

When an operation is issued, `scope_id` of the `ErrorScope` on the top of the stack is sent to the server with it and operation-count of the scope is incremented. The result of the operation can be described by the enum-

```rust
pub enum WebGPUOpResult {
    ValidationError(String),
    OutOfMemoryError,
    Success,
}
```

On receiving the result, we decrement the operation-count of the `ErrorScope` with the given `scope_id`. We further have 3 cases:
- The result is `Success`. Do nothing.
- The result is an error and the `ErrorFilter` matches the error. We record this error in the [`ErrorScopeInfo`](https://github.com/servo/servo/blob/669b16f2c054bd038b7a3c69985076607e140b7f/components/script/dom/gpudevice.rs#L85-L91), and if the `ErrorScope` has been popped by the user, resolve the promise with it.
- The result is an error but the `ErrorFilter` does not match the error. In this case, we find the nearest parent `ErrorScope` with the matching filter and record the error in it.

After the result is processed, we try to remove the `ErrorScope` from the stack- the user should have called `popErrorScope()` on the scope and the operation-count of the scope should be 0.

In case there are no error scopes on the stack or if `ErrorFilter` of none of the `ErrorScope`s match the error, the error is fired as an [`GPUUncapturedErrorEvent`](https://gpuweb.github.io/gpuweb/#gpuuncapturederrorevent).

## Conformance Test Suite
Conformance Test Suite is required for checking the accuracy of the implementation of the API and can be found [here](https://github.com/gpuweb/cts). Servo vendors it's own copy of the CTS which, currently, needs to be updated manually for the latest changes. Here are a few statistics of the tests:
- 14/36 pass completely
- 5/36 have majority of subtests passing
- 17/36 fail/crash/timeout

The wgpu team is actively working on improving the validation.

## Unfinished business
A major portion of the project that was proposed has been completed, but there's still work left to do. These are a few things that I was unable to cover under the proposed timeline:
- Profiling and benchmarking the implementation against the WebGL implementation of Servo.
- Handle canvas resize event smoothly.
- Support Error recording on Workers.
- Support WGSL shaders.
- Pass the remaining tests in the CTS.

## Important Links
The WebGPU specification can be found [here](https://gpuweb.github.io/gpuweb/).
The PRs that I made as a part of the project can be accessed via the following links:
- [Servo](https://github.com/servo/servo/pulls?q=is%3Apr+author%3Akunalmohan+created%3A%3E2020-05-05+merged%3A%3C2020-08-31+)
- [wgpu](https://github.com/gfx-rs/wgpu/pulls?q=is%3Apr+author%3Akunalmohan+created%3A%3E2020-05-05+merged%3A%3C2020-08-31+)
- [WebGPU Specification](https://github.com/gpuweb/gpuweb/pulls?q=is%3Apr+author%3Akunalmohan+created%3A%3E2020-05-05+merged%3A%3C2020-08-31+)

The progress of the project can be tracked in the [GitHub project](https://github.com/servo/servo/projects/24)

## Conclusion
WebGPU implementation in Servo supports all of the [Austin's samples](https://austineng.github.io/webgpu-samples/). Thanks to CYBAI and Josh, Servo now supports dynamic import of modules and thus accept GLSL shaders. Here are a few samples of what Servo is capable of rendering at 60fps:

![Fractal Cube](/images/webgpu-fractal-cube.gif)

![Instanced Cube](/images/webgpu-instanced-cube.gif)

![Compute Boids](/images/webgpu-compute-boids.gif)

I would like to thank Dzmitry and Josh for guiding me throughout the project and a big shoutout to the WebGPU and Servo community for doing such awesome work! I had a great experience contributing to Servo and WebGPU. I started as a complete beginner to Rust, graphics and browser internals, but learned a lot during the course of this project. I urge all WebGPU users and graphics enthusiasts out there to test their projects on Servo and help us improve the implementation and the API as well :)
