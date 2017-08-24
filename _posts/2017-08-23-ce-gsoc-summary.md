---
layout:     post
title:      Custom Elements in Servo
date:       2017-08-23 20:00:00
summary:    Summary of the Custom Element GSoC Project.
categories:
---

This summer [I] had the pleasure of implementing [Custom Elements] in Servo under the mentorship of
[jdm].

## Introduction
Custom Elements are an exciting development for the Web Platform. They are apart of the
[Web Components] APIs. The goal is to allow web developers to create reusable web components with
first-class support from the browser. The Custom Element portion of Web Components allows for
elements with custom names and behaviors to be defined and used via HTML tags.

For example, a developer could create a custom element called `fancy-button` which has special
behavior (for example, ripples from material design). This element is reusable and can be used
directly in HTML:
```
<fancy-button>My Cool Button</fancy-button>
```
For examples of cool web components check out [webcomponents.org].

While using these APIs directly is very powerful, new web frameworks are emerging that harness the
power of Web Component APIs and give developers even more power. One major contender with frontend
web frameworks is [Polymer]. The Polymer framework builds on top of Web Components and removes
boilerplate and makes using web components easier.

Another exciting framework using Custom Elements is [A-Frame] (supported by Mozilla). A-Frame is a
[WebVR] framework that allows developers to create entire Virtual Reality experiences using HTML
elements and javascript. There has been some recent work in getting WebVR and A-Frame functional in
Servo. Implementing Custom Elements removes the need for Servo to rely on a polyfill.

For more information on what Custom Elements are and how to use them, I would suggest reading
[Custom Elements v1: Reusable Web Components](https://developers.google.com/web/fundamentals/architecture/building-components/customelements?hl=en).

## Implementation
Before I began the implementation of Custom Elements, I broke down the spec into a few major pieces.
* The `CustomElementRegistry`
* Custom element creation
* Custom element reactions

The `CustomElementRegistry` keeps track of all the defined custom elements for a single `window`.
The registry is where you go to define new custom elements and later Servo will use the registry
to lookup definitions give a possible custom element name. The bulk of the work in this section of
the implementation was validating custom element definitions.

Custom element creation is the process of taking a custom element definition and running the
defined constructor on a `HTMLElement` or the element extends. This can happen either when a new
element is created, or after an element has been created via an upgrade reaction.

The final portion is triggering custom element reactions. There are two types of reactions:
1. Callback reactions
2. Upgrade reactions

Callback reactions fire when custom elements:
* are connected from the DOM tree
* are disconnected from the DOM tree
* are adopted into a new document
* have an attribute that is modified

When the reactions are triggered, the corresponding lifecycle method of the Custom Element is
called. This allows the developer to implement custom behavior when any of these lifecycle events
occur.

Upgrade reactions are used to take a non-customized element and make it customized by running
the defined constructor. There is quite a bit of trickery going on behind the scenes to make all of
this work. I wrote a post about [custom element upgrades] explaining how they work and why they are
needed.

I used Gecko's partial implementation of Custom Elements as a reference for a few parts of my
implementation. This became extrememly useful whenever I had to use the SpiderMonkey API.

## Roadblocks
As with any project, it is difficult to foresee big issues until you actually start writing the
implementation. Most parts of the spec were straightforward and did not yield any trouble while
I was writing the implementation; however, there were a few difficulties and unexpected problems
that presented themselves.

One major pain-point was working with the SpiderMonkey API. This was more due to my lack of
experience with the SpiderMonkey API. I had to learn how [compartments] work and how to debug
panics coming from SpiderMonkey. [bzbarsky] was extremely helpful during this process; they helped
me step through each issue and understand what I was doing wrong.

While I was in the midst of writing the implementation, I found out about the `HTMLConstructor`
attribute. I had missed this part of the spec during the planning phase. The `HTMLConstructor`
WebIDL attribute marks certain HTML elements that can be extended and generates a custom constructor
for each that allows custom element constructors to work (read more about this in [custom element
upgrades]).

## Notable Pull Requests
* [Implement custom element registry](https://github.com/servo/servo/pull/17112)
* [Custom element creation](https://github.com/servo/servo/pull/17381)
* [Implement custom element reactions](https://github.com/servo/servo/pull/17614)
* [Custom element upgrades](https://github.com/servo/servo/pull/17935)

## Conclusions
I enjoyed working on this project this summer and hope to continue my involvement with the Servo
project. I have a [gsoc repository] that contains a list of all my GSoC issues, PRs, and blog posts.
I want to extend a huge thanks to my mentor [jdm] and to [bzbarsky] for helping me work through
issues when using SpiderMonkey.

[I]:https://github.com/cbrewster/
[custom elements]:https://html.spec.whatwg.org/multipage/#custom-elements
[jdm]:https://github.com/jdm/
[web components]:https://www.webcomponents.org/introduction/
[polymer]:https://www.polymer-project.org/
[a-frame]:https://aframe.io/
[webvr]:https://webvr.info/
[webcomponents.org]:https://www.webcomponents.org/
[custom element upgrades]:https://cbrewster.github.io/2017/06/08/custom-element-upgrades/
[compartments]:https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey/Compartments
[gsoc repository]:https://github.com/cbrewster/gsoc2017
[bzbarsky]:https://github.com/bzbarsky
