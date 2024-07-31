---
layout:     post
tags:       blog
title:      "This month in Servo: and more!"
date:       2024-07-30
summary:    ao!! wrrrrao!!
categories:
---

<figure class="_figr"><a href="{{ '/img/blog/quest-3-passthrough.png' | url }}"><img src="{{ '/img/blog/quest-3-passthrough.png' | url }}"
    alt="Servo displaying WebXR content on a Quest 3 in Quest Link mode"></a>
<figcaption>WebXR screenshot: Daniel Adams (<a href="https://twitter.com/msub2official/status/1818533316477251669">Twitter</a>)</figcaption></figure>

<span class=_floatmin></span>

Servo has had several new features land in our nightly builds over the last month:

- as of 2024-06-27, **document.fonts.ready** (@mukilan, @mrobinson, #32576)
- as of 2024-07-03, the **getCompilationInfo() method on GPUShaderModule** (@sagudev, #32642)
- as of 2024-07-08, window.**customElements.getName** (@keithamus, #32715)
- as of 2024-07-09, **&lt;caption> in tables** (@mrobinson, @Loirooriol, @mukilan, #32657, #32695)
- as of 2024-07-13, **document.visibilityState** and **document.hidden** (@wusyong, #32635)
- as of 2024-07-18, the **measureText() method on CanvasRenderingContext2D** (@chocolate-pie, #32704)
- as of 2024-07-23, **URL.parse()** (@shanehandley, #32819)

We’ve also landed an experimental **OpenXR backend** (@msub2, #32817), allowing Servo to display WebXR content on actual headsets like the **Quest 3** in Quest Link mode.
You can enable it with `--pref dom.webxr.openxr.enabled`, though the backend currently only works on Windows.

## Rendering changes

<figure class="_figr"><a href="{{ '/img/blog/july-2024.png' | url }}"><img src="{{ '/img/blog/july-2024.png' | url }}"
    alt="Servo nightly showing a table with a caption, containing demos of several other new features"></a></figure>

<span class=_floatmin></span>
**Parallel table layout** is now enabled (@mrobinson, #32477), spreading the work for laying out rows and their columns over all available CPU cores.
This change is a great example of the strengths of [Rayon](https://crates.io/crates/rayon) and the opportunistic parallelism in Servo’s layout engine.

We‘ve also made progress on our new **flexbox layout engine** (`--pref layout.flexbox.enabled`), landing support for **‘min-height’** and **‘max-height’** on row containers (@delan, @mrobinson, @mukilan, #32785), as well as **baseline alignment of row containers** with their siblings (@mrobinson, @mukilan, @delan, #32841, #32810) and for their items by setting **‘align-items’** or **‘align-self’** to **‘baseline’**, **‘first baseline’**, or **‘last baseline’** (@delan, @mrobinson, @mukilan, @nicoburns, #32787, #32790).

<aside class="_note">

Note that our flexbox layout support is still very much experimental, and missing major functionality such as ‘flex-direction: column’.
</aside>

We’ve landed support for **generic font families** like ‘sans-serif’ and ‘monospace’ (@mrobinson, @mukilan, #32673), as well as **commas in &lt;font face>** (@mrobinson, #32622) and fixes for font matching on Android and OpenHarmony (@jschwe, #32725, #32731).

For **replaced elements** like &lt;img> and &lt;canvas>, the **‘min-width’**, **‘max-width’**, **‘min-height’**, and **‘max-height’** properties now **respect the aspect ratio** of the element (@valadaptive, #32777), and you can now change that aspect ratio with the **‘aspect-ratio’ property** (@valadaptive, #32800, #32803).

## Devtools and servoshell changes

<figure class="_figl"><a href="{{ '/img/blog/devtools-july-2024.png' | url }}"><img src="{{ '/img/blog/devtools-july-2024.png' | url }}"
    alt="Firefox devtools connected to Servo, showing several console errors"></a></figure>

<span class=_floatmin></span>
When debugging in Servo [with the **Firefox devtools**](https://book.servo.org/running-servoshell.html), you can now see **console messages** from the page (@eerii, #32727), and you can even debug the devtools connection itself with our new **devtools protocol analyzer** (@eerii, #32684).

servoshell now has experimental **OpenHarmony support** (@jschwe, #32594), in addition to our experimental Android support and nightly releases for Windows, macOS, and Linux.
We’ve also landed **directory listings** for local files (@Bobulous, @mrobinson, #32580), made the location bar behave more consistently on Android (@jschwe, #32586), and servoshell no longer quits when you press Escape (@mrego, #32603).

<figure class="_figr"><div style="text-align: left;">

| Version and build config | `servo` binary size |
|---|---|
| Before #32651 | 126364k |
| With #32651 | 110111k (−12.8%) |
| With #32651<br>• Without debug symbols | 102878k (−18.5%) |
| With #32759<br>• Without `layout_2013` | 107652k (−14.8%) |
| With #32759<br>• Without debug symbols<br>• Without `layout_2013` | 100886k (−20.1%) |
</div></figure>

<span class=_floatmin></span>
To reduce servoshell’s binary size, we now build our nightly releases with **ThinLTO** (@jschwe, #32651), and you can go even further by building Servo **without debug symbols** (@jschwe, #32651) or **without the legacy layout engine** (@jschwe, #32759).
Note that these builds use the `production` profile in Cargo, not the `release` profile.
See the table nearby for how much they save on Linux (amd64).

<div style=clear:both></div>

## Changes for Servo developers

<figure class="_figr"><a href="{{ '/img/blog/dco-check.png' | url }}"><img src="{{ '/img/blog/dco-check.png' | url }}"
    alt="GitHub checks popup showing the “DCO” check failing and a link to “Details”"></a></figure>

<span class=_floatmin></span>
[**The Servo book**](https://book.servo.org) is now the place to go for Servo’s documentation (@delan, #32743).
It includes our architecture and design docs, a link to our API docs, as well as docs on building, running, testing, debugging, and profiling Servo.

Servo now builds without the `crown` linter by default (@jschwe, #32494), simplifying the build process in some cases.
If you’re working on DOM code, you can enable it again with `./mach build --use-crown`.

When contributing to Servo, **your commits must now be [“signed off”](https://developercertificate.org)**, which is essentially a promise that you own (or are allowed to contribute) the code in your patch.
If the DCO check fails, click Details for help on signing off your commits.

<aside class="_note">

Note that this is **not** a contributor license agreement (CLA), which would allow Servo to become closed source someday, nor is it a copyright assignment.
</aside>

## Donations

Thanks again for your generous support!
We are now receiving **2955 USD/month** (+32.6% over June) in recurring donations.

Servo is now on [thanks.dev](https://thanks.dev), and already **three GitHub orgs** that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

We are still receiving donations from **14 people** on LFX, but we will stop accepting donations there soon — **please move your recurring donations to [GitHub](https://github.com/sponsors/servo) or [Open Collective](https://opencollective.com/servo)**.
In the meantime, we’ve transferred **2723 USD** of donations from LFX to our Open Collective account.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 2955 / 10000); padding-left: 0.5em;"><strong>2955</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 2955 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="2955" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

As always, use of these funds will be decided transparently in the Technical Steering Committee.
Our updated proposal for a [dedicated server for CI runners](https://github.com/servo/project/issues/94#issuecomment-2252262955) (@delan, @sagudev, @nicoburns) was accepted, which should reduce build times significantly, and this is just the start!

For more details, head to our [Sponsorship page]({{ '/sponsorship/' | url }}).

## Conferences and blogs

- [**Servo: A web rendering engine for the future**](https://www.youtube.com/watch?v=SamA5Oz-G5w) ([slides](https://servo.org/slides/2024-07-02-global-software-technology-summit/)) — Manuel Rego spoke at the [Global Software Technology Summit 2024](https://huawei-events.de/en/gsts24.htm) about the status and long-term vision of the Servo project
- [**Verso: A new browser based on Servo**](https://wusyong.github.io/posts/verso-0-1/) — Wu Yu Wei wrote about their plans to build a more polished Servo-based browser while improving Servo’s architecture
- [**Verso: Writing its own compositor part 1**](https://wusyong.github.io/posts/verso-compositor-part1/) — Wu Yu Wei uses Verso as a sandbox to explore how we might rework Servo’s compositor to support multiple windows
- [**Halfway point**](https://conflor.es/blog/03_halfway_point) — Eri wrote about repairing Servo’s devtools support, from planning to selecting tabs to finding resources and now the console, as part of their Outreachy internship

## Alan Jeffrey (1967–2024)

[Alan Jeffrey](https://web.archive.org/web/20240714161830/https://asaj.org/), an early member of the Servo team and a key part of helping the Servo project find a new life outside of Mozilla, passed away on 4 July.

His research has furthered a wide range of fields, including concurrent and distributed systems, programming languages, formal verification, software semantics, typesetting, protocol security, and circuit design.

Alan’s family have also written about his kindness, curiosity, and persistence [on his LinkedIn page](https://www.linkedin.com/feed/update/activity:7215033040614436865/).

<!--
- donations
    - thanks.dev now enabled
    - DONE total monthly 2955/month (+32.6%)
        - opencollective 1591.83/month
        - github 1217.00/month
        - lfx 147.00/month
    - DONE lfx transferred, still closing
    - ci runners
- DONE api support
    - DONE commas in <font face> 32622
    - DONE document.{visibilityState,hidden} 32635
    - DONE CanvasRenderingContext2D measureText 32704
    - DONE URL.parse 32819
    - DONE window.customElements.getName 32715
    - DONE FontFaceSet 32576
    - DONE webgpu ShaderCompilationInfo (GPUShaderModule getCompilationInfo) 32642
- devtools
    - DONE console logging 32727
    - DONE protocol pcap parser 32684
- rendering
    - DONE replaced aspect ratio min/max width/height 32777
    - DONE replaced ‘aspect-ratio’ property 32800 32803
    - DONE table parallel layout 32477
    - DONE table <caption> layout 32657 32695
    - DONE flex min/max cross container size 32785
    - DONE flex ‘align-self: [ first | last ]? && baseline’ 32787
    - DONE flex item/container baselines 32841
    - DONE flex refactors 32790 32810
- fonts
    - DONE generic font families 32673
    - DONE ohos fonts 32725 32731
- upgrades
    - stylo 2024-07-16 32474 32812
    - now upstreaming to stylo! nico patch
    - nixpkgs cargo-deny 32842
    - egui 32683
- servoshell
    - DONE local directory listings 32580
    - DONE esc no longer quits 32603
    - DONE android location bar logic 32586
    - DONE openharmony support 32594
- binary size
    - DONE cargo production-stripped 32651
    - DONE compile without layout_2013 32759
- dev
    - DONE crown optional 32494
    - SKIP mach bootstrap --skip-static-analysis 32587
    - DONE LAST MONTH ai contributions 32287
    - SKIP android signing key 32721
    - DONE book 32743
    - DONE dco signoff
- reliability
    - media player event timing 32643
    - mozjs crash 32786
- DONE verso
- DONE rego conference talk

>>> 2024-06-25T06:03:57Z
    6738902d45920e0d9225fd9e926ab4169aa432e8	https://github.com/servo/servo/pull/32591	build(deps): bump lazy_static from 1.4.0 to 1.5.0 (#32591)
+   b1fdfb88bbce82b3afe1bae964d942774af4043f	https://github.com/servo/servo/pull/32474	Upgrade stylo to 2024-05-31 (#32474)
    680735ed734bfce72a171d25f44a1ac658ca6838	https://github.com/servo/servo/pull/32588	build(deps): bump syn from 2.0.67 to 2.0.68 (#32588)
    75423656d4bbdbadfabe91b6fe81fd3103bc2a56	https://github.com/servo/servo/pull/32590	build(deps): bump libloading from 0.8.3 to 0.8.4 (#32590)
+   e331cc67c3f8d09b3108d6e8f3bd92128dad3b42	https://github.com/servo/servo/pull/32587	mach: Expose a `--skip-static-analysis` to `mach boostrap` (#32587)
    30dad2565f5fad2d498f62a62895c3fd71c2c16d	https://github.com/servo/servo/pull/32554	android: Rename the Android app to reflect servo.org ownership and `servoshell` (#32554)
+   7d7574373b5dce5a99c8832966481b8b9c3093c2	https://github.com/servo/servo/pull/32586	android: Use location_bar_input_to_url instead of re-implementing (#32586)
+   26bbfe9b551c268188d952b1b565da890d3eb6f4	https://github.com/servo/servo/pull/32494	Make `crown` optional (#32494)
>>> 2024-06-26T06:03:59Z
    b3d99a607fda9511900f2d5e2c81f905802fe758	https://github.com/servo/servo/pull/32613	build(deps): bump bitflags from 2.5.0 to 2.6.0 (#32613)
    7a76f4ed208f54c65e65ce792d5dabe81d82990c	https://github.com/servo/servo/pull/32611	build(deps): bump zerovec-derive from 0.10.2 to 0.10.3 (#32611)
    b42208a20e89b98ebf77d9a22f043cff3778d2bd	https://github.com/servo/servo/pull/32614	build(deps): bump zerovec from 0.10.2 to 0.10.3 (#32614)
    e51c15d84fe8976ad1d6640a95501c91ace292bd	https://github.com/servo/servo/pull/32612	build(deps): bump icu_properties from 1.5.0 to 1.5.1 (#32612)
    3a30fa9977fcb5c3ef56394f00b9ea99c50fcd59	https://github.com/servo/servo/pull/32609	build(deps): bump serde_json from 1.0.117 to 1.0.118 (#32609)
    92378ac3d6a1c5903498c81069c2766dad1758cf	https://github.com/servo/servo/pull/32610	build(deps): bump serde_bytes from 0.11.14 to 0.11.15 (#32610)
    6d3c67d469f0b33850a6e2b75663e8ed0ff13f96	https://github.com/servo/servo/pull/32608	build(deps): bump uuid from 1.9.0 to 1.9.1 (#32608)
    7b6aa64acaf412a94753d9b142b1733a3ed66181	https://github.com/servo/servo/pull/32600	Clean up some unused dependencies (#32600)
    52e6e59ebdfa88978ec1e0f204318d14ef4198a0	https://github.com/servo/servo/pull/32589	build(deps): bump uuid from 1.8.0 to 1.9.0 (#32589)
    a972e5c2002c64f0746250d6272e40f3dbaa1add	https://github.com/servo/servo/pull/32599	Switch flex layout to app units (#32599)
    42e090a1eb7df134c39ab27c71de646d510e2f9f	https://github.com/servo/servo/pull/32583	clippy: fix some warnings in desktop and some components (#32583)
>>> 2024-06-27T06:05:09Z
+   574a22a6cd0ca4a6eb9e6af4541f835f22691768	https://github.com/servo/servo/pull/32603	Avoid Esc shortcut to close Servo (#32603)
    aa99c85645dee69f184ecfaace05a1ad9babc0c3	https://github.com/servo/servo/pull/32627	build(deps): bump either from 1.12.0 to 1.13.0 (#32627)
+   da2de4fc689aa506fe9711e0ff92a0819b7106e5	https://github.com/servo/servo/pull/32622	html: Parse a comma-separated list of faces in the `<font>` tag (#32622)
    47678a61b9f191a7c58dc8466459f15036c4c4f5	https://github.com/servo/servo/pull/32626	build(deps): bump the gstreamer-related group with 2 updates (#32626)
+   e16291f14edc38d4bc3663a36619e6e461329402	https://github.com/servo/servo/pull/32477	layout: Enable parallel layout for tables (#32477)
    f055964792a466cdea794f1bf97a3a9fd89d5d8b	https://github.com/servo/servo/pull/32625	Switch replaced layout to app units (#32625)
+   a730469b704878da9b484b0018f369438ce08851	https://github.com/servo/servo/pull/32576	script: Implement the `FontFaceSet` DOM API (#32576)
+   7ea894774f3a00a1e31aa22d8862dfb54661e18a	https://github.com/servo/servo/pull/32580	Add a directory listing feature for `file` URLs (#32580)
>>> 2024-06-28T05:58:53Z
    fced0b49404c02bb5aafa9ddd468f9077ce26c19	https://github.com/servo/servo/pull/32630	use au in AtomicLineItem (#32630)
+   9ff900e166b2e11b7c902512c4ca71a1cf975338	https://github.com/servo/servo/pull/32287	CONTRIBUTING: add AI contributions policy (#32287)
>>> 2024-06-29T06:03:08Z
    3a0f56491614508af069fc393a8cc0dbeb733d71	https://github.com/servo/servo/pull/32638	build(deps): bump log from 0.4.21 to 0.4.22 (#32638)
    14ef3f55aae840e9eefcb9dcef2adc16dd20ea06	https://github.com/servo/servo/pull/32639	build(deps): bump zerovec from 0.10.3 to 0.10.4 (#32639)
    40878c654eb126d1cfe598571f0772fe065b13e7	https://github.com/servo/servo/pull/32637	build(deps): bump ab_glyph from 0.2.26 to 0.2.27 (#32637)
+   9455169813a2730db7bb0f80f6e83e40ee01f9cb	https://github.com/servo/servo/pull/32594	Add OpenHarmony support to servoshell (#32594)
    a7ebc2873897ce74cb77adf97f8f15f661dd9e00	https://github.com/servo/servo/pull/32631	Replace null-byte terminated string literals with C-string literals (#32631)
    adc0fc984d07918ad2eac3ab641d833a3cab008c	https://github.com/servo/servo/pull/32633	layout: Make `geom.rs` logical geoemetry types more ergonomic (#32633)
e9cf4d4971c0ce8ec64da7f09d6e97ae10be5b05	https://github.com/servo/servo/pull/32575	webgpu: Update wgpu and revamp computepass (#32575)
>>> 2024-06-30T06:04:35Z
>>> 2024-07-01T06:08:08Z
    e2e7476404e407caa3e6625f4cf4bd6aed9ded6b	https://github.com/servo/servo/pull/32649	Sync WPT with upstream (30-06-2024) (#32649)
>>> 2024-07-02T06:04:01Z
    ad01342f00089cbddb252d54ed55f90a20ce43da	https://github.com/servo/servo/pull/32660	build(deps): bump mime_guess from 2.0.4 to 2.0.5 (#32660)
    7ed5e804b557af7620b7dbf2be0aa8af46de8867	https://github.com/servo/servo/pull/32661	build(deps): bump serde_json from 1.0.118 to 1.0.119 (#32661)
    67e13e49919ad61d82b5e59c3238a1a6f32a4db1	https://github.com/servo/servo/pull/32658	build(deps): bump object from 0.36.0 to 0.36.1 (#32658)
    0615428aa9e03345c44bba555065233984d35ffe	https://github.com/servo/servo/pull/32652	android: fix application name used in ./mach run (#32652)
>>> 2024-07-03T06:07:15Z
    fe58a5f0a3bd9a20e368ed283dfcb89769f75c00	https://github.com/servo/servo/pull/32669	build(deps): bump idna from 1.0.1 to 1.0.2 (#32669)
    a958a0bb4040b37ef8d83a3262bbb03aa6a98dc1	https://github.com/servo/servo/pull/32668	build(deps): bump serde_json from 1.0.119 to 1.0.120 (#32668)
    044ab3eeabcff408c864ba890d0fc469d30fe482	https://github.com/servo/servo/pull/32667	fix clippy warning (#32667)
+   c0105de82b3d6259d4359062b98d6fbfabf1c139	https://github.com/servo/servo/pull/32642	webgpu: Implement ShaderCompilationInfo (#32642)
+   bd0a5eb4b7df0c9ce731277a97cdb21cfdbdb9fb	https://github.com/servo/servo/pull/32651	Add production-stripped cargo profile (#32651)
    7b324074b5ecd89ad8b15dfbe51787751d5cd3e9	https://github.com/servo/servo/pull/32663	mark test/wpt as vendored in .gitattributes (#32663)
>>> 2024-07-04T06:09:16Z
    650af7db926e9cc070e136f21a56bd47d566d10a	https://github.com/servo/servo/pull/32682	webgpu: Remove mutex around Identities (#32682)
+   959ffad99a57f5f8f0554fed0983317577ae8290	https://github.com/servo/servo/pull/32657	layout: Add support for table captions (#32657)
    f8e4ae60401358ac6adaa480e63c587f9f8293a2	https://github.com/servo/servo/pull/32679	build(deps): bump sctk-adwaita from 0.8.1 to 0.8.3 (#32679)
    70697adeb9c5e118bcdf35d4d66949375af446a0	https://github.com/servo/servo/pull/32678	build(deps): bump zerocopy from 0.7.34 to 0.7.35 (#32678)
4e79ac57018039b2d3f76e4a4616574e5d90505f	https://github.com/servo/servo/pull/32666	layout: Allow rendering LineItems independent of inline box (#32666)
    4357751f285c79bf37a8e7a02d4c8dc4f7a8ae69	https://github.com/servo/servo/pull/32653	use au in TextFragment (#32653)
>>> 2024-07-05T06:15:31Z
7eac599aa1d6bcf8858c51d90763373f0dd5f289	https://github.com/servo/servo/pull/32699	fonts: Stop using `Stylesheet::effective_font_face_rules` (#32699)
    0f2139be27f99919c46982f981e8bf68eb6be050	https://github.com/servo/servo/pull/32698	layout_2013: Remove code preventing writing mode assertion failures (#32698)
    10326f7e0f93385b42373ba9e6b2eb119a847099	https://github.com/servo/servo/pull/32701	build(deps): bump wayland-cursor from 0.31.3 to 0.31.4 (#32701)
    4b63043c6ae9ca9d51c6139101e294aaef379702	https://github.com/servo/servo/pull/32674	clippy: Fix warnings in `shared` and `config`, `fonts`, `layout`, and `layout_2020` components (#32674)
99c1f886b8398e73e5af06135f6f357752e2cb16	https://github.com/servo/servo/pull/32665	webgpu: Update wgpu and revamp RenderPass (#32665)
    26624a109f9d94560780b5ca8d08926e855c5987	https://github.com/servo/servo/pull/32680	clippy: Fix a bunch of warnings in `script` (#32680)
93fdb8263d14346d0757c2192527bc8c7c577572	https://github.com/servo/servo/pull/32693	Make task_info as `macos` specific (#32693)
+   fb1c57da3e6a0faa75fedcad463182ec40aebc39	https://github.com/servo/servo/pull/32684	DevTools: Add parser tool (#32684)
aae66cc33cdf4d4a83de5d17f86c8074e82812f0	https://github.com/servo/servo/pull/32688	Updated all kill_*_id functions defined in indentityhub.rs to free_*_id naming format for issue 32685 (#32688)
    42f42b39cc91766cee2192fc9ba91d4ca6ac2101	https://github.com/servo/servo/pull/32691	build(deps): bump wayland-client from 0.31.3 to 0.31.4 (#32691)
    44c4fe32c4615ec34393208a34db102f25a448f1	https://github.com/servo/servo/pull/32690	build(deps): bump wayland-scanner from 0.31.2 to 0.31.3 (#32690)
    81f40400b7e63322615f8ffd42dcc37a2c8d4337	https://github.com/servo/servo/pull/32689	build(deps): bump windows_i686_gnullvm from 0.52.5 to 0.52.6 (#32689)
+   e14e079fffaf862be6c2f8181e908ab35473af1f	https://github.com/servo/servo/pull/32683	servoshell: Update all egui dependencies and group them for dependabot (#32683)
>>> 2024-07-06T06:19:11Z
    438e99ca9a7f517236ffbed4d4ccf5d75a3bef99	https://github.com/servo/servo/pull/32708	build(deps): bump the egui-related group with 2 updates (#32708)
    fabd7a178fb5e48aef8f938fa30e702c95d7f5ef	https://github.com/servo/servo/pull/32710	build(deps): bump emath from 0.28.0 to 0.28.1 (#32710)
    a16666db03fa5ad47e41d301f65bca2f96b77ce6	https://github.com/servo/servo/pull/32709	build(deps): bump ab_glyph from 0.2.27 to 0.2.28 (#32709)
>>> 2024-07-07T06:06:38Z
141a594e236201acb44ca7cc42e2e653f4d55e7b	https://github.com/servo/servo/pull/32716	 Replace null-byte terminated string literals with C-string literals (#32716)
59d0f1fe1aec4bec736bf2839e43de886eaebf32	https://github.com/servo/servo/pull/32706	script: Impl cloning of JSPrincipals (#32706)
    5a9dc98f07cbd13394142ccf578a951c742af286	https://github.com/servo/servo/pull/32712	build(deps): bump egui_glow in the egui-related group (#32712)
    1e5c844eb5ea49e6d0a3dc7d14fac417ae4b2ac0	https://github.com/servo/servo/pull/32711	Add more crates to egui Dependabot group (#32711)
>>> 2024-07-08T06:09:40Z
+   db4cba4d6d0f1a26009967d17ffdf30157a81b5e	https://github.com/servo/servo/pull/32715	Add customElements.getName (#32715)
    816359583c55ced698ed450d644d82a6d25213c9	https://github.com/servo/servo/pull/32717	Update web-platform-tests to revision b'4e3b5de2eb8218cf18a1674618994efeb96e2cc0' (#32717)
>>> 2024-07-09T06:11:22Z
    1c6b74e1f16f6c92f80410d98608064fa4fbede2	https://github.com/servo/servo/pull/32736	build(deps): bump clipboard-win from 5.3.1 to 5.4.0 (#32736)
    84ec01762592352dccc817db21d3992ad8e2fa67	https://github.com/servo/servo/pull/32733	build(deps): bump gilrs-core from 0.5.12 to 0.5.13 (#32733)
    b7d9415a4ad25ceca0c55258a62239fdb15f9a8b	https://github.com/servo/servo/pull/32739	build(deps): bump cc from 1.0.104 to 1.0.106 (#32739)
    7a8cdcd4cad96b8ddf8e07c25606f2af91be7eb9	https://github.com/servo/servo/pull/32738	build(deps): bump syn from 2.0.68 to 2.0.69 (#32738)
    b919ac0dadf568a76526e0f5b4220fc509e9c4da	https://github.com/servo/servo/pull/32735	build(deps): bump serde from 1.0.203 to 1.0.204 (#32735)
    d8283d1a42e64963f6348901e164cecf7c0ab425	https://github.com/servo/servo/pull/32734	build(deps): bump gilrs from 0.10.7 to 0.10.8 (#32734)
+   77e9e3deba3925e8024719a6c3c54fbd4dddee7a	https://github.com/servo/servo/pull/32673	fonts: Add support for generic font families and font size configuration (#32673)
956b7f62e066f7f01a785a328a05f0f06d70f602	https://github.com/servo/servo/pull/32694	Avoid unnecessary clones for URLs (#32694)
    d9b99723f59c7ea665f293151476b75fb9381d9e	https://github.com/servo/servo/pull/32729	Remove unused ToWebRender implementation (#32729)
+   8cd1e22f8dc624deb80de9a730a21ef8d8cc503e	https://github.com/servo/servo/pull/32725	android/ohos: fonts: Ignore ascii case when searching for font family (#32725)
+   89944bd330c1e46a6f406c9aa36e5118ddd06902	https://github.com/servo/servo/pull/32695	layout: Improve layout of table captions (#32695)
    2888193cfe3d1b3317984324add07a5e4e4228dc	https://github.com/servo/servo/pull/32726	DevTools: Replace camel case variable names (#32726)
    b243457ccc6cd5a2dab58d9c9ff8b6fee1db6a20	https://github.com/servo/servo/pull/32724	ci: fix security issue in try job workflow (#32724)
    099b5607b95bfc53ead51caee554175f2593f1d2	https://github.com/servo/servo/pull/32722	readme: Clarify that `rust` and `cargo` must be in your path after rustup runs (#32722)
+   24639bb540b3a83febea9d2dab0ea9e28a989422	https://github.com/servo/servo/pull/32721	android: sign release APK with a custom key. (#32721)
    6cb95827a3097a73846dccb759be4489e1365fef	https://github.com/servo/servo/pull/32718	Set compositor's cursor_pos properly (#32718)
>>> 2024-07-10T06:05:02Z
    a3bb8048fc09d7ce7b0f5a9bbed37b2f21ce866d	https://github.com/servo/servo/pull/32728	use au in inline (#32728)
+   33f3c34d28cdd970455f93dde4d7f3a9ad0bbb2e	https://github.com/servo/servo/pull/32727	DevTools: Display console messages and errors (#32727)
+   34d9be70f9bacc391f6ed69aa1ed5e364bc2c2d6	https://github.com/servo/servo/pull/32743	Update in-tree docs to point to the new book (#32743)
+   72e6a1f007fd78d450e3e2f5569bec5a0bb247ff	https://github.com/servo/servo/pull/32643	Remove media element state changes triggered by network responses (#32643)
    f29dd64a7b633e844756e6eecf9e05e0b327fc51	https://github.com/servo/servo/pull/32740	Fix more clippy (#32740)
    4e1f623666e6ba3ffe7fe2d86564885260d8f65a	https://github.com/servo/servo/pull/32737	build(deps): bump target-lexicon from 0.12.14 to 0.12.15 (#32737)
>>> 2024-07-11T06:06:33Z
    3e163bfcdbe093470dbdea5d2d9b18a7a0c31239	https://github.com/servo/servo/pull/32753	shell: set `no-wgl` flag in servoshell instead (#32753)
    313536fd82875cb73248b2ee0b91db903bac89c9	https://github.com/servo/servo/pull/32746	build(deps): bump cc from 1.0.106 to 1.1.0 (#32746)
    f455321f8436381e01d44468ec744576e57c3555	https://github.com/servo/servo/pull/32749	build(deps): bump syn from 2.0.69 to 2.0.70 (#32749)
    fc34137fdaf5e4ad8b8360fc9fbc3c349ca25c44	https://github.com/servo/servo/pull/32748	build(deps): bump vergen from 8.3.1 to 8.3.2 (#32748)
    0c362329c30ac1a4e8722f7390ab1acbb4d35bfc	https://github.com/servo/servo/pull/32750	build(deps): bump hyper from 0.14.29 to 0.14.30 (#32750)
    1ec1207099418746de4f72010e2b25ffb348b394	https://github.com/servo/servo/pull/32747	build(deps): bump darling from 0.20.9 to 0.20.10 (#32747)
    c6443f74a4693f2f28316aed97860aebeca3cdad	https://github.com/servo/servo/pull/32754	Remove unused  implementation (#32754)
    097b9a3d0b2dc96f4c1ac2c93582feb74276046c	https://github.com/servo/servo/pull/32751	build(deps): bump uuid from 1.9.1 to 1.10.0 (#32751)
>>> 2024-07-12T06:15:01Z
b206a0f4a3d9742f46f35141fd1df8e5c81ee779	https://github.com/servo/servo/pull/32760	ohos: Add default log filter (#32760)
+   496ce717c5343984e0f3da00d223604eff03893c	https://github.com/servo/servo/pull/32759	Move legacy layout behind a feature flag (#32759)
4907e896560dd68bfcd9318b4493de10d7ceee19	https://github.com/servo/servo/pull/32758	canvas: Remove as much usage of `font-kit` as possible (#32758)
c6cb7ee98169ce1acb3b43b5071385d8f4f4adc2	https://github.com/servo/servo/pull/32741	script: Use the new C string literal in the DOM bindings (#32741)
>>> 2024-07-13T06:08:13Z
    d667b797396b9aeb60482112e84608f21cb10c4b	https://github.com/servo/servo/pull/32768	build(deps): bump thiserror from 1.0.61 to 1.0.62 (#32768)
    2fc0fd131253a876f2e63bdb0e01c8f1b5796ac2	https://github.com/servo/servo/pull/32767	build(deps): bump syn from 2.0.70 to 2.0.71 (#32767)
    42eb93624c889dfc6a1afc49ac69b6d9eeca552a	https://github.com/servo/servo/pull/32765	build(deps): bump cc from 1.1.0 to 1.1.1 (#32765)
91ca727eb9412012d2a38c1a9c870415b34d989b	https://github.com/servo/servo/pull/32700	webgpu: Divide message code into separate files (#32700)
+   40bac8c3df1d139a7248f2246cb5de9ca0faa9fc	https://github.com/servo/servo/pull/32635	script: `document.visibilityState` and `document.hidden` (#32635)
>>> 2024-07-14T06:08:13Z
    cd394af018c1816f5d504e49b37af9258ce052e6	https://github.com/servo/servo/pull/32764	Bump duplicated nix to 0.29 (#32764)
>>> 2024-07-15T06:08:01Z
    968474a9fda45b951de9b9b16b5a1fae16c5f2a7	https://github.com/servo/servo/pull/32774	Update web-platform-tests to revision b'f3dd9cba239a9655951ee62ec4dafc8fe37df2c5' (#32774)
3118542a9e90478cdabf1f2479851f86dd0e94d6	https://github.com/servo/servo/pull/32772	Use mallinfo only on target_env=gnu (#32772)
>>> 2024-07-16T06:07:14Z
    d5171c068cd3a00dafb70e0d4f10dff42a8888a5	https://github.com/servo/servo/pull/32781	build(deps): bump setuptools from 68.2.2 to 70.0.0 in /python (#32781)
    ddf3bb495757b1eee063a2be9c821ba32855d663	https://github.com/servo/servo/pull/32780	build(deps): bump document-features from 0.2.8 to 0.2.10 (#32780)
    bb201fb4ec5136ad47bd2b608afbb516b71cfaf2	https://github.com/servo/servo/pull/32779	build(deps): bump bytes from 1.6.0 to 1.6.1 (#32779)
    025b8318621215078fb3f54a7b96f207bca132f0	https://github.com/servo/servo/pull/32778	build(deps): bump cc from 1.1.1 to 1.1.5 (#32778)
    e761b7d7111e4826467727f354ae8c18893ab38a	https://github.com/servo/servo/pull/32775	Auto merge all WPT and dependabot PRs (#32775)
>>> 2024-07-17T06:08:20Z
    bc1bf82f786bf7258c264e474ce1d6f51dff6e05	https://github.com/servo/servo/pull/32788	build(deps): bump webxr from `88fd368` to `bacb22f` (#32788)
    946af8450cda308bc591db1af4ce7c977846975b	https://github.com/servo/servo/pull/32783	Update WebGPU CTS (#32783)
+   039631cfa59e4f831fbbb42a164e46026f217d41	https://github.com/servo/servo/pull/32785	layout: Properly handle min/max cross container size (#32785)
+   80559c829b84eb33d8ad5fed58aa6640e06200fc	https://github.com/servo/servo/pull/32786	Bump mozjs version (#32786)
    0189b89fd16b9fefd5c659dc27013b9dd6a0c3dd	https://github.com/servo/servo/pull/32784	Fixes typo in clippy::enum_variant_names (#32784)
>>> 2024-07-18T06:08:47Z
34eed29037ba7c7ab68cd6ddbf27aa0fe81d6a47	https://github.com/servo/servo/pull/32799	Less nesting in webgpu response (#32799)
+   122333554768d69789a08df25c0bcde3ddd1aa4c	https://github.com/servo/servo/pull/32704	enhance: Implement `CanvasRenderingContext2D.measureText` (#32704)
    d82232d549a880aaa1b5613e22ca4f7ec9593d74	https://github.com/servo/servo/pull/32798	build(deps): bump wayland-client from 0.31.4 to 0.31.5 (#32798)
    62c3d30b3ddbd8a239c5f5a437a426740628758e	https://github.com/servo/servo/pull/32797	build(deps): bump wayland-scanner from 0.31.3 to 0.31.4 (#32797)
    f8ebbdc0d1681301f6462290bfa106e2537a048b	https://github.com/servo/servo/pull/32794	build(deps): bump tokio from 1.38.0 to 1.38.1 (#32794)
    26beacdabd3a80d2afdb8cb70769fcf62f62f16e	https://github.com/servo/servo/pull/32795	build(deps): bump wayland-backend from 0.3.5 to 0.3.6 (#32795)
    e4ad1d3ab97a10892dc3dca28bbd7ab06da94e07	https://github.com/servo/servo/pull/32791	[clippy] Rename enum FormSubmitter and its elements (#32791)
+   882a855b8c71d461ab14c2953a2b574861fba5d2	https://github.com/servo/servo/pull/32790	Convert layout to use Gecko's alignment style representation (#32790)
    a0d2b36ad8d48034d6490232e31106ef8b7bfa9d	https://github.com/servo/servo/pull/32789	clippy: Fix four warnings (#32789)
    5fd0d2f17bccce81bcf1e9c36f453fa8eef66467	https://github.com/servo/servo/pull/32762	Mark flexbox-mbp-horiz-003 tests as only failing on linux (#32762)
>>> 2024-07-19T06:08:52Z
    8b3c9b744ab41f52f01ee624228e655b981824eb	https://github.com/servo/servo/pull/32808	Fix 5 clippy warnings (#32808)
    a6048c46d20912952811dea341f51b746163311c	https://github.com/servo/servo/pull/32805	build(deps): bump thiserror from 1.0.62 to 1.0.63 (#32805)
    f28b5419abf4f22c017a933e0f05013ec8115d65	https://github.com/servo/servo/pull/32806	build(deps): bump wayland-cursor from 0.31.4 to 0.31.5 (#32806)
    627f0b4f611b6158dd6371647ea489891a28d0f0	https://github.com/servo/servo/pull/32804	build(deps): bump xcursor from 0.3.5 to 0.3.6 (#32804)
+   bb5ace79298c6a48a6ba110496792ad1f8f29e15	https://github.com/servo/servo/pull/32803	Bump stylo and enable aspect-ratio tests (#32803)
+   f6c9714286b044df02ae1f2a7af1a7c3d89e9320	https://github.com/servo/servo/pull/32777	Fix sizing of replaced elements with min/max sizes (#32777)
+   1b1f79305e6061b3e122a43247c897a418b0adce	https://github.com/servo/servo/pull/32787	flex: handle ‘align-self: [ first | last ]? && baseline’ (#32787)
>>> 2024-07-20T06:14:55Z
    a29e5c8115bc9b2a07467a44518a0a617e056208	https://github.com/servo/servo/pull/32815	build(deps): bump cc from 1.1.5 to 1.1.6 (#32815)
    4bf5024ee058784d4f505fe5ec279cd87a7fd2b4	https://github.com/servo/servo/pull/32813	fix a couple of simple clipy warnings (#32813)
+   5eb77592ea8a0ba83e81d5e99f7beb54a8e48712	https://github.com/servo/servo/pull/32810	layout: Reduce the complexity of `FlexLine::layout` (#32810)
>>> 2024-07-21T06:11:53Z
b471f6473f2564f0a32664b36139b0ae5d02655c	https://github.com/servo/servo/pull/32814	Remove failure breaks from webgpu thread (#32814)
2c17de7fa72ca6f96f4e37faf90ac9786d0b53a0	https://github.com/servo/servo/pull/32046	Gamepad: Implement GamepadHapticActuator (#32046)
9212ed203a7dcec88008fca47bce0bff3fe2649b	https://github.com/servo/servo/pull/32817	Enable OpenXR backend from the WebXR crate (#32817)
>>> 2024-07-22T07:50:30Z
    f6dc35f11dcbc7f3cfeb7f0e804c5f9851088ebe	https://github.com/servo/servo/pull/32825	chore: Update WebGPU CTS (#32825)
    2c4b96b872ea10771efbb9d536d38538364293b9	https://github.com/servo/servo/pull/32824	Update web-platform-tests to revision b'5af3e9c2a2aba76ade00f0dbc3486e50a74a4506' (#32824)
    a7a380777d03807dcffe6c40127766362ac56398	https://github.com/servo/servo/pull/32822	Remove a comment related to a TODO which has already been done. (#32822)
>>> 2024-07-23T06:08:11Z
    2a31e62e2c057e0a30a3d81eace031427ba1465e	https://github.com/servo/servo/pull/32832	build(deps): bump libloading from 0.8.4 to 0.8.5 (#32832)
    835e4f49262e179a4b646cf82de74cc6c1cd3523	https://github.com/servo/servo/pull/32833	build(deps): bump pathfinder_simd from 0.5.3 to 0.5.4 (#32833)
    47d702edc3895ff0137075588b820afe230c8048	https://github.com/servo/servo/pull/32830	build(deps): bump syn from 2.0.71 to 2.0.72 (#32830)
    753dedbeba1cbe39be45b802f6275c103ce2a41a	https://github.com/servo/servo/pull/32831	build(deps): bump arrayref from 0.3.7 to 0.3.8 (#32831)
+   f040b821a3c6f0079912d156c3b5349b505fc8e0	https://github.com/servo/servo/pull/32731	ohos: Detect installed fonts (#32731)
b5482e34c017c64fae6f5c1db41880d826546a46	https://github.com/servo/servo/pull/32829	compositor: propagate scroll events across pipelines (#32829)
+   45eabad16971e51394a2050ec16966c1bbefa8ff	https://github.com/servo/servo/pull/32819	Implement URL::parse() (#32819)
a007baa4cf6791cb42e2d7ec46eb9cc803f24b29	https://github.com/servo/servo/pull/32828	deps: switch to `tikv-jemallocator` crates in Cargo.toml (#32828)
>>> 2024-07-24T06:13:07Z
    b6652f88d163fe38982a9d2bb2f797a349559288	https://github.com/servo/servo/pull/32839	build(deps): bump jobserver from 0.1.31 to 0.1.32 (#32839)
    69b16e02c4e0c6e0cae40f7a6eb09e31eb95bff2	https://github.com/servo/servo/pull/32837	build(deps): bump env_filter from 0.1.0 to 0.1.1 (#32837)
    e8cf751e11fc8fcd7c9619c022d0617fd44de7a4	https://github.com/servo/servo/pull/32835	Clarify the Code of Conduct (closes servo/servo.org#164) (#32835)
    d46c66f9da1c24d1ce42a954136bb513431f9205	https://github.com/servo/servo/pull/32834	ohos: Bump ohos-sys to v0.2.1 (#32834)
>>> 2024-07-25T06:04:42Z
    450aebc839c04097b822cc479cb8eb0ff8bdc509	https://github.com/servo/servo/pull/32851	build(deps): bump gstreamer from 0.22.6 to 0.22.7 (#32851)
    d53962abd56cb68e452c8efdb0aa62d2531b492f	https://github.com/servo/servo/pull/32852	build(deps): bump object from 0.36.1 to 0.36.2 (#32852)
    bf8decbffbd5fca02129697b2a1ceeb8c3858206	https://github.com/servo/servo/pull/32847	clippy: ports/servoshell/desktop (#32847)
    f2fbe44dc9434d9bee5884bcef664ef10f4b4aa6	https://github.com/servo/servo/pull/32844	dependencies: Upgrade `tokio`, `ipc-channel`, and `mio` (#32844)
+   dee03bf297bd9acc5d63f21a638939f3de65356c	https://github.com/servo/servo/pull/32842	Bump nixpkgs and add cargo-deny in shell.nix (#32842)
    33a48f76fb35dd94bed1228d3836341fe1d67c57	https://github.com/servo/servo/pull/32848	build(deps): bump webxr from `bacb22f` to `11a3727` (#32848)
    7ace7b43dc7ca463a4661d5379f71c4ecc279f5e	https://github.com/servo/servo/pull/32843	clippy: components/canvas/canvas_data.rs (#32843)
+   1906741704dff0d1db54a83752a4f198eae3fc84	https://github.com/servo/servo/pull/32841	layout: Add support for propagating baselines from flexbox (#32841)
+   569fd5d8b580b9b9e5f9746f239a24caa857b71e	https://github.com/servo/servo/pull/32812	Upgrade stylo to 2024-07-16 (#32812)
+   60e65c175dcc6dda08161f3a3f56510fc88ddceb	https://github.com/servo/servo/pull/32800	Implement the `aspect-ratio` property for replaced elements (#32800)
    e425ad0cb722b01420ddc315492d13067828250e	https://github.com/servo/servo/pull/32840	Remove googlevr feature (#32840)
-->

<style>
    /* guaranteed minimum width for first paragraph after a float */
    ._floatmin {
        display: block;
        width: 13em;
        overflow: hidden;
    }
    ._none {
        display: none;
    }
    ._fig:not(#specificity) {
        width: 33em;
        max-width: 100%;
        margin: 1em auto;
    }
    ._fig > ._flex {
        display: flex;
    }
    ._fig table {
        text-align: initial;
    }
    ._fig figcaption._notes {
        text-align: left;
        width: max-content;
        max-width: 100%;
    }
    ._figl:not(#specificity),
    ._figr:not(#specificity) {
        margin: 0 1em 1em;
    }
    ._figl {
        float: left;
        max-width: 100%;
    }
    ._figr {
        float: right;
        max-width: 100%;
    }
    ._figl > figcaption,
    ._figr > figcaption,
    ._figl > iframe,
    ._figr > iframe,
    ._figl > video,
    ._figr > video,
    ._figl > a > img,
    ._figr > a > img {
        width: 21em;
        max-width: 100%;
    }
    ._runin {
        margin-bottom: 1em;
    }
    ._runin > p,
    ._runin > h2 {
        display: inline;
    }
    ._correction {
        max-width: 33em;
        margin: 1em auto;
        border-bottom: 1px solid;
        padding-bottom: 1em;
    }
    ._note {
        margin: 1em 1em;
        border-left: 1px solid;
        padding-left: 1em;
        opacity: 0.75;
    }
</style>
