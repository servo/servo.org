---
layout:     post
tags:       blog
title:      "This month in Servo: and more!"
date:       2024-08-30
summary:    ao!! wrrrrao!!
categories:
---

<figure class="_figr"><a href="{{ '/img/blog/features-august-2024.png' | url }}"><img src="{{ '/img/blog/features-august-2024.png' | url }}"
    alt="Servo nightly with a flexbox-based table of new features including textarea text, ‘border-image’, structuredClone(), crypto.randomUUID(), ‘clip-path’, and flexbox properties themselves"></a>
<figcaption>A flexbox-based table showcasing some of Servo’s new features this month.</figcaption></figure>

Servo has had several new features land in our nightly builds over the last month:

- as of 2024-07-27, basic support for **show() on HTMLDialogElement** (@lukewarlow, #32681)
- as of 2024-07-29, the **type property on HTMLFieldSetElement** (@shanehandley, #32869)
- as of 2024-07-31, we now support **rendering text typed in &lt;textarea>** (@mrobinson, #32886)
- as of 2024-07-31, we now support the **‘border-image’** property (@mrobinson, #32874)
- as of 2024-08-02, **unsafe-eval** and **wasm-unsafe-eval** CSP [sources](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/Sources) (@chocolate-pie, #32893)
- as of 2024-08-04, we now support playback of **WAV audio files** (@Melchizedek6809, #32924)
- as of 2024-08-09, we now support the **structuredClone()** API (@Taym95, #32960)
- as of 2024-08-13, we now support navigating through **cross-origin redirects** (@jdm, #32996)
- as of 2024-08-23, we now support the **crypto.randomUUID()** API (@webbeef, #33158)

We’ve upgraded Servo to **SpiderMonkey 128** (@sagudev, @jschwe, #32769, #32882, #32951, #33048), **WebRender 0.65** (@mrobinson, #32930, #33073), **wgpu 22.0** (@sagudev, #32827, #32873, #32981, #33209), and **Rust 1.80.1** (@Hmikihiro, @sagudev, #32896, #33008).

**WebXR** (@msub2, #33245) and **flexbox** (@mrobinson, #33186) are now **enabled by default!**

The biggest flexbox features that landed this month are the **‘gap’ property** (@Loirooriol, #32891), **‘align-content: stretch’** (@mrobinson, @Loirooriol, #32906, #32913), and the **‘start’** and **‘end’** values on **‘align-items’** and **‘align-self’** (@mrobinson, @Loirooriol, #33032), as well as basic support for **‘flex-direction: column’** and **‘column-reverse’** (@mrobinson, @Loirooriol, #33031, #33068).

**‘position: relative’** is now supported on flex items (@mrobinson, #33151), **‘z-index’ always creates stacking contexts** for flex items (@mrobinson, #32961), and we now give flex items and flex containers their correct **intrinsic sizes** (@delan, @mrobinson, @mukilan, #32854).

We’re now working on support for **bidirectional text**, with architectural changes to the fragment tree (@mrobinson, #33030) and ‘writing-mode’ interfaces (@mrobinson, @atbrakhi, #33082), and now partial support for the **‘unicode-bidi’ property** and the **dir attribute** (@mrobinson, @atbrakhi, #33148).
Note that the `dir=auto` value is not yet supported.

<figure class="_figl"><a href="{{ '/img/blog/servoshell-august-2024.png' | url }}"><img src="{{ '/img/blog/servoshell-august-2024.png' | url }}"
    alt="Servo nightly showing a toolbar with icons on the buttons, one tab open with the title “Servo - New Tab”, and a location bar that reads “servo:newtab”"></a>
<figcaption>servoshell now has a more elegant toolbar, tabbed browsing, and a clean but useful “new tab” page.</figcaption></figure>

## <span class=_floatmin></span>servoshell

Servo’s reference browser now has a **redesigned toolbar** (@Melchizedek6809, 33179) and **tabbed browsing** (@webbeef, @Wuelle, #33100, #33229)!
This includes a slick **new tab page**, taking advantage of a new API that lets Servo embedders register **custom protocol handlers** (@webbeef, #33104).

## Engine reliability

August has been a huge month for squashing **crash bugs** in Servo, including on real-world websites.

We’ve fixed crashes when rendering **floats near tables** in [the HTML spec](https://html.spec.whatwg.org) (@Wuelle, #33098), **removed unnecessary explicit reflows** that were causing crashes on w3schools<!-- no link -->.com (@jdm, #33067), and **made the HTML parser re-entrant** (@jdm, #32820, #33056, html5ever#548), fixing crashes on kilonova<!-- no link -->.ro ([issue] #32454), tweakers<!-- no link -->.net ([issue] #32744), and many other sites.
Several other crashes have also been fixed:

- crashes when **resizing windows with WebGL** on macOS (@jdm, #33124)
- crashes when rendering text with **extremely long grapheme clusters** (@crbrz, #33074)
- crashes when rendering text with **tabs in certain fonts** (@mrobinson, #32979)
- crashes in the parser **after calling window.stop()** (@Taym95, #33173)
- crashes when **passing some values to console.log()** (@jdm, #33085)
- crashes when **parsing some &lt;img srcset> values** (@NotnaKO, #32980)
- crashes when **parsing some HTTP header values** (@ToBinio, #32973)
- crashes when **setting window.opener** in certain situations (@Taym95, #33002, #33122)
- intermittent crashes in WRSceneBuilder **when exiting Servo** (@Taym95, #32897)

We’ve fixed a bunch of **BorrowError** crashes under SpiderMonkey GC (@jdm, #33133, [issue] #24115, [issue] #32646), and we’re now working towards preventing this class of bugs with static analysis (@jdm, #33144).

Servo no longer **leaks the DOM Window object** when navigating (@ede1998, @rhetenor, #32773), and servoshell now **[terminates abnormally](https://pubs.opengroup.org/onlinepubs/9799919799/functions/V2_chap02.html#tag_16_04_03_01) when panicking** on Unix (@mrobinson, #32947), ensuring [web tests](https://book.servo.org/hacking/testing.html) correctly record their test results as “CRASH”.

## Changes for Servo developers

Servo now has **new CI runners** for Windows builds (@delan, #33081), thanks to your donations, **cutting Windows-only build times by 70%**!
We’re not stopping at Windows though, and with new runners for Linux builds just around the corner, your WPT try builds will soon be a lot faster.

## Donations

Thanks again for your generous support!
We are now receiving **3077 USD/month** (+4.1% over July) in recurring donations.
This includes donations from **12 people** on LFX, but we will stop accepting donations there soon — **please move your recurring donations to [GitHub](https://github.com/sponsors/servo) or [Open Collective](https://opencollective.com/servo)**.

Servo is also on [thanks.dev](https://thanks.dev), and already **three GitHub orgs** that depend on Servo are sponsoring us there.
If you use Servo libraries like [url](https://crates.io/crates/url/reverse_dependencies), [html5ever](https://crates.io/crates/html5ever/reverse_dependencies), [selectors](https://crates.io/crates/selectors/reverse_dependencies), or [cssparser](https://crates.io/crates/cssparser/reverse_dependencies), signing up for [thanks.dev](https://thanks.dev) could be a good way for you (or your employer) to give back to the community.

<figure class="_fig" style="width: 100%; margin: 1em 0;"><div class="_flex" style="height: calc(1lh + 3em); flex-flow: column nowrap; text-align: left;">
    <div style="position: relative; text-align: right;">
        <div style="position: absolute; margin-left: calc(100% * 3077 / 10000); padding-left: 0.5em;"><strong>3077</strong> USD/month</div>
        <div style="position: absolute; margin-left: calc(100% * 3077 / 10000); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="position: absolute; margin-left: calc(100% - 0.5em); height: calc(1lh + 1.5em); border-left: 1px solid;"></div>
        <div style="padding-right: 1em;"><strong>10000</strong><!-- USD/month --></div>
    </div>
    <progress value="3077" max="10000" style="transform: scale(3); transform-origin: top left; width: calc(100% / 3);"></progress>
</div></figure>

As always, use of these funds will be decided transparently in the Technical Steering Committee.
For more details, head to our [Sponsorship page]({{ '/sponsorship/' | url }}).

<!--
- DONE donations 3077/month (+4.1%)
    - DONE opencollective 1637.00/month
    - DONE github 1313.00/month
    - DONE lfx 127.00/month (10+10+10+10+10+10+25+5+12+5+10+10)
    - DONE self-hosted ci runners
- upgrades
    - DONE mozjs 115 → 128 32769 32882 32951 33048
    - DONE webrender 0.64 → 0.65 32930 33073
    - DONE wgpu 22 32827 32873 32981 33209
        - better exception handling 32925
    - DONE rust 1.78.0 → 1.80.1 32896 33008
- rendering
    - DONE typing in textarea 32886
    - DONE wav playback 32924
    - DONE cross-origin redirects 32996
    - ‘clip-path: [<basic-shape> || <shape-box>]’ 33107
    - DONE flex
        - DONE column mode 33031 33068
        - DONE ‘gap’ 32891
        - DONE ‘align-content: stretch’ 32906
        - DONE ‘align-(items|content): (start|end)’ 33032
        - DONE ‘position: relative’ 33151
        - DONE intrinsic sizes 32854
        - DONE ‘z-index’ stacking context fix 32961
        - DONE subpixel fix 32913
        - DONE flexbox enabled by default 33186
    - DONE bidi
        - DONE physical geometry 33030
        - DONE ‘writing-mode’ access 33082
        - DONE basic support for dir attribute and ‘unicode-bidi’ 33148
    - DONE ‘border-image’ 32874
    - DONE structuredClone() 32960
    - DONE crypto.randomUUID() 33158
    - webaudio IIRFilterNode 33001
    - webxr XRInputSource.gamepad 32860
    - webxr XRBoundedReferenceSpace 33176
    - webgpu createComputePipelineAsync() createRenderPipelineAsync() 32636
    - DONE csp unsafe-eval wasm-unsafe-eval 32893
    - DONE basic support for show() method on HTMLDialogElement 32681
    - DONE type property on HTMLFieldSetElement 32869
    - non-tree-structural pseudo-classes 33165
    - DONE webxr enabled by default 33245
- embedding
    - DONE custom protocol handlers 33104
    - additional webrender surfaces 32933
- devtools
    - html tree 32655
    - text nodes? 32884
    - attributes 32888
    - style inspector and computed tab 33025
- DONE servoshell
    - DONE redesigned toolbar 33179
    - DONE tabs 33100 33229
- dev
    - watch out! mediafire fix.rar 33201
    - clippy ci 33150
    - faster build-then-run on macos 32928
    - DONE self-hosted ci runners windows 33081
- platform support
    - windows text/image rendering fixes 33045 33177
    - windows --output to png fix 32914
    - musl? background hang monitor 33153
- DONE rendering/crashes
    - DONE html parser reentrancy! 32820 33056
    - DONE forced reflows 33067
- DONE crashes and reliability
    - DONE panics now look like crashes in tests 32947
    - DONE gc borrow hazards 33133
        - DONE static analysis 33144
    - DONE resizing window macos 33124
    - DONE large grapheme clusters 33074
    - DONE tabs with certain fonts 32979
    - DONE aborting parser 33173
    - DONE console.log 33085
    - DONE srcset 32980
    - DONE set() method on Headers 32973
    - DONE window.opener setter 33002 33122
    - DONE table layout 33098
    - DONE webrender shutdown 32897
    - DONE leak CreateProxyWindowHandler 32773
- bustage
    - nixpkgs 32945
    - spaces windows 32936
    - non-ascii windows 32949
    - ci android 32907 32927
    - building for ohos 33029
    - macos apple silicon 33190 33200
- cleanups
    - lazy_static 33046 33047 33049 33060 33065 33078
    - once_cell 33080
    - syn dedupe 33038

>>> 2024-07-26T06:07:44Z
    bc1c71bd4df9424e4cceed9dc8cc38efc591095b	https://github.com/servo/servo/pull/32857	build(deps): bump serde_spanned from 0.6.6 to 0.6.7 (#32857)
    f91792d9c33dc23a7f0d67b0d370ec59f39ca85e	https://github.com/servo/servo/pull/32856	build(deps): bump env_filter from 0.1.1 to 0.1.2 (#32856)
    4afa382733517e2c875744ab922ab36caf80ed19	https://github.com/servo/servo/pull/32855	build(deps): bump toml_datetime from 0.6.6 to 0.6.7 (#32855)
+   ad74bfc4ea70f052939163f2404bf543131d06d3	https://github.com/servo/servo/pull/32827	webgpu: Update wgpu to 22.0 (#32827)
>>> 2024-07-27T06:02:22Z
    9f151faf1d97b90e1e07e8a21861a2d5050ab73f	https://github.com/servo/servo/pull/32865	build(deps): bump webxr from `11a3727` to `89d7027` (#32865)
    bdc07eab752a462379f881cdad5a4e3c8ad78d28	https://github.com/servo/servo/pull/32864	build(deps): bump version_check from 0.9.4 to 0.9.5 (#32864)
    b6f1e3b22d076a9b52691bf641fe4ba55df4470f	https://github.com/servo/servo/pull/32861	dependencies: Upgrade `cookie` and rename Servo's `Cookie` to `ServoCookie` (#32861)
+   8f377a0cb144b32182938f2210360a9a124e2b16	https://github.com/servo/servo/pull/32681	Partially implement dialog.show() (#32681)
+   902bf5733139ba6269e4f10c52ae62e0eea4a4c0	https://github.com/servo/servo/pull/32655	DevTools: Show HTML tree (#32655)
    f7448b5d6121339508a5cbc31e1da2db704da371	https://github.com/servo/servo/pull/32862	Remove the WebXR dependency on ancient `time@0.1` crate (#32862)
    eac54183c154ca044f98e9d74aa51892f73c0085	https://github.com/servo/servo/pull/32859	clippy: components/script/realms (#32859)
>>> 2024-07-28T06:08:04Z
>>> 2024-07-29T06:08:11Z
+   ed8def28960fd64fa0d00bd67731d594c1042747	https://github.com/servo/servo/pull/32869	Add the type IDL attribute to htmlfieldsetelement (#32869)
    bc75bf4cfa42d627309bd003dbb6dab3f3233dfd	https://github.com/servo/servo/pull/32868	Remove treatment of whitespace in the construction of a for data entry list, move it to the encoding stage (#32868)
>>> 2024-07-30T06:05:57Z
+   29a4cca42d01ab7acf6610362cd1165d2c2e85f7	https://github.com/servo/servo/pull/32882	Update mozjs again (#32882)
    a295c3e8aac1afa76307595613feb9ce8e2398ae	https://github.com/servo/servo/pull/32881	build(deps): bump serde_json from 1.0.120 to 1.0.121 (#32881)
    4fa1daa2451270018f14acc64ce88db0c824e323	https://github.com/servo/servo/pull/32879	build(deps): bump tokio from 1.39.1 to 1.39.2 (#32879)
    15f7db273f8ec987c19429ac9ba01bb626cf93b8	https://github.com/servo/servo/pull/32878	build(deps): bump cc from 1.1.6 to 1.1.7 (#32878)
    d8c09b8b1412dab29f5584e0691423e0b976458e	https://github.com/servo/servo/pull/32876	build(deps): bump num_enum from 0.7.2 to 0.7.3 (#32876)
    33bf31f2122322a5df3d090e2fe6e23ad14cc423	https://github.com/servo/servo/pull/32877	build(deps): bump webxr from `89d7027` to `93ee726` (#32877)
+   c5fe64a59454be739f9d09a088f900656965f559	https://github.com/servo/servo/pull/32873	webgpu: update wgpu again (#32873)
    976850d92de1dfcf80a06428f9491fa64241f347	https://github.com/servo/servo/pull/32875	Fix debugmozjs compilation (#32875)
+   d132a0273d17a140a916bb4c73cdb1d81fee1d2d	https://github.com/servo/servo/pull/32769	Update mozjs (SpiderMonkey) to 128.0 (#32769)
>>> 2024-07-31T06:02:33Z
    f86493cd7ef78a0a7bbe78f0047cd695d4f956e2	https://github.com/servo/servo/pull/32890	Enable flexbox for css-align tests (#32890)
    c69d59259e06490de002e00c084a5b59e1c14e7f	https://github.com/servo/servo/pull/32894	build(deps): bump ppv-lite86 from 0.2.17 to 0.2.19 (#32894)
    506096222fe127a7b10974c1cf49580f08276db0	https://github.com/servo/servo/pull/32895	build(deps): bump toml_datetime from 0.6.7 to 0.6.8 (#32895)
+   a64f75b62f3cd1c12219dbb44ac40c1104de63ef	https://github.com/servo/servo/pull/32886	layout: Fix display of new text in `textarea` elements (#32886)
+   c06a6a764ea568be5faade665302aa23ca64304c	https://github.com/servo/servo/pull/32884	DevTools: Inline text and clean whitespace (#32884)
+   e23dc0bf6f5ed6dec0537a3f4f1c668937c87246	https://github.com/servo/servo/pull/32874	layout: Port `border-image` support for legacy layout (#32874)
>>> 2024-08-01T06:14:12Z
    b4e1ec441254daf2df75f84347480a9afb9f4779	https://github.com/servo/servo/pull/32902	build(deps): bump bytemuck from 1.16.1 to 1.16.3 (#32902)
    b94e7e00a900834626ed0dab4e7fb45dc6bbf2f0	https://github.com/servo/servo/pull/32901	build(deps): bump bytes from 1.6.1 to 1.7.0 (#32901)
    4a7b50fedb840e123da21044c08e89f2165f6da3	https://github.com/servo/servo/pull/32900	build(deps): bump target-lexicon from 0.12.15 to 0.12.16 (#32900)
+   ca6169990ea8b429bbb8c11e4dcc9d8c6f59c7dd	https://github.com/servo/servo/pull/32891	Implement gaps in flexbox layout (#32891)
>>> 2024-08-02T06:17:24Z
+   5963695664a6c0112bded05c9af9bbfa2224d411	https://github.com/servo/servo/pull/32773	fix: Memory leak from CreateProxyWindowHandler (#32773)
    501950c2e33d421ad1a38fa095fa7aae610fd3aa	https://github.com/servo/servo/pull/32908	build(deps): bump indexmap from 2.2.6 to 2.3.0 (#32908)
+   92866ab911cb65d09b6b46bc1fb26868854cbafe	https://github.com/servo/servo/pull/32893	enhance: Add support for `unsafe-eval` and `wasm-unsafe-eval` (#32893)
+   2cf207ddc8133f1abb85704d2d0eee9e26b52723	https://github.com/servo/servo/pull/32907	Free some space on android runners (#32907)
    0ff4398380c58d2402765c0ca017c0d12b25cd5c	https://github.com/servo/servo/pull/32905	Update mozjs to fix enforcerange for 64bit numbers (#32905)
>>> 2024-08-03T06:12:23Z
    1e510e8de7ae6d9e2c490362dbfb935374e233f5	https://github.com/servo/servo/pull/32918	build(deps): bump regex from 1.10.5 to 1.10.6 (#32918)
    69a716a4ce1518aced772b2f343edf13e6e0144c	https://github.com/servo/servo/pull/32919	build(deps): bump bytes from 1.7.0 to 1.7.1 (#32919)
    3699aa0c185a38b682dfd916e99e2d0f0347f28b	https://github.com/servo/servo/pull/32916	build(deps): bump serde_json from 1.0.121 to 1.0.122 (#32916)
    72b3fd56e165f80b92ba35b787d4aa7899f6cc8c	https://github.com/servo/servo/pull/32910	script: Fix two build warnings about unused imports (#32910)
+   974c9dc89a70ff341c19d751a8d7c00c81989dea	https://github.com/servo/servo/pull/32854	layout: Compute intrinsic sizes for flex items and flex containers (#32854)
    7495ba20a51fb2bea033d115e98db5ea07e68a4b	https://github.com/servo/servo/pull/32909	Select servo feature on servo_arc (#32909)
>>> 2024-08-04T06:06:53Z
+   7c2c383bb1fb15dfeea1e0f33af2e42b407af4e1	https://github.com/servo/servo/pull/32914	Fix save to image on Windows (#32914)
    bb176514c64b50011ee0be5cfb10f0cbce48cd93	https://github.com/servo/servo/pull/32926	Pass AppInfo to OpenXrDiscovery (#32926)
+   f3fe11c382d85f47f2adf3099a3b92c4202c52f1	https://github.com/servo/servo/pull/32924	Enabled WAV decoding support in gstreamer (#32924)
f3bec0aed386615e850b9e24b74c697624c32bce	https://github.com/servo/servo/pull/32923	bindings: Convert certain Exceptions into Promise rejections (#32923)
+   fd832816572e26cafb8207d3710bd704f2617758	https://github.com/servo/servo/pull/32860	Implement WebXR Gamepads Module (#32860)
    0672eca7496bd54001e4625f7987d3e4053a3914	https://github.com/servo/servo/pull/32917	build(deps): bump malloc_size_of_derive from 0.1.2 to 0.1.3 (#32917)
>>> 2024-08-05T06:07:48Z
+   5e59988c87c40e84b0228021798455175699e824	https://github.com/servo/servo/pull/32925	webgpu: Use wgpu's instead of string errors and update limits handling (#32925)
+   b366a02318def70948f8ff6ed321e433b721ece4	https://github.com/servo/servo/pull/32928	build: Speed up first run after build on macOS (#32928)
+   8052027dd497241157fc74365c5c78fde028b8a0	https://github.com/servo/servo/pull/32927	ci: allow android builds on forks to skip keystore configuration (#32927)
>>> 2024-08-06T06:08:20Z
+   b50c1cfaaab6eb7bbef4327a7cdca540a29cbddb	https://github.com/servo/servo/pull/32945	Nix: Bump nixpkgs (#32945)
    1e30642d75bac6f545803d50a08a4d8f79aae123	https://github.com/servo/servo/pull/32944	build(deps): bump ttf-parser from 0.24.0 to 0.24.1 (#32944)
    83821fdec51918b0829e2fba5cbb86fe425e24ee	https://github.com/servo/servo/pull/32943	build(deps): bump xml-rs from 0.8.20 to 0.8.21 (#32943)
    a33b66ade5f577e0d85483ca10ec232f361d2d27	https://github.com/servo/servo/pull/32941	build(deps): bump serde_test from 1.0.176 to 1.0.177 (#32941)
    551fbdd092dab4013b667238174118b96a195275	https://github.com/servo/servo/pull/32940	build(deps): bump ppv-lite86 from 0.2.19 to 0.2.20 (#32940)
    a348e68086cd2628e316388f46692cc8d99fa59f	https://github.com/servo/servo/pull/32939	build(deps): bump flate2 from 1.0.30 to 1.0.31 (#32939)
    2443b1784855fe7c4b849aee4338bc5706331462	https://github.com/servo/servo/pull/32938	build(deps): bump tempfile from 3.10.1 to 3.11.0 (#32938)
    6ae64b2716285d419fc6dcce65e2a82a2cea03cd	https://github.com/servo/servo/pull/32937	build(deps): bump scc from 2.1.7 to 2.1.8 (#32937)
+   0ce9ce8dc02a9812795174890b507a7a7fb72fd4	https://github.com/servo/servo/pull/32936	mach: Add support for paths with spaces on Windows (#32936)
+   f1602005a085ec279a7280ccae1ea3ceffdb0eca	https://github.com/servo/servo/pull/32930	deps: Upgrade to WebRender 0.65 (#32930)
+   babc844c93755e032e724adb81cfb235090c4fdb	https://github.com/servo/servo/pull/32888	DevTools: Allow modification of attributes (#32888)
+   4d49b04668c3793bbb5dd8460a9d6f55d7f6538e	https://github.com/servo/servo/pull/32933	Add surface methods to RenderingContext (#32933)
    45aa296b2658e47eea38134298351a20a74e0fa6	https://github.com/servo/servo/pull/32932	build: Fix a print statement when repackaging GStreamer (#32932)
    10b06f01292a4d9b7d73a41fe134ad355e05b2a0	https://github.com/servo/servo/pull/32911	layout: Improve documentation and code structure in `FlexItemBox::automatic_min_size` (#32911)
>>> 2024-08-07T06:24:11Z
+   a3f588832b104421030c162cd782df02b055bf08	https://github.com/servo/servo/pull/32951	Bump mozjs-sys to 128.0-6 (#32951)
    d2e620e03e5bf90710e2b2dad19514ace945548b	https://github.com/servo/servo/pull/32955	build(deps): bump bytemuck from 1.16.1 to 1.16.3 (#32955)
    63265b8c475dd333ab26c2647d7ec6c2a0a17417	https://github.com/servo/servo/pull/32954	build(deps): bump target-lexicon from 0.12.15 to 0.12.16 (#32954)
+   c9fbe018f18d1cff8a4b30261ea4b1e981ef435b	https://github.com/servo/servo/pull/32947	testing: Trigger a crash more reliably when panicking and hard fail is active (#32947)
    89d20fc40116e9a35ed4fe2b5ee07e0382babc19	https://github.com/servo/servo/pull/32953	build(deps): bump toml_datetime from 0.6.7 to 0.6.8 (#32953)
    49aa129d22a8d9c61aceb638e9c58f7ff79b512b	https://github.com/servo/servo/pull/32952	build(deps): bump scc from 2.1.8 to 2.1.9 (#32952)
68f4b359c53b241e0ef82b640e84d8de70cfb805	https://github.com/servo/servo/pull/32950	Add exception to rejection logic in `generic_call` (#32950)
+   1d464a576a6506196ff10e2c5bbee1969272fc54	https://github.com/servo/servo/pull/32906	layout: Add support for `align-content: stretch` (#32906)
+   3800922cde6f1c5698a931183de9dbcd3d5d7e4e	https://github.com/servo/servo/pull/32897	Fix panic in Webrender during shutdown (#32897)
+   28430bad0e7a4d4c11710d61fbaf1c598bffa87d	https://github.com/servo/servo/pull/32949	Fix visual_studio.py to call vswhere with -utf8 (#32949)
    3f339d6856283dc4839f6378df5df1ddbedcb5d6	https://github.com/servo/servo/pull/32946	webrender_traits: update closure in with_front_buffer to FnOnce (#32946)
    23df681479e20d099abae2852c2107b395fb09a1	https://github.com/servo/servo/pull/32942	build(deps): bump winapi-util from 0.1.8 to 0.1.9 (#32942)
>>> 2024-08-08T06:07:41Z
    1379cd5779657774a14303ff26269df2a03bb3aa	https://github.com/servo/servo/pull/32965	build(deps): bump tempfile from 3.11.0 to 3.12.0 (#32965)
    db23bc7b121e85c79ab5fb93a55f9b751352e542	https://github.com/servo/servo/pull/32964	build(deps): bump object from 0.36.2 to 0.36.3 (#32964)
    206d515c32b4541be59d8a0f1f88c5b7ca2ffa25	https://github.com/servo/servo/pull/32963	build(deps): bump cc from 1.1.7 to 1.1.8 (#32963)
3fca6e015f1f0e9e375a87d41f37fe56720cfaa5	https://github.com/servo/servo/pull/32782	script: Properly handle removed iframes in `GlobalScope::get_referrer` (#32782)
    9cb0e74cdca0c42b8c47a555de24eb1caffbca14	https://github.com/servo/servo/pull/32959	Update web-platform-tests to revision b'3634d5a63f2fa3969616396d95537c91c3348fe5' (#32959)
+   3c271fb2989fa838473ab006397c7a9d8c3b4b21	https://github.com/servo/servo/pull/32896	Update to rust 1.80.0 (#32896)
>>> 2024-08-09T06:15:38Z
+   24b1404d12be64db5b173f5648de71a1bcf7792e	https://github.com/servo/servo/pull/32981	Update wgpu (#32981)
    77ce73e4c60b180f2d951abb1e85008c73c10524	https://github.com/servo/servo/pull/32983	build(deps): bump serde from 1.0.204 to 1.0.205 (#32983)
+   8fab6911d16577bf98f5179dab7e0d75e57bc5ba	https://github.com/servo/servo/pull/32973	script: dont unwrap in header set (#32973)
+   b8cf0cf9afa03d5e2ba3f8a4727e4de00ab63eb2	https://github.com/servo/servo/pull/32636	webgpu: Implement proper async pipeline creation and GPUPipelineError (#32636)
+   08eb4faf4d2805283137a19739b092cd7ddff600	https://github.com/servo/servo/pull/32960	Initial structuredClone implementation (#32960)
f989d3776eca7c4a21f03a406a11c1b1228b285e	https://github.com/servo/servo/pull/32966	separate Queue&Device Id (#32966)
    a5df51ea56dd7116b5fb95acd9c88f123bdebbfc	https://github.com/servo/servo/pull/32956	Refine crown annotations for HTML parser. (#32956)
>>> 2024-08-10T06:15:44Z
    2ebb71f08a9e2521a2fd277c2bc2b54b9e21dd8d	https://github.com/servo/servo/pull/32991	Set the cfg properly for the production-stripped profile (#32991)
a1d3649f7c282aec9220ab67b203297fe33e5a07	https://github.com/servo/servo/pull/32574	Fix ordering of documents (#32574)
    c6a6319502c3df4bf401d394a27854aa1f267658	https://github.com/servo/servo/pull/32982	build(deps): bump windows-sys from 0.52.0 to 0.59.0 (#32982)
    4eae4e29fa92d1684e5a1dcff1d4a12020a284af	https://github.com/servo/servo/pull/32984	Fix incorrect target_os value. (#32984)
>>> 2024-08-11T06:01:54Z
    1af3ad8a7466a372c9e9f39f0d06e973a75a427e	https://github.com/servo/servo/pull/33000	Update web-platform-tests to revision b'3b3beee1bf2469013583bafe702f2d4821d76c1f' (#33000)
    71898dae179df6b873994211611aee4884cdc974	https://github.com/servo/servo/pull/32993	build(deps): bump filetime from 0.2.23 to 0.2.24 (#32993)
    1a58dba03ecaa5b67df47b3e7c7c592cadb6f145	https://github.com/servo/servo/pull/32998	Use correct feature name for JS backtraces. (#32998)
>>> 2024-08-12T06:18:51Z
+   5520a9eb5089d8441718162452848159ed51ffca	https://github.com/servo/servo/pull/33001	webaudio: Implement IIRFilterNode (#33001)
>>> 2024-08-13T06:24:20Z
    4744debdfd5e829c753c46a7f8088576b79dbd96	https://github.com/servo/servo/pull/33021	build(deps): bump serde_json from 1.0.122 to 1.0.124 (#33021)
    2d52b51e763a487016d2a5d95be5fd61f32ef60e	https://github.com/servo/servo/pull/33019	build(deps): bump xcursor from 0.3.6 to 0.3.8 (#33019)
    f33190ae7943660abe247a35c07d989a72139544	https://github.com/servo/servo/pull/33020	build(deps): bump mio from 1.0.1 to 1.0.2 (#33020)
    26cd4a84e53398df0328b0dce4600859fad1290c	https://github.com/servo/servo/pull/33018	build(deps): bump serde from 1.0.205 to 1.0.206 (#33018)
    3f1149fbdd8d6543e71a25e9c936dd0fa8d7508a	https://github.com/servo/servo/pull/33016	build(deps): bump scc from 2.1.9 to 2.1.13 (#33016)
    d0b5080b5e4409759d942a8cc8f910f001103dfc	https://github.com/servo/servo/pull/33014	build(deps): bump syn from 2.0.72 to 2.0.74 (#33014)
    1f3c193339f0d0a6a3f486894c2d35e5cccd11f9	https://github.com/servo/servo/pull/33017	build(deps): bump core-foundation-sys from 0.8.6 to 0.8.7 (#33017)
    ebf28fc7844d84c5d8098c1adbb452299ad8115b	https://github.com/servo/servo/pull/33015	build(deps): bump polling from 3.7.2 to 3.7.3 (#33015)
    93b43703e63c423a0e309ce28f73d3c51917dc6e	https://github.com/servo/servo/pull/33013	build(deps): bump cc from 1.1.8 to 1.1.10 (#33013)
+   564ba5969f1fb7a609e1ffc2a8f1b7ae48744ee8	https://github.com/servo/servo/pull/32961	layout: Non-auto `z-index` should always make stacking contexts for flex items (#32961)
+   d29e937f7e1f246f069c001ab60846c74046630c	https://github.com/servo/servo/pull/33008	Update Rust to 1.80.1 (#33008)
+   df8ccafa7c01c162bebd00aefe557a1bfc0f300b	https://github.com/servo/servo/pull/33002	Fix: Return error and avoid panicking in SetOpener function (#33002)
    a797969efed10c46c7cf93e5eb7a03b52d6ca7bc	https://github.com/servo/servo/pull/33004	Replace the lazy_static crate whth `std::sync::LazyLock` in components/script (#33004)
+   f38d1574bcb27449b8878192ac0ea3ba2ce824e7	https://github.com/servo/servo/pull/32996	Allow navigations that include cross-origin redirects to succeed. (#32996)
>>> 2024-08-14T06:09:01Z
+   3aef023368d522251d72443e1b5c03c2fc3208d3	https://github.com/servo/servo/pull/33029	ohos: Fix x86_64-unknown-linux-ohos (#33029)
+   478d95d2454f15184b45c5887af05c1cf51d2b23	https://github.com/servo/servo/pull/33038	Dedupliate `syn` (#33038)
    fb6b56cdda03d2bf218ec079a5298a9ce8c9eb4e	https://github.com/servo/servo/pull/33035	build(deps): bump cpufeatures from 0.2.12 to 0.2.13 (#33035)
    c922ab4b5233e55c9ddbebccbe544a2051d85ead	https://github.com/servo/servo/pull/33040	build(deps): bump serde from 1.0.206 to 1.0.207 (#33040)
    a0a83bad961a57466cd33ef71f4a7a4e15859080	https://github.com/servo/servo/pull/33039	build(deps): bump js-sys from 0.3.69 to 0.3.70 (#33039)
    0c276aeea593bb0e19d19a836b4adb1358ffc0d9	https://github.com/servo/servo/pull/33037	build(deps): bump scc from 2.1.13 to 2.1.14 (#33037)
    89c456b6d1da549139b0a25506f0ab4f36a168a5	https://github.com/servo/servo/pull/33036	build(deps): bump wasm-bindgen from 0.2.92 to 0.2.93 (#33036)
    3c19982040f6337637645b8c843cfbe4fd16601b	https://github.com/servo/servo/pull/33033	ci: Only export WPT test changes on the `main` branch (#33033)
+   8582678e4b97818629d5039a28b7fc6de0b23a9d	https://github.com/servo/servo/pull/32913	Properly handle subpixel units when dividing space between flex lines (#32913)
    5d6840873a53c57432ee6f48338d5c5261f12905	https://github.com/servo/servo/pull/33026	clippy: Fix missing indentation in comments and remove on unecessary cast (#33026)
    ea5cf751696ec8c24e7303b042d534a32c2a9a24	https://github.com/servo/servo/pull/33003	clippy: Fix various clippy warnings throughout the code  (#33003)
0d137d276a3a2ad3749750c0e34ebbfd91511106	https://github.com/servo/servo/pull/33007	webxr: Add missing IDL members from AR Module (#33007)
>>> 2024-08-15T06:08:05Z
+   a6638c195242105ec4cf840dd435d68a08c93843	https://github.com/servo/servo/pull/33048	Update mozjs and use release libz-sys (#33048)
825d6f10e9cc837219aaa4db480405a31c5388a7	https://github.com/servo/servo/pull/32958	webxr: Update hand input to match latest spec (#32958)
    057873c94a016b00d205f342d8929eb50365ac91	https://github.com/servo/servo/pull/33054	Remove unused constant from `components/net/fetch/methods.rs` (#33054)
    c438bfddd0528c3b3b0e5775be151d5d8c3e873e	https://github.com/servo/servo/pull/33053	build(deps): bump indexmap from 2.3.0 to 2.4.0 (#33053)
    6b0680c779bdb744f22cf572458cbd7810a147ee	https://github.com/servo/servo/pull/33052	build(deps): bump web-sys from 0.3.69 to 0.3.70 (#33052)
    d3209040ced94230298acc1c9173eca5f860ab18	https://github.com/servo/servo/pull/33051	build(deps): bump cc from 1.1.10 to 1.1.11 (#33051)
    cfbc10aefeab22c213be19d5c3bdfb910d0aa2c9	https://github.com/servo/servo/pull/33050	build(deps): bump wasm-bindgen-futures from 0.4.42 to 0.4.43 (#33050)
+   ad85dd10e3aa6124e3f8a9504d9c6efa178b8d34	https://github.com/servo/servo/pull/33049	Replace lazy_static with std::sync::LazyLock in components/fonts (#33049)
+   7633bdccd229eeba46bba9508564a96066fd4f91	https://github.com/servo/servo/pull/33031	layout: Initial implementation of `flex-direction: column` and `column-reverse` (#33031)
+   c059bab6f4aa920326167b861a3ae17f53001070	https://github.com/servo/servo/pull/33047	Dont use lazy static to construct mutexes (#33047)
+   d941d2fd67e7c2cd9859ae743c76b0238679bfe4	https://github.com/servo/servo/pull/33030	layout: Convert the FragmentTree to physical geometry (#33030)
+   65f90ff1fd82758aa7644ada7bb75d34291c363f	https://github.com/servo/servo/pull/33046	Replace the lazy_static crate with std::sync::LazyLock in components/net (#33046)
    6be99241c64bb5c8c4df6be3c37a5f53829cd499	https://github.com/servo/servo/pull/33043	Fix warnings after latest rust upgrade (#33043)
    380348e4df8211838680dedb76c117f101ee9bba	https://github.com/servo/servo/pull/33041	build(deps): bump tower-service from 0.3.2 to 0.3.3 (#33041)
>>> 2024-08-16T06:12:08Z
+   4cc1b6854616ae5f4b2455aedcd3e1fe9251a6a1	https://github.com/servo/servo/pull/33078	Remove lazy static (#33078)
4b3ed4b68489342f41693243b25711079070dcd1	https://github.com/servo/servo/pull/33076	 ohos: Fix log filtering (#33076)
+   69185c4af156e66c2b69de1dbb7ff9faf10fd5aa	https://github.com/servo/servo/pull/33056	Ensure parsers initiated from DOMParser always complete. (#33056)
+   3cc91e655f4119d15fa226cabe8e2f66be3d3c58	https://github.com/servo/servo/pull/33067	Remove many explicit reflow calls (#33067)
    a34920b6058016f026c2b710224b9227826fcf85	https://github.com/servo/servo/pull/33072	fix(clippy): Clippy suggestions in components/script/dom/* (#33072)
    386a067c4b83b9fd60200e07c9668aba2a667944	https://github.com/servo/servo/pull/33071	build(deps): bump is-terminal from 0.4.12 to 0.4.13 (#33071)
    0710209557e4048137b1030da566c6bd5d1e133e	https://github.com/servo/servo/pull/33070	build(deps): bump serde_json from 1.0.124 to 1.0.125 (#33070)
    bcfc642f2f7a0b0e329230637a914fc7b3fc1999	https://github.com/servo/servo/pull/33069	build(deps): bump cc from 1.1.11 to 1.1.12 (#33069)
    e4d0af8d9120d8172c270becd81e1c25c51ba478	https://github.com/servo/servo/pull/33066	build(deps): bump serde from 1.0.207 to 1.0.208 (#33066)
+   016ff5dfa67d05b5c5d1d3fc42bf9f4fbeb537c1	https://github.com/servo/servo/pull/33065	Replace lazy_static crate with `std::sync::LazyLock` in layout and config (#33065)
c01b733523085bb9365601c252b7b49154383631	https://github.com/servo/servo/pull/33062	Update codegen for GetOpener:inRealms in Bindings.conf (#33062)
+   86c4e014b40805ba7048f6357e4276680d3a7451	https://github.com/servo/servo/pull/33060	Replace the lazy_static crate with `std::sync::LazyLock` in components/shared (#33060)
+   8f82b2a7cbc086a6e939c9e0c3a7a3e11e512df5	https://github.com/servo/servo/pull/33045	Use FontInstanceFlags::SUBPIXEL_POSITION for font instances on Windows (#33045)
97c84b6127bbe56821f8db661e88400cd646526c	https://github.com/servo/servo/pull/32858	ohos/android: Redirect stdout/stderr to `log` sink (#32858)
353ceb0ffb7aa48bede60e031872218ebaaba839	https://github.com/servo/servo/pull/33058	Update WebXR WPT expectations (#33058)
+   8159f032880e72accba54ce3175062423fcdeef0	https://github.com/servo/servo/pull/33032	layout: Support `start` and `end` values for flexbox `align-self` (#33032)
>>> 2024-08-17T06:09:14Z
20273b062af969152635306c3df2a3a1364ac4d1	https://github.com/servo/servo/pull/33059	webxr: Update XRSession to latest spec (#33059)
    f0045a76866f2d56d6a01aaf93ec20177dad778a	https://github.com/servo/servo/pull/33095	remove usage of legacy numeric operations in script (#33095)
    09cac6430bfc98dace01ccf2a0af40c2420a4d19	https://github.com/servo/servo/pull/33091	build(deps): bump libc from 0.2.155 to 0.2.156 (#33091)
    842bd607d42b116b4f717f42c4c3ee81f9fd86e8	https://github.com/servo/servo/pull/33086	build(deps): bump bytemuck_derive from 1.7.0 to 1.7.1 (#33086)
    a8fbfe712f05ed45375592a8ac94f8bbe56046c4	https://github.com/servo/servo/pull/33092	build(deps): bump webxr from `dd76329` to `08a6d70` (#33092)
    23c2040f2b196f596add050ce8e5915762d8390d	https://github.com/servo/servo/pull/33093	build(deps): bump cc from 1.1.12 to 1.1.13 (#33093)
    10e2dc7a63febed33466dfbee16a0e2091b72055	https://github.com/servo/servo/pull/33090	build(deps): bump bytemuck from 1.16.3 to 1.17.0 (#33090)
    c6d6823b85272b7e6bc5146aa2fdb9f11b8e9e4f	https://github.com/servo/servo/pull/33089	build(deps): bump scc from 2.1.14 to 2.1.16 (#33089)
    4bdf6403d072c03573da616c6da9a56007a7a35a	https://github.com/servo/servo/pull/33088	build(deps): bump surfman from 0.9.5 to 0.9.6 (#33088)
+   3829e91662c2f139d9514aa1b5ede4462000f43a	https://github.com/servo/servo/pull/33085	Handle failed string conversions in console.log. (#33085)
+   4df7a1af25b46146fc5a580ad2e50f2ebe91e154	https://github.com/servo/servo/pull/32820	Support HTML parser reentrancy (#32820)
    d44c0f7e5dd9952506dfc491975cc84d7dac111a	https://github.com/servo/servo/pull/33083	mach: remove unused maven packaging code (#33083)
+   0d94a8acd25cd90dd822dce22f7e19706d101e2a	https://github.com/servo/servo/pull/33082	layout: Prepare for bidi by guarding all access to `writing-mode` (#33082)
    3d3621b65265607eaa33f66c9636356a4dfe2ba2	https://github.com/servo/servo/pull/33079	Update stylo for latest changes. (#33079)
+   ce5ebbcf7772afdb82d1cdaf318c3ebd6cee3a10	https://github.com/servo/servo/pull/33073	legacy-layout: Fix display list building after WebRender upgrade (#33073)
+   6816d11f887ea0f72943d900654c999d763772b5	https://github.com/servo/servo/pull/33080	replace once_cell (#33080)
>>> 2024-08-18T06:03:02Z
db312319ae89989a94d2047b04d3d58809e8887b	https://github.com/servo/servo/pull/33101	fix: Replace callargs_is_constructing with is_constructing method (#33101)
>>> 2024-08-19T06:08:41Z
    e078353bf01aebe5703b29c68ac59304cf6414f7	https://github.com/servo/servo/pull/33112	Fix race in WebXR WPT test setup (#33112)
    a50e6a503e48da26fb270eb54d869bd515557da7	https://github.com/servo/servo/pull/33109	Remove unnecessary `unsafe` block (#33109)
a24e92778afd60c775b5145a4ad7dc260fa94b62	https://github.com/servo/servo/pull/33023	fix: add error handling to BaseAudioContext::new_inherited (#33023)
1ef3e107bd194fdf0ca1da66d9167046538366d7	https://github.com/servo/servo/pull/33097	Add makeXRCompatible for WebGL2, update WebXR WPT expectations (#33097)
280063eee2662a1bea925310652f4e9922051afe	https://github.com/servo/servo/pull/33096	Make string formatting more consistent in `CodegenRust.py` (#33096)
    6aee84f0d10e3484b6113907f1b51e7dfe77f0bc	https://github.com/servo/servo/pull/33103	Update data-url to 0.3 (#33103)
>>> 2024-08-20T06:07:56Z
+   91adf39de78626df8c04c89261c4a925e8e7f689	https://github.com/servo/servo/pull/33122	Fix panic in embedded-opener-remove-frame (#33122)
    32a298f3a279161ae2ec8885a17c41246f3677c3	https://github.com/servo/servo/pull/33131	build(deps): bump libc from 0.2.156 to 0.2.158 (#33131)
    9e2536c877d921ced87d35df9fb97a9a7721664c	https://github.com/servo/servo/pull/33130	build(deps): bump syn from 2.0.74 to 2.0.75 (#33130)
    40e0052ef73784de96faab3bd0f6081ae5e641b1	https://github.com/servo/servo/pull/33129	build(deps): bump webxr from `08a6d70` to `474d538` (#33129)
    6a7d5210e9f66dcca6264942d9356b5e6ba60149	https://github.com/servo/servo/pull/33127	build(deps): bump redox_users from 0.4.3 to 0.4.6 (#33127)
    c5751af926ebd6438fc3f49d2529a732bf5cd497	https://github.com/servo/servo/pull/33128	build(deps): bump ohos-sys from 0.2.1 to 0.2.2 (#33128)
    54cb8d9a366ae0b425d3961a644a830b43dda896	https://github.com/servo/servo/pull/33126	build(deps): bump tokio from 1.39.2 to 1.39.3 (#33126)
    c5d3c29b7959f3f836a5a69bbd367664c86c1a86	https://github.com/servo/servo/pull/33125	build(deps): bump arrayvec from 0.7.4 to 0.7.6 (#33125)
+   b3280fe07113b89c38b58b1a7c6a8031a9b998ff	https://github.com/servo/servo/pull/33124	Update surfman to fix macOS webgl crashes. (#33124)
94ff89a5e4c1c99118b6240845bb283d58ebb149	https://github.com/servo/servo/pull/33009	webgpu: Sync various parts of spec (#33009)
    f45c98496e0e473b404fe898ba7ef184c8a46b33	https://github.com/servo/servo/pull/33120	Upgrade font-kit, raqote, and stop using `dirs-next` (#33120)
+   2f6745c0c68388460bde8f5167c45b6f78316cd8	https://github.com/servo/servo/pull/33068	layout: Layout for column flex-basis and minimum automatic size determination (#33068)
+   2a31fddc0b6f3ae89bd36cff3be1062e54c4a64c	https://github.com/servo/servo/pull/33074	Refactor `GlyphStore::iter_glyphs_for_byte_range` without recursion (#33074)
    d59a7f62f8f49c810a6d42b154d39bb8440eb11e	https://github.com/servo/servo/pull/33116	Update web-platform-tests to revision b'ebe057a1153d34042bac1ff3dc944220876f69ec' (#33116)
b5fe99ba5dd548b4e9d5b5afc3e798fe4811a5fe	https://github.com/servo/servo/pull/33115	wpt-tests-to-run -> wpt-args and make them last so they can override already provide (#33115)
84b5b6442491560d46807967026bb5ef3a86fcbf	https://github.com/servo/servo/pull/33111	Fix incorrect documentation and add `track_caller` to DomRefCell methods (#33111)
3576c02ae29180cc06fc2f6f4396a2f68c3ca1b5	https://github.com/servo/servo/pull/33113	ohos: Remove custom touch history code (#33113)
>>> 2024-08-21T06:05:01Z
8e224cb4d3730899eba2f01c26cb1bd43caa8812	https://github.com/servo/servo/pull/33145	webxr: Update XRView to latest spec (#33145)
    75b817cca38b40b00041e1b2767222d471cff669	https://github.com/servo/servo/pull/33143	build(deps): bump unicode-xid from 0.2.4 to 0.2.5 (#33143)
    1492624bb5a9f593b85b3b7debfca446f0a7cfdc	https://github.com/servo/servo/pull/33142	build(deps): bump unicode-properties from 0.1.1 to 0.1.2 (#33142)
+   bc5235827f655fc3aeedb18afe0d82451d41308f	https://github.com/servo/servo/pull/33133	Various borrow hazard fixes (#33133)
c00cd1326a5a0ec0caf40cc619389b6ba49da381	https://github.com/servo/servo/pull/33135	Take into account the intrinsic block size when computing the main size of a column flex container (#33135)
cf98d8d7ece88f74b7617bb9481f25cad1491134	https://github.com/servo/servo/pull/33134	Update url setters test result (#33134)
7e4979c8520576286adb4f52ef5d1d247d27f229	https://github.com/servo/servo/pull/33102	webxr: Update XRFrame to latest spec (#33102)
>>> 2024-08-22T06:03:22Z
562d32c0519d58052cea681a696546fd4818bd3a	https://github.com/servo/servo/pull/33157	webxr: Update XRWebGLLayer interface to latest spec (#33157)
    cde10241c32208fbce0cb87f2d6a6deeca2c74a4	https://github.com/servo/servo/pull/33141	build(deps): bump flate2 from 1.0.31 to 1.0.32 (#33141)
+   0e56241c1be52efd52e7ba4c999fec0bf29ce2de	https://github.com/servo/servo/pull/33153	background_hang_monitor: Add musl compatibility (#33153)
7501e3e12fca16d906b88608363db768b29f822d	https://github.com/servo/servo/pull/33155	webxr: Update XRInputSource interface to latest spec (#33155)
+   56280c62425bcf9478e613d26bca8704a898b5b1	https://github.com/servo/servo/pull/33148	layout: Add initial support for bidirectional text (BiDi) (#33148)
65bd5a3b9982c9af453fe97134e4f91e55b1df19	https://github.com/servo/servo/pull/33147	webgpu: Align `writeBuffer` with spec (#33147)
+   3b8c638a845ac21cb42a87434130dbd8e7b5107e	https://github.com/servo/servo/pull/33098	Fix floating point errors in table layout (#33098)
fb22dfb3738089e1fea55bde65f0a4effa865958	https://github.com/servo/servo/pull/33146	webxr: Update XRPose interface to latest spec (#33146)
>>> 2024-08-23T06:09:10Z
    e956b53827e6c4ad6d3c2b0d9281dfc0e37b89d9	https://github.com/servo/servo/pull/33149	layout: Clean up inline layout data structures (#33149)
+   60ef6bc46125d34e492a4294622e2791f3c619b5	https://github.com/servo/servo/pull/33144	Start marking functions that can transitively trigger a GC (#33144)
+   9a1051c9170abc8e40c43b2a6be712a3ff4b523f	https://github.com/servo/servo/pull/33158	Implement crypto.randomUUID() (#33158)
+   663a92a5df39f5daef091624b6e29c228dcecbc3	https://github.com/servo/servo/pull/33104	make protocol handlers registrable (#33104)
>>> 2024-08-24T06:04:46Z
+   2db9032e72bda6108b4eb5988eaf164141a61d64	https://github.com/servo/servo/pull/33151	layout: Add support for flex items with `position: relative` (#33151)
    b9f02cf7730dae8c2bf2bcd0e2eeeae155178bb9	https://github.com/servo/servo/pull/33167	build(deps): bump quote from 1.0.36 to 1.0.37 (#33167)
    1165190c8ef87f912e0cbe85b11f36fe2910c2cb	https://github.com/servo/servo/pull/33166	build(deps): bump cc from 1.1.13 to 1.1.14 (#33166)
+   78e2691d3f396c9811bd27d69877cade365e5d78	https://github.com/servo/servo/pull/32979	shaping: Don't assume there's a space glyph when rendering tabs (#32979)
+   ebdae6094ecc105be10fb2e59b13cf63773a4c10	https://github.com/servo/servo/pull/33150	CI: Add separate Lint&Tidy check and remove test-tidy from linux (#33150)
    0afcb83e9f13bdaeb0ef01b4809ed298b9f24ac0	https://github.com/servo/servo/pull/33077	Print reason when tests are skipped. (#33077)
>>> 2024-08-25T06:05:02Z
    6caaa0c955fa7535554d50e46c1eb91bc2d2ba3b	https://github.com/servo/servo/pull/33178	Update web-platform-tests to revision b'd988aeeb33edc4d452899921799b8bed69fff65d' (#33178)
+   7582afebeca965f8d12a6594284969ee55f6742f	https://github.com/servo/servo/pull/33165	script: Update list of non-TS pseudo classes supported by Servo (#33165)
+   ad45fa0a196a5d8f9655c41afc6b5b42570f5340	https://github.com/servo/servo/pull/32980	script: Fix panic in `htmlimageelement.rs` using `str::find()` to find character boundaries. (#32980)
e85491b5fc0ccbedfa312b82edf37d8e1cecc780	https://github.com/servo/servo/pull/33163	Allow prefs to be overridden from a file and set WPT-specific prefs from file (#33163)
>>> 2024-08-26T06:09:38Z
+   c028b5c2993aceba5c4268e95d01e9dc56baeca7	https://github.com/servo/servo/pull/33176	webxr: Implement XRBoundedReferenceSpace (#33176)
e0e562137ce8d985c5bda8e65add5edb8409c25f	https://github.com/servo/servo/pull/33185	Add fallback value for data['message'] (#33185)
+   a3f5a8482d1bdcf2fd4ed4fc16c7aaa7fc5d4e42	https://github.com/servo/servo/pull/33173	Fix panic in abort-block-bfcache.window.js (#33173)
88d87702147b296de230c120e636fe97f8466e96	https://github.com/servo/servo/pull/33169	Use global exports from derives (#33169)
+   6357998ede902de7fb75354283f4fabbc141c28c	https://github.com/servo/servo/pull/33025	DevTools: Inspect node styles (#33025)
    67e2bb0ee6039e98f361e33617c0401a52963daf	https://github.com/servo/servo/pull/33174	script: fix `querySelector` returning the root (#33174)
+   c79d9e68a39bc6c2ff396f8cb843d3d9abb01b1f	https://github.com/servo/servo/pull/33177	Use webrender `UploadMethod::Immediate` with ANGLE (#33177)
>>> 2024-08-27T06:07:55Z
    ba4e081e8eddf8bee186a19a15f3f5dfe9c62dc9	https://github.com/servo/servo/pull/33196	build(deps): bump serde from 1.0.208 to 1.0.209 (#33196)
    f84da1521a76371c8f3a6fd7815e7e9a4ad3384a	https://github.com/servo/servo/pull/33198	build(deps): bump fastrand from 2.1.0 to 2.1.1 (#33198)
    4b8ca674fc0eac3eb2ece389ee6274f39326d91a	https://github.com/servo/servo/pull/33197	build(deps): bump syn from 2.0.75 to 2.0.76 (#33197)
    00ba0dfa2efcb4bf64448765fbb98a9eacdf476b	https://github.com/servo/servo/pull/33194	build(deps): bump libz-sys from 1.1.19 to 1.1.20 (#33194)
    806d960d3820967c4c841561b34306ec25ab7514	https://github.com/servo/servo/pull/33195	build(deps): bump serde_json from 1.0.125 to 1.0.127 (#33195)
    cdedb57aee1e92255ec9af6f8bce774cfa12166a	https://github.com/servo/servo/pull/33193	build(deps): bump cc from 1.1.14 to 1.1.15 (#33193)
    8f14f7bee628009f5a1a45d92e677a7d8584cc12	https://github.com/servo/servo/pull/33192	build(deps): bump flate2 from 1.0.32 to 1.0.33 (#33192)
+   7b7020a8d429d4b58bcaf09615cdc246becfcfe5	https://github.com/servo/servo/pull/33186	layout: Enable flexbox by default on non-legacy layout (#33186)
b6d5ac09b0b2acbb0f5b00232e53d0111a159063	https://github.com/servo/servo/pull/33114	mach: introduce `BuildTarget` abstraction (#33114)
4397d8a02156a009d16d8b79796b1e54ca635624	https://github.com/servo/servo/pull/33187	Add `dom.allow_scripts_to_close_windows` pref. (#33187)
+   0e6b55c71d8e782d626afb34042cf41b9c2021b5	https://github.com/servo/servo/pull/33179	Redesigned minibrowser toolbar to use icons instead of text (#33179)
    e5caa725da54e58aa2e545f2a975def10d943ec5	https://github.com/servo/servo/pull/33175	Fix a memory leak in `components/script/script_runtime.rs` and add more leak suppressions (#33175)
>>> 2024-08-28T05:55:51Z
    6de7848aff46920e1f8235ed3bd57aae7f350c26	https://github.com/servo/servo/pull/33218	android: Remove unused imports in android.rs (#33218)
    2037884469bae64c993d1e54d988e58f254a6b62	https://github.com/servo/servo/pull/33215	Fix clippy wanings in layout (#33215)
+   12661c1920a14c29b84e005ff4a3564bedcfa821	https://github.com/servo/servo/pull/33209	Update wgpu (#33209)
+   1b48bd18aa855cc966869dd81530aa0da3eea4f3	https://github.com/servo/servo/pull/33100	Basic tab strip for the minibrowser (#33100)
    a0ff57cea1675e7ec9ee8657d80024a110a0092a	https://github.com/servo/servo/pull/33214	build(deps): bump bytemuck from 1.17.0 to 1.17.1 (#33214)
    87027d2e5c02b51fea0cb49c1cd4ba4f85debd3a	https://github.com/servo/servo/pull/33210	Remove measurement of layout query wait time (#33210)
    50eb69a7e0f9d70d9c395eadb03fb7bbe2ae6724	https://github.com/servo/servo/pull/33208	Allow creating a `ContentSizes` from `Au` (#33208)
    dbd0a79b3e45b60a29d26c0af20297ab260f2a8b	https://github.com/servo/servo/pull/33207	Allow caching `IndependentFormattingContext::inline_content_sizes()` (#33207)
253723409022546475240b04843ed19ad321d847	https://github.com/servo/servo/pull/33206	ohos: Add FFI-APIs to navigate back and forward (#33206)
+   658df79d8885a337f5d5172fb8c2dc4d391cc6c8	https://github.com/servo/servo/pull/33081	CI: use self-hosted runners for Windows build jobs (#33081)
5d43d88b6c335bf786de910dacb5e898d51b961b	https://github.com/servo/servo/pull/33203	Respect min/max constraints in the block axis of block containers (#33203)
+   fef44620cc58fca454138ce77f56d49ef96bf670	https://github.com/servo/servo/pull/33200	Fixed build error on macos (#33200)
    173b6f183c6db86c68eb430b06a548f9e47264dc	https://github.com/servo/servo/pull/33202	wpt: check for wpt-prefs.json in "./servo" sub-directory (#33202)
7fce24f9d54a015db7ee813fc16c74d2feacbb12	https://github.com/servo/servo/pull/33154	webgpu: Sync `GPUBuffer` (#33154)
+   bb5926b3291877fb47d44ea376881c2d52701bbf	https://github.com/servo/servo/pull/33190	mach: Do not manually install toolchain for non-cross builds (#33190)
>>> 2024-08-29T06:01:33Z
c69acd184826b87d29a91c78b149cd413dec29bd	https://github.com/servo/servo/pull/33239	Fix run_dromaeo.py (#33239)
    b2a9184ddc48085ea5e89429740efce11d196837	https://github.com/servo/servo/pull/33238	build(deps): bump euclid from 0.22.10 to 0.22.11 (#33238)
    3d0c4f9ea8b552ef277befbeda80b739c514f52f	https://github.com/servo/servo/pull/33234	build(deps): bump filetime from 0.2.24 to 0.2.25 (#33234)
    1e47361537067f157619864ca4303236c58c4918	https://github.com/servo/servo/pull/33233	build(deps): bump webxr from `06cf810` to `7656508` (#33233)
    0a9fe1beb21a52d245a148f6478aa274a23262ad	https://github.com/servo/servo/pull/33232	build(deps): bump rustix from 0.38.34 to 0.38.35 (#33232)
    64b31b6e6a49c40bbc2acc3874f040bcd6846a92	https://github.com/servo/servo/pull/33231	build(deps): bump webrender from `c0bcdd0` to `8468e81` (#33231)
    87f437d23035fe8cc01e14ed42cdb04abc65aa6a	https://github.com/servo/servo/pull/33230	fix clippy warning for clamp pattern in `webgl_thread` (#33230)
+   7c4ba51f51febe36dda0a11a1403c5804c18746a	https://github.com/servo/servo/pull/33229	Don't allow minibrowser tab titles to be empty (#33229)
    ef42ac0dfc6bef95e2e25487bd4346bf52f2dc80	https://github.com/servo/servo/pull/33227	Fix several clippy warnings in components/devtools (#33227)
+   590527176e7c03648fcce797604d3e12da0c2c99	https://github.com/servo/servo/pull/33107	layout: Add initial support for `clip-path: [<basic-shape> || <shape-box>]` (#33107)
    f810983fd21dfa8b54e55e5068e87e6ab4dc7395	https://github.com/servo/servo/pull/33226	Remove unused import (#33226)
fe4401000065185b4d4feca4bffc5dc469848b4a	https://github.com/servo/servo/pull/33205	mach: Extract binary select into common_command_arguments (#33205)
    b29b614775b562cc57d420d29ea190d5bafef014	https://github.com/servo/servo/pull/33224	ci: Use Servo's `wpt` repository for WPT export (#33224)
bb5547a5d05b1f002d9cce3197cfb9cdcb71d33c	https://github.com/servo/servo/pull/33162	Fix panic in parser-reentrancy-customelement.window.js (#33162)
9639d36550a47bc66efcea2f05117efc318ad3c4	https://github.com/servo/servo/pull/33211	Remove `width` and `height` presentational hints for `<canvas>` (#33211)
    a6b9640c99da121641dd63765835ab55aa1d378d	https://github.com/servo/servo/pull/33222	compositor: Do not parse the Cargo.lock file while building (#33222)
    5092cece7a7b2962fdc961183c00f5f146ed0b78	https://github.com/servo/servo/pull/33220	wpt: fix the path to wpt-prefs.json on WPT runner (#33220)
>>> 2024-08-30T05:56:52Z
    13cbcf614ace35ef5178ba62ec87fcad8e8e4622	https://github.com/servo/servo/pull/33253	build(deps): bump ohos-sys from 0.2.2 to 0.3.0 (#33253)
4bf941bc8a0eff281da668dbe550fb52c0e7a983	https://github.com/servo/servo/pull/33248	Fix automatic minimum size for column flexbox (#33248)
9ea02fa4b46e92c00d3efa252e36681729d385a0	https://github.com/servo/servo/pull/33252	Fix minibrowser scroll by keyboard (#33252)
99bd6afa81adc81b90b723fa8673f5992e7af722	https://github.com/servo/servo/pull/33225	Pass keyboard events to WebView on Windows (#33225)
8dd40ed2bd4411d73ca1661803635345c2d9c3c1	https://github.com/servo/servo/pull/33247	mach: Add `test-speedometer` command and `--bmf-output` to speedometer and dromaeo (#33247)
0643aa47089838353e80f6fd509cbe70d13af271	https://github.com/servo/servo/pull/33240	Handle aspect ratios in `ReplacedContent::inline_content_sizes` (#33240)
    3f93de7f5494191ee659de9b5a340b329a25879b	https://github.com/servo/servo/pull/33250	layout: Stop using `unicode-segmentation`  in layout (#33250)
93abdf7cb56fa9db6aa160d63e8773292c5e7520	https://github.com/servo/servo/pull/33204	layout: Add an indefinite containing block for intrinsic sizing (#33204)
46dbe4ce320eb99e851dd422f624615e18c39e15	https://github.com/servo/servo/pull/33242	Obey min and max cross sizes of flex items (#33242)
59c74c874a082dc2c4652747d768498c2d03d3ee	https://github.com/servo/servo/pull/33241	Obey `min-block-size` and `max-block-size` in floats (#33241)
    e8d0f85f52c9b9c15fe8d8970a4bb7efb48e345f	https://github.com/servo/servo/pull/33246	Bump xi_unicode to latest version (#33246)
    65c2e75379a4c79ff815267c23353fa5898325c7	https://github.com/servo/servo/pull/33228	ci: Fix the WPT export job after the repository change (#33228)
    89421b70ada45d32ba0d5cfb0e921b5f459bf74f	https://github.com/servo/servo/pull/33236	build(deps): bump rustc_version from 0.4.0 to 0.4.1 (#33236)
+   5ffdce9aee9314e10474263513bc8cb2b73f9412	https://github.com/servo/servo/pull/33245	servoshell: Enable OpenXR by default and remove old WebVR prefs, adjust XrDiscovery initialization (#33245)
    1aff31fd963bb139843574cd73158ac0c0a4a430	https://github.com/servo/servo/pull/33243	wpt: fix path to wpt-prefs.json (#33243)
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
