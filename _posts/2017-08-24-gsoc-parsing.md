---
layout: post
title:  "Off main thread HTML parsing in Servo"
date:   2017-08-24 00:11:57 +0530
summary: GSOC wrap-up: Async HTML parser project
categories:
---

_Originally published on [Nikhil's blog](https://cynicaldevil.github.io/blog/2017/08/24/async-html-parsing-in-servo.html)._

## Introduction
Traditionally, browsers have been written as single threaded applications, and the html spec certainly seems
to validate this statement. This makes it difficult to parallelize any task which a browser carries out, and
we generally have to come up with innovative ways to do so.

One such task is HTML parsing, and I have been working on parallelizing it this summer as part of my GSoC
project. Since Servo is written in Rust, I'm assuming the reader has some basic knowledge about Rust.
If not, check out this awesome [Rust book](https://doc.rust-lang.org/book/second-edition/). Done? Let's dive straight into the details:

### HTML Parser
Servo's HTML (and XML) parsing code live in [html5ever](https://github.com/servo/html5ever). Since this project concerns HTML parsing, I will only be talking about that. The first component we need to know about is the `Tokenizer`. This component is responsible for taking in raw input from a buffer and creating tokens, eventually sending them to its Sink, which we will call `TokenSink`. This could be any type which implements the `TokenSink` trait.

html5ever has a type called `TreeBuilder`, which implements this trait. The TreeBuilder's job is to create tree operations based on the tokens it receives. TreeBuilder contains its own Sink, called [TreeSink](https://doc.servo.org/markup5ever/interface/tree_builder/trait.TreeSink.html), which details the methods corresponding to these tree ops. The TreeBuilder calls these `TreeSink` methods under appropriate conditions, and these 'action methods' are responsible for constructing the DOM tree.

With me so far? Good. The key to parallelizing HTML parsing is realizing that the task of creating tree ops is independent from the task of *actually* executing them to construct the DOM tree. Therefore, tokenization and tree op creation can happen on a separate thread, while the tree construction can be done on the main thread itself.

![Example image](https://cynicaldevil.github.io/blog/assets/parsing_diagram.png){:class="img-responsive"}

### The Process
The first step I took was to decouple tree op creation from tree construction. Previously, tree ops were executed as soon as they were created. This involved the creation of a new [TreeSink](https://github.com/servo/servo/blob/270d445f27631ee6388f837545a5440f50e0cafb/components/script/dom/servoparser/async_html.rs#L512), which instead of executing them directly, created a [representation](hhttps://github.com/servo/servo/blob/270d445f27631ee6388f837545a5440f50e0cafb/components/script/dom/servoparser/async_html.rs#L59-L105) of a tree op, containing all relevant data. For the time being, I sent the tree op to a `process_op` function as soon as it was created, whereupon it was executed.

Now that these two processes were independent, my next task consisted of creating a new thread, where the Tokenizer+TreeBuilder pair would live, to generate these tree ops. Now, when a tree op was created, it would be sent to the main thread, and control would return back to the TreeBuilder. The TreeBuilder does not have to wait for the execution of the tree op anymore, thus speeding up the entire process.

So far so good. The final task in this project was to implement speculative parsing, by building on top of these recent changes.

### Speculative Parsing
The HTML spec dictates that at any point during parsing, if we encounter a script tag, then the script must be executed immediately (if it is an inline script), or must be fetched and then executed (note that this rule does not apply to `async` or `defer` scripts). Why, you might ask, must this be done so? Why can't we mark these scripts and execute them all at the end, after the parsing is done? This is because of an old, ill-thought out `Document` API function called `document.write()`. This function is a pain point for many developers who work on browsers, as it is a real headache implementing it well enough, while working around the many idiosyncrasies which surround it. I won't dive into the details here, as they are not relevant. All we need to know is what `document.write()` does: it takes a string argument, which is generally markup, and inserts this string as part of the document's HTML content. It is suffice to say that using this function might break your page, and should not be used.

Returning to the parsing task, we can't commit any DOM manipulations until the script finishes executing, because `document.write()` could make them redundant. What speculative parsing aims to do is to continue parsing the content after the script tag in the parser thread, while the script is being executed in the main thread. Note that we are only speculatively creating tree ops here, not the actual tree construction. After the script finishes executing, we analyze the actions of the `document.write()` calls (if any) to determine whether to use the tree ops, or to throw them away.

### Roadblock!
Remember when I said the process of creating tree ops is independent from tree construction? Well, I lied a little. Until a week ago, we need access to some DOM nodes for the creation of a couple of tree actions (one method needed to know if a node had a parent, and the other needed to know whether two nodes existed in the same tree). When I moved the task of creating tree ops to a separate thread, I could no longer access the DOM tree, which lived on the main thread. So I used a `Sender` on the TreeSink to create and send [queries](https://github.com/servo/servo/pull/17565/files#diff-10b46cb1e26142d2058e291de25bd4c7R133) to the main thread, which would access the DOM and send the results back. Then only would the TreeSink method return, with the data it received from the main thread. Additionally, this meant that these couple of methods were synchronous in nature. No biggie.

I realized the problem when I sat down to think about how I would implement speculative parsing. Since the main thread is busy executing scripts, it won't be listening to the queries these synchronous methods will be sending, and therefore the task of creating tree ops cannot progress further!

This turned out to be a bigger problem than I'd imagined, and I also had to sift through the equivalent Gecko code to understand how this situation was handled. I eventually came up with a good solution, but I won't bore you with the details. If you want to know more, here's a [gist](https://gist.github.com/cynicaldevil/09fb8a6dd1db58852d2085ac59ca0f9b) explaining the solution.

With these changes landed in html5ever, I can finally implement speculative parsing. Unfortunately, there's not much time to implement it as a part of the GSoC project, so I will be landing this feature in Servo some time later. I hope to publish another blog post describing it thoroughly, along with details on the performance improvements this feature would bring.

#### Links to important PRs:
Added Async HTML Tokenizer: [https://github.com/servo/servo/pull/17037](https://github.com/servo/servo/pull/17037)

Run the async HTML Tokenizer on a new thread: [https://github.com/servo/servo/pull/17914](https://github.com/servo/servo/pull/17914)

TreeBuilder no longer relies on `same_tree` and `has_parent_node`: [https://github.com/servo/html5ever/pull/300](https://github.com/servo/html5ever/pull/300)

End TreeBuilder's reliance on DOM: [https://github.com/servo/servo/pull/18056](https://github.com/servo/servo/pull/18056)

## Conclusion
This was a really fun project; I got solve lots of cool problems, and also learnt a lot more about how a modern, spec-compliant rendering engine works.

I would like to thank my mentor [Anthony Ramine](https://twitter.com/nokusu), who was absolutely amazing to work with, and [Josh Matthews](https://twitter.com/lastontheboat), who helped me a lot when I was still a rookie looking to contribute to the project.

