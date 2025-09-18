---
layout:     post
tags:       blog
title:      "Your Donations at Work: Funding Josh Matthews' Contributions to Servo"
date:       2025-09-17
summary:    Announcing Servo's first donation-funded role to help improve contributor experience.
categories:
---


The Servo project is excited to share that long-time maintainer [Josh Matthews (@jdm)](https://github.com/jdm) is now working part-time on improving the Servo contributor experience.

This is a direct result of the monthly donations to the project through [OpenCollective](https://opencollective.com/servo) and [GitHub](https://github.com/sponsors/servo). The generosity of our supporters has allowed us to operate dedicated computing resources for CI purposes, as well as participate in the [Outreachy program](https://www.outreachy.org/) as a mentoring organization. We're excited that we can now financially support developers and allow them to dedicate more time to the Servo project over longer periods.

Josh will use this funded time to make it easier for others to contribute to the project. You will see him improving documentation, reviewing pull requests, breaking down large projects into smaller actionable tasks, and generally helping others get unstuck quicker.

Here's Josh in his own words:

## Tell us about yourself!

I've been working on web browsers since 2009, with a brief diversion into distributed systems and finance for a few years. I've been a stay at home dad for several years, though, and Servo is a great way for me to keep that intellectual curiosity. I love helping people accomplish things they haven't tried before; it's a very satisfying experience to watch them flourish and grow.

## Why did you start contributing to Servo?

The team I had lined up at Mozilla in 2012 abruptly was cancelled shortly before I started full time. I knew of the existence of the very beginnings of the Servo project, and I was in the unique position of having several years of experience in both working on Firefox and the early Rust compiler. When I suggested that I should help get Servo off the ground, everyone thought that was a good idea.

## What was challenging about your first contribution?

Brian Anderson (@brson) handed me a program that could parse simple HTML and a tiny bit of CSS and draw solid rectangles into a png. He said "Can you make it run JavaScript?" The amount of details I needed to learn about how a web page's DOM gets hooked up to a JS engine were intimidating, and the relevant web standards were still quite underdeveloped in 2012. There was a lot of guessing and then going and talking to the experts from the Firefox side of the org.

## What do you like about contributing to the project? What do you get out of it?

I love seeing familiar websites becoming more usable. I am fascinated by all the different technologies that make up rendering engines today, and all the ways we discover that websites use them. And I love working in Rust in a large project, especially one that I'm so familiar with. There are a lot of kind, talented, and clever people that contribute to the project that make it a really enjoyable experience for me.

## What is currently being worked on in Servo that you’re excited about?

The work to get the JavaScript debugger up and running will be a game changer for investigating site compatibility problems. I'm also really pleased to see work happening in the JS bindings layer—ways to reduce the number of string conversions required when going from JS->Rust->JS, or make interactions with typed arrays safer and more ergonomic. I love when we make it easier for non-experts to implement missing web APIs.

## What would you like to see the Servo community do more of?

I would love to see more experiments with embedding Servo in other projects. The ones I know about, like the verso browser and the cuervo text-mode browser, have been enormously helpful in pointing out use cases that we had missed, or areas of the engine that could be made more modular and configurable. I'd love to get to a place where almost any major component of Servo could be replaced without forking the engine.

## Do you have any advice for new developers who are thinking of contributing to the project?

Choose your favourite web feature and look for it in the engine. Either it's already implemented and you can use it to understand how some pieces fit together, or you could probably get a skeleton implementation going! Either way, we would love to help you find your way around the codebase. I take pride in the number of PRs we've received from people who have never written Rust code before, but their implementation is totally mergeable. I think Servo is the most approachable web rendering engine for new contributors, and I want to keep it that way.

## What do you hope to see evolve in Servo over the next 1-2 years?

I would love to see a larger set of maintainers who review code changes, which will be good for maintainers and contributors alike. Similarly, I'd love to see more experienced contributors writing down the details for solving complex issues that only live in their heads right now. That's how we grow a long-term project contributor base that skills up over time, by modelling that kind of behaviour.

## Any final thoughts you’d like to share?

I'm humbled by how many people contribute to Servo, whether financially, through code, or just Zulip discussions. I think Servo is in a really lucky position, and I hope to continue shepherding it towards a bright future.
