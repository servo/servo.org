---
layout:     post
tags:       blog
title:      Adding support for ‘outline’ properties
date:       2023-05-31
summary:    Guide to the ‘outline’ implementation in Layout 2020, plus the tests and spec issues we added along the way.
categories:
---

As mentioned in [our last blog post](https://servo.org/blog/2023/04/13/layout-2013-vs-2020/), we're currently working on selecting a layout engine for Servo between the original Layout 2013 and the newer Layout 2020.

Our plan has been to start by implementing some small features in Layout 2020, to help us decide whether to switch to the new layout engine, and in turn tackle more complex features like floats. One of these features was ‘outline’, which is now supported in the new engine.

A few days ago, we landed support for ‘outline’ and ‘outline-offset’. These properties are now fully supported in Servo, with two minor caveats:
* [Snap border and outline widths at computed-value time](https://github.com/servo/servo/pull/29718) — this is blocked on a Stylo upgrade to avoid diverging from Firefox
* The ‘outline-style’ value ‘auto’ currently works like ‘solid’ — this is allowed by the spec, but we may be able to do something better here, like rounding the corners of the outline or matching the platform style

The impact of this feature is most noticeable in the focus styles for links and input fields. For example, the User Agent stylesheet already applies ‘outline: thin dotted’ to ‘a:focus’, so clicking the first link in

```html
Lorem ipsum <a href="#">dolor sit amet</a>,
consectetur <a href="#">adipiscing elit</a>.
```

now yields

![Text with two links where the first one is focused so it has a thin outline around it]({{ '/img/blog/servo-outline.png' | url}})

## Implementation

The bulk of the feature was implemented in [#29695](https://github.com/servo/servo/pull/29695) (‘outline’) and [#29702](https://github.com/servo/servo/pull/29702) (‘outline-offset’):

1. In `{longhands,shorthands}/outline.mako.rs`, we enable ‘outline-offset’, ‘outline-color’, and ‘outline’ in Layout 2020, and remove the pref gates for ‘outline-style’ and ‘outline-width’, allowing those properties to be resolved and queried
2. In `BoxFragment::build_stacking_context_tree_for_children`, we check ‘outline-width’ and (if non-zero) push a `StackingContextFragment` to remind ourselves to paint an outline for the box fragment when building its display list
3. In `StackingContext::build_display_list`, we search for those reminders and paint the necessary outlines, but only after all other kinds of content in the stacking context (“out-of-band”)
4. In `BuilderForBoxFragment::build`, we now need to handle requests to paint the `Outline`, not just the `BlockBackgroundsAndBorders`
5. In `BuilderForBoxFragment::build_outline`, we paint the outline by creating a `BorderDisplayItem` in WebRender, while taking the ‘outline-offset’ into account

We also improved the shorthand serialisation in [#29708](https://github.com/servo/servo/pull/29708), by replacing the `#[derive(ToCss)]` for ‘outline’ with a custom impl that returns ‘auto’ in the case where all of the longhands are set to initial values.

## Tests and spec issues

The spec allows outlines to be painted either [in-band](https://drafts.csswg.org/css-position-4/#in-band-outline), such that other elements can obscure them, or [out-of-band](https://drafts.csswg.org/css-position-4/#out-of-band-outline), on top of all other content in the stacking context. We chose the latter, because it’s the recommended approach for accessibility and matches other browsers.

For example, the magenta element below overlaps the blue border of the previous element, but not the out-of-band cyan outline:

```html
<div style="
    outline: 5px solid cyan;
    border: 5px solid blue;
">Lorem ipsum</div>
<div style="
    background: magenta;
    margin-top: -15px;
    width: 50px;
    height: 50px;
"></div>
```

![Painting order is blue border, then magenta background, then “Lorem ipsum” and cyan outline]({{ '/img/blog/servo-outline-painting.png' | url}})

‘outline’ already has good test coverage, though during our implementation we added [one new test](https://github.com/servo/servo/pull/29686) to check that ‘background-clip’ works as expected with ‘border-radius’, which affects both borders and outlines in Servo.

We’ve also filed two spec issues:
* [Negative outline-offset is not interoperable and spec is not clear](https://github.com/w3c/csswg-drafts/issues/8786)
* [Should outline-offset be a longhand of outline?](https://github.com/w3c/csswg-drafts/issues/8788)

As always, despite ‘outline’ being a well-known property that has long been implemented by all of the major engines, with every new implementation comes new opportunities to clarify specs and improve test coverage. Building features like ‘outline’ helps the web platform as much as it helps Servo.

